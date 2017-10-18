<?php


function asMoney($value) {
  return number_format($value, 2);
}

?>

@extends('template')
@section('content')


<div class="row">
	<div class="col-lg-12">
   
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

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Items</h3>
        <div class="box-tools pull-right">
          
          <a class="btn btn-info btn-sm" href="{{ URL::to('items/create')}}">New Item</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">


    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        <th>#</th>
        <th>Item Make</th>
        <th>Item Size</th>
        <th>Description</th>
        <th>Purchase Price</th>
        <th>Selling Price</th>
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($items as $item)

        <tr>

          <td> {{ $i }}</td>
          <td>{{ $item->item_make }}</td>
          <td>{{ $item->item_size }}</td>
          <td>{{ $item->description }}</td>
          <td align="right">{{ asMoney($item->purchase_price) }}</td>
          <td align="right">{{ asMoney($item->selling_price) }}</td>
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                    <!--<li><a href="{{URL::to('items/code/'.$item->id)}}">Generate Barcode</a></li>-->
                    <li><a href="{{URL::to('items/edit/'.$item->id)}}">Update</a></li>
                    <li><a href="{{URL::to('items/delete/'.$item->id)}}" onclick="return (confirm('Are you sure you want to delete this item?'))">Delete</a></li>
                    
                  </ul>
              </div>

                    </td>



        </tr>

        <?php $i++; ?>
        @endforeach


      </tbody>


    </table>
  </div>


  </div>

</div>

</div>

@stop