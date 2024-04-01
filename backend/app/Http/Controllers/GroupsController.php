<?php

namespace App\Http\Controllers;

use App\Models\Groups;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class GroupsController extends Controller
{
    public function group(int $id){
        $groups = Groups::all()->where('permanent', '=', 1)->where("team_id",'=', $id);

        if($groups==null){

        }
        return response()->json($groups, 200, [], JSON_PRETTY_PRINT);
    }

    public function createGroup(Request $request){
        $validator = Validator::make($request->all(), [
                'name' => 'required',
                'users' => 'required',
                'team_id' => 'required',
                'permanent' => 'required',
            ]
        );

        if ($validator->fails()) {
            return response()->json(['message' => 'Wrong fields received', 'error' => $validator->errors()->first()], 422);
        }

        $group = Groups::create([
            'name' => $request->name,
            'users' => $request->users,
            'team_id' => intval($request->team_id),
            'permanent' => intval($request->permanent)
        ]);

        return response()->json(['message'=>'Successfully created a group.'], 201);
    }
}
