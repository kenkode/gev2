@extends('accounting')
@section('content')
<br/>

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
        <h3 class="box-title">Journal Entries</h3>
        <div class="box-tools pull-right">
          <a class="btn btn-info btn-sm" href="{{ URL::to('journals/create')}}">new journal entry</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

  
    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        
        <th>Transaction #</th>
      
         <th>Account Category</th>
        <th>Account Name</th>
         <th>Date</th>
        <th>Amount </th>
        <th>Type </th>
        <th>status </th>
       
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($journals as $journal)

        <tr>

       
          <td>{{ $journal->trans_no }}</td>
          
          <td>{{ $journal->account->category }}</td>
          <td>{{ $journal->account->name."(".$journal->account->code.")" }}</td>
 <td>{{ $journal->date }}</td>
        <td>

          <?php


echo asMoney($journal->amount);

?>
        </td>
          <td>{{ $journal->type }}</td>
          <td> @if($journal->void) Void @endif</td>
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                   
                    <!-- <li><a href="{{URL::to('journals/show/'.$journal->id)}}">View</a></li> -->
                    <li><a href="{{URL::to('journals/delete/'.$journal->id)}}" onclick="return (confirm('Are you sure you want to void this entry?'))">Void</a></li>
                   
                    
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