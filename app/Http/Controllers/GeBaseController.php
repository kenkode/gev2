<?php

namespace App\Http\Controllers;

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

class GeBaseController extends Controller {

  public $navigation;

  public function __construct() {
    // $navigation = Navigation::where('type', Auth::user()->type);
    // $this->navigation = $navigation;
  }

}


?>
