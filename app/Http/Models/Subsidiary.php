<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Subsidiary extends Model {

    protected $fillable = [
      "name",
      "email",
      "location",
      "status"
    ];
}

 ?>
