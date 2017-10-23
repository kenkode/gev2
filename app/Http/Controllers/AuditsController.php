<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Audit;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Auth;
use DB;

class AuditsController extends Controller {

	/**
	 * Display a listing of audits
	 *
	 * @return Response
	 */
	public function index()
	{
		$audits = Audit::all();
		$header='Audit Trails';
		$description='View Audit Trails';

		Audit::logaudit('Audit Trails', 'viewed audit trails', 'viewed audit trails in the system');

		return view('audits.index', compact('audits','header','description'));
	}

	/**
	 * Show the form for creating a new audit
	 *
	 * @return Response
	 */
	public function create()
	{
		return view('audits.create');
	}

	/**
	 * Store a newly created audit in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Audit::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		Audit::create($data);

		return Redirect::route('audits.index');
	}

	/**
	 * Display the specified audit.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$audit = Audit::findOrFail($id);

		return view('audits.show', compact('audit'));
	}

	/**
	 * Show the form for editing the specified audit.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$audit = Audit::find($id);

		return view('audits.edit', compact('audit'));
	}

	/**
	 * Update the specified audit in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$audit = Audit::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Audit::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$audit->update($data);

		return Redirect::route('audits.index');
	}

	/**
	 * Remove the specified audit from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		Audit::destroy($id);

		return Redirect::route('audits.index');
	}

}
