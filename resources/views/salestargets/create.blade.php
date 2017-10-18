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
        <h3 class="box-title">New Sales Target</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">
<font color="red"><i>All fields marked with * are mandatory</i></font>

		 <form method="POST" action="{{{ URL::to('salestargets') }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>

        <div class="form-group">
            <label for="username">Month:<span style="color:red">*</span> :</label>
            <div class="right-inner-addon ">
            <i class="glyphicon glyphicon-calendar"></i>
            <input class="form-control datepicker23" placeholder="" type="text" name="month" id="month" value="{{{ old('month') }}}" required readonly="readonly">
            </div>
        </div>

        <div class="form-group">
            <label for="username">Target Amount:<span style="color:red">*</span> :</label></label>
            <input class="form-control" placeholder="" type="text" name="target_amount" id="target_amount" value="{{{ old('target_amount') }}}" required>
        </div>

         <div class="form-group">
                        <label for="username">Date</label>
                        <div class="right-inner-addon ">
                        <i class="glyphicon glyphicon-calendar"></i>
                        <input class="form-control datepicker"  readonly="readonly" placeholder="" type="text" name="date" id="date" value="{{date('Y-M-d')}}">
                        </div>
          </div>


        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Set Target</button>
        </div>

    </fieldset>
</form>
		
</div>
</div>
  </div>

</div>

@stop