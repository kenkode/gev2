<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use App\Http\Controllers\GeController\FirebaseController;

use Illuminate\Http\Request;
use App\Http\Models\Customer;
use App\Http\Models\Size;
use App\Http\Models\BulkGas;
use App\Http\Models\Service;
use App\Http\Models\Gas;
use App\Http\Models\Order;
use App\Http\Models\UserOrder;
use App\Http\Models\Accessory;
use App\Http\Models\Location;
use App\Http\Models\UserLocation;
use App\Http\Models\DeliveryLocation;
use App\Http\Models\Rating;

use App\Http\Controllers\GeController\AfricasTalking\AfricasTalkingController;

class CustomerController extends Controller {

  public function getAccessories(Request $request) {
    $accessories = Accessory::select("id", "name", "price")->get();
    return json_encode($accessories);
  }

  public function getServices(Request $request) {
    $services = Service::select("id", "name")->get();
    return json_encode($services);
  }

  public function getBulkGas(Request $request) {
    $bulk = BulkGas::select("id", "price")->first()['price'];
    return json_encode($bulk);
  }

  public function getSizes(Request $request) {
    $sizes = Size::join('gas', 'gas.id', 'sizes.gas_id')->groupby('size')->orderby('size', 'asc')->pluck('size');
    return json_encode($sizes);
  }

  public function getGases(Request $request) {
    $size = $request->input('size');

    $gases = Gas::join("sizes", "sizes.gas_id", "gas.id")->where('size', $size)
      ->select("name", "sizes.id", "size", "price")
      ->get();

    return json_encode($gases);
  }

  public function placeOrder(Request $request) {
    $orderJson = $request->input('json');
    $user = $request->input('user');
    $location = $request->input('location');
    $payment = $request->input('payment');

    $orders = json_decode($orderJson);

    $orderId = 11001;

    while(UserOrder::where('order_id', $orderId)->exists()) {
      $orderId++;
    }

    $fbItems = array();
    $fbPrice = 0;

    foreach($orders as $order) {
       $orderDetails = array(
          "item_id" => $order->id,
          "order_id" => $orderId,
          "type" => $order->type,
          "qty" => $order->quantity
        );
        switch($order->type) {
          case 0:
            $gas = Size::join('gas', 'gas_id', 'gas.id')->where('sizes.id', $order->id)->first();
            $name = $gas['name'];
            $price = $gas->price;
            $fbPrice+=($price * $order->quantity);
            array_push($fbItems, $name);
            break;
          case 1:
            $acc = Accessory::where('id', $order->id)->first();
            $name = $acc['name'];
            $price = $acc->price;
            $fbPrice+=($price * $order->quantity);
            array_push($fbItems, $name);
            break;
          case 2:
            $service = Service::where('id', $order->id)->first();
            $name = $service['name'];
            $price = $service->price;
            $fbPrice+=($price * $order->quantity);
            array_push($fbItems, $name);
            break;
          case 3:
            $gas = BulkGas::first();
            $name = "Bulk Gas";
            $price = $gas->price;
            $fbPrice+=($price * $order->quantity);
            array_push($fbItems, $name);
            break;
        }
      Order::create($orderDetails);
    }

    UserOrder::create([
      "user_id" => $user,
      "order_id" => $orderId,
      "payment_method" => $payment
    ]);

    DeliveryLocation::create([
      "location_id" => $location,
      "order_id" => $orderId
    ]);

    $orderType;

    if(count($orders) > 1) {
      $orderType = "Multiple";
    }else {
      $orderType = "Single";
    }

    // Send request to all riders

    $fbLocation = Location::where('id', $location)->first();

    $fbData = array(
      'id' => $orderId,
      'items' => $fbItems,
      'location' => [
        "latitude" => $fbLocation->lat,
        "longitude" => $fbLocation->lng
      ],
      'price' => $fbPrice,
      'status' => 0
    );

    $fbc = new FirebaseController();
    $fbc->firebase->push($fbData, '/');
  }

