<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('event_assignees', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("event_id");
            $table->unsignedBigInteger("team_id");
            // 0 = user, 1 = group, 2 = team
            $table->integer("type");
            $table->unsignedBigInteger("user_id")->nullable();
            $table->unsignedBigInteger("group_id")->nullable();
            $table->foreign("event_id")->references("id")->on("events");
            $table->foreign("team_id")->references("id")->on("teams");
            $table->foreign("user_id")->references("id")->on("users");
            $table->foreign("group_id")->references("id")->on("groups");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('event_assignees');
    }
};
