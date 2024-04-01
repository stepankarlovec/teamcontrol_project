<?php

namespace App\Http\Controllers;

use App\Models\Team;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TeamController extends Controller
{

    //
    // THE REST API CONVENTION
    //
    public function createTeam(Request $request)
    {
        /* TODO some validation of the permissions for this action */

        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'country' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'error' => $validator->errors()->first()], 422);
        }

        $team = Team::create([
            'name' => $request->name,
            'country' => $request->country
        ]);

        // update users team_id
        $request->user()->team_id = $team->id;
        $request->user()->role = 1;
        $request->user()->save();

        return response()->json(['message' => 'Successfully created team', 'team' => $team], 201);
    }

    public function editTeam(Request $request){
        /* TODO some validation of the permissions for this action */

        $request->validate([
            'id' => 'required',
            'name' => 'required',
            'country' => 'required',
        ]);

        $team = Team::where('id', $request->id)->first();

        $team->name = $request->name;
        $team->country = $request->country;
        $team->save();

        return response()->json(['message' => 'Successfully edited team', 'team' => $team], 201);
    }

    public function teams()
    {
        $swag = Team::all();
        foreach ($swag as $team) {
            $team->users = $team->users;
            foreach ($team->users as $user) {
                $user->person = $user->person;
            }
        }
        return response()->json($swag, 200, [], JSON_PRETTY_PRINT);
    }

    public function team(int $id)
    {
        $swag = Team::find($id);
        $swag->users = $swag->users;
        foreach ($swag->users as $user) {
            $user->person = $user->person;
        }
        return response()->json($swag, 200, [], JSON_PRETTY_PRINT);
    }

    //
    // THE REST API CONVENTION ENDS HERE
    //

    public function addUserToTeam(Request $request)
    {
        /* TODO some validation of the permissions for this action */
        $request->validate([
            'user_id' => 'required',
            'team_id' => 'required',
        ]);

        $user = User::where('id', $request->user_id)->first();
        $user->update([
            'team_id' => $request->team_id
        ]);

        return response()->json(['message' => 'Successfully added user to team'], 201);
    }

    public function removeUserFromTeam(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
        ]);
        if($request->user()->id != $request->user_id && $request->user()->role>=1) {
            $user = User::where('id', $request->user_id)->first();
            $user->team_id = null;
            $user->save();
        }else{
            return response()->json(['message' => 'Cant perform this action !', 'error' => "sorry"], 422);
        }

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'error' => $validator->errors()->first()], 422);
        }

        return response()->json(['message' => 'Successfully removed user from team'], 201);
    }
}
