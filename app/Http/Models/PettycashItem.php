<?php 

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class PettycashItem extends Model{

	protected $table = 'pettycash_items';

	// Add your validation rules here
	public static $rules = [
		
	];

	// Link with AccountTransaction controller
	public function accountTransaction(){
		return $this->belongsTo('App\Http\Models\AccountTransaction');
	}

}