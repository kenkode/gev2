<?php 
	function asMoney($value){
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
        <h3 class="box-title">Clients with Balances</h3>
        <div class="box-tools pull-right">
          <h4>
            Clients with Balances &emsp;
            <a href="{{ URL::to('client/balances/report') }}" class="btn btn-primary btn-sm" target="_blank"><i class="fa fa-file fa-fw"></i> View PDF</a>
          </h4>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

    		<div class="panel-body">
    			<table id="users" class="table table-bordered table-condensed table-responsive table-hover">
    				<thead>
    					<th>#</th>
    					<th>Name</th>
    					<!-- <th>Discount (%)</th> -->
              <th>Current</th>
              <th>1-30</th>
              <th>31-60</th>
              <th>61-90</th>
              <th>> 90</th>
    					<th>Total</th>
    				</thead>

    				<tbody>
    					<?php $count = 1; ?>
						@foreach($clients as $client)
						@if(App\Http\Models\Client::due($client->id) > 0)
						<tr>
							<td>{{ $count }}</td>
							<td>{{ $client->name }}</td>
							<!-- <td align="center">{{ asMoney($client->percentage_discount) }}</td> -->
              <td align="right"> {{ App\Http\Models\Client::dueToday($client->id)}} </td>
              <td align="right"> {{ App\Http\Models\Client::due30($client->id)}} </td>
              <td align="right"> {{ App\Http\Models\Client::due60($client->id)}} </td>
              <td align="right"> {{ App\Http\Models\Client::due90($client->id)}} </td>
              <td align="right"> {{ App\Http\Models\Client::due91($client->id)}} </td>
							<td align="right"> {{ App\Http\Models\Client::due($client->id)}} </td>
						</tr>
						<?php $count++ ?>
						@endif	
						@endforeach
    				</tbody>
    			</table>
    		</div>
    	</div>
	</div>
</div>
</div>

@stop
