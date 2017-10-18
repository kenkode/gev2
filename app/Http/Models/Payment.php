<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Payment extends Model {

	// Add your validation rules here
	public static $rules = [
	 'order' => 'required',
	];

	public static $messages = array(
    	'order.required'=>'Please select ordered item!',
    );

	// Don't forget to fill this array
	protected $fillable = [];


	public function erporder(){

		return $this->belongsTo('Erporder');
	}

	public function client(){

		return $this->belongsTo('Client');
	}

}