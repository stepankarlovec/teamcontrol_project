@extends('layouts.default')
@section('content')
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Typ</th>
            <th scope="col">Date</th>
            <th scope="col">Location</th>
            <th scope="col">Team</th>
            <th scope="col">Created at</th>
        </tr>
        </thead>
        <tbody>
        @foreach($events as $event)
            <tr>
                <td>{{$event->name ?? 'undefined'}}</td>
                <td>{{$event->type ?? 'undefined'}}</td>
                <td>{{$event->date}}</td>
                <td>{{$event->location ?? 'undefined'}}</td>
                <td><a href="{{route('team', $event->creator->team->id)}}">{{$event->creator->team->name}}</a></td>
                <td>{{$event->created_at}}</td>
                <td><a href="{{route('event', $event->id)}}" class="btn btn-primary btn-block">Edit</a></td>
            </tr>
        @endforeach
        </tbody>
    </table>
    {{$events->links("pagination::bootstrap-5")}}
@endsection
