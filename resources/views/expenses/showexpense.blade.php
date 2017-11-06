@extends('accounting')
@section('content')

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
        <h3 class="box-title">Approve Expense</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

         <form method="POST" action="{{{ URL::to('notificationapproveexpense') }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>
        <div class="form-group">
            <label for="username">Expense Name <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="name" id="name" value="{{ $name }}" required>
        </div>

        <div class="form-group">
            <label for="username">Amount <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="amount" id="amount" value="{{$amount}}" required>
        </div>

       <div class="form-group">
            <label for="username">Type <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="type" id="type" value="{{$type}}" required>
        </div>

        <div class="form-group">
            <label for="username">Account <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="acc" id="acc" value="{{$acc->name}}" required>
        </div>

         <div class="form-group">
            <label for="username">Date <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="date" id="date" value="{{$date}}" required>
        </div>


        <input class="form-control" placeholder="" type="hidden" name="account" id="account" value="{{$account}}" required>
        <input class="form-control" placeholder="" type="hidden" name="receiver" id="receiver" value="{{$receiver}}" required>
        <input class="form-control" placeholder="" type="hidden" name="confirmer" id="confirmer" value="{{$confirmer}}" required>
        <input class="form-control" placeholder="" type="hidden" name="key" id="key" value="{{$key}}" required>

        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Approve Expense</button>
        </div>

    </fieldset>
</form>
        

  </div>

</div>

@stop