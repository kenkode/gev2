{{HTML::script('media/jquery-1.8.0.min.js') }}
@extends('template')
<script type="text/javascript">
$(document).ready(function() {
  
    $('#item').change(function(){
      
        $.get("{{ url('api/getsellingprice')}}", 
        { option: $(this).val() }, 
        function(data) {
            /*console.log('hi');*/
                $('#selling_price').val(data);
            });
        });
   });
</script>
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
        <h3 class="box-title">Approve Client Discount Update</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

		 <form method="POST" action="{{{ URL::to('notificationapprovepriceupdate') }}}" accept-charset="UTF-8">
     {{ csrf_field() }}
         <input type="hidden" name="id" value="{{$id}}">
         <input type="hidden" name="key" value="{{$key}}">
         <input type="hidden" name="confirmer" value="{{$confirmer}}">
         <input type="hidden" name="receiver" value="{{$receiver}}">
         <input type="hidden" name="client" value="{{$client}}">
         <input type="hidden" name="item" value="{{$item}}">
   
    <fieldset>
        <div class="form-group">
            <label for="username">Client:</label>
            <input class="form-control" placeholder="" type="text" name="clientname" id="selling_price" value="{{$clientname}}" readonly>
        </div>

         <div class="form-group">
            <label for="username">Item</label>
            <input class="form-control" placeholder="" type="text" name="itemname" id="itemname" value="{{$itemmake}}" readonly>
        </div>

        
        <div class="form-group">
            <label for="username">Selling Price:</label>
            <input class="form-control" placeholder="" type="text" name="selling_price" id="selling_price" value="{{App\Http\Models\Price::sprice($item)}}" readonly>
        </div>

        <div class="form-group">
            <label for="username">Discount:</label>
            <input class="form-control" placeholder="" readonly type="text" name="discount" id="discount" value="{{$discount}}">
        </div>

        <!-- <div class="form-group">
            <label for="username">Customer Price:</label>
            <input class="form-control" placeholder="" type="text" name="customer_price" id="customer_price" value="">
        </div> -->
        
        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-success btn-sm">Approve Update</button>
        </div>

    </fieldset>
</form>
		</div>
  </div>

  </div>

</div>

@stop