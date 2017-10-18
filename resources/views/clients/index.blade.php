<?php

function asMoney($value) {
  return number_format($value, 2);
}

?>
@extends('template')

@section('content')

<div class="row">
	<div class="col-lg-12">

    @if (Session::has('flash_message'))

      <div class="alert alert-success">
      {{ Session::get('flash_message') }}
     </div>
    @endif

    @if (Session::has('delete_message'))

      <div class="alert alert-danger">
      {{ Session::get('delete_message') }}
     </div>
    @endif

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Clients</h3>
        <div class="box-tools pull-right">
          
          <a class="btn btn-info btn-sm" href="{{ URL::to('clients/create')}}">New Client</a> &emsp;
          <a class="btn btn-primary btn-sm" href="{{ URL::to('client/balances')}}">Client Balances</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table class="table table-condensed table-bordered table-responsive table-hover" id="users">
                <thead>

        <th>#</th>
        <th>Code</th>
        <th>Name</th>
        <th>Phone</th>
        <th>Email</th>
        <th>Address</th>
        <th>Type</th>
        <!-- <th>Percentage Discount</th> -->
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($clients as $client)

        <tr>

          <td> {{ $i }}</td>
          <td>{{ $client->code }}</td>
          <td>{{ $client->name }}</td>
          <td>{{ $client->phone }}</td>
          <td>{{ $client->email }}</td>
          <td>{{ $client->address }}</td>
          <td>{{ $client->type }}</td>
          <!-- <td>{{ asMoney($client->percentage_discount)}}%</td> -->
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{URL::to('clients/edit/'.$client->id)}}">Update</a></li>
                    <li><a href="{{URL::to('clients/show/'.$client->id)}}">View Client</a></li>
                    <li><a href="{{URL::to('client/selectPeriod/'.$client->id)}}">View Statement</a></li>
                    <!--<li><a href="{{URL::to('erpReports/customerstatement/'.$client->id)}}" target="blank">View Statement</a></li>-->
                   <!--  <li><a href="{{URL::to('clients/delete/'.$client->id)}}"  onclick="return (confirm('Are you sure you want to delete this client?'))">Delete</a></li> -->
                    
                  </ul>
              </div>
              </td>

        </tr>

        <?php $i++; ?>
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

@stop