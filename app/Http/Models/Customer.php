<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model {

    protected $fillable = [
      "id",
      "name",
      "phone",
      "birthday",
      "email"
    ];
}

 ?>
