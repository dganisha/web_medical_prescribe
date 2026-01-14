<?php

namespace App\Http\Controllers;

use App\Models\Medicine;
use App\Services\ActivityLogService;
use App\Services\MedicineManagementService;
use App\Services\MedicineService;
use App\Services\PatientService;
use Illuminate\Http\JsonResponse;

class MedicineController extends Controller
{
    private MedicineManagementService $medicineManagementService;
    private MedicineService $medicineService;
    private PatientService $patientService;
    private ActivityLogService $activityLogService;

    public function __construct(
        MedicineManagementService $medicineManagementService,
        MedicineService $medicineService,
        PatientService $patientService,
        ActivityLogService $activityLogService
    )
    {
        $this->medicineManagementService = $medicineManagementService;
        $this->medicineService = $medicineService;
        $this->patientService = $patientService;
        $this->activityLogService = $activityLogService;
    }

    // Web view: Medicines management menu
    public function index()
    {
        $medicines = $this->medicineManagementService->listMedicines(10);

        return view('medications.index', compact('medicines'));
    }

    // Web view: Show medicine details
    public function show(Medicine $medicine)
    {
        return view('medications.show', compact('medicine'));
    }

    // Web view: Edit medicine
    public function edit(Medicine $medicine)
    {
        return view('medications.edit', compact('medicine'));
    }

    public function prescribing()
    {
        $patients = $this->patientService->listPatients();
        $medicines = $this->medicineManagementService->listMedicines();

        return view('medications.medication_prescribing', compact('patients', 'medicines'));
    }

    public function fetchMedicines(): JsonResponse
    {
        $medicines = $this->medicineManagementService->listMedicines(10);

        return response()->json($medicines);
    }

    public function fetchMedicinePrices(string $medicineId): JsonResponse
    {
        $prices = $this->medicineManagementService->listMedicinePrices($medicineId);

        return response()->json($prices);
    }

    public function saveMedicines(): JsonResponse
    {
        $result = $this->medicineService->saveMedicines();
        return response()->json(['message' => $result ? 'Medicines saved successfully' : 'Failed to save medicines']);
    }

    public function saveMedicinePrices(string $medicineId): JsonResponse
    {
        $result = $this->medicineService->saveMedicinePrices($medicineId);
        return response()->json(['message' => $result ? 'Prices saved successfully' : 'Failed to save prices']);
    }

    public function synchronize(): JsonResponse
    {
        $result = $this->medicineService->synchronize();

        $this->activityLogService->log(
            'medicines.synchronize',
            auth()->user(),
            null,
            'Medicines synchronized.',
            $result
        );

        return response()->json([
            'message' => 'Synchronization completed.',
            'medicines' => $result['medicines'] ?? 0,
            'prices' => $result['prices'] ?? 0,
        ]);
    }
}
