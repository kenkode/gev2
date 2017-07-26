<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use App\Http\Models\Order;
use App\Http\Models\Authentication;

class LoginController extends Controller {

  public function index() {
    return view('login');
  }

  public function login($request) {
    $username = $request->input('username');
    $password = $request->input('password');
    if(Authentication::where('username', $username)
          ->where('password', $password)->exists()) {
            Auth::
          }
  }

  public function logout() {

  }


}

?>
