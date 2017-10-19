@extends('template')
@section('content')
<br><br/>

@if (Session::get('notice'))
            <div class="alert alert-info">{{ Session::get('notice') }}</div>
        @endif


<div class="row">
                          
<div class="col-lg-2"></div>
  <div class="col-lg-2">

    

    <br><br>
    <img src="{{asset('images/ourlogo.png')}}">
    
  </div>


</div>

@stop