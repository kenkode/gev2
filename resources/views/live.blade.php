<!-- Info boxes -->
<div class="row">
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="box" id="live_order">
      <div class="box-header with-border">
        <h3 class="box-title"><i class="fa fa-refresh fa-spin"></i> Live Orders</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
          </button>
        </div>
      </div>
      <div class="box-body" id="loc">
          <span class="info-box-icon bg-red"><i class="ion ion-ios-gear-outline"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Live Orders</span>
          </div>
          <a href="{{ route('orders') }}" style="padding: 8px" id="noc"><strong><span class="label label-warning"><label id="nto">0 </label> New Order(s)</span></strong></a>
      </div>
    </div>
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="box box-default">
      <div class="box-header with-border">
        <h3 class="box-title">Pending Orders</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
          </button>
        </div>
      </div>
      <div class="box-body">
          <span class="info-box-icon bg-yellow"><i class="ion ion-ios-gear-outline"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Pending Orders</span>
            <span class="info-box-number">{{ $data['pending'] }}</span>
          </div>
      </div>
    </div>
  </div>
  <div class="clearfix visible-sm-block"></div>

  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="box box-default">
      <div class="box-header with-border">
        <h3 class="box-title">Sales</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
          </button>
        </div>
      </div>
      <div class="box-body">
          <span class="info-box-icon bg-green"><i class="ion ion-ios-cart-outline"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Sales</span>
            <span class="info-box-number">{{ $data['totalSales'] }}</span>
          </div>
      </div>
    </div>
  </div>
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="box box-default">
      <div class="box-header with-border">
        <h3 class="box-title">Users</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
          </button>
        </div>
      </div>
      <div class="box-body">
          <span class="info-box-icon bg-blue"><i class="ion ion-ios-people-outline"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Users</span>
            <span class="info-box-number">{{ $data['users'] }}</span>
          </div>
      </div>
    </div>
  </div>
</div>
