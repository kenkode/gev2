<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class BBranch extends Model {

public $table = "bank_branches";

public static $rules = [
		'name' => 'required',
		'code' => 'required',
		'bank_id' => 'required'
	];

public static $messages = array(
        'name.required'=>'Please insert bank name!',
        'code.required'=>'Please insert bank branch code!',
        'bank_id.required'=>'Please insert bank!',
    );

	// Don't forget to fill this array
	protected $fillable = [];


	public function employees(){

		return $this->hasMany('App\Http\Models\Employee');
	}

	public function bank(){
         return $this->belongsTo('App\Http\Models\Bank');
    }

    public static function getName($id){
        if($id > 0){
		$bbranch = BBranch::find($id);
        return $bbranch->bank_branch_name;
    }
	}

}