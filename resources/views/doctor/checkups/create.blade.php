@extends('layouts.app')

@section('content')
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">New Checkup</h4>
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

                    <form method="POST" action="{{ route('doctor.checkups.store') }}" enctype="multipart/form-data">
                        @csrf
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Visit Queue</label>
                                <select class="form-select" name="visit_id" required>
                                    <option value="" disabled selected>Select visit</option>
                                    @foreach ($visits as $visit)
                                        <option value="{{ $visit->id }}" {{ (string) $visit->id === (string) ($selectedVisitId ?? '') ? 'selected' : '' }}>
                                            #{{ $visit->id }} - {{ $visit->patient->name }}
                                        </option>
                                    @endforeach
                                </select>
                                <div class="form-text">Pasien harus berasal dari antrean pendaftaran.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Checkup Date & Time</label>
                                <input type="datetime-local" class="form-control" name="checkup_date" value="{{ old('checkup_date') }}" required>
                            </div>
                        </div>

                        <div class="card border-0 bg-light mb-3">
                            <div class="card-body">
                                <h6 class="fw-semibold mb-3">Patient Details</h6>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Name</label>
                                        <input type="text" class="form-control" id="patientName" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Date of Birth</label>
                                        <input type="text" class="form-control" id="patientDob" readonly>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Gender</label>
                                        <input type="text" class="form-control" id="patientGender" readonly>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Phone Number</label>
                                        <input type="text" class="form-control" id="patientPhone" readonly>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Address</label>
                                        <input type="text" class="form-control" id="patientAddress" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Tinggi Badan</label>
                                <input type="text" class="form-control" name="tinggi_badan" value="{{ old('tinggi_badan') }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Berat Badan</label>
                                <input type="text" class="form-control" name="berat_badan" value="{{ old('berat_badan') }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Suhu Tubuh</label>
                                <input type="text" class="form-control" name="temperature" value="{{ old('temperature') }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Sistole</label>
                                <input type="text" class="form-control" name="sistole" value="{{ old('sistole') }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Diastole</label>
                                <input type="text" class="form-control" name="diastole" value="{{ old('diastole') }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Heart Rate</label>
                                <input type="text" class="form-control" name="heart_rate" value="{{ old('heart_rate') }}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Respiration Rate</label>
                                <input type="text" class="form-control" name="respiratory_rate" value="{{ old('respiratory_rate') }}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Diagnosis (Free Text)</label>
                            <textarea class="form-control" name="diagnosis" rows="3">{{ old('diagnosis') }}</textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">External File (Optional)</label>
                            <input type="file" class="form-control" name="external_file">
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
                                        <tr>
                                            <td>
                                                <select class="form-select medicine-select" name="items[0][medicine_id]" required>
                                                    <option value="" disabled selected>Select medicine</option>
                                                    @foreach ($medicines as $medicine)
                                                        <option value="{{ $medicine->id }}">{{ $medicine->name }}</option>
                                                    @endforeach
                                                </select>
                                            </td>
                                            <td><input type="text" class="form-control" name="items[0][dosage]" required></td>
                                            <td><input type="text" class="form-control" name="items[0][frequency]" required></td>
                                            <td><input type="text" class="form-control" name="items[0][duration]" required></td>
                                            <td><input type="number" min="1" class="form-control" name="items[0][quantity]" value="1" required></td>
                                            <td><input type="text" class="form-control" name="items[0][notes]"></td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-danger remove-item" disabled>Remove</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success">Save Checkup</button>
                        <a href="{{ route('doctor.checkups.index') }}" class="btn btn-secondary ms-2">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const visitDetails = @json($visitDetails);
        const visitSelect = document.querySelector('select[name="visit_id"]');
        const patientName = document.getElementById('patientName');
        const patientDob = document.getElementById('patientDob');
        const patientGender = document.getElementById('patientGender');
        const patientPhone = document.getElementById('patientPhone');
        const patientAddress = document.getElementById('patientAddress');

        function updatePatientDetails() {
            const visitId = visitSelect.value;
            const details = visitDetails[visitId];
            patientName.value = details?.name ?? '';
            patientDob.value = details?.date_of_birth ?? '';
            patientGender.value = details?.gender ?? '';
            patientPhone.value = details?.phone_number ?? '';
            patientAddress.value = details?.address ?? '';
        }

        visitSelect.addEventListener('change', updatePatientDetails);
        updatePatientDetails();

        const addButton = document.getElementById('addItem');
        const tableBody = document.querySelector('#itemsTable tbody');
        let itemIndex = 1;

        function initSelect2(container) {
            const $selects = $(container).find('.medicine-select');
            if ($selects.length === 0) {
                return;
            }
            $selects.select2({
                width: '100%',
                placeholder: 'Select medicine',
                allowClear: true,
                dropdownParent: $('body'),
            });
        }

        initSelect2(document);

        addButton.addEventListener('click', function() {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>
                    <select class="form-select medicine-select" name="items[${itemIndex}][medicine_id]" required>
                        <option value="" disabled selected>Select medicine</option>
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
            initSelect2(row);
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
