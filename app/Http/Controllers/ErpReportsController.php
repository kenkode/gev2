<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Client;
use App\Http\Models\Payment;
use App\Http\Models\Erporder;
use App\Http\Models\Erporderitem;
use App\Http\Models\Audit;
use App\Http\Models\Item;
use App\Http\Models\Expense;
use App\Http\Models\Paymentmethod;
use App\Http\Models\Organization;
use App\Http\Models\BankAccount;
use App\Http\Models\Account;
use App\Http\Models\ItemTracker;
use App\Http\Models\Notification;
use App\Http\Models\Store;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Mail;
use App\Mail\PurchaseOrder;
use App\Mail\Quotation;
use App\Mail\Report;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Auth;
use DB;
use Barryvdh\DomPDF\Facade as PDF;
use Session;

set_time_limit(-1);

class ErpReportsController extends Controller {


    public function clients(){

        $clients = Client::all();       

        $organization = Organization::find(1);

        ini_set("memory_limit", "-1");
        ini_set("max_execution_time", "-1");

        $pdf = PDF::loadView('erpreports.cReport', compact('clients', 'organization'))->setPaper('a4', 'landscape');

        Audit::logaudit('Client', 'viewed clients report', 'viewed clients report in the system');
    
        return $pdf->stream('Client List.pdf');
        return view('erpreports.clientsReport', compact('clients', 'organization'));
        
    }


public function kenya($id){

       $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->first();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.salesdelivery', compact('orders','erporder','txorders','count' ,'organization'))->setPaper('a4');
    
        return $pdf->stream('quotation.pdf');
        
    }




    public function items(){

        $from = Input::get("from");
        $to= Input::get("to");

        /*$items = Item::all();*/

        $items = DB::table('items')
                    ->whereBetween('date', array(Input::get("from"), Input::get("to")))->get();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.itemsReport', compact('items', 'organization','from','to'))->setPaper('a4');

        Audit::logaudit('Item', 'viewed items report', 'viewed items report in the system');
    
        return $pdf->stream('Item List.pdf');
        
    }
    public function expenses(){

        $from = Input::get("from");
        $to= Input::get("to");

        $expenses = Expense::whereBetween('date', array(Input::get("from"), Input::get("to")))->get();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.expensesReport', compact('expenses', 'organization','from','to'))->setPaper('a4');

        Audit::logaudit('Client', 'viewed expenses report', 'viewed expenses report in the system');
    
        return $pdf->stream('Expense List.pdf');
        
    }

    public function paymentmethods(){

        $paymentmethods = Paymentmethod::all();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.paymentmethodsReport', compact('paymentmethods', 'organization'))->setPaper('a4');

        Audit::logaudit('Payment Method', 'viewed payment methods report', 'viewed payment methods report in the system');
    
        return $pdf->stream('Payment Method List.pdf');
        
    }

    public function payments(){

        $from = date("Y-m-d");
        $to= date("Y-m-d");

        $payments = Payment::whereNotNull('confirmed_id')->whereNotNull('is_approved')->get();

       /* $payments = DB::table('payments')
                    ->whereBetween('date', array(Input::get("from"), Input::get("to")))->get();
*/

        $erporders = Erporder::all();

        $erporderitems = Erporderitem::all();

        $organization = Organization::find(1);

        //return view('erpreports.paymentsReport', compact('payments','erporders', 'erporderitems', 'organization','from','to'));

        $pdf = PDF::loadView('erpreports.paymentsReport', compact('payments','erporders', 'erporderitems', 'organization','from','to'))->setPaper('a4', 'landscape');

        Audit::logaudit('Payment', 'viewed payments report', 'viewed payments report in the system');

        return $pdf->stream('Payment List.pdf');
        
    }


   public function invoice($id){

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->first();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);

        $client = Client::find($erporder->client_id);

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.invoice', compact('orders','erporder','txorders','count' ,'organization'))->setPaper('a4');

        Audit::logaudit('Invoice', 'viewed invoice', 'viewed invoice for client '.$client->name.' order number '.$erporder->order_number.' in the system');
    
