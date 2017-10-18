@extends('template')

@section('content')

<div class="row" style="padding: 8px">
  <div class="col-md-5 col-md-offset-5">
    <button type="button" class="btn btn-default btn-flat" data-toggle="modal" data-target="#add_subsidiary">Add Subsidiary</button>
  </div>
</div>

<div class="row">
@foreach($subsidiaries as $subsidiary)
  <div class="col-md-4">
      <div class="box box-widget widget-user">
          <div class="widget-user-header bg-@if($subsidiary['subsidiary']['status'] == 1){{ 'green' }}@else{{ 'yellow' }}@endif-active">
              <h3 class="widget-user-username">{{ $subsidiary['subsidiary']['name'] }}</h3>
              <h5 class="widget-user-desc">{{ $subsidiary['subsidiary']['location'] }}</h5>
          </div>
          <div class="widget-user-image">
              <span class="info-box-icon bg-@if($subsidiary['subsidiary']['status'] == 1){{ 'green' }}@else{{ 'yellow' }}@endif"><i class="fa fa-building"></i></span>
          </div>
          <div class="box-body">
            <div class="row">
                <div class="col-sm-6 border-right">
                    <div class="description-block">
                        <h5 class="description-header">{{ $subsidiary['riders'] }}</h5>
                        <span class="description-text">Riders</span>
                    </div>
                </div>
                <div class="col-sm-6 border-right">
                    <div class="description-block">
                        <h5 class="description-header">{{ $subsidiary['deliveries'] }}</h5>
                        <span class="description-text">Deliveries</span>
                    </div>
                </div>
            </div>
          </div>
          <div class="box-footer">
            <div class="row">
              <div class="col-sm-7 col-md-offset-3">
                <div class="btn-group">
                  <button type="button" class="btn btn-default btn-flat">Edit</button>
                  <button type="button" class="btn btn-default btn-flat">Deactivate</button>
                </div>
              </div>
            </div>
          </div>
      </div>
  </div>
  @endforeach
</div>

<div class="clearfix"></div>

<div class="modal fade" id="add_subsidiary" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">New Subsidiary</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label>Name: </label>
          <input type="text" id="name" name="name" class="form-control">
        </div>
        <div class="form-group">
          <label>Subsidiary Email: </label>
          <input type="email" id="email" name="email" class="form-control">
        </div>
        <div class="form-group">
          <label>Subsidiary Phone: </label>
          <input type="text" id="phone" name="phone" class="form-control">
        </div>
        <div class="form-group" id="stockLevelInput">
          <label>Location: </label>
            <input type="text" class="form-control pull-right" id="location" name="location">
          </div>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="add_subsidiary_button">Submit</button>
      </div>
    </div>
  </div>
  </div>



@endsection
