@extends('template')

@section('content')

<div class="row" style="padding: 12px">
  <div class="col-md-offset-4 col-md-3">
    <select class="select2 form-control" id="order_search">
      <option value="AL">Search Rider by Name</option>
      @foreach($riders as $rider)
        <option value="{{ $rider['id'] }}">{{ $rider['name'] }}</option>
      @endforeach
    </select>
  </div>
</div>

<div class="row">

  @foreach($riders as $rider)
    <div class="col-md-3 col-sm-6 col-xs-12">
      <div class="info-box">
        <span class="info-box-icon bg-blue"><i class="fa fa-user"></i></span>
        <div class="info-box-content">
          <span class="info-box-text"><a href="rider/{{ $rider['id'] }}">{{ $rider['name'] }}</a></span>
          <span class="info-box-text">{{ $rider['email'] }}</span>
          <span class="info-box-text">{{ $rider['ride'] }}</span>
        </div>
        <!-- /.info-box-content -->
      </div>
      <!-- /.info-box -->
    </div>
  @endforeach

</div>



<div class="clearfix"></div>

@endsection
