@extends('accounting')
@section('content')

<?php
	function asMoney($value) {
	  return number_format($value, 2);
	}
?>

<!--
BEGINNING OF PAGE
-->
<div class="row">

	<div class="col-lg-6">
		
		<!-- ERROR MESSAGES -->
	@if ( count( $errors ) > 0 )
    <div class="alert alert-danger">
        @foreach ($errors->all() as $error)
            {{ $error }}<br>        
        @endforeach
    </div>
    @endif

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Add Bank Account</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">
		

		<form action="{{ URL::to('bankAccounts') }}" method="POST">
			{{ csrf_field() }}
			<div class="form-group">
				<label>Bank Name:</label>
				<input class="form-control" type="text" name="bnkName" placeholder="Bank Name">
			</div>

			<div class="form-group">
				<label>Account Name:</label>
				<input class="form-control" type="text" name="acName" placeholder="Account Name">
			</div>

			<div class="form-group">
				<label>Account Number:</label>
				<input class="form-control" type="text" name="acNumber" placeholder="Account Number">
			</div>

			<div class="form-group text-right">
				<input class="btn btn-primary btn-sm" type="submit" name="bnkSbmt" value="Add Bank">
			</div>
		</form>
	</div>
</div>
</div>
</div>

@stop