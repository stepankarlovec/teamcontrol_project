<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{

    public function createAttendance(Request $request){
        /* TODO some validation of the permissions for this action */
        $request->validate([
            'state' => 'required',
            'user_id' => 'required',
            'event_id' => 'required',
        ]);

        $attendance = Attendance::create([
            'state' => $request->state,
            'user_id' => $request->user_id,
            'event_id' => $request->event_id,
        ]);

        return response()->json(['message' => 'Successfully created attendance', 'attendance' => $attendance], 201);
    }

    public function updateAttendance(Request $request){
        /* TODO some validation of the permissions for this action */
        $request->validate([
            'id' => 'required',
            'state' => 'required',
        ]);

        $attendance = Attendance::where('id', $request->id)->first();

        $attendance->state = $request->state;
        $attendance->save();

        return response()->json(['message' => 'Successfully updated attendance', 'attendance' => $attendance], 201);
    }

    public function deleteAttendance(Request $request){
        /* TODO some validation of the permissions for this action */
        $request->validate([
            'id' => 'required',
        ]);

        $attendance = Attendance::where('id', $request->id)->first();

        $attendance->delete();

        return response()->json(['message' => 'Successfully deleted attendance'], 201);
    }

    public function attendances()
    {
        return response()->json(Attendance::with('event', 'user')->get(), 200, [], JSON_PRETTY_PRINT);
    }

    public function attendance($id)
    {
        return response()->json(Attendance::with('event', 'user')->find($id), 200, [], JSON_PRETTY_PRINT);
    }

    public function attendancesByEvent($id)
    {
        return response()->json(Attendance::with('event', 'user')->where('event_id', $id)->get(), 200, [], JSON_PRETTY_PRINT);
    }

    public function attendancesByUser($id)
    {
        return response()->json(Attendance::with('event', 'user')->where('user_id', $id)->get(), 200, [], JSON_PRETTY_PRINT);
    }
}
