<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Services\AdminService;

class DashboardController extends Controller
{
    private AdminService $adminService;

    public function __construct(AdminService $adminService)
    {
        $this->adminService = $adminService;
    }

    public function index()
    {
        $this->authorizeAdmin();

        return view('admin.dashboard');
    }

    private function authorizeAdmin(): void
    {
        if (!$this->adminService->canAdmin(auth()->user())) {
            abort(403);
        }
    }
}
