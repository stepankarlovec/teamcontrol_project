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
        Schema::create('apologies', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('text');
            $table->dateTime('dateFrom');
            $table->dateTime('dateUntil');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('team_id');
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('team_id')->references('id')->on('teams');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('apologies');
    }
};
