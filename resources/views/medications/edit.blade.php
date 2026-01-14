@extends('layouts.app')

@section('content')
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0">Edit Medicine</h4>
                </div>
                <div class="card-body">
                    <form method="POST" action="#">
                        @csrf
                        @method('PUT')
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="{{ $medicine->name }}" required>
                        </div>
                        <div class="mb-3">
                            <label for="medicines_central_id" class="form-label">Central ID</label>
                            <input type="text" class="form-control" id="medicines_central_id" name="medicines_central_id" value="{{ $medicine->medicines_central_id }}" required>
                        </div>
                        <button type="submit" class="btn btn-success">Save Changes</button>
                        <a href="{{ route('medicines.index') }}" class="btn btn-secondary ms-2">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
