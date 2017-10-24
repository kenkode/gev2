@extends('report')
@section('content')
<br/>

<?php
use Illuminate\Support\Facades\Input;
?>


<div class="row">
  <div class="col-lg-6">

    
    
     @if ( count( $errors ) > 0 )
        <div class="alert alert-danger">
            @foreach ($errors->all() as $error)
                {{ $error }}<br>        
            @endforeach
        </div>
        @endif

        <div class="box">
      <div class="box-header with-border">
        <h4>Financial Reports</h4>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

   <form method="post" target="_blank" action="{{URL::to('reports/financials')}}">
{{ csrf_field() }}

      <div class="form-group">
            <label for="username">Report</label>
            <select class="form-control" name="report_type">
                <option value="">select report</option>
                <option>--------------------------</option>
                <option value="balancesheet">Balance Sheet</option>
                <option value="income">Income Statement</option>
                <option value="trialbalance">Trial Balance</option>
            </select>
            
        </div>



        <div class="form-group">
            <label for="username">As at Date </label>
            <input class="form-control" placeholder="" type="date" name="date" id="date" value="{{date('Y-m-d')}}">
        </div>


        <div class="form-actions form-group">
        
        

          <button type="submit" class="btn btn-primary btn-sm">View Report</button> 
        </div>


   </form>

  </div>

</div>

 </div>

</div>






















@stop