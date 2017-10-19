@extends('template')
@section('content')

<?php

use App\Http\Models\Stock;
?>


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
    
    @if (Session::get('notice'))
            <div class="alert alert-info">{{ Session::get('notice') }}</div>
        @endif

<div class="row">
	<div class="col-lg-12">

    
    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Stock</h3>
        <div class="box-tools pull-right">
          
           <a class="btn btn-info btn-sm" href="{{ URL::to('stocks/create')}}">Receive Stock </a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">
          


    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        <th>#</th>
        <th>Item</th>
        <!-- <th>Stock In</th>
        <th>Stock Out</th> -->
        <th>Stock Amount</th>
       <th>Barcode</th> 

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($items as $item)

        <tr>

          <td> {{ $i }}</td>
          <td>{{ $item->item_make }}</td>
               
          <td>{{Stock::getStockAmountNew($item)}}</td>
           <td>

            <img src="data:image/png;base64,{{DNS1D::getBarcodePNG($item->id, 'C128')}}" alt="barcode" />
         
       <!--  {{  DNS1D::getBarcodeHTML($item->name, "C128" ,1,13) }} -->

      
        <div style="padding-top: 30px; padding-left: 45px;  width: 500px;">
        {{$item->purchase_price}}   Rs{{$item->selling_price}} <br>


        </div>
      

      <style> 
    .code{
        height: 60px !important;
    }

</style>
</td>
       
        </tr>

          
        <?php
        $reorder = (Stock::getStockAmount($item) < $item->reorder_level);
        $message = "Running low on "." ". $item->name." ".$item->description." ."."Please reorder" ;
       

        if ($reorder) 
          
        //echo "<script type='text/javascript'> alert('$message');</script>";
           
        $i++; 
        ?>
        @endforeach




      </tbody>


    </table>
  </div>
</div>
</div>

  </div>

</div>

@stop