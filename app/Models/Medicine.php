<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medicine extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'medicines_central_id',
    ];

    public function prices()
    {
        return $this->hasMany(MedicinePrice::class);
    }
}
