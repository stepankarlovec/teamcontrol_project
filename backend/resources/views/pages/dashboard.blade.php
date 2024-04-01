@extends('layouts.default')
@section('content')
    <div class="jumbotron py-4">
        <h1 class="display-4">Hello, {{auth()->user()->person->first_name}}</h1>
        <p class="lead">Welcome in the Super Administration web view of TeamControl. You can manage all the users, teams and events from without having to open-up the Flutter app!</p>
        <hr class="my-4">
        <p>This administration is directly connected to the same database as the mobile app. Be careful what you gonna change.</p>
        <p class="lead">
            <a class="btn btn-primary btn-md" href="{{route('teams')}}" role="button">Let's change some things up.</a>
        </p>
    </div>
@endsection
