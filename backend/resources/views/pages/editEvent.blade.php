@extends('layouts.default')
@section('content')
    <div class="flex justify-content-center my-2 col-md-6">
        @if(session()->has('message'))
            <div class="alert alert-success" role="alert">
                {{ session()->get('message') }}
            </div>
        @endif
        <form method="post" action="{{route('updateEvent', $event->id)}}">
            @csrf
            <div class="form-outline" >
                <label class="form-label" for="form12">Event name</label>
                <input type="text" id="form12" name="name" value="{{$event->name}}" class="form-control" />
            </div>
            <div class="form-outline" >
                <label class="form-label" for="form12">Type</label>
                <input type="text" id="form12" name="type" value="{{$event->type}}" class="form-control" />
            </div>
            <div class="form-outline" >
                <label class="form-label" for="form12">Date:</label>
                <input type="datetime-local" id="form12" name="date" value="{{$event->date}}" class="form-control" />
            </div>
            <div class="form-outline" >
                <label class="form-label" for="form12">Location</label>
                <input type="text" id="form12" name="location" value="{{$event->location}}" class="form-control" />
            </div>
            <div class="form-outline" >
                <label class="form-label" for="form12">Creator</label>
                <input type="text" id="form12" name="creator_id" value="{{$event->creator_id}}" class="form-control" />
            </div>
            <input type="submit" class="col-2 my-2 btn btn-primary btn-block" />
        </form>
    </div>
    <div class="col-md-6 my-5">
        <p>Updated: {{$event->updated_at}}</p>
        <p>Created: {{$event->created_at}}</p>
    </div>
@endsection
