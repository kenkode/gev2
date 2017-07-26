<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use App\Http\Models\Order;

class GeController extends Controller {

  public function index() {
    $user = "";
    $orders = "";
    $users = "";
    $totalSales = "";
    $revenues = "";
    $costs = "";

    $data = array(
      'user' => $user,
      'orders' => $orders,
      'users' => $users,
      'totalSales' => $totalSales,
      'revenues' => $revenues,
      'costs' => $costs
    );

    return view('dashboard', ['header'=>'Dashboard', 'description'=>'Admin Dashboard', 'data' => $data]);
  }


}

?>
