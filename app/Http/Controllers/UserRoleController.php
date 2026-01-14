<?php

namespace App\Http\Controllers;

use App\Models\UserRole;
use App\Services\ActivityLogService;
use App\Services\UserRoleService;
use Illuminate\Http\Request;

class UserRoleController extends Controller
{
    private UserRoleService $userRoleService;
    private ActivityLogService $activityLogService;

    public function __construct(
        UserRoleService $userRoleService,
        ActivityLogService $activityLogService
    ) {
        $this->userRoleService = $userRoleService;
        $this->activityLogService = $activityLogService;
    }

    public function index()
    {
        $userRoles = $this->userRoleService->listUserRoles();

        return view('user_roles.index', compact('userRoles'));
    }

    public function create()
    {
        return view('user_roles.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255', 'unique:user_roles,name'],
        ]);

        $role = $this->userRoleService->createUserRole($validated);

        $this->activityLogService->log(
            'roles.created',
            auth()->user(),
            $role,
            'Role created.'
        );

        return redirect()->route('user_roles.index')->with('success', 'User role created successfully.');
    }

}
