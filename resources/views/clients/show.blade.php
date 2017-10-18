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
      <h4 class="box-title">Customer/Supplier</h4>
      <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
     </div> 
        
<div class="box-body">

    <table style="border: #000 !important"  class="table table-condensed table-bordered table-responsive table-hover">

    <tr>
       <td>Client Code</td><td>{{$client->code}}</td>
     </tr>
     <tr>
       <td>Client Name</td><td>{{$client->name}}</td>
     </tr>
      <tr>
       <td>Date</td><td>{{$client->date}}</td>
     </tr>
     <tr>
       <td>Email Address</td><td>{{$client->email}}</td>
     </tr>
     <tr>
       <td>Phone Number</td><td>{{$client->phone}}</td>
     </tr>
     
     <tr>
       <td>Physical Address</td><td>{{$client->address}}</td>
     </tr>  

    <tr>
       <td>Contact Person</td><td>{{$client->contact_person}}</td>
     </tr>
     <tr>
       <td>Contact Person email</td><td>{{$client->contact_person_email}}</td>
     </tr>
     <tr>
       <td>Contact Person Phone Number</td><td>{{$client->contact_person_phone}}</td>
     </tr>
     <tr>
       <td>Type</td><td>{{$client->type}}</td>
     </tr>

      <!-- <tr>
       <td>Percentage Discount</td><td>{{asMoney($client->percentage_discount)}}%</td>
     </tr> -->


    </table>
  </div>
 </div>
</div>
</div>

@stop