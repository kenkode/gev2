<!-- 0 Gases -->
<!-- 1 Services -->
<!-- 2 Accessories -->

<div class="modal fade" id="update_modal" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Stock Level</h4>
      </div>
      <div class="modal-body">
        <h5><label style="margin: 0 auto">Current Stock: <span id="current_stock_text"></span><i class="fa fa-refresh fa-spin" id="current_stock_spinner"></i></label></h5>
        <div class="form-group">
          <label>Supplier:</label>
          <select class="form-control select2" style="width: 100%;" id="supplier_list" required="required">
          </select>
        </div>
        <div class="form-group" id="stockLevelInput">
          <label>Stock Level(quantity):</label>
          <div class="input-group">
            <div class="input-group-addon">
              <i class="fa fa-database"></i>
            </div>
            <input type="text" class="form-control pull-right" id="stockLevel">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="submit_stock_update">Submit</button>
      </div>
    </div>
  </div>
</div>
