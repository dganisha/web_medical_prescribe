<?php

namespace App\Repositories;

use App\Models\MedicinePrice;
use Carbon\Carbon;

class MedicinePriceRepository
{
    public function findLatestActivePrice(int $medicineId, ?string $date = null): ?MedicinePrice
    {
        $dateValue = $date ? Carbon::parse($date)->toDateString() : now()->toDateString();

        return MedicinePrice::where('medicine_id', $medicineId)
            ->where('effective_date', '<=', $dateValue)
            ->where(function ($query) use ($dateValue) {
                $query->whereNull('end_date')
                    ->orWhere('end_date', '>=', $dateValue);
            })
            ->orderByDesc('effective_date')
            ->first();
    }

    public function findPriceForDate(int $medicineId, string $date): ?MedicinePrice
    {
        $dateValue = Carbon::parse($date)->toDateString();

        return MedicinePrice::where('medicine_id', $medicineId)
            ->where('effective_date', '<=', $dateValue)
            ->where(function ($query) use ($dateValue) {
                $query->whereNull('end_date')
                    ->orWhere('end_date', '>=', $dateValue);
            })
            ->orderByDesc('effective_date')
            ->first();
    }
}
