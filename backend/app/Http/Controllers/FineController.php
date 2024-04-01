<?php

namespace App\Http\Controllers;

use App\Models\Fine;
use Illuminate\Http\Request;

class FineController extends Controller
{
    public function createFine(Request $request)
    {
        /* TODO some validation of the permissions for this action */
        $request->validate([
            'name' => 'required',
            'amount' => 'required',
            'user_id' => 'required',
            'team_id' => 'required',
        ]);

        $fine = Fine::create([
            'name' => $request->name,
            'amount' => $request->amount,
            'user_id' => $request->user_id,
            'team_id' => $request->event_id,
        ]);

        return response()->json(['message' => 'Successfully created fine', 'fine' => $fine], 201);
    }

    public function updateFine(Request $request)
    {
        /* TODO some validation of the permissions for this action */
        $request->validate([
            'id' => 'required',
            'name' => 'required',
            'user_id' => 'required',
            'amount' => 'required',
        ]);

        $fine = Fine::where('id', $request->id)->first();

        $fine->name = $request->name;
        $fine->user_id = $request->user_id;
        $fine->amount = $request->amount;
        $fine->save();

        return response()->json(['message' => 'Successfully updated fine', 'fine' => $fine], 201);
    }

    public function deleteFine(Request $request)
    {
        /** TODO some validation of the permissions for this action */
        $request->validate([
            'id' => 'required',
        ]);

        $fine = Fine::where('id', $request->id)->first()->delete();

        return response()->json(['message' => 'Successfully deleted fine'], 201);
    }
}
