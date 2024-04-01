<?php

namespace App\Http\Controllers;

use App\Models\Roster;
use Illuminate\Http\Request;

class RosterController extends Controller
{
    public function getRoster($id){

        $roster = Roster::where('id', $id)->first();

        return response()->json(['message' => 'Retrieved roster', 'roster' => $roster], 201);
    }
    public function editRoster(Request $request){
        /* TODO some validation of the permissions for this action */

        $request->validate([
            'id' => 'required',
            'players' => 'required',
        ]);

        $roster = Roster::where('id', $request->id)->first();

        $roster->players = $request->players;
        $roster->save();

        return response()->json(['message' => 'Successfully edited team roster', 'roster' => $roster], 201);
    }
}
