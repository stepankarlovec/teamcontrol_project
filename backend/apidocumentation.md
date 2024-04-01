


# TeamControl - API documentation

## users

***/api/user***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('user', 'App\Http\Controllers\UserController@users');
```

***/api/user/{id}***
```
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
method: GET<br>
Route::get('user/{id}', 'App\Http\Controllers\UserController@user');
```


***/api/user/delete***
```
method: DELETE<br>
entry parameters: bearer token<br>
response: ['status', 201]<br>
Route::delete('user/delete', 'App\Http\Controllers\UserController@deleteUser');
```

## teams
***/api/team***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('team', 'App\Http\Controllers\TeamController@teams');  
```

***/api/team/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('team/{id}', 'App\Http\Controllers\TeamController@team');  
```

***/api/team/{id}/users***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('team/{id}/users', 'App\Http\Controllers\UserController@usersFromTeam');  
```

***/api/group/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('group/{id}', [\App\Http\Controllers\GroupsController::class, 'group']);
```

***/api/message***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('message', 'App\Http\Controllers\MessageController@messages');  
```

***/api/message/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('message/{id}', 'App\Http\Controllers\MessageController@message');
```

***/api/attendance***
```
method: GET<br>
Route::get('attendance', 'App\Http\Controllers\AttendanceController@attendances');
```

***/api/attendance/{id}***  
```
method: GET<br>
Route::get('attendance/{id}', 'App\Http\Controllers\AttendanceController@attendance');  
```
***/api/attendancesByEvent/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('attendancesByEvent/{id}', 'App\Http\Controllers\AttendanceController@attendancesByEvent');  
```

***/api/attendancesByUser/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('attendancesByUser/{id}', 'App\Http\Controllers\AttendanceController@attendancesByUser');
```

## auth

***/api/register***
```
method: POST<br>
Route::post('register', 'App\Http\Controllers\AuthController@register');  
```
***/api/token***
```
Route::post('token', 'App\Http\Controllers\AuthController@requestToken');
```
# PROTECTED

  
***/api/latest/events***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('latest/events', 'App\Http\Controllers\EventController@latestEvents');  
```
***/api/latest/messages***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('latest/messages', 'App\Http\Controllers\MessageController@latestMessages');  
```
***/api/apology/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('apology/{id}', 'App\Http\Controllers\ApologyController@userApology');
```
***/api/apologies/{teamId}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('apologies/{teamId}', 'App\Http\Controllers\ApologyController@teamApologies');
```

## invitation
***/api/invitation***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('invitation', 'App\Http\Controllers\InvitationsController@createInvitation');  

```
***/api/invitation***
```
method: POST<br>
Route::post('invitation', 'App\Http\Controllers\InvitationsController@verifyInvitation');
```

## Getting events
***/api/allEvents***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('allEvents', 'App\Http\Controllers\EventController@allEvents');  
```
***/api/event***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('event', 'App\Http\Controllers\EventController@events');  
```
***/api/event/user/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('event/user/{id}', 'App\Http\Controllers\EventController@getUsersEvents');  

```
***/api/event/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('event/{id}', 'App\Http\Controllers\EventController@event');  
```
***/api/team/user/add***
method: POST<br>
Route::post('team/user/add', 'App\Http\Controllers\TeamController@addUserToTeam');  

***/api/teams/user/remove***
method: POST<br>
Route::post('teams/user/remove', 'App\Http\Controllers\TeamController@removeUserFromTeam');

## teams
***/api/team***
method: POST<br>
Route::post('team', 'App\Http\Controllers\TeamController@createTeam');  

***/api/team/{id}***
method: PUT<br>
Route::put('team/{id}', 'App\Http\Controllers\TeamController@editTeam');  

***/api/team/{id}***
method: DELETE<br>
Route::delete('team/{id}', [\App\Http\Controllers\TeamController::class, 'deleteTeam']);

## groups

***/api/group***
method: POST<br>
Route::post('group', [\App\Http\Controllers\GroupsController::class, 'createGroup']);  

***/api/group/{id}***
method: PUT<br>
Route::put('group/{id}', [\App\Http\Controllers\GroupsController::class, 'editGroup']);  

***/api/group/{id}***
method: DELETE<br>
Route::delete('group/{id}', [\App\Http\Controllers\TeamController::class, 'deleteTeam']);

## event creation / editation
***/api/event***
method: POST<br>
Route::post('event', 'App\Http\Controllers\EventController@createEvent');  

***/api/event***
method: PUT<br>
Route::put('event', 'App\Http\Controllers\EventController@updateEvent');  

***/api/event/{id}***
method: DELETE<br>
Route::delete('event/{id}', 'App\Http\Controllers\EventController@deleteEvent');

## apologies
***/api/apology***
method: POST<br>
Route::post('apology', 'App\Http\Controllers\ApologyController@createApology');

***/api/apology/{id}***  
method: DELETE<br>
Route::delete('apology/{id}', 'App\Http\Controllers\ApologyController@deleteApology');

## messages
***/api/message***
method: POST<br>
Route::post('message', 'App\Http\Controllers\MessageController@createMessage');  

***/api/message/{id}***
method: DELETE<br>
Route::delete('message/{id}', 'App\Http\Controllers\MessageController@deleteMessage');

## profile

***/api/person/{id}***
method: POST<br>
Route::post('person/edit', 'App\Http\Controllers\PersonController@addPersonDetails');  

***/api/person/{id}***
```
method: GET<br>
entry parameters: id<br>
response: ['message', 'data'], 201)<br>
Route::get('person/{id}', 'App\Http\Controllers\PersonController@getPersonDetails');  
```
