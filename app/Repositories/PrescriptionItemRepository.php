<?php

namespace App\Repositories;

use App\Models\PrescriptionItem;

class PrescriptionItemRepository
{
    public function createMany(int $prescriptionId, array $items): void
    {
        foreach ($items as $item) {
            PrescriptionItem::create([
                'prescription_id' => $prescriptionId,
                'medicine_id' => $item['medicine_id'],
                'dosage' => $item['dosage'],
                'frequency' => $item['frequency'],
                'duration' => $item['duration'],
                'quantity' => $item['quantity'] ?? 1,
                'notes' => $item['notes'] ?? null,
            ]);
        }
    }

    public function deleteByPrescription(int $prescriptionId): void
    {
        PrescriptionItem::where('prescription_id', $prescriptionId)->delete();
    }
}
