<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Http\Models\Ride;
use App\Http\Models\RiderOrder;
use App\Http\Models\UserOrder;
use App\Http\Models\Rating;
use App\User;

/*

tables - percentage(driver earning percentage, drivers per parameter) - multiple for driver earning to prevent inconsistent payments for different periods after changing the previous one( current has int(1) for active attribute)
       ratings(driver id, star, compliment, order_id)
       rider_order(rider, order)
       payments()
*/

class RiderController extends Controller {

  public function login(Request $request, $email, $password) {
    // $email = $request->input('email');
    // $password = $request->input('password');
    $user = array();

    if (Auth::attempt(['email' => $email, 'password' => $password])) {
      $user = Auth::user();
      if($user->type != 4) {
        $user['status'] = "Fail";
        return json_encode($user);
      }
      $ride = Ride::where('rider', $email)->first();

      // $data['user'] = $user;
      $user['ride'] = $ride;
      $user['status'] = "Success";

    }else {
      $user['status'] = "Fail";
    }

    return json_encode($user);

  }

  public function earnings(Request $request, $rider) {
      $data = array();
      $geController = new GeController();

      // $percentage = Percentage::where('active', 1)->where('entity', 'RIDER')->first()['percentage'];
      $percentage = 2.5;
      // $rider = $request->input('rider');
      // $orders = RiderOrder::where('rider', $rider)->orderby('desc', 'created_at');
      $orders = [
        array(
          'payment' => 200,
          'date' => "12.12.12"
        ),
        array(
          'payment' => 100,
          'date' => "08.08.08"
        ),
        array(
          'payment' => 100,
          'date' => "08.08.08"
        ),
        array(
          'payment' => 250,
          'date' => "08.08.08"
        ),
        array(
          'payment' => 120,
          'date' => "08.08.08"
        ),
      ];
      // $latestOrder = $geController->getOrderDetails($orders->first()['order']);
      $latestOrder = 1201;
      $highest = 300;
      $lowest = 200;
      $total = 800;
      $latest = 250;
      // $orders = $orders->get();

      // foreach ($orders as $order) {
      //   $riderOrder = $geController->getOrderDetails($order->order);
      //   $totalPrice = $riderOrders['price'];
      //   $riderPrice = $percentage * $totalPrice;
      //   if($highest < $riderPrice) {
      //     $highest = $riderPrice;
      //   }
      //   if($lowest > $riderPrice) {
      //     $lowest = $riderPrice;
      //   }
      //   $total += $riderPrice;
      //   array_push($data, array('earnings'=>$riderPrice, 'data'=>$totalPrice['created_at']));
      // }

      $results = array(
        'payments' => $orders /*$data*/,
        'latest' => $latest,
        'total' => $total,
        'highest' => $highest,
        'lowest' => $lowest
      );

      return json_encode($results);

  }

  public function ratings(Request $request, $rider) {
    $riderOrder = RiderOrder::where('rider', $rider);
    $totalTrips = $riderOrder->count();

    $ratings = Rating::join("rider_orders", "rider_orders.order", "ratings.order")->where("rider", $rider);
    $coreRating = $ratings;
    $compliments = $coreRating->where('feedback', '!=', "")->select('feedback', 'ratings.order', 'rating')->get();

    $totalRatedTrips = $ratings->where('rating', '!=', 0);
    $countRatedTrips = $totalRatedTrips->count();
    $sumRatedTrips = $totalRatedTrips->sum("rating");
    $stars_5 = $ratings->where('rating', 5)->count();

    $currentRating = 0;

    if($countRatedTrips > 0) {
      $currentRating = $sumRatedTrips / $countRatedTrips;
    }else {
      $currentRating = 0;
    }

    $data = array(
      'current' => $currentRating,
      'lifetime' => $totalTrips,
      'rated' => $countRatedTrips,
      'star5' => $stars_5,
      'compliments' => $compliments
    );

    return json_encode($data);
  }

  public function setRider(Request $request, $rider, $order) {
    RiderOrder::create([
      'rider' => $rider,
      'order' => $order
    ]);

    // Alert subsidiary a rider is on transit

  }

  public function orderDelivered(Request $request, $order) {
    UserOrder::where('order_id', $order)->update([
      'status' => 1
    ]);

    // Alert the user on the delivery

  }

  public function edit(Request $request, $rider) {
    $name = $request->input('name');
    $email = $request->input('email');
    $phone = $request->input('phone');




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

  public function getToken() {
    return json_encode(session()->token());
  }




}


  ?>
