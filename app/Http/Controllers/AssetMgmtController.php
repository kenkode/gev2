<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Audit;
use App\Http\Models\Asset;
use App\Http\Models\Notification;
use App\Http\Models\Account;
use App\Http\Models\AccountTransaction;
use App\Http\Models\Journal;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Auth;
use DB;

class AssetMgmtController extends Controller {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		// INDEX PAGE
		$assets = Asset::all();
		$header='Asset Management';
		$description='View Asset Management';
		Audit::logaudit('Asset Management', 'viewed asset management', 'viewed asset management in the system');
		return view('assets.index', compact('assets','header','description'));
	}


	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
		// NEW ASSET PAGE
		$assetNum = 'AST_000'.(Asset::all()->count()+1);
		$header='Asset Management';
		$description='Create Asset';
		return view('assets.create', compact('assetNum','header','description'));
	}


	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		// STORE DATA IN DB
		if(!empty(Input::get('lifeYears'))){
			$inputData = array_merge(Input::all(), array('rate'=>'NULL', 'method'=>'years'));
		} elseif(!empty(Input::get('rate'))){
			$inputData = array_merge(Input::all(), array('lifeYears'=>'NULL', 'method'=>'rate'));
		}

		Asset::registerAsset($inputData);	

		$assetAc = 'Accumulated Depreciation';
		$expAc = 'Depreciation Expense';
		$account1 = Account::where('name', $assetAc)->first();
		$account2 = Account::where('name', $expAc)->first();
		if(empty($account1)){
			Account::createAccount('ASSET', $assetAc, $inputData['purchasePrice']);
			if(empty($account2)){
				Account::createAccount('EXPENSE', $expAc);
			}
		} else{
			Account::where('name', $assetAc)->increment('balance', $inputData['purchasePrice']);
		}

        Audit::logaudit('Asset Management', 'created asset management', 'created asset '.Input::get('assetName').' asset number '.Input::get('assetNumber').' in the system');

		return Redirect::action('AssetMgmtController@index');
	}


	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		// DISPLAY ASSET INFORMATION
		$asset = Asset::find($id);
		$header='Asset Management';
		$description='View Asset';
		Audit::logaudit('Items', 'viewed items', 'viewed items in the system');
		return view('assets.show', compact('asset','header','description'));
	}


	/**
	 * Show the form for editing the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		// DISPLAY EDIT PAGE
		$asset = Asset::find($id);
		$header='Asset Management';
		$description='Update Asset';
		return view('assets.edit', compact('asset','header','description'));
	}


	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		// UPDATE DATA IN DB
		if(!empty(Input::get('lifeYears'))){
			$inputData = array_merge(Input::all(), array('rate'=>'NULL', 'method'=>'years'));
		} elseif(!empty(Input::get('rate'))){
			$inputData = array_merge(Input::all(), array('lifeYears'=>'NULL', 'method'=>'rate'));
		}

		// Reverse Existing Depreciation
		$item = Asset::find($id);
		$creditAc = Account::where('name', 'Accumulated Depreciation')->pluck('id');
		$debitAc = Account::where('name', 'Depreciation Expense')->pluck('id');
		$lastDepAmnt = round($item->purchase_price - $item->book_value, 2);
		$item->increment('book_value', $lastDepAmnt);

		Account::where('id', $creditAc)->increment('balance', $lastDepAmnt);
		Account::where('id', $debitAc)->decrement('balance', $lastDepAmnt);

		// Update Details
		Asset::updateAsset($inputData);
		$this->depreciate($id);

        Audit::logaudit('Asset Management', 'updated asset management', 'updated asset '.Input::get('assetName').' asset number '.Input::get('assetNumber').' in the system');
		return Redirect::action('AssetMgmtController@index');
	}


	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		// DESTROY/DELETE DATA FROM DB
	}


	/**
	 * Depreciation Method
	 */
	public function depreciate($id){
		$item = Asset::find($id);

		$creditAc = Account::where('name', 'Accumulated Depreciation')->pluck('id');
		$debitAc = Account::where('name', 'Depreciation Expense')->pluck('id');
		$depAmnt = Asset::calculateDepreciation($id);
		
		$depDiff = $item->book_value - $depAmnt;

		$dta1 = [
			'date' => date("Y-m-d"), 
			'debit_account' => $debitAc,
			'credit_account' => $creditAc,
			'description' => "Depreciated $item->asset_name on ". date('jS M, Y'),
			'initiated_by' => Auth::user()->name,
		];

		if($depDiff < $item->salvage_value){
			$dta = array('amount'=>$item->book_value - $item->salvage_value);
			$data = array_merge($dta1, $dta);
		} else{
			$data = array_merge($dta1, array('amount' => $depAmnt));
		}

		// Store depreciation values in DB
		if($item->book_value == $item->purchase_price){
			// Record Depreciation
			$item->decrement('book_value', $depAmnt);
			if($item->book_value == $item->salvage_value){
				return Redirect::action('AssetMgmtController@index');
			}

			$item->last_depreciated = date('Y-m-d');
			$item->update();

			Account::where('id', $creditAc)->decrement('balance', $depAmnt);
			Account::where('id', $debitAc)->increment('balance', $depAmnt);

			$acTransaction = new AccountTransaction;
			$journal = new Journal;

			$acTransaction->createTransaction($data);
			$journal->journal_entry($data);

			return Redirect::action('AssetMgmtController@index');

		} else{
			// Reverse already existing depreciation & Re-run
			$lastDepAmnt = round($item->purchase_price - $item->book_value, 2);

			$reverseData = [
				'date' => date("Y-m-d"), 
				'debit_account' => $creditAc,
				'credit_account' => $debitAc,
				'description' => "Reversed depreciation on $item->asset_name on ". date('jS M, Y'),
				'amount' => $lastDepAmnt,
				'initiated_by' => Auth::user()->name
			];

			// Reverse Existing Depreciation
			$item->increment('book_value', $lastDepAmnt);

			Account::where('id', $creditAc)->increment('balance', $lastDepAmnt);
			Account::where('id', $debitAc)->decrement('balance', $lastDepAmnt);

			$acTransaction = new AccountTransaction;
			$journal = new Journal;

			$acTransaction->createTransaction($reverseData);
			$journal->journal_entry($reverseData);

			// Re-record Depreciation
			$item->decrement('book_value', $depAmnt);
			if($item->book_value == $item->salvage_value){
				return Redirect::action('AssetMgmtController@index');
			}

			$item->last_depreciated = date('Y-m-d');
			$item->update();

			Account::where('id', $creditAc)->decrement('balance', $depAmnt);
			Account::where('id', $debitAc)->increment('balance', $depAmnt);

			$acTransaction->createTransaction($data);
			$journal->journal_entry($data);

			Audit::logaudit('Asset Management', 'depreciated asset management', 'depreciated asset '.$item->asset_name.' asset number '.$item->asset_number.' in the system');

			return Redirect::action('AssetMgmtController@index');
		}
	}

}
