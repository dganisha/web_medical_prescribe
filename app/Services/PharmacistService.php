<?php

namespace App\Services;

use App\Models\Prescription;
use App\Models\User;
use App\Repositories\MedicinePriceRepository;
use App\Repositories\PatientVisitRepository;
use App\Repositories\PrescriptionRepository;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;

class PharmacistService
{
    private PrescriptionRepository $prescriptionRepository;
    private MedicinePriceRepository $medicinePriceRepository;
    private PatientVisitRepository $patientVisitRepository;

    public function __construct(
        PrescriptionRepository $prescriptionRepository,
        MedicinePriceRepository $medicinePriceRepository,
        PatientVisitRepository $patientVisitRepository
    ) {
        $this->prescriptionRepository = $prescriptionRepository;
        $this->medicinePriceRepository = $medicinePriceRepository;
        $this->patientVisitRepository = $patientVisitRepository;
    }

    public function listPendingPrescriptions(): Collection
    {
        return $this->prescriptionRepository->listPending();
    }

    public function listServedPrescriptions(): Collection
    {
        return $this->prescriptionRepository->listServed();
    }

    public function getPrescriptionWithItems(int $id): ?Prescription
    {
        return $this->prescriptionRepository->findWithItems($id);
    }

    public function calculateTotals(Prescription $prescription): array
    {
        $items = [];
        $total = 0;

        foreach ($prescription->items as $item) {
            $priceModel = $this->medicinePriceRepository->findLatestActivePrice($item->medicine_id);

            $unitPrice = $priceModel ? (float) $priceModel->price : 0.0;
            $quantity = $item->quantity ?? 1;
            $lineTotal = $unitPrice * $quantity;
            $total += $lineTotal;

            $items[] = [
                'item' => $item,
                'unit_price' => $unitPrice,
                'line_total' => $lineTotal,
            ];
        }

        return [
            'items' => $items,
            'total' => $total,
        ];
    }

    public function servePrescription(Prescription $prescription, User $apoteker): Prescription
    {
        if ($prescription->status !== 'pending') {
            abort(403);
        }

        $this->prescriptionRepository->update($prescription, [
            'status' => 'served',
            'served_at' => Carbon::now(),
            'served_by' => $apoteker->id,
        ]);

        $checkup = $prescription->checkupResult;
        if ($checkup) {
            $checkup->update(['apoteker_id' => $apoteker->id]);
            if ($checkup->visit) {
                $this->patientVisitRepository->update($checkup->visit, [
                    'status' => 'completed',
                    'handled_apoteker_id' => $apoteker->id,
                ]);
            }
        }

        return $prescription;
    }

    public function canPharmacistManage(?User $user): bool
    {
        if (!$user || !$user->role) {
            return false;
        }

        return strtolower($user->role->name) === 'apoteker';
    }
}
