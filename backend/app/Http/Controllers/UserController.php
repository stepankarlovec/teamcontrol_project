<?php

namespace App\Http\Controllers;

use App\Models\Person;
use App\Models\User;
use App\Models\Team;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function users()
    {
        return response()->json(User::with('person')->get(), 200, [], JSON_PRETTY_PRINT);
    }

    public function user($id)
    {
        return response()->json(User::with('person')->find($id), 200, [], JSON_PRETTY_PRINT);
    }

    public function usersFromTeam(int $id){
        $t = Team::with('users.person')->find($id);
        return response()->json($t, 200, [], JSON_PRETTY_PRINT);
    }

    public function removeAccount(){
        $user = Auth::user();
        if($user){
            return view('pages.removeAccount');
        }else{
            return redirect('/login')->withErrors(['msg' => "You don't have permissions for this"]);
        }
    }

    public function deleteUser(Request $request){
        try {
            $u = $request->user();
            foreach($u->apologies() as $a){
                $a->delete();
            }
            foreach ($u->attendances() as $a) {
                $a->delete();
            }
            foreach ($u->message() as $m) {
                $m->delete();
            }
            $p = $u->person;
            $u->delete();
            $p->delete();

        }catch (\Exception $e){
            return response()->json(["message"=>"something went wrong", "error" => $e->getMessage()], 500, [], JSON_PRETTY_PRINT);
        }

        return response()->json(["message"=>"success"], 200, [], JSON_PRETTY_PRINT);
    }

    public function changeRole(Request $request){
        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(['message' => 'Wrong parameters', 'error' => $validator->errors()->first()], 422);
        }
        if($request->user()->role>=1 && $request->user_id != $request->user()->id) {
            $u = User::find($request->user_id);
            if($u->team_id!=$request->user()->team_id){
                return response()->json(['message' => 'You are not in the same team.', 'error' => $validator->errors()->first()], 422);
            }else if($u->role == 0){
                $u->role = 1;
                $u->save();
                return response()->json(['message' => 'Successfully granted admin rights'], 200);
            }else if($u->role == 1) {
                $u->role = 0;
                $u->save();
                return response()->json(['message' => 'Successfully demoted'], 200);
            }
        }
        return response()->json(['message' => 'Something went wrong', 'error' => $validator->errors()->first()], 422);
    }

    public function removeAccountHandle(){
        return "swag";
    }
}
