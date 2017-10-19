<?php

function asMoney($value) {
  return number_format($value, 2);
}

?>

@extends('template')

{{ HTML::script('media/js/jquery.js') }}

@section('content')


<div class="row">
  <div class="col-lg-9">

    
    @if ( count( $errors ) > 0 )
        <div class="alert alert-danger">
            @foreach ($errors->all() as $error)
                {{ $error }}<br>        
            @endforeach
        </div>
        @endif

         <div class="box">
      <div class="box-header with-border">
        <h4><font color='green'>Purchase Order : {{Session::get('erporder')['order_number']}} &nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Client: {{Session::get('erporder')['client']['name']}}  &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; Date: {{Session::get('erporder')['date']}} </font></h4>

        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">
            
            <h2>Edit {{$editItem['item']}} Values:</h2>
            <form action="{{{ URL::to('erppurchases/edit/'.$count) }}}" method="POST" accept-charset="utf-8">
                {{ csrf_field() }}
                <input type="hidden" name="edit_id" value="{{$count}}">
                <div class="form-actions form-group">
                    <label for="item-name">Quantity</label>
                    <input class="form-control" placeholder="" type="text" name="qty" id="qty" value="{{$editItem['quantity']}}" required>
                </div>
                <div class="form-actions form-group">
                    <label for="item-name">Price per Item</label>
                    <input class="form-control" placeholder="" type="text" name="price" id="price" value="{{$editItem['unitprice']}}" required>
                </div>
                <div class="form-actions form-group">
                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                </div>
            </form>
            
        </div>
        
</div>
</div>
  </div>

</div>

@stop