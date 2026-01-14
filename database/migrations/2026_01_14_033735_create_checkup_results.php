<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('checkup_results', function (Blueprint $table) {
            $table->id();
            $table->integer('patient_id')->nullable();
            $table->integer('doctor_id')->nullable();
            $table->integer('apoteker_id')->nullable();
            $table->integer('medicine_id')->nullable();
            $table->date('checkup_date');
            $table->text('diagnosis')->nullable();
            $table->string('tinggi_badan');
            $table->string('berat_badan');
            $table->string('sistole');
            $table->string('diastole');
            $table->string('heart_rate');
            $table->string('respiratory_rate');
            $table->string('temperature');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('checkup_results');
    }
};
