@extends('template')

@section('content')

<form action="{{ route('add_rider') }}" method="post">
{{ csrf_field() }}
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label for="">Rider Name</label>
          <input type="text" name="rider_name" class="form-control" required="required">
        </div>
        <div class="form-group">
          <label for="">Rider Email</label>
          <input type="text" name="rider_email" class="form-control" required="required">
        </div>
        <div class="form-group">
          <label for="">Rider Phone</label>
          <input type="text" name="rider_phone" class="form-control" required="required">
        </div>
        <div class="form-group">
          <label for="">National ID</label>
          <input type="text" name="rider_nat_id" class="form-control" required="required">
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label for="">Ride Name</label>
          <input type="text" name="ride_name" class="form-control" required="required">
        </div>
        <div class="form-group">
          <label for="">Registration Number</label>
          <input type="text" name="registration_number" class="form-control" required="required">
        </div>
        <div class="form-group">
          <label for="">Licence</label>
          <input type="text" name="licence" class="form-control" required="required">
        </div required="required">
      </div>
    </div>
    </div>
    <div class="row">
      <div class="col-md-2 col-md-offset-5">
          <button type="submit" class="btn btn-primary<">Add Rider</button>
      </div>
    </div>
  </div>

</form>

@endsection
