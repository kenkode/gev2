<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Client;
use App\Http\Models\Audit;
use App\Http\Models\Item;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;

class ClientsController extends Controller {

	/**
	 * Display a listing of clients
	 *
	 * @return Response
	 */
	public function index()
	{
		$clients = Client::all();
		$header='Clients';
		$description='Current Clients';

		if (! Entrust::can('view_client') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        Audit::logaudit('Clients', 'viewed clients', 'viewed clients in the system');

		return view('clients.index', compact('clients','header','description'));
	}
	}

	/**
	 * Show the form for creating a new client
	 *
	 * @return Response
	 */
	public function create()
	{
		$header='Clients';
		$description='Create Client';
		$items = Item::all();
		if (! Entrust::can('create_client') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('clients.create', compact('items','header','description'));
	}
	}

	/**
	 * Store a newly created client in storage.
	 *
	 * @return Response
	 */
	public function store(Request $request)
	{
		$validator = Validator::make($data = $request->all(), Client::$rules, Client::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$date=date('y-m-dh:i:s'); 
		substr(md5($date),0,8);

		$client = new Client;

		$client->name = $request->name;
		$client->code = mt_rand(10000000, 99999999);
		$client->date = date('Y-m-d');
		$client->contact_person = $request->cname;
		$client->email = $request->email_office;
		$client->contact_person_email = $request->email_personal;
		$client->contact_person_phone = $request->mobile_phone;
		$client->phone = $request->office_phone;
		$client->address = $request->address;
		$client->type = $request->type;
		$client->category = $request->category;
		if($request->balance == ''){
		$client->balance = 0.00;
	    }else{
	    $client->balance = $request->balance;	
	    }
		/*$client->percentage_discount = Input::get('percentage_discount');*/
		$client->save();

		Audit::logaudit('Clients', 'created a client', 'created client '.$request->name.' in the system');

		return Redirect::route('clients.index')->withFlashMessage('Client successfully created!');
	}

	/**
	 * Display the specified client.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$client = Client::findOrFail($id);
		$header='Clients';
		$description='View Client';

		if (! Entrust::can('view_client') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        Audit::logaudit('Clients', 'viewed a client details', 'viewed client details for client '.$client->name.' in the system');

		return view('clients.show', compact('client','header','description'));
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
		$client = Client::find($id);
		$header='Clients';
		$description='Update Client';

		if (! Entrust::can('update_client') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

		return view('clients.edit', compact('client','header','description'));
	}
	}

	/**
	 * Update the specified client in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update(Request $request,$id)
	{
		$client = Client::findOrFail($id);

		$validator = Validator::make($data = $request->all(), Client::rolesUpdate($client->id), Client::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$date=date('y-m-dh:i:s'); 

		if($client->code == null || $client->code == ''){
          $client->code = mt_rand(10000000, 99999999);
		}

		$client->name = $request->name;
		$client->contact_person = $request->cname;
		$client->email = $request->email_office;
		$client->contact_person_email = $request->email_personal;
		$client->contact_person_phone = $request->mobile_phone;
		$client->phone = $request->office_phone;
		$client->address = $request->address;
		$client->type = $request->type;
		$client->category = $request->category;
		$client->balance = $request->balance;
		/*$client->percentage_discount = Input::get('percentage_discount');*/
		// $client->save();

		$client->update();

		Audit::logaudit('Clients', 'updated a client', 'updated client '.$request->name.' in the system');

		return Redirect::route('clients.index')->withFlashMessage('Client successfully updated!');
	}

	/**
	 * Remove the specified client from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{

        if (! Entrust::can('delete_client') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        $client = Client::find($id);
        Client::destroy($id);
        Audit::logaudit('Clients', 'deleted a client', 'deleted client '.$client->name.' from the system');
		return Redirect::route('clients.index')->withDeleteMessage('Client successfully deleted!');
	}
	}

}
