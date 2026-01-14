<?php

use Illuminate\Support\Facades\Route;


use App\Http\Controllers\MedicineController;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\MedicalHistoryController;
use App\Http\Controllers\Admin\PatientManagementController;
use App\Http\Controllers\Admin\UserManagementController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DoctorCheckupController;
use App\Http\Controllers\PharmacistController;
use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\UserRoleController;

Route::get('/', function () {
    $user = auth()->user();

    if ($user) {
        $roleName = strtolower(optional($user->role)->name ?? '');

        return match ($roleName) {
            'administrator' => redirect()->route('admin.dashboard'),
            'dokter' => redirect()->route('doctor.checkups.index'),
            'apoteker' => redirect()->route('pharmacy.index'),
            'pendaftaran' => redirect()->route('registrations.index'),
            default => redirect()->route('registrations.index'),
        };
    }

    return view('landing');
});

Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
Route::post('/login', [AuthController::class, 'login'])->name('login.submit');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

// Medicines management menu (Administrator only)
Route::middleware('admin')->group(function () {
    Route::get('/medicines', [MedicineController::class, 'index'])->name('medicines.index');
    Route::get('/medicines/prescribing', [MedicineController::class, 'prescribing'])->name('medicines.prescribing');
    Route::get('/medicines/{medicine}', [MedicineController::class, 'show'])->name('medicines.show');
    Route::get('/medicines/{medicine}/edit', [MedicineController::class, 'edit'])->name('medicines.edit');
});

// Patients management menu
Route::get('/patients', [PatientController::class, 'index'])->name('patients.index');
Route::get('/patients/create', [PatientController::class, 'create'])->name('patients.create');
Route::post('/patients', [PatientController::class, 'store'])->name('patients.store');
Route::get('/patients/{patient}/edit', [PatientController::class, 'edit'])->name('patients.edit');
Route::put('/patients/{patient}', [PatientController::class, 'update'])->name('patients.update');

// Registration (Pendaftaran)
Route::get('/registrations', [RegistrationController::class, 'index'])->name('registrations.index');
Route::get('/registrations/create', [RegistrationController::class, 'create'])->name('registrations.create');
Route::post('/registrations', [RegistrationController::class, 'store'])->name('registrations.store');

// Doctor checkups & prescriptions
Route::get('/doctor/checkups', [DoctorCheckupController::class, 'index'])->name('doctor.checkups.index');
Route::get('/doctor/checkups/create', [DoctorCheckupController::class, 'create'])->name('doctor.checkups.create');
Route::post('/doctor/checkups', [DoctorCheckupController::class, 'store'])->name('doctor.checkups.store');
Route::get('/doctor/checkups/{checkup}/edit', [DoctorCheckupController::class, 'edit'])->name('doctor.checkups.edit');
Route::put('/doctor/checkups/{checkup}', [DoctorCheckupController::class, 'update'])->name('doctor.checkups.update');

// Administrator
Route::get('/admin', [DashboardController::class, 'index'])->name('admin.dashboard');
Route::get('/admin/users', [UserManagementController::class, 'index'])->name('admin.users.index');
Route::get('/admin/users/create', [UserManagementController::class, 'create'])->name('admin.users.create');
Route::post('/admin/users', [UserManagementController::class, 'store'])->name('admin.users.store');
Route::get('/admin/users/{user}/edit', [UserManagementController::class, 'edit'])->name('admin.users.edit');
Route::put('/admin/users/{user}', [UserManagementController::class, 'update'])->name('admin.users.update');
Route::patch('/admin/users/{user}/toggle', [UserManagementController::class, 'toggle'])->name('admin.users.toggle');
Route::get('/admin/doctors', [UserManagementController::class, 'doctors'])->name('admin.doctors.index');
Route::get('/admin/apotekers', [UserManagementController::class, 'apotekers'])->name('admin.apotekers.index');
Route::get('/admin/patients', [PatientManagementController::class, 'index'])->name('admin.patients.index');
Route::get('/admin/patients/create', [PatientManagementController::class, 'create'])->name('admin.patients.create');
Route::post('/admin/patients', [PatientManagementController::class, 'store'])->name('admin.patients.store');
Route::get('/admin/patients/{patient}/edit', [PatientManagementController::class, 'edit'])->name('admin.patients.edit');
Route::put('/admin/patients/{patient}', [PatientManagementController::class, 'update'])->name('admin.patients.update');
Route::get('/admin/history', [MedicalHistoryController::class, 'index'])->name('admin.history.index');

// Pharmacy
Route::get('/pharmacy', [PharmacistController::class, 'index'])->name('pharmacy.index');
Route::get('/pharmacy/{prescription}', [PharmacistController::class, 'show'])->name('pharmacy.show');
Route::put('/pharmacy/{prescription}/serve', [PharmacistController::class, 'serve'])->name('pharmacy.serve');
Route::get('/pharmacy/{prescription}/receipt', [PharmacistController::class, 'receipt'])->name('pharmacy.receipt');

// User roles management menu
Route::get('/user-roles', [UserRoleController::class, 'index'])->name('user_roles.index');
Route::get('/user-roles/create', [UserRoleController::class, 'create'])->name('user_roles.create');
Route::post('/user-roles', [UserRoleController::class, 'store'])->name('user_roles.store');
