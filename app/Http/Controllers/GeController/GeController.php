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
use App\Http\Models\Service;
use App\Http\Models\Stock;

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
    $bulk = BulkGas::first()['price'];
    $sizes = Size::join('gas', 'gas_id', 'gas.id')->select('sizes.id', 'name', 'size', 'price', 'gas_id')->get();
    return view('manage', ['header'=>'Products', 'description'=>'Manage Products', "gases" => $gases, 'sizes'=>$sizes, 'bulk'=>$bulk]);
  }

  public function stock(Request $request) {
    $accessories = Accessory::join('stocks', 'stocks.item', 'accessories.id')
        ->where('type', 1)
        ->select('accessories.id as id', 'accessories.name as name', 'accessories.price as price', 'stocks.stock as stock')
        ->get();

    $gases = Size::join('gas', 'gas.id', 'sizes.gas_id')->get();

    return view('stock', ['header'=>'Stock', 'description'=>'Live Stock', 'accessories'=>$accessories, 'gases'=>$gases]);
  }

  public function addStock(Request $request) {
    $stock = $request->input('stock');
    $item = $request->input('id');
    $type = $request->input('type');

    $array = array(
      "item" => $item,
      "type" => $type
    );

    $prev = Stock::where($array)->first()['stock'];

    $stock+=$prev;

    Stock::where($array)
      ->update([
        "stock" => $stock
    ]);

    echo $stock;

  }

// Supplier

  public function supplier() {
    $suppliersData = Supplier::where('status', 1)
      ->orderby('created_at', 'desc')->get();

    $suppliers = array();

    foreach($suppliersData as $data) {
      $subSupplier = array();
      $subSupplier['id'] = $data['id'];
      $subSupplier['name'] = $data['supplier_name'];
      $subSupplier['item_id'] = $data['item'];
      $subSupplier['item_type'] = $data['item_type'];
      switch ($data['item_type']) {
        case '1':
          $subSupplier['item'] = Accessory::where('id', $data['item'])->first()['name'];
          break;
        case '2':
          $subSupplier['item'] = Gas::where('id', $data['item'])->first()['name'];
        break;
        default:
          $subSupplier['item'] = 'Unknown';
        break;
      }

      array_push($suppliers, $subSupplier);
    }

    $items = Accessory::all();
    $sizes = Gas::all();

    $data = array();

    foreach($items as $item) {
      $array = array(
        'id' => $item['id'],
        'name' => $item['name'],
        'type' => 1
      );
      array_push($data, $array);
    }

    foreach($sizes as $size) {
      $array = array(
        'id' => $size['id'],
        'name' => $size['name'],
        'type' => 2
      );
      array_push($data, $array);
    }

    return view('supplier', ['header'=>'Suppliers', 'description'=>'Suppliers', 'suppliers'=>$suppliers, 'items'=>$data]);
  }

  public function addSupplier(Request $request) {
    $supplierName = $request->input('supplier');
    $supplierType = $request->input('type');
    $itemType = $request->input('item_type');

    Supplier::create([
      'supplier_name' => $supplierName,
      'item' => $supplierType,
      'item_type' => $itemType
    ]);

    $id = Supplier::orderBy('created_at', 'desc')->first()['id'];

    echo $id;

  }

  public function editSupplier(Request $request) {
    $supplierName = $request->input('supplier');
    $supplierType = $request->input('type');
    $supplierId = $request->input('id');
    $itemType = $request->input('item_type');

    Supplier::where('id', $supplierId)
    ->update([
      'supplier_name' => $supplierName,
      'item' => $supplierType,
      'item_type' => $itemType
    ]);

    $itemName = '';

    switch ($itemType) {
      case '1':
        $itemName = Accessory::where('id', $supplierType)->first()['name'];
        break;
      case '2':
        $itemName = Gas::where('id', $supplierType)->first()['name'];
      break;
      default:
        $itemName = 'Unknown';
      break;
    }

    echo $itemName;

  }

  public function deleteSupplier(Request $request) {
    $supplierId = $request->input('supplier');

    Supplier::where('id', $supplierId)
    ->update([
      'status' => 0
    ]);

  }

  public function getSupplier(Request $request) {
    $id = $request->input('id');
    $type = $request->input('type');

    $data = array(
      'item' => $id,
      'item_type' => $type
    );

    $suppliers = Supplier::where($data)
        ->select('id', 'supplier_name as name')
      ->get();

    $array = array(
      "item" => $id,
      "type" => $type
    );

    $stock = Stock::where($array)->first()['stock'];

    $data = array(
      'suppliers' => $suppliers,
      'stock' => $stock
    );

    echo json_encode($data);

  }

// Manage
public function addGasType(Request $request) {
  $name = $request->input('type');
  $id = 1;

  while(Gas::where('id', $id)->exists()) {
    $id++;
  }

  Gas::create([
    'id' => $id,
    'name' => $name
  ]);

  echo $id;

}

public function addGas(Request $request) {
  $id = $request->input('type');
  $size = $request->input('size');
  $price = $request->input('price');

  if(!Size::where('gas_id', $id)->where('size', $size)->exists()) {
    Size::create([
      'gas_id' => $id,
      'size' => $size,
      'price' => $price
    ]);
  }else {
    echo "E";
  }
}

public function addProduct(Request $request) {
    $id = 10099;
    $type = $request->input('type');
    $name = $request->input('name');
    $price = $request->input('price');

    while(Accessory::where('id', $id)->exists()) {
        $id++;
    }

    switch ($type) {
      case '0':
        Service::create([
          "name" => $name
        ]);
        break;
      case '1':
        Accessory::create([
          "id" => $id,
          "name" => $name,
          "price" => $price
        ]);
        break;
    }

    echo $name;

}

public function addBulkGas(Request $request) {
  $id = 10099;
  $price = $request->input('price');
  $bulk = BulkGas::where('id', $id);

  if($bulk->exists()) {
      $bulk->update([
        'price' => $price
      ]);
  }else {
    BulkGas::create([
    "id" => $id,
    "price" => $price
  ]);
  }

  echo $price;
}





  /*

  Mobile

  */



















}

?>
