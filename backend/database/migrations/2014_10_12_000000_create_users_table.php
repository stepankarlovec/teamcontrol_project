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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->integer('role')->default(0);
            $table->unsignedBigInteger("team_id")->nullable();
            $table->unsignedBigInteger("person_id")->nullable();
            $table->rememberToken();
            $table->timestamps();
            $table->foreign("team_id")->references("id")->on("teams");
            $table->foreign("person_id")->references("id")->on("people");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
