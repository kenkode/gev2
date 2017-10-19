<?php

function asMoney($value) {
  return number_format($value, 2);
}

?>

@extends('template')

{{ HTML::script('media/js/jquery.js') }}

<script type="text/javascript">
$(document).ready(function(){
    $('#select_all').on('click',function(){
        if(this.checked){
            $('.checkbox').each(function(){
                this.checked = true;
            });
        }else{
             $('.checkbox').each(function(){
                this.checked = false;
            });
        }
    });
    
    $('.checkbox').on('click',function(){
        if($('.checkbox:checked').length == $('.checkbox').length){
            $('#select_all').prop('checked',true);
        }else{
            $('#select_all').prop('checked',false);
        }
    });
});
</script>

@section('content')

@if (Session::get('notice'))
            <div class="alert alert-info">{{ Session::get('notice') }}</div>
        @endif
<!-- MODAL WINDOW TO SEND MAIL -->
<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Mail Quotation To Client</h4>
            </div>
            <div class="modal-body">
                <form role="form" action="{{URL::to('purchaseorders/mail')}}" method="POST">
                    {{ csrf_field() }}
                    <!-- HIDDEN FIELDS -->
                    <input type="hidden" name="order_id" value="{{$order->id}}">

                    <div class="form-group">
                        <label>To:</label>
                        @if($order->client->contact_person_email != "")
                            <input class="form-control" required type="email" name="mail_to" value="{{{$order->client->contact_person_email}}}">
                        @else
                            <input class="form-control" required type="email" name="mail_to" value="{{{$order->client->email}}}">
                        @endif
                    </div>
                    <div class="form-group">
                        <label>Subject:</label>
                        <input class="form-control" required type="text" name="subject" value="Purchase Order">
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <textarea class="form-control" name="mail_body" id="mail_body" rows="4"></textarea>
                    </div>
                    <hr>
                    <div class="form-group text-right">
                        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Cancel</button> &emsp; 
                        <button type="submit" class="btn btn-primary btn-sm">Send Mail</button>        
                    </div>
                
                </form>
            </div>
        </div>
    </div>
</div>
<!-- END MODAL MAIL -->
<!-- ========================================================================= -->

<div class="row">
<div class="col-lg-12">
    <div class="box">
      <div class="box-header with-border">
        <h4><font color='green'>Purchase Order : {{$order->order_number}} &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Client: {{$order->client->name}}  &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; Date: {{$order->date}} &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; Status: {{$order->status}} </font> </h4>
        
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      
    <!-- ALERT MESSAGE BOX {SUCCESS OR FAILURE OF SENDING EMAIL} -->
    
    
		
		 @if ( count( $errors ) > 0 )
        <div class="alert alert-danger">
            @foreach ($errors->all() as $error)
                {{ $error }}<br>        
            @endforeach
        </div>
        @endif
   <div class="box-body">
    <?php
        $success = Session::get('success');
        $fail = Session::get('fail');
        Session::forget('success');
        Session::forget('fail');
    ?>
    @if(isset($success) && count($success) > 0)
        <div class="col-lg-12">
            <div class="alert alert-success fade in" style="font-size: 15px;">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <strong>Success!</strong> {{$success}}
            </div> 
        </div>
    @elseif(isset($fail) && count($fail) > 0)
        <div class="col-lg-12">
            <div class="alert alert-danger fade in" style="font-size: 15px;">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <strong>Error!</strong> {{$fail}}
            </div> 
        </div>
    @endif

    <div class="col-lg-12">
    @if($order->reviewed_by > 0 && $order->authorized_by > 0)
    <a target="_blank" href="{{URL::to('erpReports/PurchaseOrder/'.$order->id)}}" class="btn btn-primary"> View Purchase Order</a>
    <a href="#myModal" role="button" class="btn btn-success" data-toggle="modal">
            <span class="glyphicon glyphicon-envelope"></span>&nbsp; Mail Quotation
        </a>
    @endif
    @if(!Entrust::can('authorize_purchase_order') || !Entrust::can('review_purchase_order'))
    @if($order->prepared_by == null || $order->prepared_by == "")
    <a href="{{URL::to('submitpurchaseorder/'.$order->id)}}" class="btn btn-success"> Submit For Approval</a>
    @endif
    @endif
    @if(Entrust::can('review_purchase_order'))
    @if($order->reviewed_by == null || $order->reviewed_by == "")
    <a href="{{URL::to('reviewpurchaseorder/'.$order->id)}}" class="btn btn-warning"> Review Purchase Order</a> 
    @endif
    @endif
    @if(Entrust::can('authorize_purchase_order'))
    @if(($order->reviewed_by > 0) && ($order->authorized_by == null || $order->authorized_by == ""))
    <a href="{{URL::to('authorizepurchaseorder/'.$order->id)}}" class="btn btn-danger"> Authorize Purchase Order</a> 
    @endif
    @endif
    <br><br>
    <table class="table table-condensed table-bordered table-hover" >

    <thead>
        
        <th>Item</th>
        <th>Quantity</th>
        <th>Price</th>
        <!-- <th>Amount</th>
        <th>Duration</th> -->
        <th>Total Amount</th>
       
    </thead>

    <tbody>

   
        <?php $total = 0; ?>
        @foreach($order->erporderitems as $orderitem)

            <?php

            $amount = $orderitem->item->item_size * $orderitem['price'] * $orderitem['quantity'];
            /*$total_amount = $amount * $orderitem['duration'];*/
            $total = $total + $amount;
            ?>
        <tr>
            
            <td>{{$orderitem->item->item_make}}</td>
            <td>{{$orderitem['quantity']}}</td>
            <td>{{asMoney($orderitem['price'])}}</td>
            <!-- <td>{{$amount}}</td>
            <td>{{$orderitem['duration']}}</td> -->
            <td>{{asMoney($amount) }}</td>
            
        </tr>

        @endforeach

        <tr>
           <td></td>
            <td></td>
            <!-- <td></td>
            <td></td> -->
            <td><strong><font color = "red">Grand Total</strong></font></td>
            <td><strong><font color = "red">{{asMoney($total)}}</strong></font></td>
          
        </tr>
    </tbody>
        
    </table>
		

  </div>

</div>

 </div>

</div>

 </div>

</div>



@stop