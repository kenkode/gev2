<?php


function asMoney($value) {
  return number_format($value, 2);
}

?>

@extends('system')
@section('content')


<div class="row">
  <div class="col-lg-12">
   
    @if (Session::has('flash_message'))

      <div class="alert alert-success">
      {{ Session::get('flash_message') }}
     </div>
    @endif

    @if (Session::has('delete_message'))

      <div class="alert alert-danger">
      {{ Session::get('delete_message') }}
     </div>
    @endif

   
   <div class="row">

<div class="col-lg-12">
  <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title"><h3>{{$role->name}}</h3></h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">
        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

        <?php $i = 1; ?>
            @foreach($categories as $category)
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="{{$i}}">
      <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#" aria-expanded="true" aria-controls="collapseOne">
         Manage {{$category->category}}
        </a>
      </h4>
    </div>

    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">

        <table class="table table-condensed">

          <tr>
          <?php $count = 0; ?>
            @foreach($permissions as $perm)
              @if($perm->category == $category->category)


         

            <td>

              @if(in_array($perm->name, $roleperm))
              <input type="checkbox" name="permission[]" value="{{ $perm->id }}" checked="checked" readonly> {{$perm->display_name}}
              @else
              <input type="checkbox" name="permission[]" value="{{ $perm->id }}" readonly> {{$perm->display_name}}
               @endif

            </td>

         


          @endif

          <?php $i++; ?>
        @endforeach


          </tr>

        </table>
        

      </div>
    </div>
  </div>

  @endforeach


  
</div>

</div>
 
</div>

</div>

@stop