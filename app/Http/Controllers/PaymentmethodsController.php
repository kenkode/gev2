<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Paymentmethod;
use App\Http\Models\Audit;
use App\Http\Models\Account;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use DB;

class PaymentmethodsController extends Controller {

	/**
	 * Display a listing of paymentmethods
	 *
	 * @return Response
	 */
	public function index()
	{
		$paymentmethods = Paymentmethod::all();
		$header='Payment methods';
		$description='View Payment Methods';

		if (! Entrust::can('view_payment_methods') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Payment Methods', 'viewed payment methods', 'viewed payment methods in the system');
		return view('paymentmethods.index', compact('paymentmethods','header','description'));
	}
	}

	/**
	 * Show the form for creating a new paymentmethod
	 *
	 * @return Response
	 */
	public function create()
	{
		$accounts = Account::all();
		$header='Payment method';
		$description='Create Payment Method';

		if (! Entrust::can('create_payment_methods') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('paymentmethods.create',compact('accounts','header','description'));
	}
	}

	/**
	 * Store a newly created paymentmethod in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Paymentmethod::$rules, Paymentmethod::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		$paymentmethod = new Paymentmethod;

		$paymentmethod->name = Input::get('name');
		$paymentmethod->account_id = Input::get('account');
		$paymentmethod->save();

		Audit::logaudit('Payment Methods', 'created a payment method', 'created a payment method '.Input::get('name').' in the system');

		return Redirect::route('paymentmethods.index')->withFlashMessage('Payment Method successfully created!');
	}

	/**
	 * Display the specified paymentmethod.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		$paymentmethod = Paymentmethod::findOrFail($id);
		$header='Payment method';
		$description='View Payment Method';

        if (! Entrust::can('view_payment_methods') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('Payment Methods', 'viewed a payment method details', 'viewed a payment method details for '.$paymentmethod->name.' in the system');
		return view('paymentmethods.show', compact('paymentmethod','header','description'));
	}
	}

	/**
	 * Show the form for editing the specified paymentmethod.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		$paymentmethod = Paymentmethod::find($id);
        $accounts = Account::all();
        $header='Payment method';
		$description='Update Payment Method';

        if (! Entrust::can('update_payment_methods') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		return view('paymentmethods.edit', compact('paymentmethod','accounts','header','description'));
	}
	}

	/**
	 * Update the specified paymentmethod in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$paymentmethod = Paymentmethod::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Paymentmethod::$rules, Paymentmethod::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

        $paymentmethod->name = Input::get('name');
		$paymentmethod->account_id = Input::get('account');
		$paymentmethod->update();

		Audit::logaudit('Payment Methods', 'updated a payment method', 'updated a payment method '.Input::get('name').' in the system');

		return Redirect::route('paymentmethods.index')->withFlashMessage('Payment Method successfully updated!');
	}

	/**
	 * Remove the specified paymentmethod from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		

        if (! Entrust::can('delete_payment_methods') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        $paymentmethod = Paymentmethod::find($id);
         Paymentmethod::destroy($id);
        Audit::logaudit('Payment Methods', 'deleted a payment method', 'deleted a payment method '.$paymentmethod->name.' from the system');
		return Redirect::route('paymentmethods.index')->withDeleteMessage('Payment Method successfully deleted!');
	}
	}

}
