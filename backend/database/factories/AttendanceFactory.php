<?php

namespace Database\Factories;

use App\Models\Event;
use App\Models\Person;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Attendance>
 */
class AttendanceFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            "event_id" => Event::all()->random()->id,
            "user_id" => User::all()->random()->id,
            "state" => fake()->randomElement([0, 1, 2]),
        ];
    }
}
