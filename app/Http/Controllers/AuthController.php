<?php

namespace App\Http\Controllers;

use App\Services\ActivityLogService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    private ActivityLogService $activityLogService;

    public function __construct(ActivityLogService $activityLogService)
    {
        $this->activityLogService = $activityLogService;
    }

    public function showLogin()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required', 'string'],
        ]);

        if (Auth::attempt($credentials)) {
            if (auth()->user()?->is_nonactive) {
                $this->activityLogService->log(
                    'auth.login_blocked',
                    auth()->user(),
                    null,
                    'Login blocked for nonactive user.'
                );
                Auth::logout();
                return back()
                    ->withErrors(['email' => 'Akun Anda nonaktif. Hubungi administrator.'])
                    ->onlyInput('email');
            }

            $request->session()->regenerate();

            $this->activityLogService->log(
                'auth.login',
                auth()->user(),
                null,
                'User logged in.'
            );

            return redirect()->intended('/');
        }

        $this->activityLogService->log(
            'auth.login_failed',
            null,
            null,
            'Login failed.',
            ['email' => $credentials['email'] ?? null]
        );

        return back()
            ->withErrors(['email' => 'Email atau password tidak sesuai.'])
            ->onlyInput('email');
    }

    public function logout(Request $request)
    {
        $user = auth()->user();
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        $this->activityLogService->log(
            'auth.logout',
            $user,
            null,
            'User logged out.'
        );

        return redirect('/');
    }
}
