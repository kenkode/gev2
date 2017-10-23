@extends('system')
@section('content')

<br/>

<div class="row">

    @if (Session::has('success'))
            <div class="alert alert-error alert-success">
                
                    {{ Session::get('success') }}
               
            </div>
        @endif

	<div class="col-lg-6">

<div class="box">
      <div class="box-header with-border">
        <h3 class="box-title"><h3>Profile</h3></h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">
		<table class="table table-condensed table-bordered">

            <tr>
                <td>username</td><td>{{ $user->name}}</td>
            </tr>
            <tr>
                <td>email</td><td>{{ $user->email}}</td>
            </tr>
            <tr>
                <td>password</td><td><a class="btn btn-info btn-xs" href="{{URL::to('users/password/'.$user->id)}}">change</a></td>

            </tr>
            <tr>
                <td><a class="btn btn-info btn-xs" href="{{URL::to('users/edit/'.$user->id)}}">update</a></td>

            </tr>

        </table>
		

  </div>
</div>



</div>
</div>







@stop