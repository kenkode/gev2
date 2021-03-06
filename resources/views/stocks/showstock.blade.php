
{{HTML::script('media/jquery-1.8.0.min.js') }}
@extends('template')

<script type="text/javascript">
$(document).ready(function() {
  
    $('#item').change(function(){
      
        $.get("{{ url('api/getpurchased')}}", 
        { option: $(this).val() }, 
        function(data) {
            /*console.log('hi');*/
                $('#sup').val(data);
            });
        });
   });
</script>

 {{ HTML::style('jquery-ui-1.11.4.custom/jquery-ui.css') }}
 {{ HTML::script('jquery-ui-1.11.4.custom/jquery-ui.js') }}

<script type="text/javascript">
$(document).ready(function(){
$('#').hide();

$('#item').change(function(){
if($(this).val()){
    $('#').show();
}else if($(this).val() == "EXPENSE"){
    $('#expensecategory').show();
    $('#assetcategory').hide();
    $('#liabilitycategory').hide();
    $('#incomecategory').hide();
    $('#assetcat').val('');
    $('#liabilitycat').val('');
    $('#incomecat').val('');
}else if($(this).val() == "LIABILITY"){
    $('#liabilitycategory').show();
    $('#assetcategory').hide();
    $('#expensecategory').hide();
    $('#incomecategory').hide();
    $('#assetcat').val('');
    $('#expensecat').val('');
    $('#incomecat').val('');
}else if($(this).val() == "INCOME"){
    $('#incomecategory').show();
    $('#assetcategory').hide();
    $('#expensecategory').hide();
    $('#liabilitycategory').hide();
    $('#assetcat').val('');
    $('#expensecat').val('');
    $('#liabilitycat').val('');
}else{
    $('#assetcategory').hide();
    $('#expensecategory').hide();
    $('#liabilitycategory').hide(); 
    $('#incomecategory').hide(); 
    $('#assetcat').val('');
    $('#expensecat').val('');
    $('#liabilitycat').val('');
    $('#incomecat').val('');
}

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

        <div class="row">
    <div class="col-lg-12">

    
    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Confirm Stock</h3>
        <div class="box-tools pull-right">
          
           <a class="btn btn-info btn-sm" href="{{ URL::to('stocks/create')}}">Receive Stock </a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

         <form method="POST" action="{{{ URL::to('notificationconfirmstock') }}}" accept-charset="UTF-8">
            {{ csrf_field() }}
        <font color="red"><i>All fields marked with * are mandatory</i></font>

         <input type="hidden" name="id" value="{{$stock->id}}">
         <input type="hidden" name="erporder_id" value="{{$erporder_id}}">
         <input type="hidden" name="key" value="{{$key}}">
         <input type="hidden" name="confirmer" value="{{$confirmer}}">

   
    <fieldset>
        <div class="form-group">
            <label for="username">Client:</label>
            <input class="form-control" placeholder="" type="text" name="client" id="client" value="{{$client}}" readonly>
        </div>

        <div class="form-group">
            <label for="username">Order Number:</label>
            <input class="form-control" placeholder="" type="text" name="item" id="item" value="{{$erporder->order_number}}" readonly>
        </div>


        <div class="form-group">
            <label for="username">Item:</label>
            <input class="form-control" placeholder="" type="text" name="item" id="item" value="{{$item->item_make}}" readonly>
        </div>

        <div class="form-group">
            <label for="username">Location:</label>
            <input class="form-control" placeholder="" type="text" name="location" id="location" value="{{$stock->location->name}}" readonly>
        </div>

        
       <div class="form-group">
            <label for="username">Quantity:</label>
            <input class="form-control" placeholder="" type="text" name="quantity" id="quantity" value="{{$stock->quantity_in}}" readonly>
        </div>
        

        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-success btn-sm">Confirm Stock</button>
        </div>

    </fieldset>
</form>
        
</div>
</div>
  </div>

</div>

@stop