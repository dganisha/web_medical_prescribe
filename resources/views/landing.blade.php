@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="row align-items-center g-5">
        <div class="col-lg-6">
            <h1 class="fw-bold display-5">Medication Prescribing App</h1>
            <p class="lead text-muted mt-3">
                Kelola pemeriksaan pasien, resep dokter, dan layanan apotek dalam satu sistem.
            </p>
            <div class="d-flex gap-2 mt-4">
                <a href="/login" class="btn btn-primary btn-lg">Masuk</a>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">
                    <h5 class="fw-semibold">Fitur Utama</h5>
                    <ul class="list-unstyled mt-3">
                        <li class="mb-2">- Dokter mencatat hasil pemeriksaan dan resep.</li>
                        <li class="mb-2">- Apoteker melayani dan mencetak resi.</li>
                        <li class="mb-2">- Administrator mengelola data pengguna dan pasien.</li>
                    </ul>
                    <div class="alert alert-info mt-4 mb-0">
                        Siap digunakan oleh berbagai peran dengan akses terarah.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
