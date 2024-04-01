<?php

namespace App\Http\Controllers;

use App\Models\Invitations;
use App\Models\User;
use Carbon\Traits\Date;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class InvitationsController extends Controller
{
    public function verifyInvitation(Request $request){
        $validator = Validator::make($request->all(), [
            'code' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => "Wrong fields", 'error' => $validator->errors()->first()], 422);
        }

        $inv = Invitations::all()->where('link', $request->code)->first();

        $now = new DateTime();

        if(!$inv){
            return response()->json(['message' => "Invalid code.", 'error' => $validator->errors()->first()], 422);
        }elseif($now<$inv->duration){
            return response()->json(['message' => "Expired code", 'error' => $validator->errors()->first()], 422);
        } else{
            $u = User::where('id', $request->user()->id)->first();
            $u->update([
                'team_id' => $inv->team_id
            ]);
            return response()->json(['message' => "Successfully joined team"], 201);
        }


    }

    public function createInvitation(Request $request){
        $i = Invitations::create([
           'link' => $this->generateLink(),
           'duration' => $this->generateDuration(),
           'team_id' => $request->user()->team_id
        ]);

        return response()->json(['code' => $i->link], 200);
    }

    private function generateDuration(): DateTime{
        $now = new DateTime();
        // Add 30 days to the current date and time
        $now->modify('+30 days');
        // Return the resulting DateTime object
        return $now;
    }
    private function generateLink(): string{
        $code = $this->generateUniqueCode();

        // Check if the generated code already exists in the database
        while ($this->codeExistsInDatabase($code)) {
            $code = $this->generateUniqueCode();
        }

        return $code;
    }

    private function generateUniqueCode(){
        // Generate a random 10-character alphanumeric code
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $code = '';

        for ($i = 0; $i < 10; $i++) {
            $code .= $characters[rand(0, strlen($characters) - 1)];
        }

        return $code;
    }

    private function codeExistsInDatabase($code){
        // Check if the code already exists in the Invitations table
        return DB::table('invitations')->where('link', $code)->exists();
    }

}
