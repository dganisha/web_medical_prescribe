@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="card mb-4">
        <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Waiting for Checkup</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Patient</th>
                            <th>Registered At</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($waitingVisits as $visit)
                            <tr>
                                <td>{{ $visit->id }}</td>
                                <td>{{ $visit->patient->name ?? '-' }}</td>
                                <td>{{ $visit->registered_at }}</td>
                                <td>
                                    <a href="{{ route('doctor.checkups.create', ['visit_id' => $visit->id]) }}" class="btn btn-sm btn-primary">
                                        Mulai Periksa
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">No patients in queue.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Doctor Checkups</h2>
    </div>

    @if (session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <div class="card">
        <div class="card-header bg-white">
            <h5 class="mb-0">Checkup List</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Patient</th>
                            <th>Checkup Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($checkups as $checkup)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $checkup->patient->name ?? '-' }}</td>
                                <td>{{ $checkup->checkup_date }}</td>
                                <td>
                                    @if ($checkup->prescription?->status === 'served')
                                        <span class="badge text-bg-success">Served</span>
                                    @else
                                        <span class="badge text-bg-warning">Pending</span>
                                    @endif
                                </td>
                                <td>
                                    @if ($checkup->prescription?->status !== 'served')
                                        <a href="{{ route('doctor.checkups.edit', $checkup) }}" class="btn btn-sm btn-warning">Lihat/Ubah Pemeriksaan</a>
                                    @else
                                        <button class="btn btn-sm btn-outline-secondary" disabled>Sudah Terperiksa</button>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">No checkups available.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
