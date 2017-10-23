<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Expense;
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

class ExpensesController extends Controller {

	/**
	 * Display a listing of expenses
	 *
	 * @return Response
	 */
	public function index()
	{
		if (! Entrust::can('view_expense') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		$expenses = Expense::whereNotNull('confirmed_id')->whereNotNull('receiver_id')->get();
		$header='Expenses';
		$description='View Expenses';

		Audit::logaudit('Expenses', 'viewed expenses', 'viewed expenses in the system');

		return view('expenses.index', compact('expenses','header','description'));
	    }
	}

	/**
	 * Show the form for creating a new expense
	 *
	 * @return Response
	 */
	public function create()
	{
		if (! Entrust::can('create_expense') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		$accounts = Account::all();
		$header='Expenses';
		$description='Create Expense';
		return view('expenses.create',compact('accounts','header','description'));
	}
	}

	/**
	 * Store a newly created expense in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$validator = Validator::make($data = Input::all(), Expense::$rules, Expense::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}

		if (! Entrust::can('approve_expense') ) // Checks the current user
        {

        $username = Auth::user()->username;

		$users = DB::table('roles')
		->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
		->join('users', 'assigned_roles.user_id', '=', 'users.id')
		->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
		->select("users.id","email","users.name")
		->where("permission_id",141)->get();

        $key = md5(uniqid());

		foreach ($users as $user) {

		Notification::notifyUser($user->id,"Hello, Please check expense inserted for item ".Input::get('name'),"check expense","notificationshowexpense/".Input::get('name')."/".Input::get('type')."/".Input::get('amount')."/".date("Y-m-d",strtotime(Input::get('date')))."/".Input::get('account')."/".Auth::user()->id."/".$user->id."/".$key,$key);
     	}
     	Audit::logaudit('Expenses', 'created an expense', 'created expense '.Input::get('name').' in the system and awaiting approval');
        return Redirect::to('expenses')->with('notice', 'Admin approval is needed to insert this expense');
        }else{

		$expense = new Expense;

		$expense->name = Input::get('name');
		$expense->type = Input::get('type');
		$expense->amount = Input::get('amount');		
		$expense->date = date("Y-m-d",strtotime(Input::get('date')));
		$expense->account_id = Input::get('account');
		$expense->receiver_id = Auth::user()->id;
        $expense->confirmed_id = Auth::user()->id;
		$expense->save();

        DB::table('accounts')
            ->join('expenses','accounts.id','=','expenses.account_id')
            ->where('accounts.id', Input::get('account'))
            ->decrement('accounts.balance', Input::get('amount'));

        Audit::logaudit('Expenses', 'created an expense', 'created expense '.Input::get('name').' in the system');

		return Redirect::route('expenses.index')->withFlashMessage('Expense successfully created!');
	}
	}

	/**
	 * Display the specified expense.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		if (! Entrust::can('view_expense') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		$expense = Expense::findOrFail($id);

		Audit::logaudit('Expenses', 'viewed expense details', 'viewed expense details for expense '.$expense->name.' in the system');
        $header='Expenses';
		$description='View Expense';
		return view('expenses.show', compact('expense','header','description'));
	}
	}

	/**
	 * Show the form for editing the specified expense.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{

		if (! Entrust::can('update_expense') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
		$expense = Expense::find($id);
		$accounts = Account::all();
        $header='Expenses';
		$description='Update Expense';
		return view('expenses.edit', compact('expense','accounts','header','description'));
	}
	}

	/**
	 * Update the specified expense in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		$expense = Expense::findOrFail($id);

		$validator = Validator::make($data = Input::all(), Expense::$rules, Expense::$messages);

		if ($validator->fails())
		{
			return Redirect::back()->withErrors($validator)->withInput();
		}
     
        $expense->name = Input::get('name');
		$expense->type = Input::get('type');
		$expense->amount = Input::get('amount');
		$expense->date = date("Y-m-d",strtotime(Input::get('date')));
		$expense->account_id = Input::get('account');

		$expense->update();

		Audit::logaudit('Expenses', 'updated an expense', 'updated expense '.Input::get('name').' in the system');

		return Redirect::route('expenses.index')->withFlashMessage('Expense successfully updated!');;
	}

	/**
	 * Remove the specified expense from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		if (! Entrust::can('delete_expense') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        $expense = Expense::find($id);

		Expense::destroy($id);

		Audit::logaudit('Expenses', 'deleted an expense', 'deleted expense '.$expense->name.' from the system');

		return Redirect::route('expenses.index')->withDeleteMessage('Expense successfully deleted!');
	}
	}

}
