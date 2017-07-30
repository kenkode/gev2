@extends('template')


@section('content')

@include('modal')

<div class="row">

  <div class="col-md-12">
    <div class="box collapsed-box">
      <div class="box-header with-border">
        <h3 class="box-title">Accessories</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <table id="products" class="table table-bordered table-striped">
          <thead>
          <tr>
            <th>Name</th>
            <th>Stock No.</th>
            <th>Price</th>
            <th>Update Stock</th>
          </tr>
          </thead>
          <tbody>
          @foreach($accessories as $accessory)
          <tr>
            <td>{{ $accessory['name'] }}</td>
            <td>{{ $accessory['stock'] }}</td>
            <td>{{ $accessory['price'] }}</td>
            <td><button type="button" class="btn btn-info stock_update_button" data-type="1" data-id="{{ $accessory['id'] }}">Update</button></td>
          </tr>
          @endforeach
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <div class="box collapsed-box">
      <div class="box-header with-border">
        <h3 class="box-title">Gases</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
        </div>
      </div>
      <!-- /.box-header -->
      <div class="box-body">
        <table id="products" class="table table-bordered table-striped">
          <thead>
          <tr>
            <th>Name</th>
            <th>Size</th>
            <th>Price</th>
            <th>Update Stock</th>
          </tr>
          </thead>
          <tbody>
          @foreach($gases as $gas)
          <tr>
            <td>{{ $gas['name'] }}</td>
            <td>{{ $gas['size'] }}</td>
            <td>{{ $gas['price'] }}</td>
            <td><button type="button" class="btn btn-info stock_update_button" data-type="2" data-id="{{ $gas['id'] }}">Update</button></td>
          </tr>
          @endforeach
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

@endsection
