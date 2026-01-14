<?php

namespace Tests\Unit;

use App\Models\CheckupResult;
use App\Models\Medicine;
use App\Models\MedicinePrice;
use App\Models\Patient;
use App\Models\Prescription;
use App\Models\PrescriptionItem;
use App\Models\User;
use App\Models\UserRole;
use App\Services\PharmacistService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class PharmacistServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_calculate_totals_and_serve_prescription(): void
    {
        $apotekerRole = UserRole::create(['name' => 'Apoteker']);
        $apoteker = User::factory()->create(['user_roles_id' => $apotekerRole->id]);
        $patient = Patient::create([
            'name' => 'Patient B',
            'date_of_birth' => '1992-05-01',
            'gender' => 'Perempuan',
        ]);
        $doctorRole = UserRole::create(['name' => 'Dokter']);
        $doctor = User::factory()->create(['user_roles_id' => $doctorRole->id]);

        $medicine = Medicine::create(['name' => 'Amoxicillin', 'medicines_central_id' => 'm-2']);
        MedicinePrice::create([
            'medicine_id' => $medicine->id,
            'price' => 10000,
            'effective_date' => '2026-01-01',
            'end_date' => null,
        ]);

        $checkup = CheckupResult::create([
            'patient_id' => $patient->id,
            'doctor_id' => $doctor->id,
            'checkup_date' => '2026-01-14 10:00:00',
            'diagnosis' => 'Infeksi ringan',
            'tinggi_badan' => '160',
            'berat_badan' => '55',
            'sistole' => '110',
            'diastole' => '70',
            'heart_rate' => '72',
            'respiratory_rate' => '19',
            'temperature' => '37.2',
        ]);

        $prescription = Prescription::create([
            'checkup_result_id' => $checkup->id,
            'status' => 'pending',
        ]);

        PrescriptionItem::create([
            'prescription_id' => $prescription->id,
            'medicine_id' => $medicine->id,
            'dosage' => '500mg',
            'frequency' => '3x sehari',
            'duration' => '7 hari',
            'quantity' => 2,
            'notes' => null,
        ]);

        $service = app(PharmacistService::class);
        $prescription = $service->getPrescriptionWithItems($prescription->id);
        $totals = $service->calculateTotals($prescription);

        $this->assertSame(20000.0, $totals['total']);

        $service->servePrescription($prescription, $apoteker);

        $this->assertDatabaseHas('prescriptions', [
            'id' => $prescription->id,
            'status' => 'served',
            'served_by' => $apoteker->id,
        ]);
    }
}
