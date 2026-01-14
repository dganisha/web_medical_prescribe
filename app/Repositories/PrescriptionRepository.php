<?php

namespace App\Repositories;

use App\Models\Prescription;
use Illuminate\Database\Eloquent\Collection;

class PrescriptionRepository
{
    public function create(array $data): Prescription
    {
        return Prescription::create($data);
    }

    public function update(Prescription $prescription, array $data): Prescription
    {
        $prescription->update($data);

        return $prescription;
    }

    public function findWithItems(int $id): ?Prescription
    {
        return Prescription::with([
            'items.medicine',
            'checkupResult.patient',
            'checkupResult.doctor',
        ])->find($id);
    }

    public function listPending(): Collection
    {
        return Prescription::with([
            'items.medicine',
            'checkupResult.patient',
            'checkupResult.doctor',
        ])
            ->where('status', 'pending')
            ->orderByDesc('created_at')
            ->get();
    }

    public function listServed(): Collection
    {
        return Prescription::with([
            'items.medicine',
            'checkupResult.patient',
            'checkupResult.doctor',
        ])
            ->where('status', 'served')
            ->orderByDesc('served_at')
            ->get();
    }
}
