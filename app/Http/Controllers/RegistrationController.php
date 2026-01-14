<?php

namespace App\Http\Controllers;

use App\Services\ActivityLogService;
use App\Services\RegistrationService;
use Illuminate\Http\Request;

class RegistrationController extends Controller
{
    private RegistrationService $registrationService;
    private ActivityLogService $activityLogService;

    public function __construct(
        RegistrationService $registrationService,
        ActivityLogService $activityLogService
    )
    {
        $this->registrationService = $registrationService;
        $this->activityLogService = $activityLogService;
    }

    public function index()
    {
        $this->authorizeRegistration();

        $visits = $this->registrationService->listVisits();

        return view('registrations.index', compact('visits'));
    }

    public function create()
    {
        $this->authorizeRegistration();

        $patients = $this->registrationService->getPatients();

        return view('registrations.create', compact('patients'));
    }

    public function store(Request $request)
    {
        $this->authorizeRegistration();

        $validated = $request->validate([
            'patient_id' => ['nullable', 'exists:patients,id'],
            'name' => ['nullable', 'required_without:patient_id', 'string', 'max:255'],
            'date_of_birth' => ['nullable', 'required_without:patient_id', 'date'],
            'gender' => ['nullable', 'required_without:patient_id', 'string', 'max:50'],
            'address' => ['nullable', 'string', 'max:255'],
            'phone_number' => ['nullable', 'string', 'max:50'],
        ]);

        $patientId = $validated['patient_id'] ?? null;

        if (!$patientId) {
            $patient = $this->registrationService->createPatient([
                'name' => $validated['name'],
                'date_of_birth' => $validated['date_of_birth'],
                'gender' => $validated['gender'],
                'address' => $validated['address'] ?? null,
                'phone_number' => $validated['phone_number'] ?? null,
            ]);
            $patientId = $patient->id;

            $this->activityLogService->log(
                'registration.patient_created',
                auth()->user(),
                $patient,
                'New patient created during registration.'
            );
        }

        $visit = $this->registrationService->createVisit((int) $patientId, auth()->user());
        $this->activityLogService->log(
            'registration.visit_created',
            auth()->user(),
            $visit,
            'Patient registered to visit queue.'
        );

        return redirect()->route('registrations.index')->with('success', 'Patient registered successfully.');
    }

    private function authorizeRegistration(): void
    {
        if (!$this->registrationService->canRegister(auth()->user())) {
            abort(403);
        }
    }
}
