@extends('template')

@section('content')
  <div class="row invoice-info">
    <div class="col-sm-4 invoice-col">
      <strong><u>Customer Details</u></strong>
      <address>
        <strong>ID</strong>: {{ $results['user']['id'] }}<br>
        <strong>Name</strong>: {{ $results['user']['name'] }}<br>
        <strong>Phone</strong>: {{ $results['user']['phone'] }}<br>
        <strong>Email</strong>: {{ $results['user']['email'] }}
      </address>
    </div>
    <!-- /.col -->
    <div class="col-sm-4 invoice-col">
      <strong><u>Order Details</u></strong>
      <address>
        <strong>Order Type</strong>: {{ $results['order']['type'] }}<br>
        <strong>Order Price</strong>: {{ $results['order']['price'] }}<br>
        <strong>Order Date</strong>: {{ $results['order']['created_at'] }}<br>
        <strong>Status</strong>: {{ $results['order']['status'] }}
      </address>
    </div>
    <!-- /.col -->
    <div class="col-sm-4 invoice-col">
      <strong><u>Location Details</u></strong><br>
      <strong>Location Name</strong>: {{ $results['location']['address'] }}<br>
      <strong>Location Description</strong>: {{ $results['location']['description'] }}<br>
    </div>
    <!-- /.col -->
  </div>
  <!-- /.row -->

  <!-- Table row -->
  <div class="row">
    <div class="col-xs-12 table-responsive">
      <table class="table table-striped">
        <thead>
        <tr>
          <th>Item Name</th>
          <th>Quantity</th>
          <th>Price</th>
        </tr>
        </thead>
        <tbody>
        @foreach($results['items'] as $order)
        <tr>
          <td>{{ $order['name'] }}</td>
          <td>{{ $order['quantity'] }}</td>
          <td>{{ $order['price'] }}</td>
        </tr>
        @endforeach
        </tbody>
      </table>
    </div>
    <!-- /.col -->
  </div>
  <!-- /.row -->

  <div class="row">
    <!-- accepted payments column -->
    <div class="col-xs-6">
      <p class="lead">Payment Method: {{ $results['order']['payment'] }}</p>
    </div>
    <!-- /.col -->
  </div>
  <!-- /.row -->

  <!-- this row will not appear when printing -->
  <div class="row no-print">
    <div class="col-xs-12">
      <!-- <a href="invoice-print.html" target="_blank" class="btn btn-default"><i class="fa fa-print"></i> Print</a> -->
      <!-- <button type="button" class="btn btn-primary pull-right" style="margin-right: 5px;">
        <i class="fa fa-download"></i> Generate PDF
      </button> -->
    </div>
  </div>
<!-- /.content -->
<div class="clearfix"></div>

@endsection
