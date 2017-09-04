<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\User;

/*

tables - percentage(driver earning percentage, drivers per parameter) - multiple for driver earning to prevent inconsistent payments for different periods after changing the previous one( current has int(1) for active attribute)
       ratings(driver id, star, compliment, order_id)
       rider_order(rider, order)
       payments()
*/

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

  public function earnings(Request $request) {
      $data = array();

      $percentage = Percentage::where('active', 1)->where('entity', 'RIDER')->first()['percentage'];
      $rider = $request->input('rider');
      $orders = RiderOrder::where('rider', $rider)->get();
      $geController = new GeController($this->container);

      foreach ($orders as $order) {
        $riderOrder = $geController->getOrderDetails($order->order);
        $totalPrice = $riderOrders['price'];
        $riderPrice = $percentage * $totalPrice;
        array_push($data, array('earning'=>$riderPrice, 'data'=>$totalPrice['created_at']));
      }

      return json_encode($data);

  }

  public function ratings(Request $request) {
    $rider = $request->input('rider');
    $totalTrips = RiderOrder::where('rider', $rider)->count();
    $totalRatedTrips = Rating::where('stars', '!=', 0);
    $countRatedTrips = $totalRatedTrips->count();
    $sumRatedTrips = $totalRatedTrips->sum();
    $stars_5 = Rating::where('stars', 5)->count();

    $currentRating = $sumRatedTrips / $countRatedTrips;

    $compliments = Rating::where('compliment', '!=', "")->get();

    $data = array(
      'current' => $currentRating,
      'lifetime' => $totalTrips,
      'rated' => $countRatedTrips,
      'star-5' => $star_5,
      'compliments' => $compliments
    );

    return json_encode($data);
  }

  public function pickOrder(Request $request) {
    $rider = $request->input('rider');
    $order = $request->input('order');

    RiderOrder::create([
      'rider' => $rider,
      'order' => $order
    ]);

    // Alert subsidiary a rider is on transit

  }

  public function orderDelivered(Request $request) {
    $order = $request->input('order');

    UserOrder::where('order_id', $order)->update([
      'status' => 1
    ]);

    // Alert the user on the delivery

  }

  public function rating(Request $request) {
    $rider = $request->input('rider');
    $star = $request->input('star');
    $compliment = $request->input('compliment');

    Rating::create([
      'rider' => $rider,
      'stars' => $star,
      'compliment' => $compliment
    ]);

  }




}


  ?>
