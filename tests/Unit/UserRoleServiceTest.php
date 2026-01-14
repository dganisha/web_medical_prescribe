<?php

namespace Tests\Unit;

use App\Models\UserRole;
use App\Services\UserRoleService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class UserRoleServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_create_user_role(): void
    {
        $service = app(UserRoleService::class);

        $userRole = $service->createUserRole([
            'name' => 'Dokter',
        ]);

        $this->assertInstanceOf(UserRole::class, $userRole);
        $this->assertDatabaseHas('user_roles', [
            'id' => $userRole->id,
            'name' => 'Dokter',
            'is_nonactive' => 0,
        ]);
    }

    public function test_default_user_role_is_active(): void
    {
        $userRole = UserRole::create([
            'name' => 'Apoteker',
            'is_nonactive' => false,
        ]);

        $this->assertDatabaseHas('user_roles', [
            'id' => $userRole->id,
            'is_nonactive' => 0,
        ]);
    }
}