        return $pdf->stream('Invoice.pdf');
        
    }

    public function customerstatement($id){
        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                
                ->where('clients.id','=',$id)                                  
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','erporderitems.client_discount as client_discount','erporders.date as date')
                ->get();
        $order_payment = DB::table('payments')         
                ->join('clients', 'payments.client_id', '=', 'clients.id')        
                ->where('payments.client_id',$id)                
                ->select('payments.payment_date as payment_date','payments.amount_paid as amount_paid','clients.id as id')
                ->get();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id') 
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.client_id',$id)               
                ->get();

        $count = DB::table('tax_orders')->count();

        $count_payment= Payment::where('payments.client_id',$id)->count();

        $erporder = Erporder::where('client_id',$id)->first();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.customerStatementReport', compact('orders','erporder','txorders','count' ,'organization','order_payment','count_payment'))->setPaper('a4');
    
        return $pdf->stream('Customer_Statement.pdf');
        
    }

    /**
     * Client statements for a certain period
     */
    public function ClientStatement(){
        $id = Input::get('client_id');
        $asAt = Input::get('date');
        $from = Input::get('from');
        $to = Input::get('to');

        $client = DB::table('clients')->where('id',$id)->select('balance','date')->first();
        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                
                ->where('clients.id','=',$id) 
                ->whereBetween('erporders.date', array($from, $to))                                 
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.id as erporderid','erporders.order_number as order_number',
                  'price','erporderitems.client_discount as client_discount','erporders.date as date')
                ->orderBy('erporders.date','asc')
                ->get();
        $order_payment = DB::table('payments')         
                ->join('clients', 'payments.client_id', '=', 'clients.id')        
                ->where('payments.client_id',$id)            
                ->select('payments.erporder_id as erporder_id','payments.payment_date as payment_date',
                    'payments.amount_paid as amount_paid','payments.id','clients.id as client_id')
                ->get();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id') 
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.client_id',$id)               
                ->get();

        Session::forget('clientStatement');
        foreach($orders as $order){
            Session::push('clientStatement', [
                    'transaction'=>'order',
                    'date'=>$order->date,
                    'order_number'=>$order->order_number,
                    'order_id'=>$order->id,
                    'payment_id'=>'',
                    'item'=>$order->item,
                    'item_price'=>$order->price,
                    'item_qty'=>$order->quantity,
                    'client_discount'=>$order->client_discount,
                    'discount_amount'=>$order->discount_amount,
                    'amount_paid'=>'',
                    'client_id'=>$id
                ]);
        }

        foreach($order_payment as $payment){
            Session::push('clientStatement', [
                    'transaction'=>'payment',
                    'date'=>$payment->payment_date,
                    'order_number'=>'',
                    'order_id'=>$payment->erporder_id,
                    'payment_id'=>$payment->id,
                    'item'=>'',
                    'item_price'=>'',
                    'item_qty'=>'',
                    'client_discount'=>'',
                    'discount_amount'=>'',
                    'amount_paid'=>$payment->amount_paid,
                    'client_id'=>$id
                ]);
        }

        $stmt = Session::get('clientStatement');


        $count = DB::table('tax_orders')->count();
        $count_payment= Payment::where('payments.client_id',$id)->count();
        $erporder = Erporder::where('client_id',$id)->first();
        $organization = Organization::find(1);
        //return $stmt;

        //$pdf = PDF::loadView('erpreports.clientStatement', compact('stmt','client','orders','organization','erporder','txorders','count','asAt','order_payment','count_payment'))->setPaper('a4');
        $pdf = PDF::loadView('erpreports.clientStatement', compact('stmt','client','organization','erporder','txorders','count','asAt','count_payment'))->setPaper('a4');
        return $pdf->stream('Client Statement.pdf');

    }



    public function delivery_note($id){

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->first();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.delivery_note', compact('orders','erporder','txorders','count' ,'organization'))->setPaper('a4');
    
        return $pdf->stream('Delivery note.pdf');
        
    }


    public function receipt($id){
        $driver = Input::get('driver');
        if(Input::get('driver') == NULL){
            $driver = '';
        }
        
        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'erporders.order_number as order_number','price','description','client_id',
                  'items.id as item_id')
                ->first();

        //return $orders->client_id;
 
        $count = DB::table('prices')
                  ->where('client_id','=',$orders->client_id)
                  ->where('item_id','=',$orders->item_id)
                  ->count('discount');


        $discount = 0;

        if($count == 0){
        $discount = 0;
        }else{
        $discount = DB::table('prices')
                  ->where('client_id','=',$orders->client_id)
                  ->where('item_id','=',$orders->item_id)
                  ->sum('discount');
        }

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);
        $leased = ItemTracker::all();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.receipt', compact('orders','erporder','txorders','count','organization','driver','discount','leased'))->setPaper('a4', 'landscape');

        Audit::logaudit('Delivery Note', 'viewed delivery note', 'viewed delivery note for order '.$erporder->order_number.' assigned to driver '.$driver.' in the system');
    
        return $pdf->stream('Receipt.pdf');
        
    }

    public function locations(){

        $locations = Store::all();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.locationsReport', compact('locations', 'organization'))->setPaper('a4');

        Audit::logaudit('Stores', 'viewed stores report', 'viewed stores report in the system');
    
        return $pdf->stream('Stores List.pdf');
        
    }



    public function stock(){

    $items = Item::all();

        $from = Input::get("from");
        $to= Input::get("to");

        $items = DB::table('items')->get();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.stockReport', compact('items', 'organization','from','to'))->setPaper('a4', 'landscape');

        Audit::logaudit('Stock', 'viewed stock movement report', 'viewed stock movement report in the system');
    
        return $pdf->stream('Stock Report.pdf');
        
    }


    public function sales(){

    $from = Input::get("from");
    $to= Input::get("to");

    //return $from.' - '.$to;

    $sales = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','sales')
                ->where('erporders.status','!=','cancelled') 
                //->where('erporders.client_id', 17)
                ->whereBetween('erporders.date', array(Input::get("from"), Input::get("to")))
                ->orderBy('erporders.order_number', 'Desc')
                ->select(DB::raw('erporders.id,clients.name as client,clients.id as clientid,erporderitems.client_discount as percentage_discount,items.item_make as item,items.id as itemid,quantity,clients.address as address,
                  clients.phone as phone,clients.email as email,clients.category as category,erporders.id as id,erporders.status,
                  erporders.date,erporders.order_number as order_number,price,description,erporders.type'))
                
                ->get();
                //return $sales;
    
    $total_payment= DB::table('payments')
                ->join('clients', 'payments.client_id', '=', 'clients.id')
                ->where('clients.type','=','Customer')
                ->whereBetween('payments.payment_date', array(Input::get("from"), Input::get("to")))
                ->select(DB::raw('COALESCE(SUM(amount_paid),0) as amount_paid'))
                
                ->first();

    $total_sales_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->where('erporders.type','=','sales')                         
                ->whereBetween('erporders.date', array(Input::get("from"), Input::get("to")))  
                ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                ->first();

    $discount_amount = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')        
                ->whereBetween('erporders.date', array(Input::get("from"), Input::get("to")))                    
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))               
                ->first();

    $discount_amount_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')            
                ->whereBetween('erporders.date', array(Input::get("from"), Input::get("to")))              
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))             
                ->first();

  $items = Item::all();
  $locations = Store::all();
  $organization = Organization::find(1);
  $accounts = Account::all();

        $pdf = PDF::loadView('erpreports.salesReport', compact('sales', 'total_sales_todate','total_payment','discount_amount_todate','discount_amount','percentage_discount','accounts','organization','from','to'))->setPaper('a4', 'landscape');

        Audit::logaudit('Sales Order', 'viewed sales order report', 'viewed sales order report in the system');
    
        return $pdf->stream('Sales List.pdf');

  
}

 public function sales_summary(){      
    $fileName = 'Summary Report.pdf';

    $filePath = 'resources/views/temp/';

    $from = date('Y-m-d');
    $to= date('Y-m-d');

    $from_target = date('Y-m-01');
    $to_target= date('Y-m-d');

    ini_set('memory_limit', '-1');
    ini_set("max_execution_time", "-1");

    $sales = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','sales')
                ->where('erporders.status','!=','cancelled') 
                //->whereBetween('erporders.date', array($from, $to))
                ->orderBy('erporders.order_number', 'Desc')
                ->select(DB::raw('clients.name as client,items.item_make as item,quantity,clients.address as address,erporderitems.client_discount as percentage_discount,
                  clients.category as category, clients.phone as phone,clients.email as email,erporders.id as id,erporders.status,
                  erporders.date,erporders.order_number as order_number,price,description,erporders.type'))                
                ->get();        
                //return $sales;
   
    $total_payment= DB::table('payments')
                ->join('clients', 'payments.client_id', '=', 'clients.id')
                ->where('clients.type','=','Customer')
                /*->whereBetween('erporders.date', array(Input::get("from"), Input::get("to")))*/
                ->select(DB::raw('COALESCE(SUM(amount_paid),0) as amount_paid'))                
                ->first();

    $total_sales_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->where('erporders.type','=','sales')                
                ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                ->first();
    $sales_target= DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->where('erporders.type','=','sales')
                ->whereBetween('erporders.date', array($from_target, $to_target))                
                ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                ->first();

    $discount_amount = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')               
                ->whereBetween('erporders.date', array($from, $to))                
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))               
                ->first();
    $discount_amount_target = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')               
                ->whereBetween('erporders.date', array($from_target, $to_target))                
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))               
                ->first();

    $discount_amount_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')               
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))             
                ->first();

        $target = DB::table('sales_targets')->where('month',date('M-Y'))
        ->select(DB::raw('COALESCE(target_amount,0) as target_amount'))
        ->first();
      

        $items = Item::all();
        $clients_customer = DB::table('clients')->where('clients.type','=','Customer')->get();
        $locations = Store::all();
        $organization = Organization::find(1);
        $accounts = DB::table('accounts')
                        ->get();

        $pdf = PDF::loadView('erpreports.salesSummaryReport', compact('sales','accounts','discount_amount','total_sales_todate','discount_amount_todate','total_payment','clients_customer','target','organization','percentage_discount','from','to','sales_target','discount_amount_target','from_target','to_target'))->setPaper('a4', 'landscape');
        //return view('erpreports.salesSummaryReport', compact('sales','accounts','discount_amount','total_sales_todate','discount_amount_todate','total_payment','clients_customer','target','organization','percentage_discount','from','to','sales_target','discount_amount_target','from_target','to_target'));

        Audit::logaudit('Sales Order', 'viewed sales summary report', 'viewed sales summary report in the system');
        //return view('erpreports.salesSummaryReport', compact('sales','accounts','discount_amount','total_sales_todate','discount_amount_todate','total_payment','clients_customer','target','organization','percentage_discount','from','to','sales_target','discount_amount_target','from_target','to_target'));
        return $pdf->stream('Summary Report.pdf');
    }




    public function purchases(){

        $from = Input::get("from");
        $to= Input::get("to");

        

        $purchases = DB::table('erporders')
                    ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                    ->join('items', 'erporderitems.item_id', '=', 'items.id')
                    ->join('clients', 'erporders.client_id', '=', 'clients.id')
                    ->where('erporders.type','=','purchases')
                    ->where('erporders.status','!=','cancelled')
                    ->whereNotNull('erporders.authorized_by')
                    ->whereBetween('erporders.date', array(Input::get("from"), Input::get("to")))
                    ->orderBy('erporders.order_number', 'Desc')
                    ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                      'clients.phone as phone','clients.email as email','erporders.id as id','erporders.status',
                      'discount_amount','erporders.date','erporders.order_number as order_number','price','description','erporders.type')
                    ->get();

                    

      $items = Item::all();
      $locations = Store::all();
      $organization = Organization::find(1);

      //return $organization;

            $pdf = PDF::loadView('erpreports.purchasesReport', compact('purchases', 'organization','from','to'))->setPaper('a4');

            Audit::logaudit('Purchase Order', 'viewed purchase orders report', 'viewed purchase orders report in the system');
        
            return $pdf->stream('Purchases List.pdf');
            //return view('erpreports.purchasesReport', compact('purchases', 'organization','from','to'));

      
    }


    public function pricelist(){

        $pricelist = $pricelist = DB::table('items')
                    ->select('items.item_make as item','items.purchase_price','items.selling_price')
                    ->get();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.pricelist', compact('pricelist', 'organization'))->setPaper('a4');

        Audit::logaudit('Prices', 'viewed client prices report', 'viewed client prices report in the system');
    
        return $pdf->stream('Price List.pdf');
        
    }


    public function quotation($id){

       $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->first();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);

        $client = Client::find($erporder->client_id);

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.quotation', compact('orders','erporder','txorders','count' ,'organization'))->setPaper('a4');

        Audit::logaudit('Quotation', 'viewed quotation', 'viewed quotation for client '.$client->name.' order number '.$erporder->order_number.' in the system');
    
        return $pdf->stream('quotation.pdf');
        
    }


    /**
     * SEND QUOTATION AS AN ATTACHMENT
     */
    public function sendMail_quotation(){

        $id = Input::get('order_id');
        $mail_to = Input::get('mail_to');
        $subject = Input::get('subject');
        $mail_body = Input::get('mail_body');

        $filePath = 'resources/views/temp/';
        $fileName = 'Quotation.pdf';

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->first();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);

        $client = Client::find($erporder->client_id);


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.quotation', compact('orders','erporder','txorders','count' ,'organization'))->setPaper('a4');

        $attach = $pdf->save($filePath.$fileName);
        //unlink($filePath.$fileName);

        // SEND MAIL
        $from_name = 'Gas Express';
        //$from_mail = Mailsender::username();
        $data = array('body'=>$mail_body, 'from'=>$from_name, 'subject'=>$subject);
        /*Mail::send('mails.mail_quotation', $data, function($message) use($subject, $mail_to, $from_name, $from_mail, $attach, $filePath, $fileName){
            $message->to($mail_to, '');
            $message->from($from_mail, $from_name);
            $message->subject($subject);
            $message->attach($filePath.$fileName);
        });*/

        $file = $filePath.$fileName;

        Mail::to($mail_to)->send(new Quotation($subject,$mail_body,$client->name, $file));

        unlink($filePath.$fileName);

        if(count(Mail::failures()) > 0){
            $fail = "Email not sent! Please try again later";
            return Redirect::back()->with('fail', $fail);
        } else{
            $success = "Email successfully sent";
            Audit::logaudit('Quotation', 'email quotation', 'emailed quotation for client '.$client->name.' order number '.$erporder->order_number.' in the system');
            return Redirect::back()->with('success', $success);
        }

    }

