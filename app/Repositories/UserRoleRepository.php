<?php

namespace App\Repositories;

use App\Models\UserRole;
use Illuminate\Database\Eloquent\Collection;

class UserRoleRepository
{
    public function all(): Collection
    {
        return UserRole::orderBy('name')->get();
    }

    public function create(array $data): UserRole
    {
        return UserRole::create($data);
    }
}
