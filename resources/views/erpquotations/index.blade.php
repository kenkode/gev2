@extends('template')
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

    <div class="box">
      <div class="box-header with-border">
        <h3 class="box-title">Quotations</h3>
        <div class="box-tools pull-right">
         <a class="btn btn-info btn-sm" href="{{ URL::to('quotationorders/create')}}">New Quotation </a>
          <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
          </button>
      </div>
    </div>
      <!-- /.box-header -->
      <div class="box-body">
    
    <table id="users" class="table table-condensed table-bordered table-responsive table-hover">


      <thead>

        <th>#</th>
        <th>Client</th>
        <th>Quote #</th>
        <th>Date</th>
        <!-- <th>status</th> -->
        <th></th>

      </thead>
      <tbody>

        <?php $i = 1; ?>
        @foreach($quotations as $order)
        @if($order->type == 'quotations')
        <tr>

          <td> {{ $i }}</td>
          <td>{{ $order->client->name }}</td>
          <td>{{$order->order_number }}</td>
          <td>{{$order->date }}</td>
          <!-- <td>{{$order->status }}</td> -->
           
        
          <td>

                  <div class="btn-group">
                  <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Action <span class="caret"></span>
                  </button>
          
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="{{URL::to('erpquotations/show/'.$order->id)}}">View</a></li>
                   
                    <!-- <li><a href="{{URL::to('erpquotations/cancel/'.$order->id)}}"  onclick="return (confirm('Are you sure you want to cancel this quotation?'))">Cancel</a></li> -->
                    
                  </ul>
              </div>

                    </td>



        </tr>

        <?php $i++; ?>
        @endif
        @endforeach


      </tbody>


    </table>
  </div>


  </div>

</div>

</div>

</div>

@stop