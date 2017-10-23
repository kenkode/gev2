@extends('accounting')
@section('content')

<?php

function asMoney($value) {
  return number_format($value, 2);
}

?>

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
        <h3 class="box-title">Chart of Accounts</h3>
        <div class="box-tools pull-right">
          <a class="btn btn-info btn-sm" href="{{ URL::to('accounts/create')}}">new account</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        <th>#</th>
         <th>Account Category</th>
        <th>Account Name</th>
         <th>Account Code</th>
         <th>Balance</th>
          <th>Status </th>
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($accounts as $account)

        <tr>

          <td> {{ $i }}</td>
          <td>{{ $account->category }}</td>
          <td>{{ $account->name }}</td>
          <td>{{ $account->code }}</td>
          <td>{{ asMoney($account->balance) }}</td>
          <td>
            @if($account->active)

            Active
            @endif

           @if(!$account->active)

            Disabled
            @endif


          </td>
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{URL::to('accounts/edit/'.$account->id)}}">Update</a></li>                   
                    <li><a href="{{URL::to('accounts/delete/'.$account->id)}}" onclick="return (confirm('Are you sure you want to delete this account?'))">Delete</a></li>
                     <!-- <li><a href="{{URL::to('accounts/show/'.$account->id)}}">Show</a></li> -->
                    
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