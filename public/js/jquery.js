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
    var item_type = $('#supplierFormType option:selected').data('type');
    var itemName = $('#supplierFormType option:selected').text();

    $.ajax({
      url: supplierRedirect,
      type: 'post',
      data: {
        id : supplier_id,
        supplier : supplier,
        type: item,
        item_type: item_type
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

  $("#update-gas").click(function () {
    var type = $("#gas_type_input").val();

    if(type == '') {
      $(this).parentsUntil('div.box-footer').addClass('has-error');
      return;
    }else {
      $(this).parentsUntil('div.box-footer').removeClass('has-error');
    }

    if (type.length > 0) {
      $.ajax({
        url: "/add_gas_type",
        type: "post",
        data: {
          'type': type
        },
        success: function (data) {
          $.notify({
            icon: 'pe-7s-check',
            message: "Successfully added " + type
          }, {
            type: 'success',
            timer: 1000
          });
          $("select#gas_types").append("<option value=" + data + ">" + type + "</option>");
          $("#gas_type_input").val("");
        }
      });
    } else {
      $.notify({
        icon: 'pe-7s-attention',
        message: "Invalid input detected."

      }, {
        type: 'warning',
        timer: 1000
      });
    }
  });

  $("#add-gas").click(function () {
    var type = $("select#gas_types option:selected").val();
    var name = $("select#gas_types option:selected").text();
    var size = $("#gas_size").val();
    var price = $("#gas_price").val();

    if (size.length < 1 || price.length < 1) {
      $.notify({
        icon: 'pe-7s-attention',
        message: "Invalid input detected."

      }, {
        type: 'warning',
        timer: 1000
      });
    } else {
      $.ajax({
        url: "/add_gas",
        type: "post",
        data: {
          'type': type,
          'size': size,
          'price': price
        },
        success: function (data) {
          if (data == "E") {
            $.notify({
              icon: 'pe-7s-attention',
              message: "Gas already added."

            }, {
              type: 'warning',
              timer: 1000
            });
          } else {
            $.notify({
              icon: 'pe-7s-check',
              message: "Successfully added."

            }, {
              type: 'success',
              timer: 1000
            });
          }

          $("#gas_size").val("");
          $("#gas_price").val("");
        }
      });
    }
  });

  $("button#add_product").click(function () {
    var type = $("select#product_type").val();
    var name = $("input#prd_name").val();
    var price = $("input#prd_price").val();

    if (name.length < 1 || (price.length < 1 && type == 1)) {
      $.notify({
        icon: 'pe-7s-attention',
        message: "Fill in required details"

      }, {
        type: 'warning',
        timer: 1000
      });
    } else {
      $.ajax({
        url: "/add_product",
        type: "post",
        data: {
          'type': type,
          'name': name,
          'price': price
        },
        success: function (data) {
          $.notify({
            icon: 'pe-7s-check',
            message: "Successfully added " + name
          }, {
            type: 'success',
            timer: 1000
          });
          $("input#prd_name").val("");
          $("input#prd_price").val("");
        }
      });
    }
  });

  $("button#add_bulk").click(function () {
    var price = $("input#add_bulk_price").val();

    if (price.length < 1) {
      $.notify({
        icon: 'pe-7s-attention',
        message: "Fill in required details"

      }, {
        type: 'warning',
        timer: 1000
      });
      return;
    }

    if (price.length < 1) {
      $.notify({
        icon: 'pe-7s-attention',
        message: "Fill in required details"

      }, {
        type: 'warning',
        timer: 1000
      });
    } else {
      $.ajax({
        url: "/add_bulkgas",
        type: "post",
        data: {
          price: price
        },
        success: function (data) {
          $.notify({
            icon: 'pe-7s-check',
            message: "Updated to " + data
          }, {
            type: 'success',
            timer: 1000
          });
          $("input#add_bulk_price").val("");
          $("span#price").text(data);
        }
      });
    }


  });

});
