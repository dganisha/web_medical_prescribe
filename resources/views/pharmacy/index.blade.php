@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Pharmacy Queue</h2>
    </div>

    @if (session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <div class="card mb-4">
        <div class="card-header bg-white">
            <h5 class="mb-0">Pending Prescriptions</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($prescriptions as $prescription)
                            <tr>
                                <td>{{ $prescription->id }}</td>
                                <td>{{ $prescription->checkupResult->patient->name ?? '-' }}</td>
                                <td>{{ $prescription->checkupResult->doctor->name ?? '-' }}</td>
                                <td>{{ $prescription->checkupResult->checkup_date }}</td>
                                <td>
                                    Rp{{ number_format($totals[$prescription->id]['total'] ?? 0, 0, ',', '.') }}
                                </td>
                                <td>
                                    <a href="{{ route('pharmacy.show', $prescription) }}" class="btn btn-sm btn-primary">
                                        Serve
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">No pending prescriptions.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <h5 class="mb-0">History Prescriptions</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Served At</th>
                            <th>Total</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($servedPrescriptions as $prescription)
                            <tr>
                                <td>{{ $prescription->id }}</td>
                                <td>{{ $prescription->checkupResult->patient->name ?? '-' }}</td>
                                <td>{{ $prescription->checkupResult->doctor->name ?? '-' }}</td>
                                <td>{{ $prescription->served_at }}</td>
                                <td>
                                    Rp{{ number_format($servedTotals[$prescription->id]['total'] ?? 0, 0, ',', '.') }}
                                </td>
                                <td>
                                    <a href="{{ route('pharmacy.show', $prescription) }}" class="btn btn-sm btn-outline-primary">
                                        View / Print
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">No served prescriptions.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
