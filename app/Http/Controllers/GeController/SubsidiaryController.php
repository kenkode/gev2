<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
use App\Http\Models\Subsidiary;
use App\Http\Models\Ride;

class SubsidiaryController extends Controller {

  public function addSubsidiary(Request $request) {
    Subsidiary::create([
      'email' => $request->input('email'),
      "location" => $request->input('location')
    ]);

    User::create([
        'name' => $request->input('name'),
        'email' => $request->input('email'),
        'type' => 2,
        'password' => bcrypt("123456"),
    ]);
  }

  public function addRide() {
    Ride::create([
      "rider" => "eddiebranth@gmail.com",
      "name" => "Honda Bike"
    ]);

    User::create([
        'name' => "Eddie",
        'email' => "eddiebranth@gmail.com",
        'type' => 3,
        'password' => bcrypt("123456"),
    ]);

  }



}




?>
