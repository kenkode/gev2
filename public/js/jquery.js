$(document).ready(function() {

  $.ajaxSetup({
      headers: {
          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
      }
  });
  var supplierRedirect = '';
  var supplier_id = '';
  var parentTr = '';
/*
Ajax Setup
*/

  $('#noc').hide();

  $('#submitSupplierForm').click(function() {
    var supplier = $('#supplierFormName').val();
    var item = $('#supplierFormType option:selected').val();
    var itemName = $('#supplierFormType option:selected').text();

    $.ajax({
      url: supplierRedirect,
      type: 'post',
      data: {
        id : supplier_id,
        supplier : supplier,
        type: item
      },
      success: function(data) {
        if(supplierRedirect == '/add_supplier') {
          $('table#supplier_table tbody').prepend('<tr><td>'+ data +'</td><td>'+ supplier +'</td><td>'+ itemName +'</td><td><div class="btn-group"><button type="button" class="btn btn-default">Edit</button><button type="button" class="btn btn-default">Delete</button></div></td></tr>');
        }else {
          parentTr.children('tr td:nth(1)').text(supplier);
          parentTr.children('tr td:nth(2)').text(data);
          parentTr.children('tr td:nth(3) button.edit_supplier').data('item', item);

        }
        $('#supplier_modal').modal('hide');
      },
      error: function(data) {
        console.log(data);
      }
    });

  });

  $('#add_supplier').click(function() {
    supplierRedirect = '/add_supplier';
    $('#supplier_modal').modal();
  });

  $('.edit_supplier').click(function(e) {
    e.preventDefault();
    supplierRedirect = '/edit_supplier';
    var parent = $(this).parentsUntil('tbody');
    parentTr = parent;
    var id = parent.children('tr td:nth(0)').text();
    var name = parent.children('tr td:nth(1)').text();
    var item = $(this).data('item');

    supplier_id = id;

    $('#supplierFormName').val(name);
    $('#supplierFormType').val(item);
    $('#supplier_modal').modal();
  });

  $('.delete_supplier').click(function(e) {
    var supplier = $(this).data('supplier');

    var parent = $(this).parentsUntil('tbody');

    $.ajax({
      url: '/delete_supplier',
      type: 'post',
      data: {
        supplier : supplier
      },
      success: function(data) {
        parent.hide();
      },
      error: function(data) {
        console.log(data);
      }
    });
  });

});
