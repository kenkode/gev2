@extends('system')
@section('content')


<div class="row">

	<div class="col-lg-6">

        <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Update Password</h3>
        <div class="box-tools pull-right">
          
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>

      <!-- /.box-header -->
      <div class="box-body">

           @if (Session::has('error'))
            <div class="alert alert-error alert-danger">
                
                    {{ Session::get('error') }}
               
            </div>
        @endif
        

		<form method="post" action="{{URL::to('users/password/'.$user->id)}}">
        {{ csrf_field() }}

        <div class="form-group">
            <label for="password">Old Password</label>
            <input class="form-control" placeholder="Old Password" type="password" name="oldpassword" id="oldpassword" required="">
        </div>

        <div class="form-group">
            <label for="password">New Password</label>
            <input class="form-control" placeholder="New Password" type="password" name="password" id="password" required="">
        </div>


        <div class="form-group">
            <label for="password_confirmation">Password Confirmation</label>
            <input class="form-control" placeholder="Password Confirmation" type="password" name="password_confirmation" id="password_confirmation" required="">
        </div>

         <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-info btn-sm">Update Password</button>
        </div>

        </form>

  </div>
</div>
</div>
</div>










@stop