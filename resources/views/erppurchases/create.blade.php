@extends('template')
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
        <h3 class="box-title">New Purchase Order</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

		 <form method="POST" action="{{{ URL::to('erppurchases/create') }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>
        <font color="red"><i>All fields marked with * are mandatory</i></font>
        
         <div class="form-group">
            <label for="username">Order Number:</label>
            <input type="text" name="order_number" value="{{$order_number}}" class="form-control" readonly>
        </div>

        <div class="form-group">
                        <label for="username">Date</label>
                        <div class="right-inner-addon ">
                        <i class="glyphicon glyphicon-calendar"></i>
                        <input class="form-control datepicker"  readonly="readonly" placeholder="" type="text" name="date" id="date" value="{{date('Y-M-d')}}">
                        </div>
          </div>

          <div class="form-group">
            <label for="username">Supplier <span style="color:red">*</span> :</label>
            <select name="client" class="form-control select2" required>
                @foreach($clients as $client)
                @if($client->type == 'Supplier')
                    <option value="{{$client->id}}">{{$client->name}}</option>
                    @endif
                @endforeach
            </select>
        </div>


        <div class="form-group">
            <label for="username">Purchase Type <span style="color:red">*</span> :</label>
            <select name="payment_type" class="form-control select2" required>
                
                    <option value="cash">Cash</option>
                    <option value="credit">Credit</option>
                    
            </select>
        </div>

        

        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Create</button>
        </div>

    </fieldset>
</form>
		
</div>

</div>
  </div>

</div>

@stop