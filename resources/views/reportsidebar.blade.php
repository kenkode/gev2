<aside class="main-sidebar">

  <section class="sidebar">

    <div class="user-panel">
      <div class="pull-left image">
        <img src="{{ asset('public/dist/img/avatar.png') }}" class="img-circle" alt="User Image">
      </div>
      <div class="pull-left info">
        <p>{{ Auth::user()->name }}</p>
        <p><small>{{ Auth::user()->email }}</small></p>
      </div>
    </div>
    <!-- <form action="#" method="get" class="sidebar-form">
      <div class="input-group">
        <input type="text" name="q" class="form-control" placeholder="Search...">
            <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
              </button>
            </span>
      </div>
    </form> -->

    <ul class="sidebar-menu">
      <li class="header">NAVIGATION</li>
      <!-- @foreach($navigation as $navigation)
        <li class="@if($header == $navigation['name']){{'active'}}@else{{''}}@endif"><a href="{{ route($navigation['route']) }}"><i class="fa fa-link"></i> <span>{{ $navigation['name'] }}</span></a></li>
      @endforeach -->
     

      <li class="@if($header == 'Clients'){{'active'}}@else{{''}}@endif">
          <a href="{{ URL::to('erpReports/clients') }} " target="_blank"><i class="glyphicon glyphicon-file fa-fw"></i> Customers / Suppliers</a>
       </li>

                    <li class="@if($header == 'Sales'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/selectSalesPeriod') }}"><i class="glyphicon glyphicon-file fa-fw"></i> Sales</a>
                    </li>  

                    <li class="@if($header == 'Purchases'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/selectPurchasesPeriod') }}"><i class="glyphicon glyphicon-file fa-fw"></i> Purchases</a>
                    </li>  

                    <li class="@if($header == 'Items'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/selectItemsPeriod') }}"><i class="glyphicon glyphicon-file fa-fw"></i> Items</a>
                    </li>

                    <li class="@if($header == 'Expenses'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/selectExpensesPeriod') }}"><i class="glyphicon glyphicon-file fa-fw"></i> Expenses</a>
                    </li>

                    <li class="@if($header == 'Payment Methods'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/paymentmethods') }}" target="_blank"><i class="glyphicon glyphicon-file fa-fw"></i> Payment Methods</a>
                    </li>  

                    <li class="@if($header == 'Payments'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/payments') }}" target="_blank"><i class="glyphicon glyphicon-file fa-fw"></i> Payments</a>
                    </li>

                    <li class="@if($header == 'Stores'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/locations') }}" target="_blank"><i class="glyphicon glyphicon-file fa-fw"></i> Stores</a>
                    </li>  


                    <li class="@if($header == 'Stock'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/selectStockPeriod') }}" ><i class="glyphicon glyphicon-file fa-fw"></i> Stock Report</a>
                    </li>

                     <li class="@if($header == 'Sales Summary'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/sales_summary') }}" target="_blank"><i class="glyphicon glyphicon-file fa-fw"></i> Sales Summary</a>
                    </li>  

                    <li class="@if($header == 'Pricelist'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/pricelist') }}" target="_blank"><i class="glyphicon glyphicon-file fa-fw"></i> Pricelist</a>
                    </li>

                    <li class="@if($header == 'Account Balances'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('erpReports/accounts') }}" target="_blank"><i class="glyphicon glyphicon-file fa-fw"></i> Account Balances</a>
                    </li>      

                     <li class="@if($header == 'Financial Reports'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('financialreports') }}"><i class="glyphicon glyphicon-file fa-fw"></i> Financial Reports</a>
                    </li>

      <!-- <li class="@if($header == 'Mail Configuration'){{'active'}}@else{{''}}@endif">
         <a href="{{ URL::to('mail') }}"><i class="fa fa-inbox fa-fw"></i> Mail Configuration</a>
      </li> -->
                    
                   
    </ul>
  </section>
</aside>
