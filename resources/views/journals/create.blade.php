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
        <h3 class="box-title">New Journal Entry</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

		 <form method="POST" action="{{{ URL::to('journals') }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>
        

        <div class="form-group">
                        <label for="username">Date</label>
                        <div class="right-inner-addon ">
                        <i class="glyphicon glyphicon-calendar"></i>
                        <input class="form-control datepicker"  readonly="readonly" placeholder="" type="text" name="date" id="date" value="{{date('d-M-Y')}}">
                        </div>
          </div>





        
        <div class="form-group">
            <label for="username">Description</label>
            <textarea name="description" id="description" class="form-control"> </textarea>
        </div>

        <div class="form-group">
            <label for="username">Amount</label>
            <input class="form-control" placeholder="" type="text" name="amount" id="amount" value="{{{ Input::old('amount') }}}">
        </div>

        <div class="form-group">
            <label for="username">Debit Account</label>
            <select class="form-control" name="debit_account">

                <option></option>
                @foreach($accounts as $account)
                <option value="{{ $account->id }}">{{ $account->name."(".$account->code.")" }}</option>
                @endforeach


            </select>
        </div>

        <div class="form-group">
            <label for="username">Credit Account</label>
            <select class="form-control" name="credit_account">

                <option></option>
                @foreach($accounts as $account)
                <option value="{{ $account->id }}">{{ $account->name."(".$account->code.")" }}</option>
                @endforeach


            </select>
        </div>
        

        
        
        <input type="hidden" name="user" value="{{ Auth::user()->name }}">






        
      
        
        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Submit Entry</button>
        </div>

    </fieldset>
</form>
		

  </div>

</div>

</div>

</div>
























@stop