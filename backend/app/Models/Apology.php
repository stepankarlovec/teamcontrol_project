<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Apology extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'text',
        'date',
        'team_id',
        'user_id',
        'dateFrom',
        'dateUntil',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
