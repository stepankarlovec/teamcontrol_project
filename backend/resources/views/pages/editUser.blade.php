@extends('layouts.default')
@section('content')
    <div class="flex justify-content-center my-2 col-md-6">
        @if(session()->has('message'))
            <div class="alert alert-success" role="alert">
                {{ session()->get('message') }}
            </div>
        @endif
        <form method="post" action="{{route('updateUser', $user->id)}}">
            @csrf
            <div class="form-outline" >
                <label class="form-label" for="form12">Email</label>
                <input type="text" id="form12" name="email" value="{{$user->email}}" class="form-control" />
            </div>
            <div class="form-outline" >
                <label class="form-label" for="form12">Team</label>
                <input type="text" id="form12" name="team" value="{{$user->team->id}}" class="form-control" />
            </div>
            <div class="form-outline d-flex" >
                <label class="form-label" for="form12">Role</label>
                <select name="role">
                    <option value="0" {{$user->role == 0  ? 'selected' : ''}}>Default user/Player</option>
                    <option value="1" {{$user->role == 1  ? 'selected' : ''}}>Coach</option>
                    <option value="2" {{$user->role == 2  ? 'selected' : ''}}>SuperAdmin</option>
                </select>
            </div>
            <div class="form-outline" >
                <label class="form-label" for="form12">person_id</label>
                <input type="text" id="form12" name="person_id" value="{{$user->person->id}}" class="form-control" />
            </div>
            <input type="submit" class="col-2 my-2 btn btn-primary btn-block" />
        </form>
    </div>
    <div class="col-md-6 my-5">
        <p>Updated: {{$user->updated_at}}</p>
        <p>Created: {{$user->created_at}}</p>
        <p>Roles:</p>
        <ul>
            <li>0 - Default user/ Player</li>
            <li>1 - Coach</li>
            <li>2 - SuperAdmin</li>
        </ul>
    </div>
@endsection
