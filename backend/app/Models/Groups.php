<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Groups extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'users', 'permanent', 'team_id'];

    public function eventAssignees(){
        return $this->hasMany(EventAssignees::class);
    }
}
