@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Medicines Management</h2>
        <button id="syncBtn" class="btn btn-primary sync-btn">
            <span id="syncText">Synchronize Medicines</span>
            <span id="syncSpinner" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
        </button>
    </div>
    <div class="card">
        <div class="card-header bg-white">
            <h5 class="mb-0">Medicines List</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Medicine Name</th>
                            <th>Central ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="medicinesTable">
                        @forelse ($medicines as $medicine)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $medicine->name }}</td>
                                <td>{{ $medicine->medicines_central_id ?? '-' }}</td>
                                <td>
                                    <a href="{{ route('medicines.show', $medicine) }}" class="btn btn-sm btn-info me-1">View</a>
                                    <a href="{{ route('medicines.edit', $medicine) }}" class="btn btn-sm btn-warning me-1">Edit</a>
                                    <button class="btn btn-sm btn-outline-info view-prices"
                                        type="button"
                                        data-bs-toggle="modal"
                                        data-bs-target="#pricesModal"
                                        data-medicine="{{ $medicine->name }}"
                                        data-content-id="prices-{{ $medicine->id }}">
                                        View Prices
                                    </button>
                                    <div id="prices-{{ $medicine->id }}" class="d-none">
                                        @if ($medicine->prices->isEmpty())
                                            <span class="text-muted">No prices found.</span>
                                        @else
                                            <ul class="list-group">
                                                @foreach ($medicine->prices as $price)
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                        <span>
                                                            <strong>Rp{{ number_format($price->price, 0, ',', '.') }}</strong>
                                                            <small class="text-muted ms-2">
                                                                {{ $price->effective_date }} - {{ $price->end_date ?? 'Now' }}
                                                            </small>
                                                        </span>
                                                    </li>
                                                @endforeach
                                            </ul>
                                        @endif
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center text-muted">No medicines found.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-end mt-3">
        {{ $medicines->links('pagination::bootstrap-5') }}
    </div>
</div>

<div class="modal fade" id="pricesModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Medicine Prices</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="pricesModalContent" class="text-muted">Loading...</div>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('syncBtn').addEventListener('click', function() {
            syncMedicines();
        });
    });

    document.addEventListener('click', function(event) {
        const button = event.target.closest('.view-prices');
        if (!button) {
            return;
        }
        const title = button.getAttribute('data-medicine') || 'Medicine Prices';
        const contentId = button.getAttribute('data-content-id');
        const content = document.getElementById(contentId);
        document.querySelector('#pricesModal .modal-title').textContent = `Prices - ${title}`;
        document.getElementById('pricesModalContent').innerHTML = content ? content.innerHTML : '';
    });

    function syncMedicines() {
        const btn = document.getElementById('syncBtn');
        const text = document.getElementById('syncText');
        const spinner = document.getElementById('syncSpinner');
        btn.disabled = true;
        spinner.classList.remove('d-none');
        text.textContent = 'Synchronizing...';
        fetch('/api/medicines/synchronize', { method: 'POST' })
            .then(res => res.json())
            .then(data => {
                setTimeout(() => {
                    btn.disabled = false;
                    spinner.classList.add('d-none');
                    text.textContent = 'Synchronize Medicines';
                    alert(data.message);
                    window.location.reload();
                }, 1000);
            })
            .catch(() => {
                btn.disabled = false;
                spinner.classList.add('d-none');
                text.textContent = 'Synchronize Medicines';
                alert('Failed to synchronize.');
            });
    }
</script>
@endsection
