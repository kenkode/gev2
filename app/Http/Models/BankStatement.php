<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use DB;

Class BankStatement extends Model{

	protected $table = 'bank_statements';

	/**
	 * Link with BankAcount
	 */
	public function bankAccount(){
		return $this->belongsTo('App\Http\Models\BankAccount');
	}

	/**
	 * Link with Bank Statement Transactions
	 */
	public function stmtTransaction(){
		return $this->hasMany('App\Http\Models\StmtTransaction');
	}
}