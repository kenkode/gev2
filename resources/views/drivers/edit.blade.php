@extends('layouts.erp')
@section('content')

<br><div class="row">
	<div class="col-lg-12">
  <h4>Update Driver Details</h4>

<hr>
</div>	
</div>
<font color="red"><i>All fields marked with * are mandatory</i></font>

<div class="row">
	<div class="col-lg-5">

    
		
		 @if ($errors->has())
        <div class="alert alert-danger">
            @foreach ($errors->all() as $error)
                {{ $error }}<br>        
            @endforeach
        </div>
        @endif

		 <form method="POST" action="{{{ URL::to('drivers/update/'.$driver->id) }}}" accept-charset="UTF-8">
   
    <fieldset>
        <div class="form-group">
            <label for="username">Surname <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="surname" id="surname" value="{{$driver->surname}}" required>
        </div>
        <div class="form-group">
            <label for="username">First Name <span style="color:red">*</span> :</label>
            <input class="form-control" placeholder="" type="text" name="first_name" id="first_name" value="{{$driver->first_name}}" required>
        </div>
        <div class="form-group">
            <label for="username">Other Names:</label>
            <input class="form-control" placeholder="" type="text" name="other_names" id="other_names" value="{{$driver->other_names}}">
        </div>

         <div class="form-group">
            <label for="username">Contact:</label>
            <input class="form-control" placeholder="" type="text" name="contact" id="contact" value="{{$driver->contact}}">
        </div>

        <div class="form-group">
            <label for="username">Employee Number:</label>
            <input class="form-control" placeholder="" type="text" name="employee_no" id="employee_no" value="{{$driver->employee_no}}">
        </div>

        
        
        
        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-info btn-sm">Update Driver</button>
        </div>

    </fieldset>
</form>
		

  </div>

</div>

@stop