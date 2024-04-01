<?php

namespace App\Http\Controllers;

use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class MessageController extends Controller
{
    public function message($id){

    }
    public function messages(){

    }
    public function createMessage(Request $request){
        $validator = Validator::make($request->all(), [
            'message' => 'required',
            'user_id' => 'required',
        ]);

        $user = Auth::user();


        if ($validator->fails()) {
            return response()->json(['message' => 'Wrong fields received', 'error' => $validator->errors()->first()], 422);
        }

        $event = Message::create([
            'message' => $request->message,
            'user_id' => $request->user_id,
            'team_id' => $user->team_id
        ]);

        return response()->json(['message' => 'successfully created an event'], 201, [], JSON_PRETTY_PRINT);
    }
    public function latestMessages(Request $request){
        $user = Auth::user();
        $res = $this->getTeamMessages($user->team->id);

        foreach ($res as $message) {
            $message->userName = $message->user->person->first_name . ' ' . $message->user->person->last_name ;
        }

        return response()->json($res, 201, [], JSON_PRETTY_PRINT);
    }

    public function deleteMessage($id){
        try{
            $m = Message::find($id);
            $m->delete();
        }catch (\Exception $e){
            return response()->json("Error $e", 500, [], JSON_PRETTY_PRINT);
        }
        return response()->json("Message deleted", 200, [], JSON_PRETTY_PRINT);
    }

    private function getTeamMessages($teamId){
        return Message::all()->where('team_id', $teamId)->sortBy('created_at')->reverse()->values();
    }
}
