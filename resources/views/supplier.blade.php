@extends('template')

@section('content')

@include('modal')

<div class="row">
  <div class="col-md-12">
    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Suppliers</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
          <div class="btn-group">
            <button type="button" class="btn btn-box-tool dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-wrench"></i></button>
            <ul class="dropdown-menu" role="menu">
              <li><a href="#" id="add_supplier">Add Supplier</a></li>
            </ul>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table class="table no-margin" id="supplier_table">
                <thead>
                <tr>
                  <th>Supplier ID</th>
                  <th>Supplier Name</th>
                  <th>Item</th>
                  <th></th>
                </tr>
                </thead>
                <tbody>
                @foreach($suppliers as $supplier)
                <tr>
                  <td>{{ $supplier['id'] }}</td>
                  <td>{{ $supplier['name'] }}</td>
                  <td>{{ $supplier['item'] }}</td>
                  <td>
                    <div class="btn-group">
                      <button type="button" class="btn btn-default edit_supplier" data-type="{{ $supplier['item_type'] }}" data-item="{{ $supplier['item_id'] }}">Edit</button>
                      <button type="button" class="btn btn-default delete_supplier" data-supplier="{{ $supplier['id'] }}">Delete</button>
                    </div>
                  </td>
                </tr>
                @endforeach
                </tbody>
              </table>
            </div>
            <!-- /.table-responsive -->
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- /.col -->
</div>
<!-- /.row -->

<div class="modal fade" id="supplier_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Supplier</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label>Name:</label>
          <div class="input-group">
            <div class="input-group-addon">
              <i class="fa fa-database"></i>
            </div>
            <input type="text" class="form-control pull-right" id="supplierFormName">
          </div>
        </div>
        <div class="form-group">
          <label>Type:</label>
          <select class="form-control select2" style="width: 100%;" id="supplierFormType">
            @foreach($items as $item)
              <option data-type="{{ $item['type'] }}" value="{{ $item['id'] }}">{{ $item['name'] }}</option>
            @endforeach
          </select>
        </div>
        <button type="button" class="btn btn-primary btn-block" id="submitSupplierForm">Submit</button>
    </div>
  </div>
</div>
</div>



@endsection
