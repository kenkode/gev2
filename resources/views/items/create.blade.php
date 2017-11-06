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
        <h3 class="box-title">Create Item</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

        <font color="red"><i>All fields marked with * are mandatory</i></font>

		 <form method="POST" action="{{{ URL::to('items') }}}" accept-charset="UTF-8">
            {{ csrf_field() }}
   
    <fieldset>
        <div class="form-group">
            <label for="username">Item Make <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="item_make" id="item_make" value="{{{ old('item_make') }}}" required>
        </div>
        <div class="form-group">
            <label for="username">Item Size (Kg) <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="item_size" id="item_size" value="{{{ old('item_size') }}}">
        </div>

         <div class="form-group">
            <label for="username">Description:</label>
            <textarea rows="5" class="form-control" name="description" id="description" >{{ old('email_office') }}</textarea>
        </div>

        <div class="form-group">
            <label for="username">Purchase Price <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="pprice" id="pprice" value="{{{ old('pprice') }}}" required>
        </div>

        <div class="form-group">
            <label for="username">Selling price <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="sprice" id="sprice" value="{{{ old('sprice') }}}" required>
        </div>

        <div class="form-group">
            <label for="username">Store Keeping Unit:</label>
            <input class="form-control" placeholder="" type="text" name="sku" id="sku" value="{{{ old('sku') }}}">
        </div>

        <div class="form-group">
            <label for="username">Tag Id:</label>
            <input class="form-control" placeholder="" type="text" name="tag" id="tag" value="{{{ old('tag') }}}">
        </div>
        
        <div class="form-group">
            <label for="username">Reorder Level:</label>
            <input class="form-control" placeholder="" type="text" name="reorder" id="reorder" value="{{{ old('reorder') }}}">
        </div>

        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Create Item</button>
        </div>

    </fieldset>
</form>
		

  </div>

</div>

</div>

</div>

@stop