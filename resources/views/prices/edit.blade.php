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
        <h3 class="box-title">Update Client Discount</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

		 <form method="POST" action="{{{ URL::to('prices/update/'.$price->id) }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>
        <div class="form-group">
            <label for="username">Client Name <span style="color:red">*</span> :</label>
            <select name="client" id="client" class="form-control select2" required>                
                <option>       ......................... select Client........................</option>
                @foreach($clients as $client)
                @if($client->type == 'Customer')                    
                    <option value="{{$client->id}}"<?=($price->client_id==$client->id)?'selected="selected"':''; ?>>{{$client->name}}</option>           
                @endif
                @endforeach
            </select>
        </div>

         <div class="form-group ">
            <label>Item</label><span style="color:red">*</span> :
            <select name="item" id="item" class="form-control select2" required>                       
            <option>       ......................... select item........................</option>
                @foreach($items as $item)
                
                    <option value="{{$item->id}}"<?=($price->Item_id==$item->id)?'selected="selected"':''; ?>>{{$item->item_make}}</option>
                    
                @endforeach
            </select>
        </div>

        
        <div class="form-group">
            <label for="username">Selling Price:</label>
            <input class="form-control" placeholder="" type="text" name="selling_price" id="selling_price" value="{{$price::sprice($price->Item_id)}}" readonly>
        </div>

        <div class="form-group">
            <label for="username">Discount:</label>
            <input class="form-control" placeholder="" type="text" name="discount" id="discount" value="{{$price->Discount}}">
        </div>

        <!-- <div class="form-group">
            <label for="username">Customer Price:</label>
            <input class="form-control" placeholder="" type="text" name="customer_price" id="customer_price" value="">
        </div> -->
        
        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Update Client</button>
        </div>

    </fieldset>
</form>
		

  </div>

</div>

@stop