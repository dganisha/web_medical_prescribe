@extends('layouts.app')

@section('content')
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Prescription #{{ $prescription->id }}</h2>
        <a href="{{ route('pharmacy.index') }}" class="btn btn-secondary">Back</a>
    </div>

    <div class="card mb-4">
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <div class="text-muted">Patient</div>
                    <div class="fw-semibold">{{ $prescription->checkupResult->patient->name ?? '-' }}</div>
                </div>
                <div class="col-md-4">
                    <div class="text-muted">Doctor</div>
                    <div class="fw-semibold">{{ $prescription->checkupResult->doctor->name ?? '-' }}</div>
                </div>
                <div class="col-md-4">
                    <div class="text-muted">Checkup Date</div>
                    <div class="fw-semibold">{{ $prescription->checkupResult->checkup_date }}</div>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-white">
            <h5 class="mb-0">Prescription Items</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>Medicine</th>
                            <th>Dosage</th>
                            <th>Frequency</th>
                            <th>Duration</th>
                            <th>Qty</th>
                            <th>Unit Price</th>
                            <th>Line Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($totals['items'] as $itemData)
                            <tr>
                                <td>{{ $itemData['item']->medicine->name }}</td>
                                <td>{{ $itemData['item']->dosage }}</td>
                                <td>{{ $itemData['item']->frequency }}</td>
                                <td>{{ $itemData['item']->duration }}</td>
                                <td>{{ $itemData['item']->quantity }}</td>
                                <td>Rp{{ number_format($itemData['unit_price'], 0, ',', '.') }}</td>
                                <td>Rp{{ number_format($itemData['line_total'], 0, ',', '.') }}</td>
                            </tr>
                        @endforeach
                        <tr>
                            <td colspan="6" class="text-end fw-semibold">Total</td>
                            <td class="fw-semibold">Rp{{ number_format($totals['total'], 0, ',', '.') }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="mt-4 d-flex gap-2">
        
        <a href="{{ route('pharmacy.receipt', $prescription) }}" class="btn btn-outline-primary">Download Receipt (PDF)</a>
        @if ($prescription->status !== 'served')
            <form method="POST" action="{{ route('pharmacy.serve', $prescription) }}">
                @csrf
                @method('PUT')
                <button type="submit" class="btn btn-success">Konfirmasi</button>
            </form>
        @endif
    </div>
</div>
@endsection
