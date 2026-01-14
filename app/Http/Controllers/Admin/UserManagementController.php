<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Services\ActivityLogService;
use App\Services\AdminService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserManagementController extends Controller
{
    private AdminService $adminService;
    private ActivityLogService $activityLogService;

    public function __construct(AdminService $adminService, ActivityLogService $activityLogService)
    {
        $this->adminService = $adminService;
        $this->activityLogService = $activityLogService;
    }

    public function index()
    {
        $this->authorizeAdmin();

        $roleFilter = request()->query('role');
        $users = $roleFilter
            ? $this->adminService->listUsersByRole($roleFilter)
            : $this->adminService->listUsers();

        return view('admin.users.index', compact('users'));
    }

    public function doctors()
    {
        $this->authorizeAdmin();

        $users = $this->adminService->listUsersByRole('Dokter');

        return view('admin.users.index', compact('users'));
    }

    public function apotekers()
    {
        $this->authorizeAdmin();

        $users = $this->adminService->listUsersByRole('Apoteker');

        return view('admin.users.index', compact('users'));
    }

    public function create(Request $request)
    {
        $this->authorizeAdmin();

        $roles = $this->adminService->listUserRoles();
        $selectedRole = $request->query('role');

        return view('admin.users.create', compact('roles', 'selectedRole'));
    }

    public function store(Request $request)
    {
        $this->authorizeAdmin();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email', 'max:255', 'unique:users,email'],
            'user_roles_id' => ['required', 'exists:user_roles,id'],
            'password' => ['required', 'string', 'min:6'],
        ]);

        $validated['password'] = Hash::make($validated['password']);

        $user = $this->adminService->createUser($validated);

        $this->activityLogService->log(
            'admin.user_created',
            auth()->user(),
            $user,
            'Admin created user.'
        );

        return redirect()->route('admin.users.index')->with('success', 'User created successfully.');
    }

    public function edit(User $user)
    {
        $this->authorizeAdmin();

        $roles = $this->adminService->listUserRoles();

        return view('admin.users.edit', compact('user', 'roles'));
    }

    public function update(Request $request, User $user)
    {
        $this->authorizeAdmin();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email', 'max:255', 'unique:users,email,' . $user->id],
            'user_roles_id' => ['required', 'exists:user_roles,id'],
            'password' => ['nullable', 'string', 'min:6'],
        ]);

        if ($validated['password'] ?? null) {
            $validated['password'] = Hash::make($validated['password']);
        } else {
            unset($validated['password']);
        }

        $user = $this->adminService->updateUser($user, $validated);

        $this->activityLogService->log(
            'admin.user_updated',
            auth()->user(),
            $user,
            'Admin updated user.'
        );

        return redirect()->route('admin.users.index')->with('success', 'User updated successfully.');
    }

    public function toggle(User $user)
    {
        $this->authorizeAdmin();

        if ($user->id === auth()->id()) {
            return redirect()
                ->route('admin.users.index')
                ->with('success', 'Tidak bisa menonaktifkan akun sendiri.');
        }

        $this->adminService->toggleUser($user);

        $this->activityLogService->log(
            'admin.user_toggled',
            auth()->user(),
            $user,
            'Admin toggled user status.'
        );

        return redirect()->route('admin.users.index')->with('success', 'User status updated successfully.');
    }

    private function authorizeAdmin(): void
    {
        if (!$this->adminService->canAdmin(auth()->user())) {
            abort(403);
        }
    }
}