/**
     * SEND PO AS AN ATTACHMENT
     */
    
    public function sendpomail(){

        $id = Input::get('order_id');
        $mail_to = Input::get('mail_to');
        $subject = Input::get('subject');
        $mail_body = Input::get('mail_body');

        $filePath = 'resources/views/temp/';
        $fileName = 'PurchaseOrder.pdf';

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->get();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);
        $client = Client::findorfail($erporder->client_id);


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.PurchaseOrder', compact('orders','erporder','txorders','count' ,'organization'))->setPaper('a4');
    

        $attach = $pdf->save($filePath.$fileName);
        //unlink($filePath.$fileName);

        // SEND MAIL
        /*$from_name = 'Gas Express';
        $from_mail = "info@lixnet.net";
        $data = array('body'=>$mail_body, 'from'=>$from_name, 'subject'=>$subject);*/
        $file = $filePath.$fileName;

        Mail::to($mail_to)->send(new PurchaseOrder($subject,$mail_body,$client->name, $file));

        /*Mail::send('mails.mail_po', $data, function($message) use($subject, $mail_to, $from_name, $from_mail, $attach, $filePath, $fileName){
            $message->to($mail_to, '');
            $message->from($from_mail, $from_name);
            $message->subject($subject);
            $message->attach($filePath.$fileName);
        });*/

        unlink($filePath.$fileName);

        if(count(Mail::failures()) > 0){
            $fail = "Email not sent! Please try again later";
            return Redirect::back()->with('fail', $fail);
        } else{
            $success = "Email successfully sent";
            Audit::logaudit('Purchase Order', 'emailed purchase order', 'emailed purchase order ,order number '.$erporder->order_number.' in the system');
            return Redirect::back()->with('success', $success);
        }

    }



    public function submitpurchaseorder($id){

        $erporder = Erporder::find($id);
        $erporder->prepared_by = Auth::User()->id;
        $erporder->update();
        $username = Auth::User()->username;

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->get();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);


        $organization = Organization::find(1);

        $users = DB::table('roles')
        ->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
        ->join('users', 'assigned_roles.user_id', '=', 'users.id')
        ->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
        ->where("permission_id",32)
        ->select("users.id","email","users.name")
        ->get();

        $key = md5(uniqid());

        foreach ($users as $user) {

        Notification::notifyUser($user->id,"Hello, Purchase order ".$erporder->order_number." needs to be reviewed!","review purchase order","erppurchases/notifyshow/".$key."/".$user->id."/".$id,$key);

        /*$email = $user->email;

        $send_mail = Mail::send('emails.submitpurchase', array('name' => $user->username, 'username' => $username,'orders' => $orders,'txorders' => $txorders,'count' => $count,'erporder' => $erporder,'organization' => $organization,'id' => $id), function($message) use($email)
        {   
            $message->from('info@lixnet.net', 'Gas Express');
            $message->to($email, 'Gas Express')->subject('Purchase Order Approval!');

    
        });*/
        }

        Audit::logaudit('Purchase Order', 'submit purchase order for review', 'submitted purchase order, order number '.$erporder->order_number.' for review in the system');
    
        return Redirect::to('erppurchases/show/'.$id)->with('notice', 'Successfully submited approval');
        
    }


    public function authorizepurchaseorder($id){

        $erporder = Erporder::find($id);
        $erporder->authorized_by = Auth::User()->id;
        $erporder->update();
        $username = Auth::User()->username;

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->get();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);


        $organization = Organization::find(1);

        $users = DB::table('roles')
        ->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
        ->join('users', 'assigned_roles.user_id', '=', 'users.id')
        ->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
        ->where("permission_id",49)
        ->select("users.id","email","users.name")
        ->get();

        $key = md5(uniqid());


        foreach ($users as $user) {
            # code...
       
        Notification::notifyUser($user->id,"Hello, Purchase order ".$erporder->order_number." has successfully been authorized!","view purchase order","erppurchases/notifyshow/".$key."/".$user->id."/".$id,$key);

        }
        /*$send_mail = Mail::send('emails.authorizepurchase', array('name' => 'Victor Kotonya', 'username' => $username,'orders' => $orders,'txorders' => $txorders,'count' => $count,'erporder' => $erporder,'organization' => $organization,'id' => $id), function($message)
        {   
            $message->from('info@lixnet.net', 'Gas Express');
            $message->to('wangoken2@gmail.com', 'Gas Express')->subject('Purchase Order Authorization!');

    
        });*/

        Audit::logaudit('Purchase Order', 'authorized purchase order', 'authorized purchase order, order number '.$erporder->order_number.' in the system');
    
        return Redirect::to('erppurchases/show/'.$id)->with('notice', 'Successfully authorized purchase order');
        
    }

    public function reviewpurchaseorder($id){

        $erporder = Erporder::find($id);
        if($erporder->prepared_by == null || $erporder->prepared_by == ""){
           $erporder->prepared_by = Auth::User()->id; 
        }
        $erporder->reviewed_by = Auth::User()->id;
        $erporder->update();
        $username = Auth::User()->username;

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->get();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);


        $organization = Organization::find(1);

        $users = DB::table('roles')
        ->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
        ->join('users', 'assigned_roles.user_id', '=', 'users.id')
        ->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
        ->select("users.id","email","users.name")
        ->where("permission_id",31)->get();

        $key = md5(uniqid());

        foreach ($users as $user) {

        Notification::notifyUser($user->id,"Hello, Purchase order ".$erporder->order_number." needs to be authorized!","authorize purchase order","erppurchases/notifyshow/".$key."/".$user->id."/".$id,$key);

        /*$email = $user->email;

        $send_mail = Mail::send('emails.reviewpurchase', array('name' => $user->username, 'username' => $username,'orders' => $orders,'txorders' => $txorders,'count' => $count,'erporder' => $erporder,'organization' => $organization,'id' => $id), function($message) use($email)
        {   
            $message->from('info@lixnet.net', 'Gas Express');
            $message->to($email, 'Gas Express')->subject('Purchase Order Authorization!');

    
        });*/
    }



    Audit::logaudit('Purchase Order', 'reviewed purchase order and submitted for authorization', 'reviewed purchase order, order number '.$erporder->order_number.' and submitted it for authorization in the system');
    
        return Redirect::to('erppurchases/show/'.$id)->with('notice', 'Successfully reviewed purchase order');
        
    }


    public function PurchaseOrder($id){

        $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->get();

        $txorders = DB::table('tax_orders')
                ->join('erporders', 'tax_orders.order_number', '=', 'erporders.order_number')
                ->join('taxes', 'tax_orders.tax_id', '=', 'taxes.id')
                ->where('erporders.id','=',$id)
                ->get();

        $count = DB::table('tax_orders')->count();

        $erporder = Erporder::findorfail($id);


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.PurchaseOrder', compact('orders','erporder','txorders','count' ,'organization'))->setPaper('a4');
    
        if($erporder->prepared_by ==null || $erporder->reviewed_by == null || $erporder->authorized_by == null){
        return Redirect::to('erppurchases/show/'.$id)->with('notice', 'This purchase order has not been authorized');
        }else{
        Audit::logaudit('Purchase Order', 'viewed a purchase order', 'viewed purchase order, order number '.$erporder->order_number.' in the system');
        return $pdf->stream('Purchase Order.pdf');
        }
    }

    public function vehicles(){

        $from = Input::get("from");
        $to= Input::get("to");

        $assigndrivers = DB::table('assigndrivers')
           ->join('drivers','assigndrivers.driver','=','drivers.id')           
           ->join('vehicles','assigndrivers.reg_no','=','vehicles.id')
           

           ->select('drivers.id as id','assigndrivers.date as date','drivers.first_name','drivers.surname','vehicles.reg_no as reg_no','time_out','vehicles.model as model','oil_level','water_level','fuel_level')
                  
           ->get();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.vehiclesReport', compact('assigndrivers', 'organization','from','to'))->setPaper('a4', 'landscape');

        Audit::logaudit('Vehicle', 'viewed vehicles report', 'viewed vehicles report in the system');
    
        return $pdf->stream('Vehicles Report.pdf');
        
    }


    /**
     * GET SALES COMPARISON FOR CLIENTS 
     * FOR DIFFERENT MONTHS
     */
    public function getSalesComparison(){
        $month = Input::get('month');
        $compareTo = Input::get('compareTo');
        $days = Input::get('days');
        if($days < 10){
            $days = (int) '0'.$days;
        }

        if($month == '' || $compareTo == ''){
            return Redirect::back()->with('error', 'Please insert all fields!');
        } else if($days > 31){
            return Redirect::back()->with('error', 'Number of days should not be more than 31!');
        }

        $monthSelect = date('Y-m-d', strtotime($days.'-'.$month));
        $compareWith = date('Y-m-d', strtotime($days.'-'.$compareTo));

        $clients = Client::all();

        foreach($clients as $client){
            $monthlySales = Client::clientMonthlySales($client->id, $month, $days);
            $compareTo = Client::clientMonthlySales($client->id, $compareTo, $days);

            if($monthlySales != 0 || $compareTo != 0){
                $change = $monthlySales - $compareTo;
                if($compareTo > 0){
                    $percent = ($change/$compareTo)*100;
                } else if($compareTo <= 0 && $monthlySales > 0){
                    $percent = ($change/$monthlySales)*100;
                }
                //echo date('M Y', strtotime($monthSelect)) .' == '. $client->name .' == '. $client->id .' == '. $monthlySales .' == '. $compareTo .'<br>';

                Session::push('summary', [
                        'client_name' => $client->name,
                        //'month' => date('M Y', strtotime($monthSelect)),
                        'monthlySales' => $monthlySales,
                        //'compareWith' => date('M Y', strtotime($compareWith)),
                        'compareTo' => $compareTo,
                        'change' => $change,
                        'percentage_change' => $percent,
                    ]);
                    //Session::forget('summary');
            }

        }

        $month = date('M Y', strtotime($monthSelect));
        $compareTo = date('M Y', strtotime($compareWith));

        $summary = Session::get('summary');
        $pdf = PDF::loadView('erpreports.clientSalesComparison', compact('month', 'compareTo', 'summary'))->setPaper('a4');

        Audit::logaudit('Sales Report', 'viewed sales comparison report', 'viewed sales comparison report in the system');
        
        return $pdf->stream('Customer Sales Comparison Report');
        //return view('erpreports.clientSalesComparison', compact('month', 'compareTo', 'summary'));

    }


    /**
     * Monthly Sales Summary Based on Customer
     */
    public function customerSalesSummary(){
        $month = Input::get('summaryMonth');
        //$month = '09-2016';
        $modMonth = date('M Y', strtotime('01-'.$month));

        //$sales = Client::clientMonthlySalesSummary(17,$month);

        $clients = Client::where('type', 'Customer')->get();

        $dSubTotal = 0;
        $iSubTotal = 0;

        foreach($clients as $client){
            $sales = Client::clientMonthlySalesSummary($client->id,$month);

            if($sales->category == 'Institutional' && $sales->orderTotal > 0){
                $iSubTotal += $sales->orderTotal;
            } else if($sales->category == 'Domestic' && $sales->orderTotal > 0){
                $dSubTotal += $sales->orderTotal;
            }

            if($sales->category == 'Domestic'){
                Session::push('monthlyDom', [
                    'orderTotal'=>$sales->orderTotal,
                    'qty'=>$sales->qty,
                    'desc'=>$sales->description,
                    'client_name'=>$sales->client_name,
                    'category'=>$sales->category
                ]);
            } else if($sales->category == 'Institutional'){
                Session::push('monthlyInst', [
                    'orderTotal'=>$sales->orderTotal,
                    'qty'=>$sales->qty,
                    'desc'=>$sales->description,
                    'client_name'=>$sales->client_name,
                    'category'=>$sales->category
                ]);
            }
        }

        //return $iSubTotal;
        $dom = Session::get('monthlyDom');
        $inst = Session::get('monthlyInst');
        //return $inst;

        $pdf = PDF::loadView('erpreports.customerSummarySales', compact('modMonth','dom','inst','iSubTotal','dSubTotal'))->setPaper('a4');
        return $pdf->stream('Sales By Customer Summary');
        return $month;
    }


    /**
     * Generate Daily Payments PDF
     */
    public function dailyPaymentsPDF(){
        $payments = DB::table('payments')
                            ->join('clients', 'payments.client_id', '=', 'clients.id')
                            ->join('paymentmethods', 'payments.paymentmethod_id', '=', 'paymentmethods.id')
                            ->where('clients.type', 'Customer')
                            ->where('payments.payment_date', date('Y-m-d'))
                            ->selectRaw('clients.name as client_name, amount_paid, paymentmethods.name as payment_method')
                            ->get();

        $pdf = PDF::loadView('erpreports.dailyPaymentsReport', compact('payments'))->setPaper('a4', 'portrait');

        Audit::logaudit('Payments', 'viewed daily payments report', 'viewed daily payments report in the system');
        return $pdf->stream('Daily Collections Report');

    }


    /**
     * GET CLIENT BALANCES REPORTS
     */
    public function clientBalancesReport(){
        $clients = Client::where('type', 'Customer')->get();

        $total_payment= DB::table('payments')
                    ->join('clients', 'payments.client_id', '=', 'clients.id')
                    ->where('clients.type','=','Customer')
                    ->where('payments.payment_date', date('Y-m-d'))
                    ->select(DB::raw('COALESCE(SUM(amount_paid),0) as amount_paid'))                
                    ->first();

        $total_monthly = DB::table('payments')
                    ->join('clients', 'payments.client_id', '=', 'clients.id')
                    ->where('clients.type','=','Customer')
                    ->whereBetween('payments.payment_date', array(date('Y-m-d', strtotime('-1 month')), date('Y-m-d')))
                    ->select(DB::raw('COALESCE(SUM(amount_paid),0) as amount_paid'))                
                    ->first();

        $total_sales_todate = DB::table('erporders')
                    ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                    ->where('erporders.type','=','sales')                
                    ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                    ->first();

        $discount_amount_todate = DB::table('erporders')
                    ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')               
                    ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))             
                    ->first();

        $due = ($total_sales_todate->total_sales-$discount_amount_todate->discount_amount)-($total_payment->amount_paid);

        $pdf = PDF::loadView('clients.balance_reports', compact('clients', 'total_payment', 'total_monthly', 'due'))->setPaper('a4', 'landscape');
        return $pdf->stream('Client Balances List.pdf');

        //return view('clients.balance_reports', compact('clients'));
    }



    /**
     * GENERATE BANK RECONCILIATION REPORT
     */
    public function displayRecOptions(){
        $bankAccounts = DB::table('bank_accounts')
                        ->get();

        $bookAccounts = DB::table('accounts')
                        ->where('category', 'ASSET')
                        ->get();

        $header='Reconciliation Report';
        $description='Reconciliation Report';

        return view('erpreports.recOptions', compact('bankAccounts','bookAccounts','header','description'));
    }

    public function showRecReport(){
        $bankAcID = Input::get('bank_account');
        $bookAcID = Input::get('book_account');
        $recMonth = Input::get('rec_month'); 

        //get statement id
        $bnkStmtID = DB::table('bank_statements')
                    ->where('stmt_month', $recMonth)
                    ->pluck('id');

        $bnkStmtBal = DB::table('bank_statements')
                            ->where('bank_account_id', $bankAcID)
                            ->where('stmt_month', $recMonth)
                            ->select('bal_bd')
                            ->first();

        $acTransaction = DB::table('account_transactions')
                            ->where('status', '=', 'RECONCILED')
                            ->where('bank_statement_id', $bnkStmtID)
                            ->whereMonth('transaction_date', '=', substr($recMonth, 0, 2))
                            ->whereYear('transaction_date', '=', substr($recMonth, 3, 6))
                            ->select('id','account_credited','account_debited','transaction_amount')
                            ->get();

        $bkTotal = 0;
        foreach($acTransaction as $acnt){
            if($acnt->account_debited == $bookAcID){
                $bkTotal += $acnt->transaction_amount;
            } else if($acnt->account_credited == $bookAcID){
                $bkTotal -= $acnt->transaction_amount;
            }
        }

        $additions = DB::table('account_transactions')
                            ->where('status', '=', 'RECONCILED')
                            ->where('bank_statement_id', $bnkStmtID)
                            ->whereMonth('transaction_date', '<>', substr($recMonth, 0, 2))
                            ->whereYear('transaction_date', '=', substr($recMonth, 3, 6))
                            ->select('id','description','account_credited','account_debited','transaction_amount')
                            ->get();

        $add = [];
        $less = [];
        foreach($additions as $additions){
            if($additions->account_debited == $bookAcID){
                array_push($add, $additions);
            } else if($additions->account_credited == $bookAcID){
                array_push($less, $additions);
            }
        }

        $organization = Organization::find(1);

        $bkacc = BankAccount::find($bankAcID);
        $acc   = Account::find($bookAcID);

        Audit::logaudit('Bank Reconciliation', 'viewed bank reconciliation report', 'viewed bank reconciliation report for bank account '.$bkacc->bank_name.', account number '.$bkacc->account_number.' reconciled against account '.$acc->name.' for month '.$recMonth.' in the system');

        $pdf = PDF::loadView('erpreports.bankReconciliationReport', compact('recMonth','organization','bnkStmtBal','bkTotal','add','less'))->setPaper('a4');
        return $pdf->stream('Reconciliation Reports');

    }


    /**
     * GENERAL REPORT
     */
    public function mergedReport(){
        $accounts = Account::all();
        $organization = Organization::find(1);

        /* DAILY COLLECTIONS REPORT */
        $dailyCollections = DB::table('payments')
                            ->join('clients', 'payments.client_id', '=', 'clients.id')
                            ->join('paymentmethods', 'payments.paymentmethod_id', '=', 'paymentmethods.id')
                            ->where('clients.type', 'Customer')
                            ->where('payments.payment_date', date('Y-m-d'))
                            ->selectRaw('clients.name as client_name, amount_paid, paymentmethods.name as payment_method')
                            ->get();

        /* DAILY SALES REPORT */
        $clients = Client::where('type', 'Customer')->get();

        $dSubTotal = 0;
        $iSubTotal = 0;
        $totalSales = 0;
        $lastMonthSales = 0;

        //return Client::clientMonthlySales(1, date('m-Y', strtotime('-1 month')), date('d'));
        //return date('m-Y', strtotime('-1 month'));

        foreach($clients as $client){
            //$sales = Client::clientDailySalesSummary($client->id);
            $monthlySales= Client::clientMonthlySales($client->id, date('m-Y'), date('d'));
            $lastMonthSales = Client::clientMonthlySales($client->id, date('m-Y', strtotime('-1 month')), date('d'));
            
            if(count($monthlySales) > 0){
                $totalSales += $monthlySales;
            }

            /*if($sales->category == 'Institutional' && $sales->orderTotal > 0){
                $iSubTotal += $sales->orderTotal;
            } else if($sales->category == 'Domestic' && $sales->orderTotal > 0){
                $dSubTotal += $sales->orderTotal;
            }*/

            /*if($sales->category == 'Domestic'){
                Session::push('monthlyDom', [
                    'orderTotal'=>$sales->orderTotal,
                    'qty'=>$sales->qty,
                    'desc'=>$sales->description,
                    'client_name'=>$sales->client_name,
                    'category'=>$sales->category
                ]);
            } else if($sales->category == 'Institutional'){
                Session::push('monthlyInst', [
                    'orderTotal'=>$sales->orderTotal,
                    'qty'=>$sales->qty,
                    'desc'=>$sales->description,
                    'client_name'=>$sales->client_name,
                    'category'=>$sales->category
                ]);
            }*/
        }

        $sales = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','sales')
                ->where('erporders.status','!=','cancelled') 
                ->where('erporders.date', date('Y-m-d'))
                ->orderBy('erporders.order_number', 'Desc')
                ->select(DB::raw('clients.name as client,items.item_make as item,quantity,clients.address as address,erporderitems.client_discount as percentage_discount,
                  clients.category as category, clients.phone as phone,clients.email as email,erporders.id as id,erporders.status,
                  erporders.date,erporders.order_number as order_number,price,description,erporders.type'))                
                ->get();  
        //return $sales;

        /*$dom = Session::get('monthlyDom');
        $inst = Session::get('monthlyInst');*/

        $expenses = DB::table('expenses')->where('date', date('Y-m-d'))->get();

        //return $expenses;

        $monthlyTarget = DB::table('sales_targets')
                            ->where('month', date('M-Y'))
                            ->sum("target_amount");

        if(($monthlyTarget) == ''){
            $monthlyTarget = 10000000;
        }

        $pdf = PDF::loadView('erpreports.mergedReport', compact('clients', 'accounts', 'organization', 
                     'dailyCollections', 'iSubTotal', 'dSubTotal', 'sales', 'expenses', 
                     'totalSales', 'monthlyTarget', 'lastMonthSales'))->setPaper('a4');

        Audit::logaudit('Merged Report', 'viewed merged report report', 'viewed merged report in the system');

        /*return view('erpreports.mergedReport', compact('clients', 'accounts', 'organization', 
                     'dailyCollections', 'iSubTotal', 'dSubTotal', 'sales', 'expenses', 
                     'totalSales', 'monthlyTarget', 'lastMonthSales'));*/

        return $pdf->stream('General Report');
    }



    public function selectSalesPeriod()
    {
        $sales = Erporder::all();
        $header='Reports';
        $description='Sales Report';
        return view('erpreports.selectSalesPeriod',compact('sales','header','description'));
    }

    public function selectSalesComparisonPeriod(){
        $sales = Erporder::all();
        return view('erpreports.selectSalesComparisonPeriod', compact('sales'));
    }

    public function getSelectSummaryMonth(){
        $sales = Erporder::all();
        return view('erpreports.selectSummaryMonth', compact('sales'));
    }

    public function selectPurchasesPeriod()
    {
        $purchases = Erporder::all();
        $header='Reports';
        $description='Purchase Report';
        return view('erpreports.selectPurchasesPeriod',compact('purchases','header','description'));
    }


    public function selectClientsPeriod()
    {
       $clients = Client::all();
        return view('erpreports.selectClientsPeriod',compact('clients'));
    }

     public function selectItemsPeriod()
    {
       $items = Item::all();
       $header='Reports';
        $description='Item Report';
        return view('erpreports.selectItemsPeriod',compact('items','header','description'));
    }

    public function selectExpensesPeriod()
    {
       $expenses = Expense::all();
        $header='Reports';
        $description='Expense Report';
        return view('erpreports.selectExpensesPeriod',compact('expenses','header','description'));
    }

     public function selectPaymentsPeriod()
    {
       $payments = Payment::all();
       $header='Reports';
        $description='Payment Report';
        return view('erpreports.selectPaymentsPeriod',compact('payments','header','description'));
    }

    public function selectStockPeriod()
    {
       $stocks = Item::all();
       $header='Reports';
        $description='Stock Report';
        return view('erpreports.selectStocksPeriod',compact('stocks','header','description'));
    }

    public function selectVehiclesPeriod()
    {
       $assigndrivers = Assigndriver::all();

        return view('erpreports.selectVehiclesPeriod',compact('assigndrivers'));
    }


    public function accounts(){

        $accounts = Account::all();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.accountsReport', compact('accounts', 'organization'))->setPaper('a4');

        Audit::logaudit('Account', 'viewed account balances report', 'viewed account balances report in the system');
    
        return $pdf->stream('Account Balances.pdf');
        
    }




     public function sendMail(){
        
    $fileName = 'pricelist.pdf';

    $filePath = 'resources/views/temp/';

    $pricelist = DB::table('items')
                    ->select('items.item_make as item','items.purchase_price','items.selling_price')
                    ->get();


    $organization = Organization::find(1);

    $pdf = PDF::loadView('erpreports.pricelist', compact('pricelist', 'organization'))->setPaper('a4');

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->subject('Price List Report!');

    
    $message->attach($filePath.$fileName);

    
});*/


   $file = $filePath.$fileName;
   $subject = "Price List Report!";
   $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->send(new Report($subject,$file));
   unlink($filePath.$fileName);
   echo 'Price List Report Successfully Sent!';
    return $send_mail;
    }



    public function sendMail_sales(){
        
    $fileName = 'Sales Report.pdf';

    $filePath = 'resources/views/temp/';


    $time = strtotime(date('Y-m-d').' 8:01:00');
    $time1 = strtotime(date('Y-m-d').' 19:59:59');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;

    //echo $from.' - '.$to;


   $sales = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','sales')
                ->where('erporders.status','!=','cancelled') 
                ->whereBetween('erporders.created_at', array($sdate, $stime))
                ->orderBy('erporders.order_number', 'Desc')
                ->select(DB::raw('erporders.id,clients.name as client,clients.id as clientid,erporderitems.client_discount as percentage_discount,items.item_make as item,items.id as itemid,quantity,clients.address as address,
                  clients.phone as phone,clients.email as email,clients.category as category,erporders.id as id,erporders.status,
                  erporders.date,erporders.order_number as order_number,price,description,erporders.type'))
                
                ->get();


                //return $sales;
    
    $total_payment= DB::table('payments')
                ->join('clients', 'payments.client_id', '=', 'clients.id')
                ->where('clients.type','=','Customer')
                ->whereBetween('payments.created_at', array($sdate, $stime))
                ->select(DB::raw('COALESCE(SUM(amount_paid),0) as amount_paid'))
                
                ->first();

    $total_sales_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->where('erporders.type','=','sales')                         
                ->whereBetween('erporders.created_at', array($sdate, $stime))  
                ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                ->first();

    $discount_amount = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')        
                ->whereBetween('erporders.created_at', array($sdate, $stime))                    
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))               
                ->first();

    $discount_amount_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')            
                ->whereBetween('erporders.created_at', array($sdate, $stime))              
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))             
                ->first();

    $items = Item::all();
    $locations = Store::all();
    $organization = Organization::find(1);
    $accounts = Account::all();

    $pdf = PDF::loadView('erpreports.dailySalesReport', compact('sales', 'total_sales_todate','total_payment','discount_amount_todate','discount_amount','percentage_discount','accounts','organization','from','to'))->setPaper('a4', 'landscape');

    //return $pdf->stream('Sales Reports');

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Crispus Cheruiyot')->subject('Daily Sales Report!');
    //$message->to('chrispus.cheruiyot@lixnet.net', 'Crispus Chevarvar')->subject('Daily Sales Report!');
    $message->attach($filePath.$fileName);

    
});*/

   $subject = "Daily Sales Report!";
   $file = $filePath.$fileName;
   $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Crispus Cheruiyot')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Sales Report Successfully Sent!';
    return $send_mail;
    }

    public function sendMail_morning_sales(){
        
    $fileName = 'Sales Report.pdf';

    $filePath = 'resources/views/temp/';


    $time = strtotime(date('Y-m-d').' 20:00:00');
    $time1 = strtotime(date('Y-m-d').' 8:00:00');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;


   $sales = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','sales')
                ->where('erporders.status','!=','cancelled') 
                ->whereBetween('erporders.created_at', array($sdate, $stime))
                ->orderBy('erporders.order_number', 'Desc')
                ->select(DB::raw('erporders.id,clients.name as client,clients.id as clientid,erporderitems.client_discount as percentage_discount,items.item_make as item,items.id as itemid,quantity,clients.address as address,
                  clients.phone as phone,clients.email as email,clients.category as category,erporders.id as id,erporders.status,
                  erporders.date,erporders.order_number as order_number,price,description,erporders.type'))
                
                ->get();
                //return $sales;
    
    $total_payment= DB::table('payments')
                ->join('clients', 'payments.client_id', '=', 'clients.id')
                ->where('clients.type','=','Customer')
                ->whereBetween('payments.created_at', array($sdate, $stime))
                ->select(DB::raw('COALESCE(SUM(amount_paid),0) as amount_paid'))
                
                ->first();

    $total_sales_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->where('erporders.type','=','sales')                         
                ->whereBetween('erporders.created_at', array($sdate, $stime))  
                ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                ->first();

    $discount_amount = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')        
                ->whereBetween('erporders.created_at', array($sdate, $stime))                    
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))               
                ->first();

    $discount_amount_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')            
                ->whereBetween('erporders.created_at', array($sdate, $stime))              
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))             
                ->first();

    $items = Item::all();
    $locations = Store::all();
    $organization = Organization::find(1);
    $accounts = Account::all();

    $pdf = PDF::loadView('erpreports.dailySalesReport', compact('sales', 'total_sales_todate','total_payment','discount_amount_todate','discount_amount','percentage_discount','accounts','organization','from','to'))->setPaper('a4', 'landscape');

    //return $pdf->stream('Sales Reports');


    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Crispus Cheruiyot')->subject('Daily Sales Report!');
    $message->attach($filePath.$fileName);

    
});*/

   $subject = "Daily Sales Report!";
   $file = $filePath.$fileName;
   $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Crispus Cheruiyot')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Sales Report Successfully Sent!';
    return $send_mail;
    }


    // SEND MAIL - MERGED REPORT
    public function sendMail_MergedReport(){
        $fileName = 'MERGED REPORT.pdf';
        $filePath = 'resources/views/temp/';

        $accounts = Account::all();
        $organization = Organization::find(1);

        /* DAILY COLLECTIONS REPORT */
        $dailyCollections = DB::table('payments')
                            ->join('clients', 'payments.client_id', '=', 'clients.id')
                            ->join('paymentmethods', 'payments.paymentmethod_id', '=', 'paymentmethods.id')
                            ->where('clients.type', 'Customer')
                            ->where('payments.payment_date', date('Y-m-d'))
                            ->selectRaw('clients.name as client_name, amount_paid, paymentmethods.name as payment_method')
                            ->get();

        /* DAILY SALES REPORT */
        $clients = Client::where('type', 'Customer')->get();

        $totalSales = 0;
        $lastMonthSales = 0;

        foreach($clients as $client){
            $sales = Client::clientDailySalesSummary($client->id);
            $monthlySales= Client::clientMonthlySales($client->id, date('m-Y'), date('d'));
            $lastMonthSales = Client::clientMonthlySales($client->id, date('m-Y', strtotime('-1 month')), date('d'));
            
            if(count($monthlySales) > 0){
                $totalSales += $monthlySales;
            }
        }

        $sales = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','sales')
                ->where('erporders.status','!=','cancelled') 
                ->where('erporders.date', date('Y-m-d'))
                ->orderBy('erporders.order_number', 'Desc')
                ->select(DB::raw('clients.name as client,items.item_make as item,quantity,clients.address as address,erporderitems.client_discount as percentage_discount,
                  clients.category as category, clients.phone as phone,clients.email as email,erporders.id as id,erporders.status,
                  erporders.date,erporders.order_number as order_number,price,description,erporders.type'))                
                ->get();  


        $expenses = DB::table('expenses')->where('date', date('Y-m-d'))->get();

        $monthlyTarget = DB::table('sales_targets')
                            ->where('month', date('M-Y'))
                            ->pluck('target_amount');

        if(($monthlyTarget) == ''){
            $monthlyTarget = 10000000;
        }

        $pdf = PDF::loadView('erpreports.mergedReport', compact('clients', 'accounts', 'organization', 
                     'dailyCollections', 'sales', 'expenses', 'totalSales', 
                     'monthlyTarget', 'lastMonthSales'))->setPaper('a4', 'portrait');

        $pdf->save($filePath.$fileName);

        /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName){   
            $message->from('info@lixnet.net', 'Gas Express');
            $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->subject('Daily General Report!');
            $message->attach($filePath.$fileName);
        });*/

        $subject = "Daily General Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->send(new Report($subject,$file));

        unlink($filePath.$fileName);
        //echo 'General Merged Report Successfully Sent!';
        return $send_mail;
        
    }



    public function sendMail_sales_summary(){
        
   $fileName = 'Summary Report.pdf';

    $filePath = 'resources/views/temp/';

    $time = strtotime(date('Y-m-d').' 8:01:00');
    $time1 = strtotime(date('Y-m-d').' 19:59:59');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;

    $from_target = $sdate;
    $to_target= $stime;

  $sales = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','sales')
                ->where('erporders.status','!=','cancelled') 
                ->whereBetween('erporders.created_at', array($from, $to))
                ->orderBy('erporders.order_number', 'Desc')
                ->select(DB::raw('clients.name as client,items.item_make as item,quantity,clients.address as address,erporderitems.client_discount as percentage_discount,
                  clients.phone as phone,clients.email as email,erporders.id as id,erporders.status,
                  erporders.date,erporders.order_number as order_number,price,description,erporders.type'))         
                                
                ->get();  

     $total_payment= DB::table('payments')
                ->join('clients', 'payments.client_id', '=', 'clients.id')
                ->where('clients.type','=','Customer')
                ->whereBetween('payments.created_at', array($from, $to))
                ->select(DB::raw('COALESCE(SUM(amount_paid),0) as amount_paid'))                
                ->first();

    $total_sales_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->where('erporders.type','=','sales')                
                ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                ->first();
    $sales_target= DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->where('erporders.type','=','sales')
                ->whereBetween('erporders.created_at', array($from_target, $to_target))                
                ->select(DB::raw('COALESCE(SUM(quantity*price),0) as total_sales'))               
                ->first();

    $discount_amount = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')               
                ->whereBetween('erporders.created_at', array($from, $to))                
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))               
                ->first();
    $discount_amount_target = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')               
                ->whereBetween('erporders.created_at', array($from_target, $to_target))                
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))               
                ->first();

    $discount_amount_todate = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')               
                ->select(DB::raw('COALESCE(SUM(discount_amount),0) as discount_amount'))             
                ->first();

      $target = DB::table('sales_targets')->where('month',date('M-Y'))
      ->select(DB::raw('COALESCE(target_amount,0) as target_amount'))
      ->first();

      $items = Item::all();
      $clients_customer = DB::table('clients')->where('clients.type','=','Customer')->get();
      $locations = Store::all();
      $organization = Organization::find(1);
      $accounts = DB::table('accounts')
                    ->get();


        $pdf = PDF::loadView('erpreports.salesSummaryReport', compact('sales','accounts','discount_amount','total_sales_todate','discount_amount_todate','total_payment','clients_customer','target','organization','percentage_discount','from','to','sales_target','discount_amount_target','from_target','to_target'))->setPaper('a4', 'landscape');

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
     
     $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('wangoken2@gmail.com', 'Victor Kotonya')->subject('Daily Summary Report');

    
    $message->attach($filePath.$fileName);

    
});*/

    $subject = "Daily Summary Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Daily Summary Report Successfully Sent!';
    return $send_mail;
    }


    public function sendMail_purchases(){
        
    $fileName = 'Purchases Report.pdf';

    $filePath = 'resources/views/temp/';

    $time = strtotime(date('Y-m-d').' 20:01:00');
    $time1 = strtotime(date('Y-m-d').' 7:59:59');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;

    $purchases = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.type','=','purchases')
                ->where('erporders.status','!=','cancelled')  
                ->whereBetween('erporders.created_at', array($from, $to))
                ->orderBy('erporders.order_number', 'Desc')
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id','erporders.status',
                  'discount_amount','erporders.date','erporders.order_number as order_number','price','description','erporders.type')
                ->get();
          $items = Item::all();
          $locations = Store::all();
          $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.purchasesReport', compact('purchases', 'organization','from','to'))->setPaper('a4');    
        

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->subject('Daily Purchases Report!');
   
    
    $message->attach($filePath.$fileName);

    
});*/

 $subject = "Daily Purchases Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Purchases Report Successfully Sent!';
    return $send_mail;
    }

    public function sendMail_expenses(){
        
    $fileName = 'Expenses Report.pdf';

    $filePath = 'resources/views/temp/';

     $time = strtotime(date('Y-m-d').' 8:01:00');
    $time1 = strtotime(date('Y-m-d').' 7:59:59');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;

        $expenses = Expense::whereBetween('created_at', array($from, $to))->get();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.expensesReport', compact('expenses', 'organization','from','to'))->setPaper('a4');   
        

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->subject('Daily Expenses Report!');



    
    $message->attach($filePath.$fileName);

    
});*/

