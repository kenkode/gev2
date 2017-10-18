<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class UserOrder extends Model {

    protected $fillable = [
      "user_id",
      "order_id",
      "status",
      "payment_method"
    ];
}

 ?>
