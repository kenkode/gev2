<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Expense extends Model {

	// Add your validation rules here
	public static $rules = [
		'name' => 'required',
		'type' => 'required',
		'account' => 'required',
	];

	public static $messages = array(
    	'name.required'=>'Please insert expense name!',
        'type.required'=>'Please select expense type!',
        'account.required'=>'Please select account!',
        'amount.required'=>'Please insert amount name!',
    );

	// Don't forget to fill this array
	protected $fillable = [];


	public function account(){
		return $this->belongsTo('App\Http\Models\Account');
	}

}