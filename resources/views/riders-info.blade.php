<!-- Info boxes -->
<div class="row">
  <div class="col-md-4 col-md-offset-4  col-sm-6 col-xs-12">
    <div class="box box-default">
      <div class="box-header with-border">
        <h3 class="box-title">Total Riders : {{ count($riders) }}</h3>
        <div class="box-tools pull-right">
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
          </button>
        </div>
      </div>
      <div class="box-body">
          <div class="btn-group">
            <a href="{{ route('add_rider') }}" class="btn btn-default">Add Rider</a>
            <a href="{{ route('home') }}" class="btn btn-default">View Riders</a>
          </div>
      </div>
    </div>
  </div>
  <div class="clearfix visible-sm-block"></div>
</div>
