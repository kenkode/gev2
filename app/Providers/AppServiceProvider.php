<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Schema;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\View;
use App\Http\Controllers\Controller;
use App\Http\Models\Order;
use App\Http\Models\Customer;
use App\Http\Models\UserOrder;
use App\Http\Models\Size;
use App\Http\Models\BulkGas;
use App\Http\Models\Accessory;
use App\Http\Models\Navigation;
use Auth;

use App\Http\Composers\UserComposer;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Schema::defaultStringLength(191);

        $orders = UserOrder::join('delivery_locations', 'delivery_locations.order_id', 'user_orders.order_id')
          ->join('locations', 'locations.id', 'delivery_locations.location_id')
          ->orderby('user_orders.created_at', 'desc')
          ->limit(6)
          ->get();

        $ordersData = array();

          foreach($orders as $o) {
            $type;
            $order;
            $totalPrice = 0;
            $total = Order::where('order_id', $o->order_id)->get();
            $userOrder = UserOrder::where('order_id', $o->order_id)->first();
            $user = Customer::where('id', $userOrder->user_id)->first();
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
                  $price = $gas['price'] * $t['qty'];
                  break;
                case 1:
                  $acc = Accessory::where('id', $t->item_id)->first();
                  $price = $acc['price'] * $t['qty'];
                  break;
                case 3:
                  $gas = BulkGas::first();
                  $price = $gas['price'] * $t['qty'];
                  break;
              }
              $totalPrice += $price;
            }

            $order['cust_id'] = $user->id;
            $order['fname'] = $user->fname;
            $order['lname'] = $user->lname;
            $order['phone'] = $user->phone;
            $order['order_id'] = $o->order_id;
            $order['type'] = $type;
            $order['location'] = $o->address;
            $order['price'] = $totalPrice;
            $order['type'] = $type;
            $order['status'] = $o->status;
            $order['created_at'] = date('m.d.y  h:i:s', strtotime($o->created_at));
            array_push($ordersData, $order);
          }

        $users = Customer::count();
        $totalSales = UserOrder::where('status', 1)->count();
        $pending = UserOrder::where('status', 0)->count();
        $revenues = "";
        $costs = "";
        $currentUser;
        $navigation = array();

        view()->composer("*", function($view) {
          $currentUser = Auth::user();
          $navigation = array();
          if($currentUser != null) {
            $navigation = Navigation::where('type', $currentUser->type)->orWhere('type', 5)->get();
          }
          $view->with('navigation', $navigation);
        });

        $data = array(
          'orders' => $ordersData,
          'users' => $users,
          'pending' => $pending,
          'totalSales' => $totalSales,
          'revenues' => $revenues,
          'costs' => $costs
        );

        view()->share('data', $data);

    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
