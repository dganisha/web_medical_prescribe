<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PatientVisit extends Model
{
    use HasFactory;

    protected $fillable = [
        'patient_id',
        'registered_by',
        'handled_doctor_id',
        'handled_apoteker_id',
        'status',
        'registered_at',
    ];

    protected $casts = [
        'registered_at' => 'datetime',
    ];

    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }

    public function registeredBy()
    {
        return $this->belongsTo(User::class, 'registered_by');
    }

    public function doctor()
    {
        return $this->belongsTo(User::class, 'handled_doctor_id');
    }

    public function apoteker()
    {
        return $this->belongsTo(User::class, 'handled_apoteker_id');
    }

    public function checkup()
    {
        return $this->hasOne(CheckupResult::class, 'visit_id');
    }
}
