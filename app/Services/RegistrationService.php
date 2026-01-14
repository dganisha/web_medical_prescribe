<?php

namespace App\Services;

use App\Models\PatientVisit;
use App\Models\Patient;
use App\Models\User;
use App\Repositories\PatientRepository;
use App\Repositories\PatientVisitRepository;
use Illuminate\Database\Eloquent\Collection;

class RegistrationService
{
    private PatientVisitRepository $patientVisitRepository;
    private PatientRepository $patientRepository;

    public function __construct(
        PatientVisitRepository $patientVisitRepository,
        PatientRepository $patientRepository
    ) {
        $this->patientVisitRepository = $patientVisitRepository;
        $this->patientRepository = $patientRepository;
    }

    public function listVisits(): Collection
    {
        return $this->patientVisitRepository->listAll();
    }

    public function listWaitingDoctor(): Collection
    {
        return $this->patientVisitRepository->listWaitingDoctor();
    }

    public function createVisit(int $patientId, User $user): PatientVisit
    {
        return $this->patientVisitRepository->create([
            'patient_id' => $patientId,
            'registered_by' => $user->id,
            'status' => 'waiting_doctor',
            'registered_at' => now(),
        ]);
    }

    public function getPatients(): Collection
    {
        return $this->patientRepository->all();
    }

    public function createPatient(array $data): Patient
    {
        return $this->patientRepository->create($data);
    }

    public function getVisit(int $visitId): ?PatientVisit
    {
        return $this->patientVisitRepository->find($visitId);
    }

    public function canRegister(?User $user): bool
    {
        if (!$user || !$user->role) {
            return false;
        }

        return strtolower($user->role->name) === 'pendaftaran';
    }
}
