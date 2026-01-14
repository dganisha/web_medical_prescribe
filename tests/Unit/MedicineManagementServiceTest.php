<?php

namespace Tests\Unit;

use App\Models\Medicine;
use App\Services\MedicineManagementService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class MedicineManagementServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_list_medicines_orders_by_name(): void
    {
        Medicine::create(['name' => 'Zinc', 'medicines_central_id' => 'm-1']);
        Medicine::create(['name' => 'Aspirin', 'medicines_central_id' => 'm-2']);

        $service = app(MedicineManagementService::class);
        $medicines = $service->listMedicines();

        $this->assertSame('Aspirin', $medicines->first()->name);
        $this->assertSame('Zinc', $medicines->last()->name);
    }
}