$subject = "Daily Expenses Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Expenses Report Successfully Sent!';
    return $send_mail;
    }



    public function sendMail_payments(){
        
    $fileName = 'Payments Report.pdf';

    $filePath = 'resources/views/temp/';

     

     /*$from = date('Y:m:d');
     $to= date('Y:m:d');

        $payments = DB::table('payments')
                    ->whereBetween('date', array($from, $to))->get();*/
        
        $time = strtotime(date('Y-m-d').' 8:01:00');
    $time1 = strtotime(date('Y-m-d').' 19:59:59');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;

    $payments = Payment::whereBetween('created_at',array($from, $to))->whereNotNull('confirmed_id')->whereNotNull('is_approved')->get();


        $erporders = Erporder::whereBetween('created_at',array($from, $to))->get();

        $erporderitems = Erporderitem::whereBetween('created_at',array($from, $to))->get();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.paymentsReport', compact('payments','erporders', 'erporderitems', 'organization','from','to'))->setPaper('a4');   


        

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Ken Wango')->subject('Daily Payments Report!');
    
    $message->attach($filePath.$fileName);

    
});*/

$subject = "Daily Payments Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Ken Wango')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'payments Report Successfully Sent!';
    return $send_mail;
    }

    public function sendMail_morning_payments(){
        
    $fileName = 'Payments Report.pdf';

    $filePath = 'resources/views/temp/';

     

     /*$from = date('Y:m:d');
     $to= date('Y:m:d');

        $payments = DB::table('payments')
                    ->whereBetween('date', array($from, $to))->get();*/
        
        $time = strtotime(date('Y-m-d').' 20:00:00');
    $time1 = strtotime(date('Y-m-d').' 8:00:00');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;

     $payments = Payment::whereBetween('created_at',array($from, $to))->whereNotNull('confirmed_id')->whereNotNull('is_approved')->get();

        $erporders = Erporder::whereBetween('created_at',array($from, $to))->get();

        $erporderitems = Erporderitem::whereBetween('created_at',array($from, $to))->get();

        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.paymentsReport', compact('payments','erporders', 'erporderitems', 'organization','from','to'))->setPaper('a4');   
        

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Ken Wango')->subject('Daily Payments Report!');
    
    $message->attach($filePath.$fileName);

    
});*/

