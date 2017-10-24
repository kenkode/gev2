<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Price extends Model {

	// Add your validation rules here
	public static $rules = [
		 
	];

   

    public static $messages = array(
    	
    );

	// Don't forget to fill this array
	protected $fillable = [];


	public function erporders(){

		return $this->hasMany('App\Http\Models\Erporder');
	}

	public function payments(){

		return $this->hasMany('App\Http\Models\Payment');
	}

  public function client(){

    return $this->belongsTo('App\Http\Models\Client');
  }

  public function item(){

    return $this->belongsTo('App\Http\Models\Item');
  }

  public static function sprice($id){
    $item = Item::findOrFail($id);
    $price = $item->selling_price;

		return $price;
    }

    public static function discount($clientid, $itemid){
    $discount = Price::where('client_id',$clientid)->where('item_id',$itemid)->sum('Discount');
    return $discount;
    }

}