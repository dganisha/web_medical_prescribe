<?php

namespace App\Services;

use App\Models\UserRole;
use App\Repositories\UserRoleRepository;
use Illuminate\Database\Eloquent\Collection;

class UserRoleService
{
    private UserRoleRepository $userRoleRepository;

    public function __construct(UserRoleRepository $userRoleRepository)
    {
        $this->userRoleRepository = $userRoleRepository;
    }

    public function listUserRoles(): Collection
    {
        return $this->userRoleRepository->all();
    }

    public function createUserRole(array $data): UserRole
    {
        return $this->userRoleRepository->create($data);
    }
}
