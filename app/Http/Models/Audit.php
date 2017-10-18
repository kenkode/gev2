<?php

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Audit extends Model {

	//use \Traits\Encryptable;


	/*protected $encryptable = [

		'description',
		'entity',
		'action',
		'user',
	];*/

	// Add your validation rules here
	public static $rules = [
		// 'title' => 'required'
	];

	// Don't forget to fill this array
	protected $fillable = [];


	public static function logAudit( $entity, $action, $description){

	$audit = new Audit;

    $audit->date = date('Y-m-d');
    $audit->description = $description;
    $audit->user = Auth::user()->username;
    $audit->entity = $entity;
    $audit->action = $action;
    $audit->save();

	}


}