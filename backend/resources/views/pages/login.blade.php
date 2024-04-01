@extends('layouts.default')

@section('content')
    <div class="d-flex justify-content-center">

    <form class="col-md-4 mt-4" method="POST" action="{{route('loginSuperAdmin')}}">
        @csrf
        @if($errors->any())
        <div class="alert alert-danger" role="alert">
            {{ $errors->first() }}
        </div>
        @endif
        <!-- Email input -->
        <div class="form-outline mb-4">
            <label class="form-label" for="form2Example1">Email address</label>
            <input type="email" name="email" id="form2Example1" class="form-control" />
        </div>

        <!-- Password input -->
        <div class="form-outline mb-4">
            <label class="form-label" for="form2Example2">Password</label>
            <input type="password" name="password" id="form2Example2" class="form-control" />
        </div>

        <!-- 2 column grid layout for inline styling -->
        <div class="row mb-4">
            <div class="col d-flex justify-content-center">
                <!-- Checkbox -->
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="form2Example31" checked />
                    <label class="form-check-label" for="form2Example31"> Remember me </label>
                </div>
            </div>
        </div>

        <!-- Submit button -->
        <input type="submit" class="btn btn-primary btn-block mb-4" value="Login" />
    </form>
    </div>
@endsection
