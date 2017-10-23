<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class Bank extends Model {

public static $rules = [
		'name' => 'required',
		'code' => 'required'
	];

public static $messages = array(
        'name.required'=>'Please insert bank name!',
        'code.required'=>'Please insert bank code!',
    );

	// Don't forget to fill this array
	protected $fillable = [];


	public function employees(){

		return $this->hasMany('App\Http\Models\Employee');
	}

	public function bankbranch(){

		return $this->hasMany('App\Http\Models\BBranch');
	}

	public static function getName($id){
	        if($id > 0){
			$bank = Bank::find($id);
	        return $bank->bank_name;
	        }
	}

}