<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Location extends Model {

    protected $fillable = [
      "id",
      "type",
      "address",
      "lng",
      "lat",
      "location_id",
      "description"
    ];
}

 ?>
