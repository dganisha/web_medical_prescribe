<?php

namespace App\Services;

use App\Repositories\MedicineManagementRepository;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;

class MedicineManagementService
{
    private MedicineManagementRepository $medicineRepository;
    public function __construct(
        MedicineManagementRepository $medicineRepository
    )
    {
        $this->medicineRepository = $medicineRepository;
    }

    public function listMedicines(int $perPage = 10): LengthAwarePaginator
    {
        return $this->medicineRepository->all($perPage);
    }

    public function listMedicinesCollection(): Collection
    {
        return $this->medicineRepository->allCollection();
    }

    public function listMedicinePrices(string $medicineId): Collection
    {
        return $this->medicineRepository->pricesForMedicine($medicineId);
    }
}
