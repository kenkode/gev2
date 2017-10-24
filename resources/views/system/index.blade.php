@extends('system')
@section('content')

<?php
use App\Http\Models\Organization;
$organization = Organization::find(1);
?>


<div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">System Version</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">
<div class="row">
	
	

<div class="col-lg-3">

<img src="{{asset('public/uploads/logo/'.$organization->logo)}}" alt="logo" width="50%">

</div>	


<div class="col-lg-6 ">


	<table class="table table-bordered table-condensed">

												  				<tr>

																	<td>System</td><td>XARAFinancials </td>
																</tr>
																<tr>

																	<td>Version</td><td>v3.3.10</td>
																</tr>

																<tr>

																	<td>Licensed To</td><td>{{Organization::getOrganizationName()}}</td>
																</tr>
																

																
																

															</table>



</div>	



</div>

</div>	



</div>


@stop