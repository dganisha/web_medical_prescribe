<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prescription extends Model
{
    use HasFactory;

    protected $fillable = [
        'checkup_result_id',
        'status',
        'served_at',
        'served_by',
    ];

    public function checkupResult()
    {
        return $this->belongsTo(CheckupResult::class);
    }

    public function items()
    {
        return $this->hasMany(PrescriptionItem::class);
    }

    public function servedBy()
    {
        return $this->belongsTo(User::class, 'served_by');
    }
}
