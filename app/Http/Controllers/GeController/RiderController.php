<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\User;

class RiderController extends Controller {

  public function login(Request $request) {
    $email = $request->input('email');
    $password = $request->input('password');
    $data = array();
    if (Auth::attempt(['email' => $email, 'password' => $password])) {
      $user = Auth::user();
      $ride = Ride::where('rider', $email)->first();

      $data['user'] = $user;
      $data['ride'] = $ride;
      $data['status'] = "Success";

    }else {
      $data['status'] = "Fail";
    }

    return json_encode($data);

  }


}


?>
