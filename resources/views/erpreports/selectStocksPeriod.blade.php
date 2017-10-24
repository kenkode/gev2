@extends('report')
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
        <h4>Select Period</h4>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

		 <form method="POST" action="{{URL::to('erpReports/stocks')}}" accept-charset="UTF-8" target="_blank">
   {{ csrf_field() }}
    <fieldset>

        <div class="form-group">
                        <label for="username">From<span style="color:red">*</span></label>
                        <div class="right-inner-addon ">
                        <i class="glyphicon glyphicon-calendar"></i>
                        <input required class="form-control datepicker21" readonly="readonly" placeholder="" type="text" name="from" id="from" value="{{{ Input::old('from') }}}">
                    </div>
       </div>

       <div class="form-group">
                        <label for="username">To <span style="color:red">*</span></label>
                        <div class="right-inner-addon ">
                        <i class="glyphicon glyphicon-calendar"></i>
                        <input required class="form-control datepicker21" readonly="readonly" placeholder="" type="text" name="to" id="to" value="{{{ Input::old('to') }}}">
                    </div>
       </div>
        
      
       
     

        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm" >Select</button>
        </div>

    </fieldset>
</form>
		

  </div>

</div>

</div>

</div>


@stop