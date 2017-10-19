<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Erporderitem extends Model {

	// Add your validation rules here
	public static $rules = [
		// 'title' => 'required'
		
	];

	// Don't forget to fill this array
	protected $fillable = [];

	public function erporder(){

		return $this->belongsTo('App\Http\Models\Erporder');
	}

	public function item(){
		return $this->belongsTo('App\Http\Models\Item');
	}

	public static function getInvoice($id){
	        if($id > 0){
			$erporderitem = Erporderitem::find($id);
	        return $erporderitem->status;
	        }
	}

}