<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    use HasFactory;

    protected $fillable = ['date', 'location', 'creator_id', 'name', 'id', 'color', 'repeated', 'duration'];

    public function attendances()
    {
        return $this->hasMany(Attendance::class);
    }

    public function eventAssignees(){
        return $this->hasOne(EventAssignees::class);
    }

    public function creator(){
        return $this->hasOne(User::class, 'id', 'creator_id');
    }
}
