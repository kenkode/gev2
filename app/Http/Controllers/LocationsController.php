<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Store;
use App\Http\Models\Audit;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use DB;

class LocationsController extends Controller {

	/**
	 * Display a listing of locations
	 *
	 * @return Response
	 */
	public function index()
	{
		$locations = Store::all();
		$header='Stores';
		$description='View Stores';

        if (! Entrust::can('view_store') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        Audit::logaudit('Stores', 'viewed stores', 'viewed stores in the system');
		return view('locations.index', compact('locations','header','description'));
	}
	}

	/**
	 * Show the form for creating a new location
	 *
	 * @return Response
	 */
	public function create()
	{
		$header='Stores';
		$description='Create Store';
		if (! Entrust::can('create_store') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('locations.create',compact('header','description'));
	}
	}

	/**
	 * Store a newly created location in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Store::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$location = new Store;

		$location->name = Input::get('name');
		$location->description = Input::get('description');
		$location->save();

		Audit::logaudit('Stores', 'created a store', 'created store '.Input::get('name').' in the system');

		return Redirect::route('locations.index')->withFlashMessage('Store has been successfully created!');
	}

	/**
	 * Display the specified location.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$location = Store::findOrFail($id);
		$header='Stores';
		$description='View Store';

        if (! Entrust::can('view_store') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Stores', 'viewed store details', 'viewed store details for store '.$location->name.' in the system');
		return view('locations.show', compact('location','header','description'));
	}
	}

	/**
	 * Show the form for editing the specified location.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$location = Store::find($id);
		$header='Stores';
		$description='Update Store';

        if (! Entrust::can('update_store') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('locations.edit', compact('location','header','description'));
	}
	}

	/**
	 * Update the specified location in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$location = Store::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Store::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$location->name = Input::get('name');
		$location->description = Input::get('description');
		$location->update();

		Audit::logaudit('Stores', 'updated a store', 'updated store '.Input::get('name').' in the system');

		return Redirect::route('locations.index')->withFlashMessage('Store has been successfully updated!');

	}

	/**
	 * Remove the specified location from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{


        if (! Entrust::can('delete_store') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        $location = Store::find($id);
        Store::destroy($id);

        Audit::logaudit('Stores', 'deleted a store', 'deleted store '.$location->name.' from the system');
		return Redirect::route('locations.index')->withFlashMessage('Store has been successfully removed!');
	}

	}

}
