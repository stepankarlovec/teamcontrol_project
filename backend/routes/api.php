<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


// general GET routes

// users
Route::get('user', 'App\Http\Controllers\UserController@users');
Route::get('user/{id}', 'App\Http\Controllers\UserController@user');

// teams
Route::get('team', 'App\Http\Controllers\TeamController@teams');
Route::get('team/{id}', 'App\Http\Controllers\TeamController@team');
Route::get('team/{id}/users', 'App\Http\Controllers\UserController@usersFromTeam');

// groups
Route::get('group/{id}', [\App\Http\Controllers\GroupsController::class, 'group']);

// team roster
Route::get('roster/{id}', 'App\Http\Controllers\RosterController@rosters');

// get message
Route::get('message', 'App\Http\Controllers\MessageController@messages');
Route::get('message/{id}', 'App\Http\Controllers\MessageController@message');


// get attendances
Route::get('attendance', 'App\Http\Controllers\AttendanceController@attendances');
Route::get('attendance/{id}', 'App\Http\Controllers\AttendanceController@attendance');
Route::get('attendancesByEvent/{id}', 'App\Http\Controllers\AttendanceController@attendancesByEvent');
Route::get('attendancesByUser/{id}', 'App\Http\Controllers\AttendanceController@attendancesByUser');



Route::post('register', 'App\Http\Controllers\AuthController@register');
Route::post('token', 'App\Http\Controllers\AuthController@requestToken');


Route::middleware('auth:sanctum')->get('/auth', function (Request $request) {
    return $request->user();
});


// general post/put/patch/delete routes
// only with bearer token
Route::middleware('auth:sanctum')->group(function () {

    // latest events
    Route::get('latest/events', 'App\Http\Controllers\EventController@latestEvents');
    // latest messages
    Route::get('latest/messages', 'App\Http\Controllers\MessageController@latestMessages');
    //
    Route::get('apology/{id}', 'App\Http\Controllers\ApologyController@userApology');

    Route::get('apologies/{teamId}', 'App\Http\Controllers\ApologyController@teamApologies');

    // TODO invitation
    // generates the invitation code
    Route::get('invitation', 'App\Http\Controllers\InvitationsController@createInvitation');
    // validates the invitation
    Route::post('invitation', 'App\Http\Controllers\InvitationsController@verifyInvitation');
    // deep link
    //Route::post('invitation/{code}');


    // events
    Route::get('allEvents', 'App\Http\Controllers\EventController@allEvents');
    Route::get('event', 'App\Http\Controllers\EventController@events');
    Route::get('event/user/{id}', 'App\Http\Controllers\EventController@getUsersEvents');
    Route::get('event/{id}', 'App\Http\Controllers\EventController@event');

    // team and users
    Route::post('team/user/add', 'App\Http\Controllers\TeamController@addUserToTeam');
    Route::post('teams/user/remove', 'App\Http\Controllers\TeamController@removeUserFromTeam');

    // teams
    Route::post('team', 'App\Http\Controllers\TeamController@createTeam');
    Route::put('team/{id}', 'App\Http\Controllers\TeamController@editTeam');
    Route::delete('team/{id}', [\App\Http\Controllers\TeamController::class, 'deleteTeam']);

    // groups
    Route::post('group', [\App\Http\Controllers\GroupsController::class, 'createGroup']);
    Route::put('group/{id}', [\App\Http\Controllers\GroupsController::class, 'editGroup']);
    Route::delete('group/{id}', [\App\Http\Controllers\TeamController::class, 'deleteTeam']);

    // EVENT
    Route::post('event', 'App\Http\Controllers\EventController@createEvent');
    Route::put('event', 'App\Http\Controllers\EventController@updateEvent');
    Route::delete('event/{id}', 'App\Http\Controllers\EventController@deleteEvent');

    // APOLOGY
    Route::post('apology', 'App\Http\Controllers\ApologyController@createApology');
    //Route::put('apology/{id}', 'App\Http\Controllers\ApologyController@updateApology');
    Route::delete('apology/{id}', 'App\Http\Controllers\ApologyController@deleteApology');

    // ATTENDANCE
    /*
    Route::post('attendance', 'App\Http\Controllers\AttendanceController@createAttendance');
    Route::put('attendance/{id}', 'App\Http\Controllers\AttendanceController@updateAttendance');
    Route::delete('attendance/{id}', 'App\Http\Controllers\AttendanceController@deleteAttendance');
    */

    // MESSAGE
    Route::post('message', 'App\Http\Controllers\MessageController@createMessage');
    //Route::put('message/{id}', 'App\Http\Controllers\MessageController@updateMessage');
    Route::delete('message/{id}', 'App\Http\Controllers\MessageController@deleteMessage');


    // FINE
    Route::post('fine', 'App\Http\Controllers\FineController@createFine');
    Route::put('fine/{id}', 'App\Http\Controllers\FineController@updateFine');
    Route::delete('fine/{id}', 'App\Http\Controllers\FineController@deleteFine');

    // roster
    Route::put('roster/{id}', 'App\Http\Controllers\RosterController@editRoster');

    // profile edit
    Route::post('person/edit', 'App\Http\Controllers\PersonController@addPersonDetails');
    Route::get('person/{id}', 'App\Http\Controllers\PersonController@getPersonDetails');

    Route::delete('user/delete', 'App\Http\Controllers\UserController@deleteUser');

    Route::post('user/changerole', 'App\Http\Controllers\UserController@changeRole');
});
