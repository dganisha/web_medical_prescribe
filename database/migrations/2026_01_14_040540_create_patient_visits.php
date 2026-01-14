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
        Schema::create('patient_visits', function (Blueprint $table) {
            $table->id();
            $table->foreignId('patient_id')->constrained('patients')->onDelete('cascade');
            $table->unsignedBigInteger('registered_by')->nullable();
            $table->foreign('registered_by')->references('id')->on('users')->nullOnDelete();
            $table->unsignedBigInteger('handled_doctor_id')->nullable();
            $table->foreign('handled_doctor_id')->references('id')->on('users')->nullOnDelete();
            $table->unsignedBigInteger('handled_apoteker_id')->nullable();
            $table->foreign('handled_apoteker_id')->references('id')->on('users')->nullOnDelete();
            $table->string('status')->default('waiting_doctor');
            $table->timestamp('registered_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('patient_visits');
    }
};
