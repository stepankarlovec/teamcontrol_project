<?php

namespace App\Http\Controllers;

use App\Models\Apology;
use App\Models\User;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Date;
use Illuminate\Support\Facades\Validator;

class ApologyController extends Controller
{

    // retrieve users apology
    public function userApology($id){

        $apologies = Apology::all()->where('user_id', $id);
        if(count($apologies)==0){
            return response()->json([[]], 400, [], JSON_PRETTY_PRINT);
        }
        return response()->json($apologies, 200, [], JSON_PRETTY_PRINT);
    }

    public function teamApologies($teamId){
        $apologies = Apology::all()->where('team_id', $teamId);
        if(count($apologies)==0){
            return response()->json([[]], 400, [], JSON_PRETTY_PRINT);
        }
        return response()->json($apologies, 200, [], JSON_PRETTY_PRINT);
    }

    public function createApology(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'text' => 'required',
            'dateFrom' => 'required',
            'dateUntil' => 'required',
            'user_id' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Wrong fields received', 'error' => $validator->errors()->first()], 422);
        }

        $u = User::find($request->user_id);

        //return response()->json(['message' => 'Wrong fields received', 'error' => [$request->dateFrom, $request->dateUntil]], 422);
        $apology = Apology::create([
            'name' => $request->name,
            'text' => $request->text,
            'dateFrom' => new DateTime($request->dateFrom),
            'dateUntil' => new DateTime($request->dateUntil),
            'user_id' => $request->user_id,
            'team_id' => $u->team->id,
        ]);

        return response()->json(['message' => 'Successfully created apology', 'apology' => $apology], 201);
    }

    public function updateApology(Request $request)
    {
        $request->validate([
            'id' => 'required',
            'name' => 'required',
            'text' => 'required',
            'date' => 'required',
            'user_id' => 'required',
            'event_id' => 'required',
        ]);

        $apology = Apology::where('id', $request->id)->first();

        $apology->name = $request->name;
        $apology->text = $request->text;
        $apology->date = $request->date;
        $apology->user_id = $request->user_id;
        $apology->event_id = $request->event_id;
        $apology->save();

        return response()->json(['message' => 'Successfully updated apology', 'apology' => $apology], 201);
    }

    public function deleteApology($id)
    {
        try {
            $apology = Apology::where('id', $id)->first()->delete();
        }catch (\Exception $e){
            return response()->json(['error' => $e], 500);
        }

        return response()->json(['message' => 'Successfully deleted apology'], 200);
    }
}
