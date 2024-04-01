@extends('layouts.default')
@section('content')
    <table class="table">
        <thead>
        <tr>
            <th scope="col">First name</th>
            <th scope="col">Last name</th>
            <th scope="col">Email</th>
            <th scope="col">Team</th>
            <th scope="col">Role</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        @foreach($users as $user)
        <tr>
            <td>{{$user->person->first_name ?? 'undefined'}}</td>
            <td>{{$user->person->last_name ?? 'undefined'}}</td>
            <td>{{$user->email}}</td>
            <td>{{$user->team->name ?? 'undefined'}}</td>
            <td>
                @if($user->role==0)
                    Crook
                @elseif($user->role==1)
                    Coach
                @elseif($user->role==2)
                    SuperAdmin
                @endif
            </td>
            <td><a href="{{route('user', $user->id)}}" class="btn btn-primary btn-block">Edit</a></td>
        </tr>
        @endforeach
        </tbody>
    </table>
    {{$users->links("pagination::bootstrap-5")}}
@endsection
