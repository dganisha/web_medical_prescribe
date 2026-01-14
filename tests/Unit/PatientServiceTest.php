<?php

namespace Tests\Unit;

use App\Models\Patient;
use App\Models\User;
use App\Models\UserRole;
use App\Services\PatientService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class PatientServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_create_and_update_patient(): void
    {
        $service = app(PatientService::class);

        $patient = $service->createPatient([
            'name' => 'Jane Doe',
            'date_of_birth' => '1990-01-01',
            'gender' => 'Perempuan',
            'address' => 'Jl. Mawar',
            'phone_number' => '08123456789',
        ]);

        $this->assertInstanceOf(Patient::class, $patient);
        $this->assertDatabaseHas('patients', ['id' => $patient->id]);

        $updated = $service->updatePatient($patient, [
            'name' => 'Jane Doe Updated',
            'date_of_birth' => '1990-01-01',
            'gender' => 'Perempuan',
            'address' => 'Jl. Melati',
            'phone_number' => '08987654321',
        ]);

        $this->assertSame('Jane Doe Updated', $updated->name);
        $this->assertDatabaseHas('patients', [
            'id' => $patient->id,
            'name' => 'Jane Doe Updated',
            'address' => 'Jl. Melati',
        ]);
    }

    public function test_can_manage_requires_pendaftaran_role(): void
    {
        $pendaftaran = UserRole::create(['name' => 'Pendaftaran']);
        $user = User::factory()->create(['user_roles_id' => $pendaftaran->id]);

        $service = app(PatientService::class);

        $this->assertTrue($service->canManage($user));
        $this->assertFalse($service->canManage(null));
    }
}
