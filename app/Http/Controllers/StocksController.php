<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Audit;
use App\Http\Models\Item;
use App\Http\Models\Stock;
use App\Http\Models\Store;
use App\Http\Models\Client;
use App\Http\Models\Erporderitem;
use App\Http\Models\Notification;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Auth;
use DB;

class StocksController extends Controller {

	/**
	 * Display a listing of stocks
	 *
	 * @return Response
	 */
	public function index()
	{
		$stocks = Stock::all();

		$items = Item::all();

		$header='Stocks';
		$description='View Stocks';

		$stock_in = DB::table('stocks')
         ->join('items', 'stocks.item_id', '=', 'items.id')
         ->get();

        if (! Entrust::can('view_stock') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Stocks', 'viewed stocks', 'viewed stocks in the system');
		return view('stocks.index', compact('stocks', 'items','stock_in','header','description'));
	}
	}

	/**
	 * Show the form for creating a new stock
	 *
	 * @return Response
	 */
	public function create()
	{
		$items = Item::all();
		$locations = Store::all();
		$clients = Client::all();

        $header='Stocks';
		$description='Receive Stock';

		$erporders = DB::table('erporders')
		                 ->join('clients','erporders.client_id','=','clients.id')
		                 ->select( DB::raw('erporders.client_id, erporders.order_number'))
		                 ->get();

        if (! Entrust::can('receive_stock') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('stocks.create', compact('items', 'locations','clients','erporders','header','description'));
	}
	}

	public function confirmstock()
	{
		$items = Item::all();
		$locations = Store::all();
		$clients = Client::all();

        $header='Stocks';
		$description='Confirm Stock';

		$erporders = DB::table('erporders')
		                 ->join('clients','erporders.client_id','=','clients.id')
		                 ->select( DB::raw('erporders.client_id, erporders.order_number'))
		                 ->get();

        if (! Entrust::can('receive_stock') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('stocks.create', compact('items', 'locations','clients','erporders','header','description'));
	}
	}

	/**
	 * Store a newly created stock in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Stock::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		

		$id = explode(" : ",Input::get('item'));



        $order = Erporderitem::join('erporders','erporderitems.erporder_id','=','erporders.id')
                   ->join('stocks','erporders.id','=','stocks.item_id')
                   ->where('stocks.item_id',$id[0])
                   ->where('stocks.itm_id',$id[1])
                   ->where('erporderitems.item_id',$id[1])
                   ->where('erporders.status','new')
                   ->whereNotNull('authorized_by')
                   ->select(DB::raw('(quantity-sum(quantity_in)) AS total'))
                   ->first();

       

        //print_r($order);

        //return $id[1];
        $total = 0;        

        if($order->total == null){
        $ord = Erporderitem::join('erporders','erporderitems.erporder_id','=','erporders.id')
                   ->join('items','erporderitems.item_id','=','items.id')
                   ->where('erporders.id',$id[0])
                   ->where('erporderitems.item_id',$id[1])
                   ->where('erporders.status','new')
                   ->whereNotNull('authorized_by')
                   ->first();
        $total = $ord->quantity;
        }else{
        $total = $order->total;
        }
        //return $total;
		//return $total;

		if(Input::get('lease_qty') > $total){
		  
          return Redirect::route('stocks.index')->withDeleteMessage('Quantity inputed exceeds stock available!');
		}else{

		$erporder_id = $id[0];
		$location_id = Input::get('location');
		$date = date('Y-m-d');
		$erporderitem = Erporderitem::where('erporder_id',$erporder_id)->first();
		$item = Item::findOrFail($id[1]);
		$client = Client::findOrFail(Input::get('client'));
		//$location = Location::find($location_id);
		$quantity = Input::get('lease_qty');
		/*$date = Input::get('date');*/

		

		Stock::addStock(Input::get('client'),$id[1], $erporder_id, $location_id, $quantity, $date);

		if (! Entrust::can('confirm_stock') ) // Checks the current user
        {
        Audit::logaudit('Stocks', 'receive stocks', 'received stock for item '.$item->item_make.' quantity received '.$quantity.' from supplier '.$client->name.' but awaiting approval in the system');

        return Redirect::to('stocks')->with('notice', 'Stock has been successfully updated! Please wait for admin confirmation....');

        }else{

        Audit::logaudit('Stocks', 'receive stocks', 'received stock for item '.$item->item_make.' quantity received '.$quantity.' from supplier '.$client->name.' in the system');

		return Redirect::route('stocks.index')->withFlashMessage('stock has been successfully updated!');
	}
    }
	}

	/**
	 * Display the specified stock.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$stock = Stock::findOrFail($id);

        if (! Entrust::can('view_stock') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('stocks.show', compact('stock'));
	}
    }

	/**
	 * Show the form for editing the specified stock.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$stock = Stock::find($id);

		return view('stocks.edit', compact('stock'));
	}

	/**
	 * Update the specified stock in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$stock = Stock::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Stock::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$stock->update($data);

		return Redirect::route('stocks.index');
	}

	/**
	 * Remove the specified stock from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		Stock::destroy($id);

		return Redirect::route('stocks.index');
	}

}
