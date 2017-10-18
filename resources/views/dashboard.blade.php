@extends('template')

@section('content')
<div class="row">
  <div class="col-md-12">

   @if (Session::get('notice'))
            <div class="alert alert-info">{{ Session::get('notice') }}</div>
        @endif

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Latest Orders</h3>

        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
          <div class="btn-group">
            <button type="button" class="btn btn-box-tool dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-wrench"></i></button>
            <ul class="dropdown-menu" role="menu">
              <li><a href="{{ route('orders') }}">View All</a></li>
            </ul>
          </div>
          <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table class="table no-margin" id="orders_container">
                <thead>
                <tr>
                  <th>Order ID</th>
                  <th>Order Type</th>
                  <th>Order Date</th>
                  <th>Status</th>
                  <th>Customer ID</th>
                  <th>Customer Name</th>
                  <th>Customer Phone</th>
                </tr>
                </thead>
                <tbody>
                @foreach($data['orders'] as $order)
                <tr>
                  <td><a href="orders/{{ $order['order_id'] }}">{{ $order['order_id'] }}</a></td>
                  <td>{{ $order['type'] }}</td>
                  <td>{{ $order['created_at'] }}</td>
                  <td><span class="label label-{{ $order['status'] == '1' ? 'success' : 'warning'}}">
                    {{ $order['status'] == '1' ? 'Shipped' : 'Pending'}}</span></td>
                  <td>{{ $order['cust_id'] }}</td>
                  <td>{{ $order['fname'] . ' ' . $order['lname'] }}</td>
                  <td>{{ $order['phone'] }}</td>
                </tr>
                @endforeach
                </tbody>
              </table>
            </div>
            <!-- /.table-responsive -->
          </div>
          <!-- /.col -->

            <!-- /.box -->
        </div>
        <!-- /.row -->
      </div>
      <!-- ./box-body -->
      <div class="box-footer">
        <div class="row">
          <!-- <div class="col-sm-3 col-xs-6">
            <div class="description-block border-right">
              <span class="description-percentage text-green"><i class="fa fa-caret-up"></i> 17%</span>
              <h5 class="description-header">$35,210.43</h5>
              <span class="description-text">TOTAL REVENUE</span>
            </div>
          </div>
          <div class="col-sm-3 col-xs-6">
            <div class="description-block border-right">
              <span class="description-percentage text-yellow"><i class="fa fa-caret-left"></i> 0%</span>
              <h5 class="description-header">$10,390.90</h5>
              <span class="description-text">TOTAL COST</span>
            </div>
          </div>
          <div class="col-sm-3 col-xs-6">
            <div class="description-block border-right">
              <span class="description-percentage text-green"><i class="fa fa-caret-up"></i> 20%</span>
              <h5 class="description-header">$24,813.53</h5>
              <span class="description-text">TOTAL PROFIT</span>
            </div>
          </div
          <div class="col-sm-3 col-xs-6">
            <div class="description-block">
              <span class="description-percentage text-red"><i class="fa fa-caret-down"></i> 18%</span>
              <h5 class="description-header">1200</h5>
              <span class="description-text">GOAL COMPLETIONS</span>
            </div>
          </div> -->
        </div>
      </div>
    </div>
  </div>
</div>
@endsection
