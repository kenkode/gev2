var previous;
var firstQuery = true;

(function() {
  setInterval(() => {
    queryServer();
  }, 3000);
})();

function queryServer() {

  if(!firstQuery) {
    $.ajax({
      url: '/get_updates',
      type: 'get',
      data: {
        previous: previous
      },
      success: function(data) {
        var results = JSON.parse(data);
        current = results['total'];
        if(current > previous) {
          var orders = results['orders'];

          $.each(orders, function(index, element) {
            var status;

            $('#live_order').addClass('box-warning');
            $('#nto').text(current - previous);
            $('#noc').show();
            // $('table#orders_container tbody').prepend(
            //   '<a class="col-md-4 col-lg-4 col-sm-6" href=/gas_express/order/' +  + '><div class="card order_container ' + status + '"><div class="header"><small class="title">Customer Name: <strong>' +  + '</strong></small><p class="category"><small>Order No.</small> ' + element.order_id + '</p><p class="category"><small>Order Type</small> '+ element.type +'</p><p class="category"><small>Price </small> '+ element.price +'</p><p class="category"><i class="pe-7s-map-marker"></i> Location: '+ element.location +'</p></div><div class="content"><div class="footer"><hr><div class="stats"><i class="pe-7s-clock"></i> Order made on ' +  + '</div></div></div></div></a>'
            //
            //   '<tr><td><a href="orders/'+ element.order_id +') }}">'+ element.order_id +'</a></td><td>{{ $order["type"]}}</td><td>'+ element.created_at +'</td><td><span class="label label-'+ type +'">'+ text +'</span></td><td>'+ 12 +'</td><td>'+ element.fname + ' ' + element.lname +'</td><td>{{ $order["phone"] }}</td></tr>';
          });

          // "<a class=col-md-4 col-lg-4 col-sm-6 href"+ element.id + "
          //   <div class=" + "card order_container " + status + ">" + "
          //     <div class=" + "header>" + "
          //       <h4 class=title><small>Customer Name.</small> " + element.fname + " " + element.lname + "</h4><p class=category><small>Order No.</small> " + element.order_id + "</p><small>Price </small> " + element.price + " </p><p class=category><i class=pe-7s-map-marker></i> Location: " + element.location + "</p></div><div class=content><div class=footer><hr><div class=stats><i class=pe-7s-clock></i> Order made on " + element.created_at + "</div></div></div></div></a>";
          //


          var message;

          var audio = new Audio('assets/sounds/notif.mp3');
          audio.play();

          // $.notify({
          //   icon: 'pe-7s-attention',
          //   message: "New order arrived"
          // }, {
          //   type: 'warning',
          //   timer: 40000
          // });
          previous = current;
        }
      }
    });
  }else {
    $.ajax({
      url: '/get_updates',
      type: 'get',
      success: function(data) {
        firstQuery = false;
        var results = JSON.parse(data);
        previous = results['total'];
      }
    });
  }

}
