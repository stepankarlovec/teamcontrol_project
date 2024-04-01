<?php

namespace Database\Factories;

use App\Models\Roster;
use App\Models\Team;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Team>
 */
class TeamFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => 'FC ' . fake()->city(),
            'country' => fake()->country(),
        ];
    }

    public function configure()
    {
        return $this->afterCreating(function (Team $user) {
            $roster = Roster::factory()->create(['team_id' => $user->id]);
        });
    }
}
