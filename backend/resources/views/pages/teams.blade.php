@extends('layouts.default')
@section('content')
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Country</th>
            <th scope="col">Members</th>
            <th scope="col">Created at</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        @foreach($teams as $team)
            <tr>
                <td>{{$team->name ?? 'undefined'}}</td>
                <td>{{$team->country ?? 'undefined'}}</td>
                <td>{{$team->users->count() ?? 'undefined'}}</td>
                <td>{{$team->created_at}}</td>

                <td><a href="{{route('team', $team->id)}}" class="btn btn-primary btn-block">Edit</a></td>
            </tr>
        @endforeach
        </tbody>
    </table>
    {{$teams->links("pagination::bootstrap-5")}}
@endsection
