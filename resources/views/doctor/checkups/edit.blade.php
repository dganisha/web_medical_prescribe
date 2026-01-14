@extends('layouts.app')

@section('content')
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0">Edit Checkup</h4>
                </div>
                <div class="card-body">
                    @if ($errors->any())
                        <div class="alert alert-danger">
                            <ul class="mb-0">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    <form method="POST" action="{{ route('doctor.checkups.update', $checkup) }}" enctype="multipart/form-data">
                        @csrf
                        @method('PUT')
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Patient</label>
                                <select class="form-select" name="patient_id" required>
                                    @foreach ($patients as $patient)
                                        <option value="{{ $patient->id }}" {{ old('patient_id', $checkup->patient_id) == $patient->id ? 'selected' : '' }}>
                                            {{ $patient->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Checkup Date & Time</label>
                                <input type="datetime-local" class="form-control" name="checkup_date" value="{{ old('checkup_date', \Carbon\Carbon::parse($checkup->checkup_date)->format('Y-m-d\TH:i')) }}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Tinggi Badan</label>
                                <input type="text" class="form-control" name="tinggi_badan" value="{{ old('tinggi_badan', $checkup->tinggi_badan) }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Berat Badan</label>
                                <input type="text" class="form-control" name="berat_badan" value="{{ old('berat_badan', $checkup->berat_badan) }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Suhu Tubuh</label>
                                <input type="text" class="form-control" name="temperature" value="{{ old('temperature', $checkup->temperature) }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Sistole</label>
                                <input type="text" class="form-control" name="sistole" value="{{ old('sistole', $checkup->sistole) }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Diastole</label>
                                <input type="text" class="form-control" name="diastole" value="{{ old('diastole', $checkup->diastole) }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Heart Rate</label>
                                <input type="text" class="form-control" name="heart_rate" value="{{ old('heart_rate', $checkup->heart_rate) }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Respiration Rate</label>
                                <input type="text" class="form-control" name="respiratory_rate" value="{{ old('respiratory_rate', $checkup->respiratory_rate) }}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Diagnosis (Free Text)</label>
                            <textarea class="form-control" name="diagnosis" rows="3">{{ old('diagnosis', $checkup->diagnosis) }}</textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">External File (Optional)</label>
                            <input type="file" class="form-control" name="external_file">
                            @if ($checkup->external_file_path)
                                <div class="form-text">
                                    Current file: <a href="{{ asset('storage/' . $checkup->external_file_path) }}" target="_blank">View</a>
                                </div>
                            @endif
                        </div>

                        <div class="border rounded p-3 mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="mb-0">Prescription Items</h5>
                                <button type="button" class="btn btn-sm btn-outline-primary" id="addItem">Add Item</button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-sm align-middle mb-0" id="itemsTable">
                                    <thead>
                                        <tr>
                                            <th>Medicine</th>
                                            <th>Dosage</th>
                                            <th>Frequency</th>
                                            <th>Duration</th>
                                            <th>Qty</th>
                                            <th>Notes</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($checkup->prescription->items as $index => $item)
                                            <tr>
                                                <td>
                                                    <select class="form-select" name="items[{{ $index }}][medicine_id]" required>
                                                        @foreach ($medicines as $medicine)
                                                            <option value="{{ $medicine->id }}" {{ $item->medicine_id == $medicine->id ? 'selected' : '' }}>
                                                                {{ $medicine->name }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </td>
                                                <td><input type="text" class="form-control" name="items[{{ $index }}][dosage]" value="{{ $item->dosage }}" required></td>
                                                <td><input type="text" class="form-control" name="items[{{ $index }}][frequency]" value="{{ $item->frequency }}" required></td>
                                                <td><input type="text" class="form-control" name="items[{{ $index }}][duration]" value="{{ $item->duration }}" required></td>
                                                <td><input type="number" min="1" class="form-control" name="items[{{ $index }}][quantity]" value="{{ $item->quantity }}" required></td>
                                                <td><input type="text" class="form-control" name="items[{{ $index }}][notes]" value="{{ $item->notes }}"></td>
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-outline-danger remove-item">Remove</button>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success">Save Changes</button>
                        <a href="{{ route('doctor.checkups.index') }}" class="btn btn-secondary ms-2">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const addButton = document.getElementById('addItem');
        const tableBody = document.querySelector('#itemsTable tbody');
        let itemIndex = {{ $checkup->prescription->items->count() }};

        addButton.addEventListener('click', function() {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>
                    <select class="form-select" name="items[${itemIndex}][medicine_id]" required>
                        @foreach ($medicines as $medicine)
                            <option value="{{ $medicine->id }}">{{ $medicine->name }}</option>
                        @endforeach
                    </select>
                </td>
                <td><input type="text" class="form-control" name="items[${itemIndex}][dosage]" required></td>
                <td><input type="text" class="form-control" name="items[${itemIndex}][frequency]" required></td>
                <td><input type="text" class="form-control" name="items[${itemIndex}][duration]" required></td>
                <td><input type="number" min="1" class="form-control" name="items[${itemIndex}][quantity]" value="1" required></td>
                <td><input type="text" class="form-control" name="items[${itemIndex}][notes]"></td>
                <td>
                    <button type="button" class="btn btn-sm btn-outline-danger remove-item">Remove</button>
                </td>
            `;
            tableBody.appendChild(row);
            itemIndex += 1;
        });

        tableBody.addEventListener('click', function(event) {
            if (event.target.classList.contains('remove-item')) {
                event.target.closest('tr').remove();
            }
        });
    });
</script>
@endsection
