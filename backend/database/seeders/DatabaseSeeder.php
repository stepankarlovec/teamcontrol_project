<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Attendance;
use App\Models\Event;
use App\Models\Person;
use App\Models\Team;
use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $teams = Team::factory(3)->create();
        foreach ($teams as $team) {
                $users = User::factory(21)->create([
                    'team_id' => $team->id,
                ]);
        }
        $events = Event::factory(10)->create();
        foreach ($events as $event) {
            $attendances = Attendance::factory(60)->create([
                'event_id' => $event->id,
            ]);
        }
    }
}
