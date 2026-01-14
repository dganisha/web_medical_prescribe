<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Services\AdminService;

class MedicalHistoryController extends Controller
{
    private AdminService $adminService;

    public function __construct(AdminService $adminService)
    {
        $this->adminService = $adminService;
    }

    public function index()
    {
        $this->authorizeAdmin();

        $histories = $this->adminService->listMedicalHistory();

        return view('admin.history.index', compact('histories'));
    }

    private function authorizeAdmin(): void
    {
        if (!$this->adminService->canAdmin(auth()->user())) {
            abort(403);
        }
    }
}
