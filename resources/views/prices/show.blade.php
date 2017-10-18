<?php

function asMoney($value) {
  return number_format($value, 2);
}

?>
@extends('template')
@section('content')

<div class="row">
	<div class="col-lg-6">

    @if (Session::has('flash_message'))

      <div class="alert alert-success">
      {{ Session::get('flash_message') }}
     </div>
    @endif

    @if (Session::has('delete_message'))

      <div class="alert alert-danger">
      {{ Session::get('delete_message') }}
     </div>
    @endif

         <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Customer Discount</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

        


    <table  class="table table-condensed table-bordered table-responsive table-hover">

     <tr>
      <td colspan="2"><font color="green">Customer Discount</font></td>
    </tr>
     <tr>
       <td>Date</td><td>{{ $price->date }}</td>
     </tr>
      <tr>
       <td>Client Name</td><td>{{ $price->client->name }}</td>
     </tr>
     <tr>
       <td>Item</td><td>{{ App\Http\Models\Item::itemname($price->Item_id) }}</td>
     </tr>
     <tr>
       <td>Discount</td><td>{{ $price->Discount }}</td>
     </tr>  
    </table>
 </div> 

</div>
</div>
</div>

@stop