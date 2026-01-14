@extends('layouts.app')

@section('content')
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Register Patient Visit</h4>
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

                    <form method="POST" action="{{ route('registrations.store') }}">
                        @csrf
                        <div class="mb-3">
                            <label class="form-label">Patient Name</label>
                            <input type="text" class="form-control" id="patientSearch" placeholder="Ketik nama pasien..." autocomplete="off">
                            <input type="hidden" name="patient_id" id="patientId">
                            <input type="hidden" name="name" id="newPatientName">
                            <div id="patientSuggestions" class="list-group mt-2 d-none"></div>
                            <button type="button" id="addNewPatient" class="btn btn-outline-primary btn-sm mt-2 d-none">
                                Tambah Pasien Baru
                            </button>
                        </div>
                        <div id="newPatient" class="d-none">
                            <div class="mb-3">
                                <label class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" name="date_of_birth" value="{{ old('date_of_birth') }}">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Gender</label>
                                <select class="form-select" name="gender">
                                    <option value="" disabled selected>Select gender</option>
                                    <option value="Laki-laki">Laki-laki</option>
                                    <option value="Perempuan">Perempuan</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Address</label>
                                <input type="text" class="form-control" name="address" value="{{ old('address') }}">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Phone Number</label>
                                <input type="text" class="form-control" name="phone_number" value="{{ old('phone_number') }}">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success">Register</button>
                        <a href="{{ route('registrations.index') }}" class="btn btn-secondary ms-2">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const patients = @json($patients->map(fn ($patient) => [
            'id' => $patient->id,
            'name' => $patient->name,
        ]));
        const searchInput = document.getElementById('patientSearch');
        const suggestions = document.getElementById('patientSuggestions');
        const addNewButton = document.getElementById('addNewPatient');
        const newPatientForm = document.getElementById('newPatient');
        const patientIdField = document.getElementById('patientId');
        const newPatientName = document.getElementById('newPatientName');

        function renderSuggestions(matches) {
            suggestions.innerHTML = '';
            if (matches.length === 0) {
                suggestions.classList.add('d-none');
                addNewButton.classList.remove('d-none');
                newPatientName.value = searchInput.value.trim();
                return;
            }
            addNewButton.classList.add('d-none');
            if (newPatientForm.classList.contains('d-none')) {
                newPatientName.value = '';
            }
            suggestions.classList.remove('d-none');
            matches.slice(0, 5).forEach((patient) => {
                const button = document.createElement('button');
                button.type = 'button';
                button.className = 'list-group-item list-group-item-action';
                button.textContent = patient.name;
                button.addEventListener('click', function() {
                    searchInput.value = patient.name;
                    patientIdField.value = patient.id;
                    newPatientName.value = '';
                    suggestions.classList.add('d-none');
                    newPatientForm.classList.add('d-none');
                });
                suggestions.appendChild(button);
            });
        }

        searchInput.addEventListener('input', function() {
            const query = searchInput.value.trim().toLowerCase();
            patientIdField.value = '';
            if (!query) {
                suggestions.classList.add('d-none');
                addNewButton.classList.remove('d-none');
                addNewButton.disabled = false;
                newPatientForm.classList.add('d-none');
                newPatientName.value = '';
                return;
            }
            const matches = patients.filter((patient) => patient.name.toLowerCase().includes(query));
            renderSuggestions(matches);
        });

        addNewButton.addEventListener('click', function() {
            newPatientForm.classList.remove('d-none');
            newPatientName.value = searchInput.value.trim();
            addNewButton.classList.add('d-none');
            addNewButton.disabled = true;
            suggestions.classList.add('d-none');
        });

        searchInput.addEventListener('focus', function() {
            if (newPatientForm.classList.contains('d-none')) {
                addNewButton.disabled = false;
            }
        });
    });
</script>
@endsection
