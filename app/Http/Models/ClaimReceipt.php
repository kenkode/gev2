<?php 

namespace App\Http\Models;

use Illuminate\Database\Eloquent\Model;

class ClaimReceipt extends Model{

	protected $table = 'claim_receipts';

	// Link with Claim receipt item table
	public function claimReceitItems(){
		return $this->hasMany('App\Http\Models\ClaimReceiptItem');
	}

	/**
	 * GET IDS OF RECEIPTS
	 */
	public static function getId($id){
		$cReceipt = ClaimReceipt::where('claim_id', $id)
						->select('id')->get();

		$ids = array();
		foreach($cReceipt as $cR){
			array_push($ids, $cR->id);
		}

		return $ids;
	}

	/**
	 * GET RECEIPTS WITH A GIVEN EXPENSE CLAIM ID
	 */
	public static function getReceipt($id){
		$cReceipt = ClaimReceipt::where('claim_id', $id)
						->selectRaw('COUNT(id) as receipts')
						->first();

		return $cReceipt;
	}

}