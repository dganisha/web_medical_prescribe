<?php

namespace App\Repositories;

use App\Models\User;
use Illuminate\Database\Eloquent\Collection;

class UserRepository
{
    public function all(): Collection
    {
        return User::with('role')->orderBy('name')->get();
    }

    public function byRoleName(string $roleName): Collection
    {
        return User::with('role')
            ->whereHas('role', function ($query) use ($roleName) {
                $query->whereRaw('LOWER(name) = ?', [strtolower($roleName)]);
            })
            ->orderBy('name')
            ->get();
    }

    public function create(array $data): User
    {
        return User::create($data);
    }

    public function update(User $user, array $data): User
    {
        $user->update($data);

        return $user;
    }

    public function toggle(User $user): User
    {
        $user->update(['is_nonactive' => !$user->is_nonactive]);

        return $user;
    }
}
