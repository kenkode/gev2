<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class SalesTarget extends Model {

	
	// Add your validation rules here
	
	// Don't forget to fill this array
	protected $fillable = [];

	public static $rules = [
		'month' => 'required',
		'target_amount' => 'required',
		'date' => 'required'
	];

public static $messages = array(
        'month.required'=>'Please enter Month!',
        'target_amount.required'=>'Please enter Target Amount!',
        'date.required'=>'Please Enter date!',
    );


}