<?php

use App\Http\Controllers\MedicineController;
use Illuminate\Support\Facades\Route;

Route::prefix('medicines')->name('api.medicines.')->group(function () {
    Route::get('/', [MedicineController::class, 'fetchMedicines'])->name('index');
    Route::get('/{medicineId}/prices', [MedicineController::class, 'fetchMedicinePrices'])->name('prices');
    Route::post('/save', [MedicineController::class, 'saveMedicines'])->name('save');
    Route::post('/{medicineId}/prices/save', [MedicineController::class, 'saveMedicinePrices'])->name('prices.save');
    Route::post('/synchronize', [MedicineController::class, 'synchronize'])->name('synchronize');
});
