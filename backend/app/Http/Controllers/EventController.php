<?php

namespace App\Http\Controllers;

use App\Models\Event;
use App\Models\EventAssignees;
use App\Models\Groups;
use App\Models\User;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Collection;


class EventController extends Controller
{
    public function createEvent(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'date' => 'required',
            'duration' => 'required|numeric',
            'repeated' => 'numeric',
            'location' => 'required',
            'creator_id' => 'required',
            'individualParticipants' => '',
            'groups' => '',
            'color' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Wrong fields received', 'error' => $validator->errors()->first()], 422);
        }

        $event = Event::create([
            'name' => $request->name,
            'date' => new DateTime($request->date),
            'duration' => $request->duration,
            'repeated' => isset($request->repeated) ? $request->repeated : 0,
            'location' => $request->location,
            'creator_id' => $request->creator_id,
            'color' => $request->color,
        ]);

        $creator = User::find($event['creator_id']);

            if (!$request->individualParticipants == "") {
                $arr = explode(';', $request->individualParticipants);


                if (count($arr) <= 1) {
                    EventAssignees::create([
                        'event_id' => $event['id'],
                        'team_id' => $creator['team_id'],
                        'type' => 0,
                        'user_id' => $arr[0]
                    ]);
                } else {
                    $g = Groups::create([
                        'users' => $request->individualParticipants,
                        'permanent' => 0,
                        'team_id' => $creator['team_id']
                    ]);
                    EventAssignees::create([
                        'event_id' => $event['id'],
                        'type' => 1,
                        'team_id' => $creator['team_id'],
                        'group_id' => $g['id']
                    ]);
                }
            } else {
                if($request->groups!=""){
                    EventAssignees::create([
                        'event_id' => $event['id'],
                        'type' => 2,
                        'team_id' => $creator['team_id'],
                        'group_id' => intval($request->groups)
                    ]);
                    }else{
                    return response()->json(['message' => 'Wrong fields received', 'error' => 'No users selected ' . $request->groups], 422);
                }
            }

        return response()->json(['message' => 'successfully created an event'], 201, [], JSON_PRETTY_PRINT);
    }

    public function updateEvent(Request $request){
        $request->validate([
            'id' => 'required',
            'name' => 'required',
            'date' => 'required',
            'duration' => 'required|numeric',
            'repeated' => 'numeric',
            'location' => 'required',
            'color' => 'required',
            'creator_id' => 'required',
        ]);
        $event = Event::find($request->id)->update([
            'name' => $request->name,
            'date' => $request->date,
            'duration' => $request->duration,
            'repeated' => isset($request->repeated) ? $request->repeated : 0,
            'location' => $request->location,
            'creator_id' => $request->creator_id,
            'color' => $request->color
        ]);

        return response()->json($event, 200, [], JSON_PRETTY_PRINT);
    }

    public function deleteEvent($id){
        try {
            $event = Event::find($id);
            $event->eventAssignees()->delete();
            $event->delete();
        }catch (\Exception $e){
            return response()->json("Error $e", 500, [], JSON_PRETTY_PRINT);
        }

        return response()->json("Event deleted", 200, [], JSON_PRETTY_PRINT);
    }

    // get functions
    public function events(Request $request)
    {
        $data = $this->getUsersEventsByRequest($request);
        return response()->json($data, 200, [], JSON_PRETTY_PRINT);
    }

    public function allEvents(Request $request){
        $data = new Collection(); // Instantiate $data as a collection
        $users = User::all()->where('team_id', $request->user()->team_id);

        foreach ($users as $user){
            $ud = Event::all()->where('creator_id', $user->id);
            $data = $data->merge($ud);
        }

        return response()->json($data, 200, [], JSON_PRETTY_PRINT);
    }


    public function latestEvents(Request $request){
        $data = $this->getUsersEventsByRequest($request);
        if(is_array($data)) {
            $data = array_slice($data, 0, 5);
        }
        return response()->json($data, 200, [], JSON_PRETTY_PRINT);
    }

    public function getUsersEvents($id){
        $data = $this->getUserEventsByUserId($id);
        return response()->json($data, 200, [], JSON_PRETTY_PRINT);
    }

    private function getUserEventsByUserId(int $userId){
        $data = [];

        $user = User::where('id', $userId)->first();

        // Retrieve personal events
        $personalEvents = EventAssignees::where('team_id', $user->team_id)
            ->where('user_id', $user->id)
            ->get();

        $data = array_merge($data, $personalEvents->pluck('event')->toArray());

        // Retrieve group events
        $userIds = $personalEvents->pluck('user_id')->toArray();
        $groupEvents = EventAssignees::where('team_id', $user->team_id)
            ->whereNull('user_id')
            ->whereNotNull('group_id')
            ->get();

        $newData = [];
        foreach ($groupEvents as $ge){
            $arr = explode(';', $ge->group->users);
            if(in_array($user->id, $arr)) {
                $newData[] = $ge->event->toArray();
            }
        }

        // Merge the new data array into the main data array
        $data = array_merge($data, $newData);

        return $data;
    }


    private function getUsersEventsByRequest(Request $request)
    {
        $data = [];

        // Retrieve personal events
        $personalEvents = EventAssignees::where('team_id', $request->user()->team_id)
            ->where('user_id', $request->user()->id)
            ->get();

        $data = array_merge($data, $personalEvents->pluck('event')->toArray());

        // Retrieve group events
        $userIds = $personalEvents->pluck('user_id')->toArray();
        $groupEvents = EventAssignees::where('team_id', $request->user()->team_id)
            ->whereNull('user_id')
            ->whereNotNull('group_id')
            ->get();

        $newData = [];
        foreach ($groupEvents as $ge){
            $arr = explode(';', $ge->group->users);
            if(in_array($request->user()->id, $arr)) {
                $newData[] = $ge->event->toArray();
            }
        }

        // Merge the new data array into the main data array
        $data = array_merge($data, $newData);

        return $data;
    }



    public function event($id)
    {
        return response()->json(Event::with('attendances')->find($id), 200, [], JSON_PRETTY_PRINT);
    }
}
