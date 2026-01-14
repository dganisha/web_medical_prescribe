<?php

namespace App\Services;

use App\Models\User;
use App\Repositories\CheckupResultRepository;
use App\Repositories\PatientRepository;
use App\Repositories\UserRepository;
use App\Repositories\UserRoleRepository;
use Illuminate\Database\Eloquent\Collection;

class AdminService
{
    private UserRepository $userRepository;
    private UserRoleRepository $userRoleRepository;
    private PatientRepository $patientRepository;
    private CheckupResultRepository $checkupResultRepository;

    public function __construct(
        UserRepository $userRepository,
        UserRoleRepository $userRoleRepository,
        PatientRepository $patientRepository,
        CheckupResultRepository $checkupResultRepository
    ) {
        $this->userRepository = $userRepository;
        $this->userRoleRepository = $userRoleRepository;
        $this->patientRepository = $patientRepository;
        $this->checkupResultRepository = $checkupResultRepository;
    }

    public function listUsers(): Collection
    {
        return $this->userRepository->all();
    }

    public function listUsersByRole(string $roleName): Collection
    {
        return $this->userRepository->byRoleName($roleName);
    }

    public function listUserRoles(): Collection
    {
        return $this->userRoleRepository->all();
    }

    public function createUser(array $data): User
    {
        return $this->userRepository->create($data);
    }

    public function updateUser(User $user, array $data): User
    {
        return $this->userRepository->update($user, $data);
    }

    public function toggleUser(User $user): User
    {
        return $this->userRepository->toggle($user);
    }

    public function listPatients(): Collection
    {
        return $this->patientRepository->all();
    }

    public function listMedicalHistory(): Collection
    {
        return $this->checkupResultRepository->listAll();
    }

    public function canAdmin(?User $user): bool
    {
        if (!$user || !$user->role) {
            return false;
        }

        return strtolower($user->role->name) === 'administrator';
    }
}