  public function getHistory(Request $request) {
    $user = $request->input('user');

    $history = UserOrder::join('delivery_locations', 'delivery_locations.order_id', 'user_orders.order_id')
      ->where('user_orders.user_id', $user)
      ->orderby('user_orders.created_at', 'desc')
      ->get();

    $data = array();

      foreach($history as $h) {
        $type;
        $order;
        $totalPrice = 0;
        $total = Order::where('order_id', $h->order_id)->get();
        if(count($total) >= 2) {
          $type = "Multiple";
        }else {
          $type = "Single";
        }

        foreach($total as $t) {
          $price = 0;
          switch($t->type) {
            case 0:
              $gas = Size::where('id', $t->item_id)->first();
              $price = $gas['price'] * $t->qty;
              break;
            case 1:
              $acc = Accessory::where('id', $t->item_id)->first();
              $price = $acc['price'] * $t->qty;
              break;
            case 3:
              $gas = BulkGas::first();
              $price = $gas['price'] * $t->qty;
              break;
          }
          $totalPrice += $price;
        }

        $order['type'] = $type;
        $order['order_id'] = $h->order_id;
        $order['status'] = $h->status;
        $order['type'] = $type;
        $order['price'] = $totalPrice;
        $order['created_at'] = date('m.d.y', strtotime($h->created_at));

        array_push($data, $order);
      }

    return json_encode($data);
  }

  public function getOrderItems(Request $request) {
    $id = $request->input('id');
    $user = $request->input('user');
    $orderDetails = array();
    $data = array();

    $orders = Order::join('user_orders', 'user_orders.order_id', 'orders.order_id')
      ->where('orders.order_id', $id)
      ->where('user_id', $user)
      ->get();
        foreach($orders as $order) {
          $price;
          $name;
          switch($order->type) {
            case 0:
              $gas = Size::join('gas', 'gas_id', 'gas.id')->where('sizes.id', $order->item_id)->first();
              $price = $gas->price;
              $name = $gas['name'];
              $id = $gas['id'];
              $orderDetails['name'] = $name;
              $orderDetails['price'] = $price;
              $orderDetails['id'] = $id;
              break;
            case 1:
              $acc = Accessory::where('id', $order->item_id)->first();
              $price = $acc->price;
              $name = $acc['name'];
              $id = $acc['id'];
              $orderDetails['name'] = $name;
              $orderDetails['price'] = $price;
              $orderDetails['id'] = $id;
              break;
            case 2:
              $service = Service::where('id', $order->item_id)->first();
              $price = "0";
              $metric;
              $id = $service['id'];
              $name = $service['name'];
              $orderDetails['name'] = $name;
              $orderDetails['price'] = $price;
              $orderDetails['id'] = $id;
              break;
            case 3:
              $gas = BulkGas::first();
              $price = $gas->price;
              $id = $gas['id'];
              $name = "Bulk Gas";
              $orderDetails['name'] = $name;
              $orderDetails['price'] = $price;
              $orderDetails['id'] = $id;
              break;
          }
          $orderDetails['quantity'] = $order->qty;

          array_push($data, $orderDetails);
        }

    return json_encode($data);
  }
  //
  // public function getOrders(Request $request) {
  //   $user = $request->input('user');
  //   $orders = Order::join("user_orders", 'user_orders.order_id', 'orders.order_id')
  //     ->where('user_id', $user)->get();
  //
  //   return json_encode($orders);
  // }

  public function getLocations(Request $request) {
    $user = $request->input('user');
    $locations = Location::join("user_locations", 'user_locations.location_id', 'locations.id')
      ->where('user_locations.id', $user)
      ->where('type', 1)
      ->where('active', '!=', 2)
      ->get();

    return json_encode($locations);
  }

