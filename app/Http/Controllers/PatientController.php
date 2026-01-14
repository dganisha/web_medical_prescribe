<?php

namespace App\Http\Controllers;

use App\Models\Patient;
use App\Services\ActivityLogService;
use App\Services\PatientService;
use Illuminate\Http\Request;

class PatientController extends Controller
{
    private PatientService $patientService;
    private ActivityLogService $activityLogService;

    public function __construct(PatientService $patientService, ActivityLogService $activityLogService)
    {
        $this->patientService = $patientService;
        $this->activityLogService = $activityLogService;
    }

    public function index()
    {
        $patients = $this->patientService->listPatients();
        $canManage = $this->patientService->canManage(auth()->user());

        return view('patients.index', compact('patients', 'canManage'));
    }

    public function create()
    {
        $this->authorizeManage();

        return view('patients.create');
    }

    public function store(Request $request)
    {
        $this->authorizeManage();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'date_of_birth' => ['required', 'date'],
            'gender' => ['required', 'string', 'max:50'],
            'address' => ['nullable', 'string', 'max:255'],
            'phone_number' => ['nullable', 'string', 'max:50'],
        ]);

        $patient = $this->patientService->createPatient($validated);

        $this->activityLogService->log(
            'patients.created',
            auth()->user(),
            $patient,
            'Patient created.'
        );

        return redirect()->route('patients.index')->with('success', 'Patient created successfully.');
    }

    public function edit(Patient $patient)
    {
        $this->authorizeManage();

        return view('patients.edit', compact('patient'));
    }

    public function update(Request $request, Patient $patient)
    {
        $this->authorizeManage();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'date_of_birth' => ['required', 'date'],
            'gender' => ['required', 'string', 'max:50'],
            'address' => ['nullable', 'string', 'max:255'],
            'phone_number' => ['nullable', 'string', 'max:50'],
        ]);

        $patient = $this->patientService->updatePatient($patient, $validated);

        $this->activityLogService->log(
            'patients.updated',
            auth()->user(),
            $patient,
            'Patient updated.'
        );

        return redirect()->route('patients.index')->with('success', 'Patient updated successfully.');
    }

    private function authorizeManage(): void
    {
        if (!$this->patientService->canManage(auth()->user())) {
            abort(403);
        }
    }
}
