@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-header bg-primary text-white text-center">
                    <h3 class="mb-0">Medication Prescribing</h3>
                </div>
                <div class="card-body p-4">
                    <form>
                        <div class="mb-3">
                            <label for="patient" class="form-label">Patient</label>
                            <select class="form-select" id="patient" name="patient">
                                <option selected disabled>Select patient</option>
                                <!-- @foreach($patients as $patient)
                                    <option value="{{ $patient->id }}">{{ $patient->name }}</option>
                                @endforeach -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="medicine" class="form-label">Medicine</label>
                            <select class="form-select" id="medicine" name="medicine">
                                <option selected disabled>Select medicine</option>
                                <!-- @foreach($medicines as $medicine)
                                    <option value="{{ $medicine->id }}">{{ $medicine->name }}</option>
                                @endforeach -->
                            </select>
                        </div>
                        <div class="mb-3 row">
                            <div class="col-md-6">
                                <label for="dosage" class="form-label">Dosage</label>
                                <input type="text" class="form-control" id="dosage" name="dosage" placeholder="e.g. 500mg">
                            </div>
                            <div class="col-md-6">
                                <label for="frequency" class="form-label">Frequency</label>
                                <input type="text" class="form-control" id="frequency" name="frequency" placeholder="e.g. 2x a day">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="duration" class="form-label">Duration</label>
                            <input type="text" class="form-control" id="duration" name="duration" placeholder="e.g. 7 days">
                        </div>
                        <div class="mb-3">
                            <label for="notes" class="form-label">Notes</label>
                            <textarea class="form-control" id="notes" name="notes" rows="2" placeholder="Additional instructions"></textarea>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">Prescribe Medication</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
