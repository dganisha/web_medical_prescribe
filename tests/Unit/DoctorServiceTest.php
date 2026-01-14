<?php

namespace Tests\Unit;

use App\Models\CheckupResult;
use App\Models\Medicine;
use App\Models\Patient;
use App\Models\User;
use App\Models\UserRole;
use App\Services\DoctorService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class DoctorServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_create_checkup_with_prescription(): void
    {
        $doctorRole = UserRole::create(['name' => 'Dokter']);
        $doctor = User::factory()->create(['user_roles_id' => $doctorRole->id]);
        $patient = Patient::create([
            'name' => 'Patient A',
            'date_of_birth' => '1990-01-01',
            'gender' => 'Laki-laki',
            'address' => null,
            'phone_number' => null,
        ]);
        $medicine = Medicine::create(['name' => 'Paracetamol', 'medicines_central_id' => 'm-1']);

        $service = app(DoctorService::class);

        $checkup = $service->createCheckup([
            'patient_id' => $patient->id,
            'checkup_date' => '2026-01-14 10:00:00',
            'diagnosis' => 'Flu ringan',
            'tinggi_badan' => '170',
            'berat_badan' => '65',
            'sistole' => '120',
            'diastole' => '80',
            'heart_rate' => '70',
            'respiratory_rate' => '18',
            'temperature' => '36.8',
        ], [
            [
                'medicine_id' => $medicine->id,
                'dosage' => '500mg',
                'frequency' => '2x sehari',
                'duration' => '5 hari',
                'quantity' => 2,
                'notes' => null,
            ],
        ], null, $doctor);

        $this->assertInstanceOf(CheckupResult::class, $checkup);
        $this->assertDatabaseHas('checkup_results', [
            'id' => $checkup->id,
            'patient_id' => $patient->id,
            'doctor_id' => $doctor->id,
        ]);
        $this->assertDatabaseHas('prescriptions', [
            'checkup_result_id' => $checkup->id,
            'status' => 'pending',
        ]);
        $this->assertDatabaseHas('prescription_items', [
            'medicine_id' => $medicine->id,
            'dosage' => '500mg',
            'quantity' => 2,
        ]);
    }
}
