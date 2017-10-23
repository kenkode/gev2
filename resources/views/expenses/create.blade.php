@extends('accounting')
@section('content')

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
        <h3 class="box-title">New Expense</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

		 <form method="POST" action="{{{ URL::to('expenses') }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>
      <font color="red"><i>All fields marked with * are mandatory</i></font>
        <div class="form-group">
            <label for="username">Expense Name <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="name" id="name" value="{{{ Input::old('name') }}}" required>
        </div>

        <div class="form-group">
            <label for="username">Amount <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="amount" id="amount" value="{{{ Input::old('amount') }}}" required>
        </div>

       <div class="form-group">
            <label for="username">Type</label><span style="color:red">*</span> :
           <select name="type" class="form-control" required>
                           <option>.............................Select Expense Type........................</option>
                            <option value="Bill"> Bill</option>
                            <option value="Expenditure"> Expenditure</option>
                        </select>
        </div>

        <div class="form-group">
            <label for="username">Account</label><span style="color:red">*</span> :
           <select name="account" class="form-control" required>
                           <option>.............................Select Account Name........................</option>
                           @foreach($accounts as $account)
                            <option value="{{$account->id}}">{{$account->name}}</option>
                           @endforeach
                        </select>
        </div>

       <div class="form-group">
                        <label for="username">Date</label><span style="color:red">*</span> :
                        <div class="right-inner-addon ">
                        <i class="glyphicon glyphicon-calendar"></i>
                        <input class="form-control datepicker"  readonly="readonly" placeholder="" type="text" name="date" id="date" value="{{date('d-M-Y')}}" required>
                        </div>
          </div>

        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Create Expense</button>
        </div>

    </fieldset>
</form>
		

  </div>

</div>

</div>

</div>

@stop