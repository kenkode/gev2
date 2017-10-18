@extends('template')
@section('content')

<div class="row">
	<div class="col-lg-5">

    
		
		@if ( count( $errors ) > 0 )
        <div class="alert alert-danger">
            @foreach ($errors->all() as $error)
                {{ $error }}<br>        
            @endforeach
        </div>
        @endif

         <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">New Tax</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">
<font color="red"><i>All fields marked with * are mandatory</i></font>


		 <form method="POST" action="{{{ URL::to('taxes') }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>

        <div class="form-group">
            <label for="username">Name (e.g. VAT):<span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="name" id="name" value="{{{ old('name') }}}" required>
        </div>

        <div class="form-group">
            <label for="username">Rate (% e.g. 5):<span style="color:red">*</span> :</label></label>
            <input class="form-control" placeholder="" type="text" name="rate" id="rate" value="{{{ old('rate') }}}" required>
        </div>


        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Create Tax</button>
        </div>

    </fieldset>
</form>
		</div>
    </div>

  </div>

</div>

@stop