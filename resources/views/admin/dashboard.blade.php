@extends('layouts.app')

@section('content')
<div class="container py-5">
    <h2 class="fw-bold mb-4">Administrator Dashboard</h2>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Manage Users</h5>
                    <p class="card-text text-muted">Kelola seluruh user termasuk Dokter, Apoteker, dan Pendaftaran.</p>
                    <a href="{{ route('admin.users.index') }}" class="btn btn-primary">Open</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Manage Pendaftaran</h5>
                    <p class="card-text text-muted">Kelola user dengan role Pendaftaran.</p>
                    <a href="{{ route('admin.users.index', ['role' => 'Pendaftaran']) }}" class="btn btn-outline-primary">Open</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Manage Patients</h5>
                    <p class="card-text text-muted">Kelola data pasien.</p>
                    <a href="{{ route('admin.patients.index') }}" class="btn btn-primary">Open</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Manage Medications</h5>
                    <p class="card-text text-muted">Kelola data obat dan harga.</p>
                    <a href="{{ route('medicines.index') }}" class="btn btn-primary">Open</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Medical History</h5>
                    <p class="card-text text-muted">Lihat riwayat pemeriksaan pasien.</p>
                    <a href="{{ route('admin.history.index') }}" class="btn btn-primary">Open</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Doctors</h5>
                    <p class="card-text text-muted">Kelola user dengan role Dokter.</p>
                    <a href="{{ route('admin.doctors.index') }}" class="btn btn-outline-primary">Open</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Apotekers</h5>
                    <p class="card-text text-muted">Kelola user dengan role Apoteker.</p>
                    <a href="{{ route('admin.apotekers.index') }}" class="btn btn-outline-primary">Open</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Manage Roles</h5>
                    <p class="card-text text-muted">Kelola daftar role aplikasi.</p>
                    <a href="{{ route('user_roles.index') }}" class="btn btn-outline-primary">Open</a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
