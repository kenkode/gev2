<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Tax;
use App\Http\Models\Audit;
use App\Http\Models\Account;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use DB;

class TaxController extends Controller {

	/**
	 * Display a listing of branches
	 *
	 * @return Response
	 */
	public function index()
	{
		$taxes = Tax::all();
		$header='Tax Rates';
		$description='View Tax Rates';

        if (! Entrust::can('view_tax') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Taxes', 'viewed taxes', 'viewed taxes in the system');
		return view('taxes.index', compact('taxes','header','description'));
	}
	}

	/**
	 * Show the form for creating a new branch
	 *
	 * @return Response
	 */
	public function create()
	{
		$header='Tax Rates';
		$description='Create Tax Rate';
		if (! Entrust::can('create_tax') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('taxes.create',compact('header','description'));
	}
	}

	/**
	 * Store a newly created branch in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Tax::$rules,Tax::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$tax = new Tax;

		$tax->name = Input::get('name');

        $tax->rate = Input::get('rate');

		$tax->save();

		Audit::logaudit('Taxes', 'created a tax', 'created tax type '.Input::get('name').' rate '.Input::get('rate').' in the system');

		return Redirect::route('taxes.index')->withFlashMessage('Tax successfully created!');
	}

	/**
	 * Display the specified branch.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$tax = Tax::findOrFail($id);
		$header='Tax Rates';
		$description='View Tax Rates';

        if (! Entrust::can('view_tax') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Taxes', 'viewed tax details', 'viewed tax details for '.$tax->name.' rate '.$tax->rate.' in the system');
		return view('taxes.show', compact('tax','header','description'));
	}
	}

	/**
	 * Show the form for editing the specified branch.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$tax = Tax::find($id);
		$header='Tax Rates';
		$description='Update Tax Rate';

        if (! Entrust::can('update_tax') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('taxes.edit', compact('tax','header','description'));
	}
	}

	/**
	 * Update the specified branch in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$tax = Tax::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Tax::$rules, Tax::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$tax->name = Input::get('name');
		$tax->rate = Input::get('rate');
		$tax->update();

        Audit::logaudit('Taxes', 'updated a tax', 'updated tax type '.Input::get('name').' rate '.Input::get('rate').' in the system');

		return Redirect::route('taxes.index')->withFlashMessage('Tax successfully updated!');
	}

	/**
	 * Remove the specified branch from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		
        if (! Entrust::can('delete_tax') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        $tax = Tax::find($id);
        Tax::destroy($id);

        Audit::logaudit('Taxes', 'created a tax', 'created tax type '.$tax->name.' rate '.$tax->rate.' from the system');
		return Redirect::route('taxes.index')->withDeleteMessage('Tax successfully deleted!');
	}
	}

}
