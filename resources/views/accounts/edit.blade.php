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
        <h3 class="box-title">Update Accounts</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

       

		 <form method="POST" action="{{{ URL::to('accounts/update/'.$account->id) }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>

         <div class="form-group">
            <label for="username">Account Category</label>
            <select class="form-control" name="category">
                <option value="{{$account->category}}">{{$account->category}}</option>
                <option>--------------------------</option>
                <option value="ASSET">Asset</option>
                <option value="INCOME">Income</option>
                <option value="EXPENSE">Expense</option>
                <option value="EQUITY">Equity</option>
                <option value="LIABILITY">Liability</option>
            </select>
            
        </div>



        <div class="form-group">
            <label for="username">Account Name</label>
            <input class="form-control" placeholder="" type="text" name="name" id="name" value="{{$account->name}}">
        </div>


        <div class="form-group">
            <label for="username">GL Code</label>
            <input class="form-control" placeholder="" type="text" name="code" id="code" value="{{$account->code}}">
        </div>

        <div class="form-group">
            <label for="username">Account Balance</label>
            <input class="form-control" placeholder="" type="text" name="balance" id="balance" value="{{$account->balance}}">
        </div>
        

        <div class="form-group">
            <label for="username">Active</label>&nbsp;&nbsp;
            @if($account->active)
            <input   type="checkbox" name="active" id="active" value="1" checked>
            @endif

            @if(!$account->active)
            <input   type="checkbox" name="active" id="active" value="1">
            @endif

        </div>
        
        

        







        
      
        
        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Update Account</button>
        </div>

    </fieldset>
</form>
	</div>

</div>	

  </div>

</div>
























@stop