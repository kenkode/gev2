@extends('template')

@section('content')

<div class="row" style="padding: 12px">
  <div class="col-md-offset-4 col-md-3">
    <select class="select2 form-control" id="order_search">
      <option value="AL">Search Order by ID</option>
      @foreach($orders as $order)
        <option value="{{ $order['order_id'] }}">{{ $order['order_id'] }}</option>
      @endforeach
    </select>
  </div>
</div>

<div class="row">

  @foreach($orders as $order)
    <div class="col-md-3 col-sm-6 col-xs-12">
      <div class="info-box">
        <span class="info-box-icon bg-@if($order['status'] == 1){{ 'green' }}@else{{ 'yellow' }}@endif"><i class="fa fa-bookmark-o"></i></span>
        <div class="info-box-content">
          <span class="info-box-text"><a href="orders/{{ $order['order_id'] }}">{{ $order['order_id'] }}</a></span>
          <span class="info-box-text">{{ $order['fname'] . ' ' . $order['lname'] }}</span>
          <span class="info-box-text">{{ $order['created_at'] }}</span>
        </div>
        <!-- /.info-box-content -->
      </div>
      <!-- /.info-box -->
    </div>
  @endforeach

</div>



<div class="clearfix"></div>

@endsection
