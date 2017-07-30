@extends('template')

@section('content')
<div class="row">
  <div class="col-md-4">
    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Manage Gases</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
          <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
        </div>
      </div>
      <div class="box-body">
        <div class="form-group">
          <label>Gas Type:</label>
          <select class="form-control select2" style="width: 100%;" id="gas_types">
            @foreach($gases as $gas)
              <option value="{{ $gas['id'] }}">{{ $gas['name'] }}</option>
            @endforeach
          </select>
        </div>
        <div class="form-group">
          <label>Gas Size:</label>
          <div class="input-group">
            <div class="input-group-addon">
              <i class="fa fa-database"></i>
            </div>
            <input type="text" class="form-control pull-right" id="gas_size">
          </div>
        </div>
        <div class="form-group">
          <label>Gas Price:</label>
          <div class="input-group">
            <div class="input-group-addon">
              <i class="fa fa-dollar"></i>
            </div>
            <input type="text" class="form-control pull-right" id="gas_price">
          </div>
        </div>
        <button type="button" class="btn btn-primary btn-block pull-right" id="add-gas">Submit</button>
      </div>
      <div class="box-footer">
        <div class="input-group">
          <input type="text" name="message" placeholder="Add Gas Type" class="form-control" id="gas_type_input" required="required">
              <span class="input-group-btn">
                <button type="submit" class="btn btn-primary btn-flat" id="update-gas">Add</button>
              </span>
        </div>
      </div>
    </div>
  </div>
  <div class="col-md-4">
    <div class="box box-default direct-chat direct-chat-success">
      <div class="box-header with-border">
        <h3 class="box-title">Product</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
          <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
        </div>
      </div>
      <div class="box-body">
        <div class="col-md-12">
          <div class="form-group">
            <label>Type:</label>
            <select class="form-control select2" style="width: 100%;" id="product_type">
              <option value="0">Service</option>
              <option value="1">Accessory</option>
            </select>
          </div>
          <div class="form-group">
            <label>Name:</label>
            <div class="input-group">
              <!-- <div class="input-group-addon">
                <i class="fa fa-dollar"></i>
              </div> -->
              <input type="text" class="form-control" id="prd_name">
            </div>
          </div>
          <div class="form-group">
            <label>Price:</label>
            <div class="input-group">
              <div class="input-group-addon">
                <i class="fa fa-dollar"></i>
              </div>
              <input type="text" class="form-control pull-right" id="prd_price">
            </div>
          </div>
        </div>
      </div>
      <div class="box-footer">
        <button type="button" class="btn btn-primary btn-block pull-right" id="add_product">Submit</button>
      </div>
    </div>
    <!--/.direct-chat -->
  </div>
  <!-- /.col -->
  <div class="col-md-4">
    <div class="box box-default direct-chat direct-chat-success">
      <div class="box-header with-border">
        <h3 class="box-title">Bulk Gas</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
          <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
        </div>
      </div>
      <div class="box-body">
        <div class="col-md-12">
          <div class="form-group">
            <label>Current Price: <span id="price">{{ $bulk }}</span></label>
          </div>
          <div class="form-group">
            <label>Price:</label>
            <div class="input-group">
              <div class="input-group-addon">
                <i class="fa fa-dollar"></i>
              </div>
              <input type="text" class="form-control pull-right" id="add_bulk_price">
            </div>
          </div>
        </div>
      </div>
      <div class="box-footer">
        <button type="button" class="btn btn-primary btn-block pull-right" id="add_bulk">Submit</button>
      </div>
    </div>
    <!--/.direct-chat -->
  </div>
</div>
@endsection
