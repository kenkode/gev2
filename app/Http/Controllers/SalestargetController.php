<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\SalesTarget;
use App\Http\Models\Audit;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use DB;

class SalestargetController extends Controller {

	/**
	 * Display a listing of branches
	 *
	 * @return Response
	 */
	public function index()
	{
		$salestargets = SalesTarget::all();
		$header='Sales Target';
		$description='View Sales Target';

        if (! Entrust::can('view_sale_target') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        Audit::logaudit('Sales Target', 'viewed sales targets', 'viewed sales targets in the system');
		return view('salestargets.index', compact('salestargets','header','description'));
	}
	}

	/**
	 * Show the form for creating a new branch
	 *
	 * @return Response
	 */
	public function create()
	{
		$header='Sales Target';
		$description='Create Sales Target';
		if (! Entrust::can('create_sale_target') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('salestargets.create',compact('header','description'));
	}
	}

	/**
	 * Store a newly created branch in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), SalesTarget::$rules,SalesTarget::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$salestarget = new SalesTarget;

		$salestarget->month = Input::get('month');

        $salestarget->target_amount = Input::get('target_amount');

        $salestarget->target_date = date("Y-m-d",strtotime(Input::get('date')));

		$salestarget->save();


        Audit::logaudit('Sales Target', 'created sales targets', 'created sales targets for month '.Input::get('month').' target amount '.Input::get('target_amount').' target date '.date("Y-m-d",strtotime(Input::get('date'))).' in the system');
		return Redirect::route('salestargets.index')->withFlashMessage('Sales Target successfully created!');
	}

	/**
	 * Display the specified branch.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$salestarget = SalesTarget::findOrFail($id);
		$header='Sale Target';
		$description='View Sale Target';

        if (! Entrust::can('view_sale_target') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        Audit::logaudit('Sales Target', 'viewed sales targets', 'viewed sales targets in the system');	
		return view('salestargets.show', compact('salestarget','header','description'));
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
		$header='Sales Target';
		$description='Update Sales Target';
		$salestarget = SalesTarget::find($id);

        if (! Entrust::can('update_sale_target') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('salestargets.edit', compact('salestarget','header','description'));
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
		$salestarget = SalesTarget::findOrFail($id);

		$validator = Validator::make($data = Input::all(), SalesTarget::$rules, SalesTarget::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$salestarget->month = Input::get('month');
		$salestarget->target_amount = Input::get('target_amount');
		$salestarget->target_date = date("Y-m-d",strtotime(Input::get('date')));
		$salestarget->update();

		Audit::logaudit('Sales Target', 'updated sales targets', 'updated sales targets for month '.Input::get('month').' target amount '.Input::get('target_amount').' target date '.date("Y-m-d",strtotime(Input::get('date'))).' in the system');

		return Redirect::route('salestargets.index')->withFlashMessage('Target successfully updated!');
	}

	/**
	 * Remove the specified branch from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{

        if (! Entrust::can('delete_sale_target') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

        $sales = SalesTarget::find($id);
        SalesTarget::destroy($id);

        Audit::logaudit('Sales Target', 'created sales targets', 'created sales targets for month '.$sales->month.' target amount '.$sales->target_amount.' target date '.$sales->target_date.' in the system');

		return Redirect::route('salestargets.index')->withDeleteMessage('Target successfully removed!');
	}
	}

}
