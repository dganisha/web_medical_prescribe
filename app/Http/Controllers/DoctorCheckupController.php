<?php

namespace App\Http\Controllers;

use App\Models\CheckupResult;
use App\Services\ActivityLogService;
use App\Services\DoctorService;
use App\Services\RegistrationService;
use Illuminate\Http\Request;

class DoctorCheckupController extends Controller
{
    private DoctorService $doctorService;
    private RegistrationService $registrationService;
    private ActivityLogService $activityLogService;

    public function __construct(
        DoctorService $doctorService,
        RegistrationService $registrationService,
        ActivityLogService $activityLogService
    ) {
        $this->doctorService = $doctorService;
        $this->registrationService = $registrationService;
        $this->activityLogService = $activityLogService;
    }

    public function index()
    {
        $this->authorizeDoctor();

        $doctor = auth()->user();
        $checkups = $this->doctorService->listDoctorCheckups($doctor->id);
        $waitingVisits = $this->registrationService->listWaitingDoctor();

        return view('doctor.checkups.index', compact('checkups', 'waitingVisits'));
    }

    public function create()
    {
        $this->authorizeDoctor();

        $medicines = $this->doctorService->getMedicines();
        $visits = $this->registrationService->listWaitingDoctor();
        $selectedVisitId = request()->query('visit_id');
        $visitDetails = $visits->mapWithKeys(function ($visit) {
            return [
                $visit->id => [
                    'name' => $visit->patient->name,
                    'date_of_birth' => $visit->patient->date_of_birth,
                    'gender' => $visit->patient->gender,
                    'address' => $visit->patient->address,
                    'phone_number' => $visit->patient->phone_number,
                ],
            ];
        });

        return view('doctor.checkups.create', compact('medicines', 'visits', 'visitDetails', 'selectedVisitId'));
    }

    public function store(Request $request)
    {
        $this->authorizeDoctor();

        $validated = $this->validateCheckup($request);

        $visitId = (int) $validated['visit_id'];
        $visit = $this->registrationService->getVisit($visitId);
        if (!$visit || !$visit->patient_id) {
            abort(422, 'Visit tidak valid.');
        }
        $validated['patient_id'] = $visit->patient_id;

        $checkup = $this->doctorService->createCheckup(
            $this->mapCheckupData($validated),
            $validated['items'],
            $request->file('external_file'),
            auth()->user(),
            $visitId ? (int) $visitId : null
        );

        $this->activityLogService->log(
            'doctor.checkup_created',
            auth()->user(),
            $checkup,
            'Doctor created checkup.',
            ['visit_id' => $visitId]
        );

        return redirect()->route('doctor.checkups.index')->with('success', 'Checkup saved successfully.');
    }

    public function edit(CheckupResult $checkup)
    {
        $this->authorizeDoctor();
        $this->authorizeOwner($checkup);

        $patients = $this->doctorService->getPatients();
        $medicines = $this->doctorService->getMedicines();
        $checkup->load('prescription.items');

        return view('doctor.checkups.edit', compact('checkup', 'patients', 'medicines'));
    }

    public function update(Request $request, CheckupResult $checkup)
    {
        $this->authorizeDoctor();
        $this->authorizeOwner($checkup);

        $validated = $this->validateCheckup($request);

        $checkup = $this->doctorService->updateCheckup(
            $checkup,
            $this->mapCheckupData($validated),
            $validated['items'],
            $request->file('external_file')
        );

        $this->activityLogService->log(
            'doctor.checkup_updated',
            auth()->user(),
            $checkup,
            'Doctor updated checkup.'
        );

        return redirect()->route('doctor.checkups.index')->with('success', 'Checkup updated successfully.');
    }

    private function validateCheckup(Request $request): array
    {
        return $request->validate([
            'visit_id' => ['required', 'exists:patient_visits,id'],
            'checkup_date' => ['required', 'date'],
            'diagnosis' => ['nullable', 'string'],
            'tinggi_badan' => ['required', 'string', 'max:50'],
            'berat_badan' => ['required', 'string', 'max:50'],
            'sistole' => ['required', 'string', 'max:50'],
            'diastole' => ['required', 'string', 'max:50'],
            'heart_rate' => ['required', 'string', 'max:50'],
            'respiratory_rate' => ['required', 'string', 'max:50'],
            'temperature' => ['required', 'string', 'max:50'],
            'external_file' => ['nullable', 'file', 'max:5120'],
            'items' => ['required', 'array', 'min:1'],
            'items.*.medicine_id' => ['required', 'exists:medicines,id'],
            'items.*.dosage' => ['required', 'string', 'max:255'],
            'items.*.frequency' => ['required', 'string', 'max:255'],
            'items.*.duration' => ['required', 'string', 'max:255'],
            'items.*.quantity' => ['required', 'integer', 'min:1'],
            'items.*.notes' => ['nullable', 'string'],
        ]);
    }

    private function mapCheckupData(array $validated): array
    {
        return [
            'patient_id' => $validated['patient_id'],
            'visit_id' => $validated['visit_id'] ?? null,
            'checkup_date' => $validated['checkup_date'],
            'diagnosis' => $validated['diagnosis'] ?? null,
            'tinggi_badan' => $validated['tinggi_badan'],
            'berat_badan' => $validated['berat_badan'],
            'sistole' => $validated['sistole'],
            'diastole' => $validated['diastole'],
            'heart_rate' => $validated['heart_rate'],
            'respiratory_rate' => $validated['respiratory_rate'],
            'temperature' => $validated['temperature'],
        ];
    }

    private function authorizeDoctor(): void
    {
        if (!$this->doctorService->canDoctorManage(auth()->user())) {
            abort(403);
        }
    }

    private function authorizeOwner(CheckupResult $checkup): void
    {
        if ($checkup->doctor_id !== auth()->id()) {
            abort(403);
        }
    }
}
