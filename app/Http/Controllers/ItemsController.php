<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Audit;
use App\Http\Models\Item;
use App\Http\Models\Notification;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Auth;
use DB;

class ItemsController extends Controller {

	/**
	 * Display a listing of items
	 *
	 * @return Response
	 */
	public function index()
	{
		$items = Item::all();
		$header='Items';
		$description='Current Items';

		if (! Entrust::can('view_item') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Items', 'viewed items', 'viewed items in the system');
		return view('items.index', compact('items','header','description'));
	    }
	}

	/**
	 * Show the form for creating a new item
	 *
	 * @return Response
	 */
	public function create()
	{
		$header='Items';
		$description='Create Item';
		if (! Entrust::can('create_item') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('items.create',compact('header','description'));
	    }
	}

	/**
	 * Store a newly created item in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Item::$rules, Item::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$item = new Item;

		$item->item_make = Input::get('item_make');
		$item->item_size = Input::get('item_size');
		$item->date = date('Y-m-d');
		$item->description = Input::get('description');
		$item->purchase_price= Input::get('pprice');
		$item->selling_price = Input::get('sprice');
		$item->sku= Input::get('sku');
		$item->tag_id = Input::get('tag');
		$item->reorder_level = Input::get('reorder');
		$item->save();

		Audit::logaudit('Items', 'created an item', 'created item '.Input::get('item_make').' in the system');

		return Redirect::route('items.index')->withFlashMessage('Item successfully created!');
	}

	/**
	 * Display the specified item.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$item = Item::findOrFail($id);

		$header='Items';
		$description='View Item';

		if (! Entrust::can('view_item') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Items', 'viewed item details', 'viewed item details for item '.$item->item_make.' in the system');
		return view('items.show', compact('item','header','description'));
	}
	}

	/**
	 * Show the form for editing the specified item.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$item = Item::find($id);
		$header='Items';
		$description='Current Items';

		if (! Entrust::can('update_item') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

		return view('items.edit', compact('item','header','description'));
	}
	}

	/**
	 * Update the specified item in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$item = Item::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Item::$rules, Item::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		if (! Entrust::can('confirm_update_item') ) // Checks the current user
        {

        $name = Input::get('item_make');
        $size = Input::get('item_size');
		$description = Input::get('description');
		$purchase_price= Input::get('pprice');
		$selling_price = Input::get('sprice');
		$sku= Input::get('sku');
		$tag_id = Input::get('tag');
		$reorder_level = Input::get('reorder');
        $receiver_id = Auth::user()->id;
		$username = Auth::user()->name;

		if($tag_id == ""){
		$tag_id = "null";
		}else{
		$tag_id = $tag_id;
		}
		if($sku == ""){
		$sku = "null";
		}else{
		$sku = $sku;
		}
		if($size == ""){
		$size = "null";
		}else{
		$size = $size;
		}
		if($description == ""){
		$description = "null";
		}else{
		$description = $description;
		}

		$users = DB::table('roles')
		->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
		->join('users', 'assigned_roles.user_id', '=', 'users.id')
		->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
		->select("users.id","email","users.name")
		->where("permission_id",103)->get();

		$key = md5(uniqid());

		foreach ($users as $user) {

		Notification::notifyUser($user->id,"Hello, Approval to update Item ".$name." is required","item","notificationshowitemupdate/".$name."/".$size."/".$description."/".$purchase_price."/".$selling_price."/".$sku."/".$tag_id."/".$reorder_level."/".$receiver_id."/".$user->id."/".$key."/".$id,$key);

		/*$email = $user->email;
			
        $send_mail = Mail::send('emails.item', array('name' => $user->username, 'username' => $username,'itemname' => $name,'size' => $size,'description' => $description,'pprice' => $purchase_price,'sprice' => $selling_price,'sku' => $sku,'tagid' => $tag_id,'reorderlevel' => $reorder_level,'receiver' => $receiver_id,'confirmer' => $user->id,'key'=>$key,'id' => $id), function($message) use($email)
        {   
		    $message->from('info@lixnet.net', 'Gas Express');
		    $message->to($email, 'Gas Express')->subject('Item Update!');

   
        });*/
        }
        Audit::logaudit('Items', 'updated an item', 'updated item '.$name.' in the system and awaiting approval');
        return Redirect::to('items')->with('notice', 'Admin approval is needed for this update');
        }else{

		$item->item_make = Input::get('item_make');
		$item->item_size = Input::get('item_size');
		$item->description = Input::get('description');
		$item->purchase_price= Input::get('pprice');
		$item->selling_price = Input::get('sprice');
		$item->sku= Input::get('sku');
		$item->tag_id = Input::get('tag');
		$item->reorder_level = Input::get('reorder');
        $item->confirmed_id = Auth::user()->id;
        $item->receiver_id = Auth::user()->id;
		$item->update();

        Audit::logaudit('Items', 'updated an item', 'updated item '.Input::get('item_make').' in the system');

		return Redirect::route('items.index')->withFlashMessage('Item successfully updated!');
	}
	}

	public function approveitem($name,$size,$description,$pprice,$sprice,$sku,$tagid,$reorderlevel,$receiver,$confirmer,$key,$id)
	{

		$item = Item::findOrFail($id);
        if($item->confirmation_code != $key){
		$item->item_make = $name;
		$item->item_size = $size;
		$item->description = $description;
		$item->purchase_price= $pprice;
		$item->selling_price = $sprice;
		$item->sku= $sku;
		$item->tag_id = $tagid;
		$item->reorder_level = $reorderlevel;
        $item->confirmed_id = $confirmer;
        $item->receiver_id = $receiver;
        $item->confirmation_code = $key;
		$item->update();

		$user = DB::table("users")->where('id',$receiver)->first();

		Audit::logaudit('Items', 'approved an item', 'approved update for item '.$name.' updated by user '.$user->username.' in the system');

		$notification = Notification::where('confirmation_code',$key)->first();
		$notification->is_read = 1;
		$notification->update();

		return "<strong><span style='color:green'>Item update for ".$name." successfully approved!</span></strong>";
	}else{
         return "<strong><span style='color:red'>Item has already been approved!</span></strong>";
	}
	
	}

	public function notificationshowitem($name,$size,$description,$pprice,$sprice,$sku,$tagid,$reorderlevel,$receiver,$confirmer,$key,$id)
	{

    $item = Item::findOrFail($id);
    $header='Items';
	$description='Current Items';
    if($item->confirmation_code != $key){
    	$notification = Notification::where('confirmation_code',$key)->where('user_id',$confirmer)->first();
		$notification->is_read = 1;
		$notification->update();

		return view('items.showitem', compact('name','size','description','pprice','sprice','sku','tagid','reorderlevel','receiver','confirmer','key','id','header','description'));
	}else{
		$notification = Notification::where('confirmation_code',$key)->where('user_id',$confirmer)->first();
		$notification->is_read = 1;
		$notification->update();

		return Redirect::to('notifications/index')->withDeleteMessage('Item has already been approved!');
	}
	
	}

	public function notificationapproveitem()
	{

		$item = Item::findOrFail(Input::get('id'));
		$item->item_make = Input::get('name');
		$item->item_size = Input::get('item_size');
		$item->description = Input::get('description');
		$item->purchase_price= Input::get('pprice');
		$item->selling_price = Input::get('sprice');
		$item->sku= Input::get('sku');
		$item->tag_id = Input::get('tag');
		$item->reorder_level = Input::get('reorder');
        $item->confirmed_id = Input::get('confirmer');
        $item->receiver_id = Input::get('receiver');
        $item->confirmation_code = Input::get('key');
		$item->update();

		$user = DB::table("users")->where('id',Input::get('receiver'))->first();

		$notification = Notification::where('confirmation_code',Input::get('key'))->first();
		$notification->is_read = 1;
		$notification->update();

        Audit::logaudit('Items', 'approved an item', 'approved update for item '.Input::get('name').' updated by user '.$user->name.' in the system');

		return Redirect::to('notifications/index')->withFlashMessage("Item update for ".Input::get('name')." successfully approved!");
	
	}

	/**
	 * Remove the specified item from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		

		if (! Entrust::can('delete_item') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        $item = Item::find($id);

        Item::destroy($id);

        Audit::logaudit('Items', 'deleted an item', 'deleted item '.$item->item_make.' from the system');

		return Redirect::route('items.index')->withDeleteMessage('Item successfully deleted!');
	}
	}

	public function code($id)
	{
		$item = Item::find($id);
		return View::make('items.code', compact('item'));
	}

	public function generate($id)
	{

		$item = Item::find($id);
		return View::make('items.generate', compact('item'));
	}

}
