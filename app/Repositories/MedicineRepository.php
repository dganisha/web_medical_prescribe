<?php

namespace App\Repositories;

class MedicineRepository
{
    protected string $baseUrl;
    protected ?string $token;
    protected $tokenExpiresAt;

    public function __construct()
    {
        $this->baseUrl = env('API_BASE_URL', 'https://api.domain.com/api/v1');
        $this->token = null;
        $this->tokenExpiresAt = null;
    }

    protected function curlRequest(string $method, string $url, array $headers = [], ?string $body = null): ?array
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        if ($method === 'POST') {
            curl_setopt($ch, CURLOPT_POST, true);
            if ($body) {
                curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
            }
        } elseif ($method === 'GET') {
            curl_setopt($ch, CURLOPT_HTTPGET, true);
        }

        if (!empty($headers)) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        }

        $response = curl_exec($ch);
        $err = curl_error($ch);
        curl_close($ch);

        if ($err) {
            return null;
        }

        $decoded = json_decode($response, true);

        return is_array($decoded) ? $decoded : null;
    }

    protected function getBearerToken(): ?string
    {
        // If token exists and not expired, return it
        if ($this->token && $this->tokenExpiresAt && now()->lt($this->tokenExpiresAt)) {
            return $this->token;
        }

        $url = "{$this->baseUrl}/auth";
        $headers = ['Accept: application/json', 'Content-Type: application/json'];
        $body = json_encode([
            'email' => env('API_USERNAME'),
            'password' => env('API_PASSWORD'),
        ]);

        $data = $this->curlRequest('POST', $url, $headers, $body);

        if (isset($data['access_token'])) {
            $this->token = $data['access_token'];
            $this->tokenExpiresAt = now()->addSeconds($data['expires_in'] ?? 3600);
            return $this->token;
        }
        return null;
    }

    public function fetchMedicines(): array
    {
        $token = $this->getBearerToken();
        if (!$token) {
            return [];
        }

        $url = "{$this->baseUrl}/medicines";
        $headers = [
            'Accept: application/json',
            'Authorization: Bearer ' . $token,
        ];

        $data = $this->curlRequest('GET', $url, $headers);

        if (!is_array($data)) {
            return [];
        }

        return $data['medicines'] ?? [];
    }

    public function fetchMedicinePrices(string $medicineId): array
    {
        $token = $this->getBearerToken();
        if (!$token) {
            return [];
        }

        $url = "{$this->baseUrl}/medicines/{$medicineId}/prices";
        $headers = [
            'Accept: application/json',
            'Authorization: Bearer ' . $token,
        ];

        $data = $this->curlRequest('GET', $url, $headers);

        if (!is_array($data)) {
            return [];
        }

        return $data['prices'] ?? [];
    }
}
