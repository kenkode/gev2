@extends('system')
@section('content')



<div class="row">

	<div class="col-lg-6">

		<div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Edit User</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

      <form method="POST" action="{{{ URL::to('users/update/'.$user->id) }}}" accept-charset="UTF-8">
   {{ csrf_field() }}
    <fieldset>
        <div class="form-group">
            <label for="username">Username</label>
            <input class="form-control" placeholder="Username" type="text" name="username" id="username" value="{{ $user->name }}" required="">
        </div>
        <div class="form-group">
            <label for="email">Email Address <small>*</small></label>
            <input class="form-control" placeholder="Email Address" type="email" name="email" id="email" value="{{ $user->email }}" required="">
        </div>
        

        @if (Session::get('error'))
            <div class="alert alert-error alert-danger">
                @if (is_array(Session::get('error')))
                    {{ head(Session::get('error')) }}
                @endif
            </div>
        @endif

        @if (Session::get('notice'))
            <div class="alert">{{ Session::get('notice') }}</div>
        @endif

        







        
      
        
        <div class="form-actions form-group">
        
          <button type="submit" class="btn btn-primary btn-sm">Update User</button>
        </div>

    </fieldset>
</form>
		

  </div>
</div>
</div>
</div>









@stop