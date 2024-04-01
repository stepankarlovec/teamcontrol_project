<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Event>
 */
class EventFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            "name" => fake()->randomElement(["Training", "Match", "Friendly", "Recovery"]),
            "date" => fake()->dateTimeBetween("-1 year", "+1 year"),
            "location" => fake()->streetAddress(),
            "creator_id" => User::all()->random()->id
        ];
    }
}
