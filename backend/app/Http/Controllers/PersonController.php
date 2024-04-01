<?php

namespace App\Http\Controllers;

use App\Models\Person;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PersonController extends Controller
{
    public function addPersonDetails(Request $request){
        $validator = Validator::make($request->all(), [
            'person_id'=>'required',
            'first_name'=>'string|required',
            'last_name'=>'string|required',
            'height'=>'numeric|required',
            'weight'=>'numeric|required',
            'position'=>'',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'error' => $validator->errors()->first()], 422);
        }

        Person::where('id', $request->person_id)->update([
            'first_name'=>$request->first_name,
            'last_name'=>$request->last_name,
            'height'=>$request->height,
            'weight'=>$request->weight,
            'position'=>$request->position,
        ]);
        return response()->json(['message'=>'Successfully added person details'], 201);
    }

    public function getPersonDetails($id){
        if($id == null && !is_numeric($id)){
            return response()->json(['message'=>'Something went wrong..', 'error' => 'Invalid argument exception'], 400);
        }

        $person = Person::where('id', $id)->first();

        return response()->json(['profile' => $person], 201);
    }
}
