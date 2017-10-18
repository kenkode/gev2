<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Navigation extends Model {

    protected $fillable = [
      "id",
      "name",
      "type",
      "route"
    ];
}

 ?>
