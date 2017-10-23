<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Audit;
use App\Http\Models\Account;
use App\Http\Models\Notification;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Auth;
use DB;

class AccountsController extends Controller {

	/**
	 * Display a listing of accounts
	 *
	 * @return Response
	 */
	public function index()
	{

		if ( Entrust::can('view_account') ) // Checks the current user
        {
		$accounts = DB::table('accounts')->orderBy('code', 'asc')->get();
		$header='Accounts';
		$description='View Chart of Accounts';

		Audit::logaudit('Accounts', 'viewed accounts', 'viewed chart of accounts in the system');

		return view('accounts.index', compact('accounts','header','description'));
		
	    }else{
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
	    }
	}

	/**
	 * Show the form for creating a new account
	 *
	 * @return Response
	 */
	public function create()
	{
		if (! Entrust::can('create_account') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        $header='Accounts';
		$description='Create Account';
		return view('accounts.create',compact('header','description'));
	}
	}

	/**
	 * Store a newly created account in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Account::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}


		// check if code exists
		$code = Input::get('code');
		$code_exists = DB::table('accounts')->where('code', '=', $code)->count();

		if($code_exists >= 1){

			return Redirect::back()->withErrors(array('error'=>'The GL code already exists'))->withInput();
		}
		else {


		$account = new Account;


		$account->category = Input::get('category');
		$account->name = Input::get('name');
		$account->code = Input::get('code');
		$account->balance = Input::get('balance');
		if(Input::get('active')){
			$account->active = TRUE;
		}
		else {
			$account->active = FALSE;
		}
		$account->save();

		}

		Audit::logaudit('Accounts', 'created an account', 'created account  '.$account->name.' '.$account->code.' in the system');

		return Redirect::route('accounts.index');
	}

	/**
	 * Display the specified account.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		if (! Entrust::can('view_account') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		$account = Account::findOrFail($id);
        Audit::logaudit('Accounts', 'viewed account details', 'viewed account details for account '.$account->name.' '.$account->code.' in the system');
		return view('accounts.show', compact('account'));
	}
	}

	/**
	 * Show the form for editing the specified account.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$account = Account::find($id);
        $header='Accounts';
		$description='Update Account';

     if (! Entrust::can('update_account') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('accounts.edit', compact('account','header','description'));
			}
	}

	/**
	 * Update the specified account in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$account = Account::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Account::$rules);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$code = Input::get('code');
		$original_code = DB::table('accounts')->where('id', '!=', $account->id)->where('code', $code)->count();

		if($original_code > 0) {

			return Redirect::back()->withErrors(array('error'=>'The Account code already exists'))->withInput();
		}else {

		$account->category = Input::get('category');
		$account->name = Input::get('name');
		$account->code = Input::get('code');
		//$account->balance = Input::get('balance');
		if(Input::get('active')){
			$account->active = TRUE;
		}
		else {
			$account->active = FALSE;
		}

		$account->update();

		}
		
		Audit::logaudit('Accounts', 'update', 'updated: '.$account->name.' '.$account->code);


		return Redirect::route('accounts.index');
	}

	/**
	 * Remove the specified account from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{

       if (! Entrust::can('delete_account') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		$account = Account::findOrFail($id);

		Account::destroy($id);


		Audit::logaudit('Accounts', 'deleted an account', 'deleted account '.$account->name.' '.$account->code.' from the system');


		return Redirect::route('accounts.index');
	}
	}

}
