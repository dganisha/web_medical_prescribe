<?php

namespace App\Jobs;

use App\Services\MedicineService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class SyncMedicinesJob implements ShouldQueue
{
    /**
     * Create a new job instance.
     */
    public function __construct()
    {
        //
    }

    /**
     * Execute the job.
     */
    public function handle(MedicineService $medicineService): void
    {
        try {
            $result = $medicineService->synchronize();
            Log::info('Medicine synchronization completed', $result);
        } catch (\Throwable $exception) {
            Log::error('Medicine synchronization failed', [
                'error' => $exception->getMessage(),
            ]);
        }
    }
}
