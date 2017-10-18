<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Stock extends Model {

    protected $fillable = [
      "id",
      "stock",
      "item",
      "type"
    ];
}

 ?>
