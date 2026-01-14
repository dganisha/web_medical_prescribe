<?php

namespace App\Repositories;

use App\Models\CheckupResult;
use Illuminate\Database\Eloquent\Collection;

class CheckupResultRepository
{
    public function create(array $data): CheckupResult
    {
        return CheckupResult::create($data);
    }

    public function update(CheckupResult $checkupResult, array $data): CheckupResult
    {
        $checkupResult->update($data);

        return $checkupResult;
    }

    public function listByDoctor(int $doctorId): Collection
    {
        return CheckupResult::with(['patient', 'prescription'])
            ->where('doctor_id', $doctorId)
            ->orderByDesc('checkup_date')
            ->get();
    }

    public function listAll(): Collection
    {
        return CheckupResult::with(['patient', 'doctor', 'apoteker', 'prescription'])
            ->orderByDesc('checkup_date')
            ->get();
    }
}
