<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MedicinePrice extends Model
{
    use HasFactory;

    protected $fillable = [
        'medicine_id',
        'price',
        'effective_date',
        'end_date',
    ];

    public function medicine()
    {
        return $this->belongsTo(Medicine::class);
    }
}
