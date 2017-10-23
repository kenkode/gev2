@extends('system')
@section('content')




<div class="row">

	<div class="col-lg-12">

		<div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">System Roles</h3>
        <div class="box-tools pull-right">
          <a class="btn btn-info btn-sm" href="{{ URL::to('roles/create')}}">new role</a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">

				<table id="users" class="display compact table table-bordered table-striped" cellspacing="0" width="100%">
					<thead>
						
						
						<th>Role</th>
						<th></th>
						
					</thead>
					<tbody>
              			 @foreach($roles as $role)
              			 <tr>
               			
               			<td>{{ $role->name }}</td>
               			
               			<td>

               				<div class="btn-group">
  								<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
    								Action <span class="caret"></span>
  								</button>
  				
  								<ul class="dropdown-menu" role="menu">
                    <li><a href="{{URL::to('roles/show/'.$role->id)}}">Permissions</a></li>
                    <li><a href="{{URL::to('roles/edit/'.$role->id)}}">Edit</a></li>

    								
    								<li><a href="{{URL::to('roles/delete/'.$role->id)}}" onclick="return (confirm('Are you sure you want to delete this user?'))">Delete</a></li>
  								</ul>
							</div>

               			</td>
               		</tr>
               			@endforeach

 
					</tbody>
				</table>
			</div>	
		</div>	
	</div>	
</div>  









@stop