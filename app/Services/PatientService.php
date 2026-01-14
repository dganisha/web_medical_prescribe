<?php

namespace App\Services;

use App\Models\Patient;
use App\Models\User;
use App\Repositories\PatientRepository;
use Illuminate\Database\Eloquent\Collection;

class PatientService
{
    private PatientRepository $patientRepository;

    public function __construct(PatientRepository $patientRepository)
    {
        $this->patientRepository = $patientRepository;
    }

    public function listPatients(): Collection
    {
        return $this->patientRepository->all();
    }

    public function createPatient(array $data): Patient
    {
        return $this->patientRepository->create($data);
    }

    public function updatePatient(Patient $patient, array $data): Patient
    {
        return $this->patientRepository->update($patient, $data);
    }

    public function canManage(?User $user): bool
    {
        if (!$user || !$user->role) {
            return false;
        }

        return strtolower($user->role->name) === 'pendaftaran';
    }
}
