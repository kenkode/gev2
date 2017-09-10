@extends('template')

@section('content')

<div class="row">
  <div class="col-md-6">
      <div class="box box-widget widget-user">
          <div class="widget-user-header bg-blue active">
              <h3 class="widget-user-username">{{ $rider['name'] }}</h3>
              <h5 class="widget-user-desc">{{ $rider['email'] }}</h5>
          </div>
          <div class="widget-user-image">
              <span class="info-box-icon bg-blue"><i class="fa fa-user"></i></span>
          </div>
          <div class="box-body">
            <div class="row">
                <div class="col-sm-6 border-right">
                    <div class="description-block">
                        <h5 class="description-header">{{$rating['rating']}}</h5>
                        <span class="description-text">Rating</span>
                    </div>
                </div>
                <div class="col-sm-6 border-right">
                    <div class="description-block">
                        <h5 class="description-header">{{$rating['deliveries']}}</h5>
                        <span class="description-text">Deliveries</span>
                    </div>
                </div>
            </div>
          </div>
          <div class="box-footer">
            <div class="row">
              <div class="col-sm-7 col-md-offset-3">
                <!-- <div class="btn-group">
                  <button type="button" class="btn btn-default btn-flat">Edit</button>
                  <button type="button" class="btn btn-default btn-flat">Deactivate</button>
                </div> -->
              </div>
            </div>
          </div>
      </div>
  </div>
  <div class="col-md-6">
      <div class="box box-widget widget-user">
          <div class="widget-user-header bg-blue active">
              <h3 class="widget-user-username">{{ $rider['ride'] }}</h3>
              <h5 class="widget-user-desc"></h5>
          </div>
          <div class="widget-user-image">
              <span class="info-box-icon bg-blue"><i class="fa fa-bicycle"></i></span>
          </div>
          <div class="box-body">
            <div class="row">
                <div class="col-sm-6 border-right">
                    <div class="description-block">
                        <h5 class="description-header">Last Trip</h5>
                        <span class="description-text">Last Trip</span>
                    </div>
                </div>
                <div class="col-sm-6 border-right">
                    <div class="description-block">
                        <h5 class="description-header">Online</h5>
                        <span class="description-text">Status</span>
                    </div>
                </div>
            </div>
          </div>
          <div class="box-footer">
            <div class="row">
              <div class="col-sm-7 col-md-offset-3">
                <!-- <div class="btn-group">
                  <button type="button" class="btn btn-default btn-flat">Edit</button>
                  <button type="button" class="btn btn-default btn-flat">Deactivate</button>
                </div> -->
              </div>
            </div>
          </div>
      </div>
  </div>
</div>

@endsection
