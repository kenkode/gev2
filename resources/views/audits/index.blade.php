@extends('system')
@section('content')


	@if (Session::get('error'))
            <div class="alert alert-danger">{{{ Session::get('error') }}}</div>
        @endif

<div class="row">
<div class="col-lg-12 ">
    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Audit Trail</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

	
<table class="table table-bordered table-responsive table-hover" id="users">

    <thead>
            <th>Date</th>
            <th>Made by</th>
            <th>Entity</th>
            <th>Action</th>
            <th>Description</th>
    </thead>

    <tbody>
@foreach($audits as $audit)
        <tr>
            <td>{{$audit->created_at}}</td>
            <td>{{$audit->user}}</td>
            <td>{{$audit->entity}}</td>
            <td>{{$audit->action}}</td>
            <td>{{$audit->description}}</td>

        </tr>
        @endforeach

    </tbody>

</table>

</div>	
</div>
</div>

</div>


@stop