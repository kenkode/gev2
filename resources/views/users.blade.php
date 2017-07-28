@extends('template')

@section('content')
<div class="row">

  <div class="col-md-12">

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">{{ $header }}</h3>
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
            <th>User ID</th>
            <th>User Name</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Date Joined</th>
          </tr>
          </thead>
          <tbody>
          @foreach($users as $user)
          <tr>
            <td>{{ $user['id'] }}</td>
            <td>{{ $user['fname'] . ' ' . $user['lname'] }}</td>
            <td>{{ $user['phone'] }}</td>
            <td>{{ $user['email'] }}</td>
            <td>{{ $user['created_at'] }}</td>
          </tr>
          @endforeach
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

@endsection
