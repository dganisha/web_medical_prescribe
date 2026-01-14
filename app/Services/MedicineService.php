<?php

namespace App\Services;

use App\Repositories\MedicineRepository;
use App\Models\Medicine;
use App\Models\MedicinePrice;
use Carbon\Carbon;

class MedicineService
{
    protected MedicineRepository $medicineRepository;

    public function __construct(MedicineRepository $medicineRepository)
    {
        $this->medicineRepository = $medicineRepository;
    }

    public function getMedicines(): array
    {
        return $this->medicineRepository->fetchMedicines();
    }

    public function getMedicinePrices(string $medicineId): array
    {
        return $this->medicineRepository->fetchMedicinePrices($medicineId);
    }

    public function saveMedicines(): bool
    {
        $medicines = $this->medicineRepository->fetchMedicines();

        foreach ($medicines as $medicineData) {
            $centralId = data_get($medicineData, 'id');
            $name = data_get($medicineData, 'name');

            if (!$centralId || !$name) {
                continue;
            }

            Medicine::updateOrCreate(
                ['medicines_central_id' => $centralId],
                ['name' => $name]
            );
        }

        return true;
    }

    public function saveMedicinePrices(string $medicineId): bool
    {
        $prices = $this->medicineRepository->fetchMedicinePrices($medicineId);
        $medicine = Medicine::where('medicines_central_id', $medicineId)->first();

        if (!$medicine) {
            return false;
        }

        foreach ($prices as $priceData) {
            $startDate = $this->formatDate(data_get($priceData, 'start_date.value'));
            $endDate = $this->formatDate(data_get($priceData, 'end_date.value'));
            $unitPrice = data_get($priceData, 'unit_price');

            if (!$startDate || $unitPrice === null) {
                continue;
            }

            MedicinePrice::updateOrCreate(
                ['medicine_id' => $medicine->id, 'effective_date' => $startDate],
                [
                    'price' => $unitPrice,
                    'end_date' => $endDate,
                ]
            );
        }

        return true;
    }

    public function synchronize(): array
    {
        $medicines = $this->medicineRepository->fetchMedicines();
        $medicineCount = 0;
        $priceCount = 0;

        foreach ($medicines as $medicineData) {
            $centralId = data_get($medicineData, 'id');
            $name = data_get($medicineData, 'name');

            if (!$centralId || !$name) {
                continue;
            }

            $medicine = Medicine::updateOrCreate(
                ['medicines_central_id' => $centralId],
                ['name' => $name]
            );
            $medicineCount += 1;

            $prices = $this->medicineRepository->fetchMedicinePrices($centralId);

            foreach ($prices as $priceData) {
                $startDate = $this->formatDate(data_get($priceData, 'start_date.value'));
                $endDate = $this->formatDate(data_get($priceData, 'end_date.value'));
                $unitPrice = data_get($priceData, 'unit_price');

                if (!$startDate || $unitPrice === null) {
                    continue;
                }

                MedicinePrice::updateOrCreate(
                    [
                        'medicine_id' => $medicine->id,
                        'effective_date' => $startDate,
                    ],
                    [
                        'price' => $unitPrice,
                        'end_date' => $endDate,
                    ]
                );
                $priceCount += 1;
            }
        }

        return [
            'medicines' => $medicineCount,
            'prices' => $priceCount,
        ];
    }

    private function formatDate(?string $value): ?string
    {
        if (!$value) {
            return null;
        }

        try {
            return Carbon::parse($value)->toDateString();
        } catch (\Throwable $exception) {
            return null;
        }
    }
}
