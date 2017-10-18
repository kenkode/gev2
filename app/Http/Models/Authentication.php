<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Auth\Authenticatable as AuthenticatableTrait;

class Authentication extends Model implements Authenticatable {

  use AuthenticatableTrait;

    protected $fillable = [
      "username",
      "password"
    ];

    protected $hidden = [
      'password'
    ];
}

 ?>
