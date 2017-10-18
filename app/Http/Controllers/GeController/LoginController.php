<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use App\Http\Models\Order;
use App\Http\Models\Authentication;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class LoginController extends Controller {

  public function index() {
    return view('login');
  }

  public function login(Request $request) {
    $username = $request->input('username');
    $password = $request->input('password');

    if(Auth::attempt(['username'=>$username, 'password'=>$password])) {
      Auth::guard('web');
      return redirect()->intended('dashboard');
    }else {
      echo "Not Successful";
    }


  }

  public function logout() {

  }


}

?>
