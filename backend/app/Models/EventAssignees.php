<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EventAssignees extends Model
{
    use HasFactory;

    protected $fillable = ['event_id', 'team_id', 'type', 'user_id', 'group_id'];

    public function event(){
        return $this->belongsTo(Event::class);
    }
    public function group(){
        return $this->belongsTo(Groups::class);
    }
}
