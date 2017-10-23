
{{HTML::script('media/jquery-1.8.0.min.js') }}
<?php
function asMoney($value) {
  return number_format($value, 2);
}
?>

 {{ HTML::style('jquery-ui-1.11.4.custom/jquery-ui.css') }}
{{ HTML::script('jquery-ui-1.11.4.custom/jquery-ui.js') }}

<script type="text/javascript">
$(document).ready(function(){
$('#credit').hide();

$('#category').change(function(){
if($(this).val() == "CREDIT"){
    $('#credit').show();
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

@extends('template')
@section('content')


<div class="row">
  <div class="col-lg-6">
    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">New Client</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

    <font color="red"><i>All fields marked with * are mandatory</i></font>
    
     @if ( count( $errors ) > 0 )
        <div class="alert alert-danger">
            @foreach ($errors->all() as $error)
                {{ $error }}<br>        
            @endforeach
        </div>
        @endif

     <form method="POST" action="{{{ URL::to('clients') }}}" accept-charset="UTF-8">
   
     {{ csrf_field() }}
    <fieldset>
        <div class="form-group">
            <label for="username">Client Name <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="name" id="name" value="{{{ old('name') }}}" required>
        </div>

        <div class="form-group">
            <label for="username">Account Category</label>
            <select class="form-control select2" name="category1" id="category">
                <option value="">select category</option>
                <option>--------------------------</option>
                <option value="CREDIT">CREDIT</option>
                <option value="CASH">CASH</option>
            </select>            
        </div>

        <div class="form-group" id="credit">
            <label for="username">Credit Period :</label>
            <input class="form-control" placeholder="" type="text" name="credit" id="credit" value="{{{ old('credit') }}}">
        </div>

         <div class="form-group">
            <label for="username">Email:</label>
            <input class="form-control" placeholder="" type="email" name="email_office" id="email_office" value="{{{old('email_office') }}}" >
        </div>

        <div class="form-group">
            <label for="username">Phone:</label>
            <input class="form-control" placeholder="" type="text" name="office_phone" id="office_phone" value="{{{ old('office_phone') }}}">
        </div>

        <div class="form-group">
            <label for="username">Address:</label>
            <input class="form-control" placeholder="" type="text" name="address" id="address" value="{{{ old('email_personal') }}}">
        </div>

        <div class="form-group">
            <label for="username">Contact Name :</label>
            <input class="form-control" placeholder="" type="text" name="cname" id="cname" value="{{{ old('cname') }}}">
        </div>
        
        <div class="form-group">
            <label for="username">Contact Personal Email:</label>
            <input class="form-control" placeholder="" type="email" name="email_personal" id="email_personal" value="{{{ old('email_personal') }}}">
        </div>

        <div class="form-group">
            <label for="username">Personal Mobile:</label><span style="color:red">*</span>
            <input class="form-control" placeholder="" type="text" name="mobile_phone" id="mobile_phone" value="{{{ old('address') }}}" required>
        </div>

        <!-- <div class="form-group">
          <label for="username">Type</label><span style="color:red">*</span> :
           <select name="type" class="form-control" required>
                           <option></option>
                            <option value="Customer"> Customer</option>
                            <option value="Supplier"> Supplier</option>
                        </select>
        </div> -->

        <label for="username">Client Type:</label><span style="color:red">*</span>

        <div class="radio">
          <label>
              <input type="radio" name="type" id="customer" value="Customer">
                    Customer
              </label>
              <br>
              <p>              

        </div>

        <div class="radio">
          <label>
              <input type="radio" name="type" id="supplier" value="Supplier">
                    Supplier
              </label>
              <br>
              <p>              

        </div>
        
        <div class="form-group">
            <label>Category</label>
            <select name="category" class="form-control select2">
                <option value="">----Select a category----</option>
                <option value="Institutional">Institutional</option>
                <option value="Domestic">Domestic</option>
            </select>
        </div>

         <script type="text/javascript">
            $(document).ready(function(){
            /*$("#purchase_price").hide();*/            
            $('#customer').click(function(){

            if($('#customer').is(":checked")){
            $('#customer:checked').each(function(){
            
            $("#percentage_discount").show();                       

            });
            }else{

              $("#percentage_discount").hide();
             
            }
            });



                        
            $('#supplier').click(function(){
            $("#percentage_discount").hide();
            if($('#supplier').is(":checked")){
            $('#supplier:checked').each(function(){
            $("#percentage_discount").hide();
                          

            });
            }else{

              $("#percentage_discount").show();
            }
            });
            
            });
          </script>

        <!-- <div class="form-group" id="percentage_discount">
        <div class="form-group">
            <label for="username">Percentage Discount(e.g. 5):</label>
            <input class="form-control" placeholder="" type="text" name="percentage_discount" id="percentage_discount" value="{{{ old('percentage_discount') }}}">
        </div>
        </div> -->
        <div class="form-group">
            <label for="username">Balance Brought Forward :</label>
            <div class="input-group">
                <span class="input-group-addon">KES</span>
                <input class="form-control" placeholder="{{ asMoney(0) }}" type="text" name="balance" id="balance" value="{{{ old('balance') }}}">
            </div>
        </div>
        
        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Create Client</button>
        </div>

    </fieldset>
</form>
    

  </div>

</div>
</div>
</div>


@stop