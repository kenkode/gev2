<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Supplier extends Model {

    protected $fillable = [
      "supplier_name",
      "status",
      "item"
    ];
}

 ?>
