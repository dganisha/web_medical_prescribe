<?php

namespace App\Repositories;

use App\Models\Medicine;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;

class MedicineManagementRepository
{
    public function all(int $perPage = 10): LengthAwarePaginator
    {
        return Medicine::with(['prices' => function ($query) {
            $query->orderByDesc('effective_date');
        }])->orderBy('name')->paginate($perPage);
    }

    public function allCollection(): Collection
    {
        return Medicine::orderBy('name')->get();
    }

    public function pricesForMedicine(string $medicineId): Collection
    {
        $medicine = Medicine::find($medicineId);

        if (!$medicine) {
            $medicine = Medicine::where('medicines_central_id', $medicineId)->firstOrFail();
        }

        return $medicine->prices()
            ->orderByDesc('effective_date')
            ->get();
    }
}
