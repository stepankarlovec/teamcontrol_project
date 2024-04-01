<?php

namespace App\Http\Controllers;

use App\Models\Person;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $request){

        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users',
            'password' => 'required',
            'device_name' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'error' => $validator->errors()->first()], 422);
        }


        $person = Person::create();

        $user = User::create([
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'person_id' => $person->id,
        ]);

        return response()->json(['message' => 'Successfully registered', 'token' => $user->createToken($request->device_name)->plainTextToken], 201);
    }

    /**
     * Requesting the token
     * @param Request $request
     *
     * @return string token plain text
     * @throws ValidationException
     */
    public function requestToken(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
            'device_name' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => 'Validation failed', 'error' => $validator->errors()->first()], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Validation failed', 'error' => 'Wrong credentials'], 400);
        }

        return response()->json(['message' => 'Successfully logged in', 'token' => $user->createToken($request->device_name)->plainTextToken], 201);
    }


    public function loginSuperAdmin(Request $request)
    {
        $request->validate([
            'email' => 'required',
            'password' => 'required',
        ]);

        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();

            if ($user->role == 2) {
                return redirect('/dashboard')->with('message', 'Successfully logged in.');
            } else {
                return redirect('/removeaccount');
                //Auth::logout(); // Log out the user if they don't have the required role
                //return redirect('/login')->withErrors(['msg' => "You don't have permissions for this"]);
            }
        } else {
            return redirect('/login')->withErrors(['msg' => 'Wrong credentials.']);
        }
    }
}