$subject = "Daily Payments Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Ken Wango')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'payments Report Successfully Sent!';
    return $send_mail;
    }

    public function sendMail_stock(){
        
    $fileName = 'Stock Report.pdf';

    $filePath = 'resources/views/temp/';

    $time = strtotime(date('Y-m-d').' 8:01:00');
    $time1 = strtotime(date('Y-m-d').' 19:59:59');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;
     
    $items = DB::table('items')->get();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.dailyStockReport', compact('items', 'organization','from','to'))->setPaper('a4', 'landscape');   
        


    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('wangoken2@gmail.com', 'Ken Wango')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->subject('Daily Stock Report!');

    
    $message->attach($filePath.$fileName);

    
});*/

    $subject = "Daily Stock Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Ken Wango')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Stock Report Successfully Sent!';
    return $send_mail;
    }

    public function sendMail_morning_stock(){
        
    $fileName = 'Stock Report.pdf';

    $filePath = 'resources/views/temp/';

    $time = strtotime(date('Y-m-d').' 20:00:00');
    $time1 = strtotime(date('Y-m-d').' 8:00:00');

    $sdate = date('Y-m-d H:i:s',$time);

    $stime = date('Y-m-d H:i:s',$time1);

    $from = $sdate;
    $to= $stime;
     
    $items = DB::table('items')->get();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.dailyStockReport', compact('items', 'organization','from','to'))->setPaper('a4', 'landscape');   

        //return $pdf->stream('Sales Reports');
        

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('wangoken2@gmail.com', 'Ken Wango')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->subject('Daily Stock Report!');

    
    $message->attach($filePath.$fileName);

    
});*/

