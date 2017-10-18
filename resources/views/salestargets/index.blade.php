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

    @if ( count( $errors ) > 0 )
        <div class="alert alert-danger">
            @foreach ($errors->all() as $error)
                {{ $error }}<br>        
            @endforeach
        </div>
        @endif

         <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Targets</h3>
        <div class="box-tools pull-right">
          <a class="btn btn-info btn-sm" href="{{ URL::to('salestargets/create')}}">new target</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        <th>#</th>
        <th>Month</th>
        <th>Target Amount</th>
        <th>Date</th>
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($salestargets as $salestarget)

        <tr>

          <td> {{ $i }}</td>
          <td>{{$salestarget->month }}</td>
          <td>{{asMoney($salestarget->target_amount) }}</td>
          <td>{{ date("d-M-Y",strtotime($salestarget->target_date)) }}</td>          
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{URL::to('salestargets/edit/'.$salestarget->id)}}">Update</a></li>
                   
                    <li><a href="{{URL::to('salestargets/delete/'.$salestarget->id)}}"  onclick="return (confirm('Are you sure you want to Remove this Target?'))">Delete</a></li>
                    
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