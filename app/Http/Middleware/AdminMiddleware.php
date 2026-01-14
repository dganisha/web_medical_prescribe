<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AdminMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        $user = $request->user();
        $roleName = strtolower(optional($user?->role)->name ?? '');

        if ($roleName !== 'administrator') {
            abort(403);
        }

        return $next($request);
    }
}
