<?php

namespace App\Repositories;

use App\Models\PatientVisit;
use Illuminate\Database\Eloquent\Collection;

class PatientVisitRepository
{
    public function create(array $data): PatientVisit
    {
        return PatientVisit::create($data);
    }

    public function listAll(): Collection
    {
        return PatientVisit::with(['patient', 'registeredBy', 'doctor', 'apoteker'])
            ->orderByDesc('created_at')
            ->get();
    }

    public function listWaitingDoctor(): Collection
    {
        return PatientVisit::with('patient')
            ->where('status', 'waiting_doctor')
            ->orderBy('registered_at')
            ->get();
    }

    public function find(int $id): ?PatientVisit
    {
        return PatientVisit::with('patient')->find($id);
    }

    public function update(PatientVisit $visit, array $data): PatientVisit
    {
        $visit->update($data);

        return $visit;
    }
}
