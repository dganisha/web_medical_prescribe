@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Patient Registration Queue</h2>
        <a href="{{ route('registrations.create') }}" class="btn btn-primary">Register Patient</a>
    </div>

    @if (session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <div class="card">
        <div class="card-header bg-white">
            <h5 class="mb-0">Visits</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Patient</th>
                            <th>Registered By</th>
                            <th>Status</th>
                            <th>Registered At</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($visits as $visit)
                            <tr>
                                <td>{{ $visit->id }}</td>
                                <td>{{ $visit->patient->name ?? '-' }}</td>
                                <td>{{ $visit->registeredBy->name ?? '-' }}</td>
                                <td>
                                    @if ($visit->status === 'waiting_doctor')
                                        <span class="badge text-bg-warning">Waiting Doctor</span>
                                    @elseif ($visit->status === 'waiting_pharmacy')
                                        <span class="badge text-bg-info">Waiting Pharmacy</span>
                                    @else
                                        <span class="badge text-bg-success">Completed</span>
                                    @endif
                                </td>
                                <td>{{ $visit->registered_at }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">No visits available.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
