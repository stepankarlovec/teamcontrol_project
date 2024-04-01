<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardAdmin;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/


Route::get('/', function () {
    return view('pages.homepage');
});

Route::get('/removeaccount', [UserController::class, 'removeAccount']);
Route::post('/removeaccount', [UserController::class, 'removeAccountHandle']);

Route::get('/.well-known/assetlinks.json', function (){
    $data = \Illuminate\Support\Facades\Storage::get('.well-known/assetlinks.json');
    $data = json_decode($data, true);
    return response()->json($data);
});

Route::get('/login', function () {
    return view('pages.login');
});
Route::post('/login', [AuthController::class, 'loginSuperAdmin'])->name('loginSuperAdmin');

Route::middleware(['checkRole'])->group(function () {
    Route::get('/dashboard', [DashboardAdmin::class, 'index'])->name('dashboard');
    // lists
    Route::get('/user', [DashboardAdmin::class, 'users'])->name('users');
    Route::get('/team', [DashboardAdmin::class, 'teams'])->name('teams');
    Route::get('/event', [DashboardAdmin::class, 'events'])->name('events');
    // editing
    Route::get('/user/{id}', [DashboardAdmin::class, 'user'])->name('user');
    Route::post('/user/{id}', [DashboardAdmin::class, 'updateUser'])->name('updateUser');
    Route::get('/event/{id}', [DashboardAdmin::class, 'event'])->name('event');
    Route::post('/event/{id}', [DashboardAdmin::class, 'updateEvent'])->name('updateEvent');
    Route::get('/team/{id}', [DashboardAdmin::class, 'team'])->name('team');
    Route::post('/team/{id}', [DashboardAdmin::class, 'updateTeam'])->name('updateTeam');

});
