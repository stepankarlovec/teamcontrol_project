<h1>remove account?</h1>
@extends('layouts.default')

@section('content')
    <div class="d-flex justify-content-center">

        <form class="col-md-4 mt-4" method="POST" action="{{route('removeAccount')}}">
            @csrf
            @if($errors->any())
                <div class="alert alert-danger" role="alert">
                    {{ $errors->first() }}
                </div>
            @endif
            <h1>Are you sure you want to delete your account?</h1>
            <p>This is complete removal of your data from our servers. You can create new account afterwards.</p>
            <!-- Email input -->
            <p>type <code>CONFIRM</code> into the form to delete your account.</p>
            <div class="form-outline mb-4">
                <label class="form-label" for="form2Example1">Please type <code>CONFIRM</code></label>
                <input type="text" name="confirm" id="form2Example1" class="form-control" />
            </div>
            <!-- Submit button -->
            <input type="submit" class="btn btn-primary btn-block mb-4" value="Login" />
        </form>
    </div>
@endsection
