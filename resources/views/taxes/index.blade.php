<?php


function asMoney($value) {
  return number_format($value, 2);
}

?>
@extends('template')
@section('content')

<br><div class="row">
	<div class="col-lg-12">
  <h3>Taxes</h3>

<hr>
</div>	
</div>


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
        <h3 class="box-title">Taxes</h3>
        <div class="box-tools pull-right">
          <a class="btn btn-info btn-sm" href="{{ URL::to('taxes/create')}}">new tax</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">
  

    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        <th>#</th>
        <th>Type</th>
        <th>Rate</th>
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($taxes as $tax)

        <tr>

          <td> {{ $i }}</td>
          <td>{{$tax->name }}</td>
          <td>{{ $tax->rate }}</td>
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{URL::to('taxes/edit/'.$tax->id)}}">Update</a></li>
                   
                    <li><a href="{{URL::to('taxes/delete/'.$tax->id)}}"  onclick="return (confirm('Are you sure you want to delete this tax?'))">Delete</a></li>
                    
                  </ul>
              </div>

                    </td>



        </tr>

        <?php $i++; ?>
        @endforeach


      </tbody>


    </table>
  </div>
</div>
</div>

  </div>

</div>

@stop