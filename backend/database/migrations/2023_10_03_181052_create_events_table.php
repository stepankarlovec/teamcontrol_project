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
        /*TODO implement color field/also in flutter*/
        Schema::create('events', function (Blueprint $table) {
            $table->id();
            $table->string("name");
            $table->string("type")->nullable();
            $table->dateTime("date");
            $table->integer("duration")->nullable();
            $table->integer("repeated")->default(0);
            $table->string("location");
            $table->string("color");
            $table->unsignedBigInteger("creator_id");
            $table->timestamps();
            $table->foreign("creator_id")->references("id")->on("users");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('events');
    }
};
