<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Price;
use App\Http\Models\Client;
use App\Http\Models\Audit;
use App\Http\Models\Item;
use App\Http\Models\Notification;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use DB;

class PricesController extends Controller {

	/**
	 * Display a listing of clients
	 *
	 * @return Response
	 */
	public function index()
	{
		$prices = Price::all();
		$header='Pricing';
		$description='Current Pricing';

		if (! Entrust::can('view_pricing') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Prices', 'viewed clients` discount prices', 'viewed clients` discount prices in the system');
		return view('prices.index', compact('prices','header','description'));
	}
	}

	/**
	 * Show the form for creating a new client
	 *
	 * @return Response
	 */
	public function create()
	{
		$items = Item::all();
		$header='Pricing';
		$description='Create Pricing';
		$clients = Client::all();
		if (! Entrust::can('create_pricing') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('prices.create', compact('items','clients','header','description'));
	}
	}

	/**
	 * Store a newly created client in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Price::$rules, Price::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$price = new Price;

		$price->date = date('Y-m-d');
		$price->client_id = Input::get('client');		
		$price->item_id = Input::get('item');
		$price->Discount = Input::get('discount');		
		$price->save();

		$client = Client::find(Input::get('client'));
		$i = Item::find(Input::get('item'));
        
        Audit::logaudit('Prices', 'created a client discount price', 'created a client discount price for client '.$client->name.' item '.$i->item_make.' amount '.Input::get('discount').' in the system');

		return Redirect::route('prices.index')->withFlashMessage('Discount successfully Set!');
	}

	/**
	 * Display the specified client.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$price = Price::findOrFail($id);
		$header='Pricing';
		$description='View Pricing';
        
        if (! Entrust::can('view_pricing') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        $client = Client::find($price->client_id);
		$i = Item::find($price->Item_id);	
        Audit::logaudit('Prices', 'viewed a client discount price details', 'viewed client discount price details for '.$client->name.' item '.$i->item_make.' amount '.$price->Discount.' in the system');
		return view('prices.show', compact('price','header','description'));
	}
	}

	/**
	 * Show the form for editing the specified client.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$price = Price::find($id);
		$items = Item::all();
		$clients = Client::all();
		$header='Pricing';
		$description='Update Pricing';

        if (! Entrust::can('update_pricing') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('prices.edit', compact('price','items','clients','header','description'));
	}
	}

	/**
	 * Update the specified client in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$price = Price::findOrFail($id);

		$validator = Validator::make($data = Input::all(),Price::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		if (! Entrust::can('confirm_update_pricing') ) // Checks the current user
        {

		$client_id = Input::get('client');		
		$item_id = Input::get('item');
		$discount = Input::get('discount');

		$client = Client::find($client_id);
		$item = Item::find($item_id);
		$username = Auth::user()->username;

		$users = DB::table('roles')
		->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
		->join('users', 'assigned_roles.user_id', '=', 'users.id')
		->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
		->select("users.id","email","users.name")
		->where("permission_id",104)->get();

		$key = md5(uniqid());

		foreach ($users as $user) {

		Notification::notifyUser($user->id,"Approval to pricing for item".$item->item_make." is required","price","notificationshowprice/".$client->id."/".$item->id."/".$discount."/".Auth::user()->id."/".$user->id."/".$key."/".$id,$key);

		/*$email = $user->email;

		$send_mail = Mail::send('emails.pricing', array('name' => $user->username, 'username' => $username,'client' => $client,'item' => $item,'discount' => $discount,'receiver'=>Auth::user()->id,'confirmer' => $user->id,'key'=>$key,'id' => $id), function($message) use($email)
        {   
		    $message->from('info@lixnet.net', 'Gas Express');
		    $message->to($email, 'Gas Express')->subject('Pricing Update!');

    
        });*/
	    }

	    $client = Client::find(Input::get('client'));
		$i = Item::find(Input::get('item'));

        Audit::logaudit('Prices', 'updated a client discount price', 'updated a client discount price for client '.$client->name.' item '.$i->item_make.' amount '.Input::get('discount').' awaiting approval in the system');

        return Redirect::to('prices')->with('notice', 'Admin approval is needed for this update');
        }else{

		$price->date = date('Y-m-d');
		$price->client_id = Input::get('client');		
		$price->item_id = Input::get('item');
		$price->Discount = Input::get('discount');
		$price->confirmed_id = Auth::user()->id;
        $Price->receiver_id = Auth::user()->id;	
		$price->update();

		$client = Client::find(Input::get('client'));
		$i = Item::find(Input::get('item'));

		Audit::logaudit('Prices', 'updated a client discount price', 'updated a client discount price for client '.$client->name.' item '.$i->item_make.' amount '.Input::get('discount').' in the system');

		return Redirect::route('prices.index')->withFlashMessage('Client Discount successfully updated!');
	}
	}

    public function approveprice($client,$item,$discount,$receiver,$confirmer,$key,$id)
	{
		$price = Price::findOrFail($id);
        if($price->confirmation_code != $key){
		$price->date = date('Y-m-d');
		$price->client_id = $client;		
		$price->item_id = $item;
		$price->Discount = $discount;		
        $price->confirmed_id = $confirmer;
        $price->receiver_id = $receiver;
        $price->confirmation_code = $key;
		$price->update();

		$i = Item::find($item);

		$client = Client::find($client);

		$notification = Notification::where('confirmation_code',$key)->first();
		$notification->is_read = 1;
		$notification->update();

		Audit::logaudit('Prices', 'approved client discount price updated', 'approved client discount price updated for client '.$client->name.' item '.$i->item_make.' updated by user '.$user->username.' in the system');

		return "<strong><span style='color:green'>Price update for ".$i->item_make." successfully approved!</span></strong>";
	}else{
		return "<strong><span style='color:red'>Item Price has already approved!</span></strong>";
	}
	
	}



   public function notificationshowprice($client,$item,$discount,$receiver,$confirmer,$key,$id)
	{

    $price = Price::findOrFail($id);
    $header='Pricing';
    $description='Update Pricing';
    if($price->confirmation_code != $key){
    	$notification = Notification::where('confirmation_code',$key)->where('user_id',$confirmer)->first();
		$notification->is_read = 1;
		$notification->update();

		$c = Client::find($client);
		$clientname = $c->name;
		$i = Item::find($item);
		$itemmake = $i->item_make;

		return view('prices.showitem', compact('client','item','discount','receiver','confirmer','key','id','clientname','itemmake','header','description'));
	}else{
		$notification = Notification::where('confirmation_code',$key)->where('user_id',$confirmer)->first();
		$notification->is_read = 1;
		$notification->update();

		return Redirect::to('notifications/index')->withDeleteMessage('Client discount has already approved!');
	}
	
	}

	public function notificationapproveprice()
	{

		$price = Price::findOrFail(Input::get('id'));
		
		$price->date = date('Y-m-d');
		$price->client_id = Input::get('client');		
		$price->item_id = Input::get('item');
		$price->Discount = Input::get('discount');	
        $price->confirmed_id = Input::get('confirmer');
        $price->receiver_id = Input::get('receiver');
        $price->confirmation_code = Input::get('key');
		$price->update();

		$i = Item::find(Input::get('item'));
        $client = Client::find(Input::get('client'));
        $user = DB::table("users")->where('id',Input::get('receiver'))->first();

        $notification = Notification::where('confirmation_code',Input::get('key'))->first();
		$notification->is_read = 1;
		$notification->update();

		Audit::logaudit('Prices', 'approved client discount price updated', 'approved client discount price updated for client '.$client->name.' item '.$i->item_make.' updated by user '.$user->name.' in the system');

		return Redirect::to('notifications/index')->withFlashMessage("Price update for ".$i->item_make." successfully approved!");
	
	}

	/**
	 * Remove the specified client from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{

        if (! Entrust::can('delete_pricing') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        $price = Price::find($id);
        $item = Item::find($price->item_id);
        $client = Client::find($price->client_id);
        Price::destroy($id);

        Audit::logaudit('Prices', 'deleted a client discount', 'deleted client discount for client '.$client->name.' item '.$item->item_make.' amount '.$price->Discount.' in the system');
		return Redirect::route('prices.index')->withDeleteMessage('Client Discount successfully deleted!');
	}
	}

}
