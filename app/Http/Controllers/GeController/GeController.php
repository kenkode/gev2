<?php

namespace App\Http\Controllers\GeController;

use Illuminate\Http\Request;
use App\Http\Controllers\GeBaseController;
use App\Http\Models\Order;
use App\Http\Models\Customer;
use App\Http\Models\UserOrder;
use App\Http\Models\Size;
use App\Http\Models\Gas;
use App\Http\Models\BulkGas;
use App\Http\Models\Accessory;
use App\Http\Models\DeliveryLocation;
use App\Http\Models\Supplier;
use App\Http\Models\Item;

class GeController extends GeBaseController {

  public function index() {
    return view('dashboard', ['header'=>'Dashboard', 'description'=>'Admin Dashboard' ]);
  }

  public function getUpdate(Request $request) {
    $previous = $request->input('previous');
    $data = array();
    $orders = UserOrder::join('delivery_locations', 'delivery_locations.order_id', 'user_orders.order_id')
      ->join('locations', 'locations.id', 'delivery_locations.location_id')
      ->orderby('user_orders.created_at', 'desc')
      ->get();

    $current = count($orders);

    $data['total'] = $current;
    if($current > $previous) {
      $limit = $current - $previous;
      $new = UserOrder::join('delivery_locations', 'delivery_locations.order_id', 'user_orders.order_id')
        ->join('locations', 'locations.id', 'delivery_locations.location_id')
        ->orderby('user_orders.created_at', 'desc')
        ->limit($limit)
        ->get();
        $data['orders'] = $new;
    }
    echo json_encode($data);
  }

  public function orderDetails(Request $request, $order) {
    $order_id = $order;
    $user_id = UserOrder::where('order_id', $order_id)->first();
    $location = DeliveryLocation::join('locations', 'locations.id', 'delivery_locations.location_id')->where('order_id', $order_id)->first();
    $user = Customer::where('id', $user_id->user_id)->first();
    $items = array();
    $orders = Order::join('user_orders', 'user_orders.order_id', 'orders.order_id')
      ->where('orders.order_id', $order_id)
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

          array_push($items, $orderDetails);
        }

    $order = array();
    $totalPrice = 0;

    $total = Order::where('order_id', $order_id)->get();
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
              $price = $gas->price * $t->qty;
              break;
            case 1:
              $acc = Accessory::where('id', $t->item_id)->first();
              $price = $acc->price * $t->qty;
              break;
            case 3:
              $gas = BulkGas::first();
              $price = $gas->price * $t->qty;
              break;
          }
          $totalPrice += $price;
          $order['created_at'] = $t->created_at;
        }
        $order['id'] = $order_id;
        $order['type'] = $type;
        $order['price'] = $totalPrice;
        $order['status'] = $user_id->status;
        $order['payment'] = $user_id->payment_method;

        $user['name'] = $user->fname . ' ' . $user->lname;

    $results = array('user'=>$user, 'location'=>$location, 'items'=>$items, 'order'=>$order);

    return view('order', ['header'=>$order_id, 'description'=>'Order Details', 'results'=>$results]);
  }

  public function users() {
    $users = Customer::all();
    return view('users', ['header'=>'Users', 'description'=>'Customers', 'users'=>$users]);
  }

  public function manage(Request $request) {
    $gases = Gas::orderby('name', 'asc')->get();
    $sizes = Size::join('gas', 'gas_id', 'gas.id')->select('sizes.id', 'name', 'size', 'price', 'gas_id')->get();
    return view('manage', ['header'=>'Products', 'description'=>'Manage Products', "gases" => $gases, 'sizes'=>$sizes]);
  }

// Supplier

  public function supplier() {
    $suppliers = Supplier::join('items', 'items.id', 'suppliers.item')
      ->where('status', 1)
      ->select('suppliers.id as id', 'items.item as name', 'suppliers.supplier_name as supplier', 'items.id as item_id')->orderby('suppliers.created_at', 'desc')->get();

    $items = Item::all();

    return view('supplier', ['header'=>'Suppliers', 'description'=>'Suppliers', 'suppliers'=>$suppliers, 'items'=>$items]);
  }

  public function addSupplier(Request $request) {
    $supplierName = $request->input('supplier');
    $supplierType = $request->input('type');

    Supplier::create([
      'supplier_name' => $supplierName,
      'item' => $supplierType
    ]);

    $id = Supplier::orderBy('created_at', 'desc')->first()['id'];

    echo $id;

  }

  public function editSupplier(Request $request) {
    $supplierName = $request->input('supplier');
    $supplierType = $request->input('type');
    $supplierId = $request->input('id');

    Supplier::where('id', $supplierId)
    ->update([
      'supplier_name' => $supplierName,
      'item' => $supplierType
    ]);

    $itemName = Item::where('id', $supplierType)->first()['item'];

    echo $itemName;

  }

  public function deleteSupplier(Request $request) {
    $supplierId = $request->input('supplier');

    Supplier::where('id', $supplierId)
    ->update([
      'status' => 0
    ]);

  }

}

?>
