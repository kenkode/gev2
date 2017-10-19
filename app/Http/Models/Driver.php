<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Driver extends Model {

	// Add your validation rules here
	public static $rules = [
		/*'reg_no' => 'required',
		'model' => 'required',
		'tank_capacity' => 'required'*/		
		
	];

	public static $messages = array(
        /*'reg_no.required'=>'Enter Vehicle Registration Number!',
        'model.required'=>'Please Enter Vehicle Model!',
        'tank_capacity.required'=>'Please Enter Vehicle Fuel Tank Capacity!'*/
        
        
    );
	protected $fillable = [];


	/*public function bookings(){

		return $this->hasMany('Booking');
	}*/

}