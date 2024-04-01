@extends('layouts.default')
@section('content')
    <div class="flex justify-content-center my-2 col-md-6">
        @if(session()->has('message'))
            <div class="alert alert-success" role="alert">
                {{ session()->get('message') }}
            </div>
        @endif
        <form method="post" action="{{route('updateTeam', $team->id)}}">
            @csrf
    <div class="form-outline" >
        <label class="form-label" for="form12">Team name</label>
        <input type="text" id="form12" name="name" value="{{$team->name}}" class="form-control" />
    </div>
    <div class="form-outline" >
        <label class="form-label" for="form12">Country</label>
        <input type="text" id="form12" name="country" value="{{$team->country}}" class="form-control" />
    </div>
    <input type="submit" class="col-2 my-2 btn btn-primary btn-block" />
        </form>
    </div>
    <div class="col-md-6 my-5">
        <p>Updated: {{$team->updated_at}}</p>
        <p>Created: {{$team->created_at}}</p>
    </div>
@endsection
