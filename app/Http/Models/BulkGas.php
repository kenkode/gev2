<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class BulkGas extends Model {

    protected $fillable = [
      "id",
      "size",
      "metric",
      "price"
    ];
}

 ?>
