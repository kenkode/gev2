@extends('accounting')
@section('content')

<!--
	BEGINNING OF PAGE
-->


<div class="row">
	<div class="col-lg-6">
		<div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Select Options</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">
		<form target="_blank" action="{{ URL::to('bankReconciliartion/generateReport') }}" method="POST" accept-charset="utf-8">
			{{ csrf_field() }}
			<div class="form-group">
				<label>Bank Account:</label>
				<select name="bank_account" class="form-control" required>
					<option value="">--- Select Bank Account ---</option>
					@foreach($bankAccounts as $bnkAcnt)
						<option value="{{ $bnkAcnt->id }}">{{ $bnkAcnt->account_name }} - {{ $bnkAcnt->bank_name }}</option>
					@endforeach
				</select>
			</div>
			<div class="form-group">
				<label>Reconciled Against:</label>
				<select name="book_account" class="form-control" required>
					<option value="">--- Recociled against ---</option>
					@foreach($bookAccounts as $bkAcnt)
						<option value="{{ $bkAcnt->id }}">{{ $bkAcnt->category }} - {{ $bkAcnt->name }}</option>
					@endforeach
				</select>
			</div>
			<div class="form-group">
				<label for="username">Reconciliation Month:</label>
            <div class="right-inner-addon ">
            	<i class="glyphicon glyphicon-calendar"></i>
            	<input class="form-control input-sm datepicker2"  readonly="readonly" type="text" name="rec_month" id="date" value="{{date('M-Y')}}">
            </div>
			</div>
			<div class="form-group">
				<input type="submit" name="btnRecSubmit" class="btn btn-primary btn-sm" value="Generate">
			</div>
		</form>
	</div>
</div>
</div>
</div>

@stop