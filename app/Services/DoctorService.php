<?php

namespace App\Services;

use App\Models\CheckupResult;
use App\Models\User;
use App\Repositories\CheckupResultRepository;
use App\Repositories\MedicineManagementRepository;
use App\Repositories\PatientRepository;
use App\Repositories\PatientVisitRepository;
use App\Repositories\PrescriptionItemRepository;
use App\Repositories\PrescriptionRepository;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

class DoctorService
{
    private CheckupResultRepository $checkupResultRepository;
    private PrescriptionRepository $prescriptionRepository;
    private PrescriptionItemRepository $prescriptionItemRepository;
    private PatientRepository $patientRepository;
    private PatientVisitRepository $patientVisitRepository;
    private MedicineManagementRepository $medicineRepository;

    public function __construct(
        CheckupResultRepository $checkupResultRepository,
        PrescriptionRepository $prescriptionRepository,
        PrescriptionItemRepository $prescriptionItemRepository,
        PatientRepository $patientRepository,
        PatientVisitRepository $patientVisitRepository,
        MedicineManagementRepository $medicineRepository
    ) {
        $this->checkupResultRepository = $checkupResultRepository;
        $this->prescriptionRepository = $prescriptionRepository;
        $this->prescriptionItemRepository = $prescriptionItemRepository;
        $this->patientRepository = $patientRepository;
        $this->patientVisitRepository = $patientVisitRepository;
        $this->medicineRepository = $medicineRepository;
    }

    public function listDoctorCheckups(int $doctorId): Collection
    {
        return $this->checkupResultRepository->listByDoctor($doctorId);
    }

    public function getPatients(): Collection
    {
        return $this->patientRepository->all();
    }

    public function getMedicines(): Collection
    {
        return $this->medicineRepository->allCollection();
    }

    public function createCheckup(
        array $checkupData,
        array $items,
        ?UploadedFile $externalFile,
        User $doctor,
        ?int $visitId = null
    ): CheckupResult {
        $checkupData['doctor_id'] = $doctor->id;
        $checkupData['external_file_path'] = $this->storeFile($externalFile);
        $checkupData['visit_id'] = $visitId;

        $checkup = $this->checkupResultRepository->create($checkupData);

        $prescription = $this->prescriptionRepository->create([
            'checkup_result_id' => $checkup->id,
            'status' => 'pending',
        ]);

        $this->prescriptionItemRepository->createMany($prescription->id, $items);

        if ($visitId) {
            $visit = $this->patientVisitRepository->find($visitId);
            if ($visit) {
                $this->patientVisitRepository->update($visit, [
                    'status' => 'waiting_pharmacy',
                    'handled_doctor_id' => $doctor->id,
                ]);
            }
        }

        return $checkup;
    }

    public function updateCheckup(
        CheckupResult $checkup,
        array $checkupData,
        array $items,
        ?UploadedFile $externalFile
    ): CheckupResult {
        $prescription = $checkup->prescription;

        if (!$prescription || $prescription->status !== 'pending') {
            abort(403);
        }

        if ($externalFile) {
            $checkupData['external_file_path'] = $this->storeFile($externalFile);
        }

        $this->checkupResultRepository->update($checkup, $checkupData);

        $this->prescriptionItemRepository->deleteByPrescription($prescription->id);
        $this->prescriptionItemRepository->createMany($prescription->id, $items);

        if ($checkup->visit) {
            $this->patientVisitRepository->update($checkup->visit, [
                'status' => 'waiting_pharmacy',
            ]);
        }

        return $checkup;
    }

    public function canDoctorManage(?User $user): bool
    {
        if (!$user || !$user->role) {
            return false;
        }

        return strtolower($user->role->name) === 'dokter';
    }

    private function storeFile(?UploadedFile $externalFile): ?string
    {
        if (!$externalFile) {
            return null;
        }

        return $externalFile->store('checkups', 'public');
    }
}
