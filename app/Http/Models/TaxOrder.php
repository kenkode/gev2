<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class TaxOrder extends Model {
/*
	use \Traits\Encryptable;
    

	protected $encryptable = [

		'allowance_name',
	];
	*/

	// Don't forget to fill this array
	public $table = "tax_orders";

	protected $fillable = [];

	public function tax(){
		return $this->belongsTo('App\Http\Models\Tax');
	}

	public function erporders(){
		return $this->hasMany('App\Http\Models\Erporder');
	}

	public static function getAmount($id,$orderno){
    return TaxOrder::where('tax_id',$id)->where('order_number',$orderno)->pluck('amount');
  }

}