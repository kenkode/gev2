<div class="modal fade" id="update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        <h5><label style="margin: 0 auto">Current Stock: 35</label></h5>
        <div class="form-group">
          <label>Supplier:</label>
          <select class="form-control select2" style="width: 100%;">
            <option selected="selected">Alabama</option>
            <option>Alaska</option>
            <option disabled="disabled">California (disabled)</option>
            <option>Delaware</option>
            <option>Tennessee</option>
            <option>Texas</option>
            <option>Washington</option>
          </select>
        </div>
        <div class="form-group">
          <label>Stock Level(quantity):</label>
          <div class="input-group">
            <div class="input-group-addon">
              <i class="fa fa-database"></i>
            </div>
            <input type="text" class="form-control pull-right" id="reservationtime">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="supplier_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="row">
    <div class="col-md-4">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">Supplier</h3>
          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
            </button>
            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
          </div>
        </div>
        <div class="box-body">
          <div class="form-group">
            <label>Name:</label>
            <div class="input-group">
              <div class="input-group-addon">
                <i class="fa fa-database"></i>
              </div>
              <input type="text" class="form-control pull-right" id="reservationtime">
            </div>
          </div>
          <div class="form-group">
            <label>Type:</label>
            <select class="form-control select2" style="width: 100%;">
              <option selected="selected">Alabama</option>
              <option>Alaska</option>
              <option disabled="disabled">California (disabled)</option>
              <option>Delaware</option>
              <option>Tennessee</option>
              <option>Texas</option>
              <option>Washington</option>
            </select>
          </div>
          <button type="button" class="btn btn-primary btn-block">Submit</button>
          <div class="box-footer">
            <form action="#" method="post">
              <div class="input-group">
                <input type="text" name="message" placeholder="Add Gas Type" class="form-control">
                    <span class="input-group-btn">
                      <button type="submit" class="btn btn-primary btn-flat">Add</button>
                    </span>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
