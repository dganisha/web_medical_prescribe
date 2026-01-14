@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Medical History</h2>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <h5 class="mb-0">Checkup History</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Apoteker</th>
                            <th>Checkup Date</th>
                            <th>Diagnosis</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($histories as $history)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $history->patient->name ?? '-' }}</td>
                                <td>{{ $history->doctor->name ?? '-' }}</td>
                                <td>{{ $history->apoteker->name ?? '-' }}</td>
                                <td>{{ $history->checkup_date }}</td>
                                <td>{{ $history->diagnosis ?: '-' }}</td>
                                <td>
                                    @if ($history->prescription?->status === 'served')
                                        <span class="badge text-bg-success">Served</span>
                                    @else
                                        <span class="badge text-bg-warning">Pending</span>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">No history available.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
