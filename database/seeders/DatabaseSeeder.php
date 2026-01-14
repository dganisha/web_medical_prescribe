<?php

namespace Database\Seeders;

use App\Models\CheckupResult;
use App\Models\Medicine;
use App\Models\MedicinePrice;
use App\Models\Patient;
use App\Models\Prescription;
use App\Models\PrescriptionItem;
use App\Models\User;
use App\Models\UserRole;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $truncate = $this->shouldTruncate();

        if ($truncate) {
            $this->truncateTables();
        }

        $dokterRole = UserRole::firstOrCreate(['name' => 'Dokter'], ['is_nonactive' => false]);
        $apotekerRole = UserRole::firstOrCreate(['name' => 'Apoteker'], ['is_nonactive' => false]);
        $pendaftaranRole = UserRole::firstOrCreate(['name' => 'Pendaftaran'], ['is_nonactive' => false]);
        $adminRole = UserRole::firstOrCreate(['name' => 'Administrator'], ['is_nonactive' => false]);

        $doctor = User::firstOrCreate(
            ['email' => 'dokter@example.com'],
            [
                'name' => 'Dokter Demo',
                'user_roles_id' => $dokterRole->id,
                'is_nonactive' => false,
                'password' => Hash::make('password'),
            ]
        );

        User::firstOrCreate(
            ['email' => 'apoteker@example.com'],
            [
                'name' => 'Apoteker Demo',
                'user_roles_id' => $apotekerRole->id,
                'is_nonactive' => false,
                'password' => Hash::make('password'),
            ]
        );

        User::firstOrCreate(
            ['email' => 'pendaftaran@example.com'],
            [
                'name' => 'Pendaftaran Demo',
                'user_roles_id' => $pendaftaranRole->id,
                'is_nonactive' => false,
                'password' => Hash::make('password'),
            ]
        );

        User::firstOrCreate(
            ['email' => 'admin@example.com'],
            [
                'name' => 'Administrator Demo',
                'user_roles_id' => $adminRole->id,
                'is_nonactive' => false,
                'password' => Hash::make('password'),
            ]
        );

        $patient = Patient::firstOrCreate(
            ['name' => 'Andi Wijaya', 'date_of_birth' => '1990-01-01'],
            [
                'gender' => 'Laki-laki',
                'address' => 'Jl. Melati No. 1',
                'phone_number' => '081234567890',
            ]
        );

        $medicineA = Medicine::firstOrCreate(
            ['medicines_central_id' => 'm-001'],
            ['name' => 'Paracetamol']
        );
        $medicineB = Medicine::firstOrCreate(
            ['medicines_central_id' => 'm-002'],
            ['name' => 'Amoxicillin']
        );

        MedicinePrice::firstOrCreate(
            [
                'medicine_id' => $medicineA->id,
                'effective_date' => now()->subDays(10)->toDateString(),
            ],
            [
                'price' => 8000,
                'end_date' => null,
            ]
        );
        MedicinePrice::firstOrCreate(
            [
                'medicine_id' => $medicineB->id,
                'effective_date' => now()->subDays(10)->toDateString(),
            ],
            [
                'price' => 12000,
                'end_date' => null,
            ]
        );

        $checkup = CheckupResult::firstOrCreate(
            [
                'patient_id' => $patient->id,
                'doctor_id' => $doctor->id,
                'checkup_date' => now()->subDay()->toDateTimeString(),
            ],
            [
                'diagnosis' => 'Demam ringan',
                'tinggi_badan' => '170',
                'berat_badan' => '65',
                'sistole' => '120',
                'diastole' => '80',
                'heart_rate' => '72',
                'respiratory_rate' => '18',
                'temperature' => '37.2',
            ]
        );

        $prescription = Prescription::firstOrCreate(
            ['checkup_result_id' => $checkup->id],
            ['status' => 'pending']
        );

        PrescriptionItem::firstOrCreate(
            [
                'prescription_id' => $prescription->id,
                'medicine_id' => $medicineA->id,
            ],
            [
                'dosage' => '500mg',
                'frequency' => '3x sehari',
                'duration' => '5 hari',
                'quantity' => 1,
                'notes' => 'Setelah makan',
            ]
        );
    }

    private function shouldTruncate(): bool
    {
        $envValue = env('SEED_TRUNCATE');

        if (is_string($envValue) && $envValue !== '') {
            return filter_var($envValue, FILTER_VALIDATE_BOOLEAN);
        }

        if ($this->command) {
            $choice = $this->command->choice(
                'Pilih data yang akan digunakan saat seeding',
                ['Keep data', 'Hapus data'],
                0
            );

            return $choice === 'Hapus data';
        }

        return false;
    }

    private function truncateTables(): void
    {
        Schema::disableForeignKeyConstraints();

        PrescriptionItem::truncate();
        Prescription::truncate();
        CheckupResult::truncate();
        MedicinePrice::truncate();
        Medicine::truncate();
        Patient::truncate();
        User::truncate();
        UserRole::truncate();

        Schema::enableForeignKeyConstraints();
    }
}
