<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class CheckRoleMiddleware
{
    public function handle($request, Closure $next)
    {
        // Check if the user is authenticated
        if (Auth::check()) {
            // Check if the user has the required role (role == 2)
            if (Auth::user()->role == 2) {
                return $next($request);
            }
        }

        // Redirect or handle unauthorized access
        return abort(403, 'Unauthorized');
    }
}
