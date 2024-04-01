<?php

namespace App\Http\Controllers;

use App\Models\Event;
use App\Models\Team;
use App\Models\User;
use Illuminate\Http\Request;

class DashboardAdmin extends Controller
{
    public function index(){
        return view('pages.dashboard');
    }

    public function users(){
        $users = User::paginate(10);
        return view('pages.users', compact('users'));
    }
    public function user($id){
        $user = User::findOrFail($id);
        return view('pages.editUser', compact('user'));
    }
    public function updateUser(Request $request, $id){
        $request->validate([
            'email' => 'required',
            'team' => 'required',
            'role' => 'required',
            'person_id' => 'required',

        ]);

        $t = User::find($id)->update([
            'email' => $request->email,
            'team' => $request->team,
            'role' => $request->role,
            'person_id' => $request->person_id
        ]);

        return redirect('/user/'.$id)->with('message', 'Successfully edited.');
    }

    public function teams(){
        $teams = Team::paginate(10);
        return view('pages.teams', compact('teams'));
    }
    public function team($id){
        $team = Team::findOrFail($id);
        return view('pages.editTeam', compact('team'));
    }
    public function updateTeam(Request $request, $id){
        $request->validate([
            'name' => 'required',
            'country' => 'required',
        ]);

        $t = Team::find($id)->update([
           'name' => $request->name,
           'country' => $request->country
        ]);

        return redirect('/team/'.$id)->with('message', 'Successfully edited.');
    }

    public function events(){
        $events = Event::paginate(10);
        return view('pages.events', compact('events'));
    }

    public function event($id){
        $event = Event::findOrFail($id);
        return view('pages.editEvent', compact('event'));
    }

    public function updateEvent(Request $request, $id){
        $request->validate([
            'name' => 'required',
            'country' => 'required',
        ]);

        $t = Team::find($id)->update([
            'name' => $request->name,
            'country' => $request->country
        ]);

        return redirect('/team/'.$id)->with('message', 'Successfully edited.');
    }
}
