<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Patient;
use App\Services\ActivityLogService;
use App\Services\AdminService;
use App\Services\PatientService;
use Illuminate\Http\Request;

class PatientManagementController extends Controller
{
    private AdminService $adminService;
    private PatientService $patientService;
    private ActivityLogService $activityLogService;

    public function __construct(
        AdminService $adminService,
        PatientService $patientService,
        ActivityLogService $activityLogService
    )
    {
        $this->adminService = $adminService;
        $this->patientService = $patientService;
        $this->activityLogService = $activityLogService;
    }

    public function index()
    {
        $this->authorizeAdmin();

        $patients = $this->adminService->listPatients();

        return view('admin.patients.index', compact('patients'));
    }

    public function create()
    {
        $this->authorizeAdmin();

        return view('admin.patients.create');
    }

    public function store(Request $request)
    {
        $this->authorizeAdmin();

        $validated = $this->validatePatient($request);

        $patient = $this->patientService->createPatient($validated);

        $this->activityLogService->log(
            'admin.patient_created',
            auth()->user(),
            $patient,
            'Admin created patient.'
        );

        return redirect()->route('admin.patients.index')->with('success', 'Patient created successfully.');
    }

    public function edit(Patient $patient)
    {
        $this->authorizeAdmin();

        return view('admin.patients.edit', compact('patient'));
    }

    public function update(Request $request, Patient $patient)
    {
        $this->authorizeAdmin();

        $validated = $this->validatePatient($request);

        $patient = $this->patientService->updatePatient($patient, $validated);

        $this->activityLogService->log(
            'admin.patient_updated',
            auth()->user(),
            $patient,
            'Admin updated patient.'
        );

        return redirect()->route('admin.patients.index')->with('success', 'Patient updated successfully.');
    }

    private function validatePatient(Request $request): array
    {
        return $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'date_of_birth' => ['required', 'date'],
            'gender' => ['required', 'string', 'max:50'],
            'address' => ['nullable', 'string', 'max:255'],
            'phone_number' => ['nullable', 'string', 'max:50'],
        ]);
    }

    private function authorizeAdmin(): void
    {
        if (!$this->adminService->canAdmin(auth()->user())) {
            abort(403);
        }
    }
}