  public function addLocation(Request $request) {
    $location = json_decode($request->input('location'));
    $user = $request->input('user');
    $type = $location->type;
    $address = $location->address;
    $lng = $location->lng;
    $lat = $location->lat;
    $desc = $location->description;
    $location_id = uniqid();

    Location::create([
      "type" => $type,
      "address" => $address,
      "lng" => $lng,
      "lat" => $lat,
      "description" => $desc,
      "id" => $location_id
    ]);

    UserLocation::create([
      'id' => $user,
      'location_id' => $location_id
    ]);

    return json_encode($location_id);

  }

  public function disableLocation(Request $request) {
    $id = $request->input('location');
    $user = $request->input('user');

    Location::where('id', $id)
      ->update([
        'active' => 2
      ]);

      return json_encode("Location removed successfully");
  }

  public function generateUniqueId($table, $column, $start_value) {
    while ($table::where($column, $start_value)->exists()) {
      $start_value++;
    }
    return $start_value;
  }

  public function authenticateUser(Request $request) {
    $user = array();
    $phone = $request->input('phone');

    $details = array(
      'phone' => $phone
    );

    $auth = Customer::where($details);

    if($auth->exists()) {
      $africas = new AfricasTalkingController();
      $u = $auth->first();
      $user['status'] = 'E';
      $user['user'] = $u;
      $user['token'] = session()->token();
      $user['pin'] = $africas->sendMessage(1, array("+" . $phone));
    }else {
      $user['status'] = 'DNE';
    }

    return json_encode($user);
  }

  public function addUser(Request $request) {
    $user = array();
    $userDetails = json_decode($request->input('user'));
    $locationDetails = json_decode($request->input('location'));

    while (Customer::where('email', $userDetails->email)->exists()) {
      $user['status'] = "EE";
      return json_encode($user);
      exit;
    }

    $location = uniqid();

    $userId = 1;

    while (Customer::where('id', $userId)->exists()) {
      $userId++;
    }

    Customer::create([
      "id" => $userId,
      "fname" => $userDetails->fname,
      "lname" => $userDetails->lname,
      "phone" => $userDetails->phone,
      "email" => $userDetails->email,
      "birthday" => $userDetails->birthday
    ]);

    Location::create([
      "type" => 1,
      "address" => $locationDetails->address,
      "lng" => $locationDetails->lng,
      "lat" => $locationDetails->lat,
      "description" => $locationDetails->description,
      "id" => $location
    ]);

    UserLocation::create([
      'id' => $userId,
      'location_id' => $location
    ]);

    $user['status'] = 'E';
    $user['user'] = User::where('id', $userId)->first();
    $user['token'] = $this->generateToken($userId);

    $africas = new AfricasTalkingController();
    $user['pin'] = $africas->sendMessage(1, array("+" . $userDetails->phone));

    return json_encode($user);
  }

  public function updateUser(Request $request) {
    $userDetails = json_decode($request->input('update'));
    $userId = $request->input('user');
    $message;

    $user = Customer::whereNotIn("id", [$userId]);

    if($user->where("phone", $userDetails->phone)->exists()) {
      $message = "Phone number exists";
    }else if($user->where("email", $userDetails->email)->exists()) {
      $message = "Email exists";
    }else {
      Customer::where("id", $userId)
        ->update([
          "fname" => $userDetails->fname,
          "lname" => $userDetails->lname,
          "phone" => $userDetails->phone,
          "email" => $userDetails->email
      ]);
      $message = "Successfully updated";
    }
      echo json_encode($message);
  }

  public function submitRating(Request $request) {
    $order = $request->input("order");
    $rating = $request->input("rating");
    $feedback = $request->input("feedback");

    $ratingM = Rating::where('order', $order)->first();

    if($ratingM != null) {
      Rating::where('order', $order)->update([
        "rating" => $rating,
        "order" => $order,
        "feedback" => $feedback
      ]);
    }else {
      Rating::create([
        "rating" => $rating,
        "order" => $order,
        "feedback" => $feedback
      ]);
    }
  }


}

?>
