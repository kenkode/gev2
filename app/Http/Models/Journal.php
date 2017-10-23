<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Journal extends Model {

	// Add your validation rules here
	public static $rules = [
		// 'title' => 'required'
	];

	// Don't forget to fill this array
	protected $fillable = [];



	public function branch(){

		return $this->belongsTo('App\Http\Models\Branch');
	}


	public function account(){

		return $this->belongsTo('App\Http\Models\Account');
	}




	/**
	* function fo journal entries
	*/

	public  function journal_entry($data){


		$trans_no = $this->getTransactionNumber();


		// function for crediting

		$this->creditAccount($data, $trans_no);

		// function for crediting

		$this->debitAccount($data, $trans_no);

		
	}



	public function getTransactionNumber(){

		$date = date('Y-m-d H:m:s');

		$trans_no  = strtotime($date);

		return $trans_no;
	}


	public function creditAccount($data, $trans_no){

		$journal = new Journal;


		$account = Account::findOrFail($data['credit_account']);


	
		$journal->account_id = str_replace(array('[',']'),'',$data['credit_account']);

		$journal->date = $data['date'];
		$journal->trans_no = $trans_no;
		$journal->initiated_by = $data['initiated_by'];
		$journal->amount = $data['amount'];
		$journal->type = 'credit';
		$journal->description = $data['description'];
		$journal->save();
	}



	public function debitAccount($data, $trans_no){

		$journal = new Journal;


		$account = Account::findOrFail($data['debit_account']);


	
		$journal->account_id = str_replace(array('[',']'),'',$data['debit_account']);

		$journal->date = $data['date'];
		$journal->trans_no = $trans_no;
		$journal->initiated_by = $data['initiated_by'];
		$journal->amount = $data['amount'];
		$journal->type = 'debit';
		$journal->description = $data['description'];
		$journal->save();
	}




}