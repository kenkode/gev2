<?php

function asMoney($value) {
  return number_format($value, 2);
}

?>

@extends('accounting')
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

    @if (Session::get('notice'))
            <div class="alert alert-info">{{ Session::get('notice') }}</div>
        @endif

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Expenses</h3>
        <div class="box-tools pull-right">
          <a class="btn btn-info btn-sm" href="{{ URL::to('expenses/create')}}">new expense</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

    
    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        <th>#</th>
        <th>Name</th>
        <th>Amount</th>
        <th>Type</th>
        <th>Account</th>
        <th>Date</th>
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($expenses as $expense)

        <tr>

          <td> {{ $i }}</td>
          <td>{{ $expense->name }}</td>
          <td align = "right">{{ asMoney($expense->amount )}}</td>
          <td>{{ $expense->type }}</td>
          @if($expense->account_id != 0)
          <td>{{ $expense->account->name }}</td>
                     @else          
          <td></td>
          @endif
          <td>{{$expense->date}}</td>
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{URL::to('expenses/edit/'.$expense->id)}}">Update</a></li>
                   
                    <li><a href="{{URL::to('expenses/delete/'.$expense->id)}}" onclick="return (confirm('Are you sure you want to delete this expense?'))">Delete</a></li>
                    
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