$subject = "Daily Stock Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->cc('chrispus.cheruiyot@lixnet.net', 'Crispus Cheruiyot')->cc('wangoken2@gmail.com', 'Ken Wango')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Stock Report Successfully Sent!';
    return $send_mail;
    }


     public function sendMail_account(){
        
    $fileName = 'Accounts Report.pdf';

    $filePath = 'resources/views/temp/';

     $from = date('Y:m:d');
     $to= date('Y:m:d');

    /* $accounts = Accounts::find(1);*/
     
        $accounts = DB::table('accounts')
                    ->get();


        $organization = Organization::find(1);

        $pdf = PDF::loadView('erpreports.accountsReport', compact('accounts', 'organization','from','to'))->setPaper('a4');   
        

    $pdf->save($filePath.$fileName);

    /*$send_mail = Mail::send('emails.welcome', array('key' => 'value'), function($message) use ($filePath,$fileName)
    {   
    $message->from('info@lixnet.net', 'Gas Express');

    
    $message->to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->subject('Daily Accounts Report!');

    
    $message->attach($filePath.$fileName);

    
});*/

$subject = "Daily Accounts Report!";
        $file = $filePath.$fileName;
        $send_mail = Mail::to('victor.kotonya@gx.co.ke', 'Victor Kotonya')->cc('victor.kotonya@gmail.com', 'Victor Kotonya')->send(new Report($subject,$file));

   unlink($filePath.$fileName);
   echo 'Accounts Report Successfully Sent!';
    return $send_mail;
    }


    // Send Mail on click
    public function sendMailTo(){
        $this->sendMail_MergedReport();
        return Redirect::back()->with('success', 'Email succesfully sent!');
    }


}