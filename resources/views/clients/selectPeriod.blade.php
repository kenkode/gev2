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
    
    <script type="text/javascript">
      $(document).ready(function(){
        $("#date_today").datepicker("setDate", new Date());
      });
    </script>

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Select Period</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

    <form method="GET" action="{{URL::to('erpReports/clientstatement')}}" accept-charset="UTF-8" target="_blank">
        <input type="hidden" name="client_id" value="{{$id}}">
        <fieldset>

            <div class="form-group">
              <label for="username"> Date <span style="color:red">*</span></label>
              <div class="right-inner-addon ">
                <i class="glyphicon glyphicon-calendar"></i>
                <input required class="form-control datepicker21" readonly="readonly" placeholder="" type="text" name="date" id="date_today" value="{{date('Y-m-d')}}" required>
              </div>
            </div>

            <div class="form-group">
              <label for="username">From<span style="color:red">*</span></label>
              <div class="right-inner-addon ">
                <i class="glyphicon glyphicon-calendar"></i>
                <input required class="form-control datepicker21" readonly="readonly" placeholder="" type="text" name="from" id="from" value="{{{ old('from') }}}" required>
              </div>
            </div>

            <div class="form-group">
              <label for="username">To <span style="color:red">*</span></label>
              <div class="right-inner-addon ">
                <i class="glyphicon glyphicon-calendar"></i>
                <input required class="form-control datepicker21" readonly="readonly" placeholder="" type="text" name="to" id="to" value="{{{ old('to') }}}" required>
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