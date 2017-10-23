@extends('accounting')
@section('content')

<!--
BEGINNING OF PAGE
-->

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
        <h3 class="box-title">Add Missing Transactions and Reconcile</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">
		<form action="{{ URL::to('bankAccount/reconcile/add/') }}" method="POST">
			{{ csrf_field() }}
			<input type="hidden" name="bnk_trans_id" value="{{ $bnk_trans_id }}">
			<input type="hidden" name="bnk_stmt_id" value="{{ $bnk_stmt_id }}">
			<input type="hidden" name="ac_stmt_id" value="{{ $bookStmtID }}">
			<div class="form-group">
				<label>Transaction Description:</label>
				<textarea name="t_desc" class="form-control" required></textarea>
			</div>
			<div class="form-group">
				<label>Account Credited</label>
				<select name="ac_credited" class="form-control" required>
					<option value="">--- Account Credited ---</option>
					@foreach($accounts as $account)
						<option value="{{ $account->id }}">({{ $account->category }}) - {{ $account->name }}</option>
					@endforeach
				</select>
			</div>
			<div class="form-group">
				<label>Account Debited</label>
				<select name="ac_debited" class="form-control" required>
					<option value="">--- Account Debited ---</option>
					@foreach($accounts as $account)
						<option value="{{ $account->id }}">({{ $account->category }}) - {{ $account->name }}</option>
					@endforeach
				</select>
			</div>
			<div class="form-group">
				<label>Transaction Amount</label>
				<div class="input-group">
					<span class="input-group-addon">KES</span>
					<input type="text" class="form-control" name="t_amount" placeholder="Transaction amount">
				</div>
			</div>
			<div class="form-group pull-right">
				<input type="submit" class="btn btn-primary" name="btnAddTrans" value="Add & Reconcile">
			</div>
		</form>
	</div>
</div>
</div>
</div>

@stop