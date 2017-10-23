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
      <li class="@if($header == 'Items'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('items') }}"><i class="fa fa-barcode fa-fw"></i> <span>Items</span></a></li>
      <li class="@if($header == 'Accounting'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('accounts') }}"><i class="fa fa-calculator fa-fw"></i> <span>Accounting</span></a></li>
      <li class="@if($header == 'Clients'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('clients') }}"><i class="fa fa-users fa-fw"></i> <span>Clients</span></a></li>
      <li class="@if($header == 'Pricing'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('prices') }}"><i class="fa fa-money fa-fw"></i> Pricing</a></li>
      <li class="treeview @if($header == 'Sales Order' || $header == 'Purchase Order'){{'active'}}@else{{''}}@endif">
      <a href="#"><i class="fa fa-shopping-cart"></i> <span>Orders</span> <i class="fa fa-angle-left pull-right"></i></a>
                    <ul class="treeview-menu">

                       <li class="@if($header == 'Sales Order'){{'active'}}@else{{''}}@endif">
                          <a href="{{ URL::to('salesorders') }}"><i class="fa fa-list fa-fw"></i> Sales Orders</a>
                        </li>
                              
                        <li class="@if($header == 'Purchase Order'){{'active'}}@else{{''}}@endif">
                          <a href="{{ URL::to('purchaseorders') }}"><i class="fa fa-list fa-fw"></i>  Purchase Orders</a>
                        </li>
                    </ul>
                   </li>  

                   <li class="@if($header == 'Sales Target'){{'active'}}@else{{''}}@endif">
                    <a href="{{ URL::to('salestargets') }}"><i class="fa fa-bar-chart fa-fw"></i> Sales Targets</a>
                  </li>               
                  
                  <li class="@if($header == 'Quotations'){{'active'}}@else{{''}}@endif">
                    <a href="{{ URL::to('quotationorders') }}"><i class="fa fa-file fa-fw"></i> Quotation</a>
                  </li>
                
                 <!--  <li>
                    <a href="{{ URL::to('account') }}"><i class="fa fa-tasks fa-fw"></i>  Accounts</a>
                  </li> -->
                  
                 <li class="treeview @if($header == 'Payment methods' || $header == 'Payments'){{'active'}}@else{{''}}@endif">
                 <a href="#"><i class="fa fa-credit-card"></i> <span> Payments </span> <i class="fa fa-angle-left pull-right"></i></a>
                    <ul class="treeview-menu"> 
                      <li class="@if($header == 'Payment methods'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('paymentmethods') }}"><i class="fa fa-tasks fa-fw"></i>  Payment Methods</a>
                      </li>      
                      <li class="@if($header == 'Payments'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('payments') }}"><i class="fa fa-list fa-fw"></i> Payments</a>
                      </li>
                    </ul>
                  </li>

                  <li class="@if($header == 'Stocks'){{'active'}}@else{{''}}@endif">
                    <a href="{{ URL::to('stocks') }}"><i class="fa fa-random fa-fw"></i>  Stock</a>
                  </li>

                  <li class="@if($header == 'Stores'){{'active'}}@else{{''}}@endif">
                    <a href="{{ URL::to('locations') }}"><i class="fa fa-map-marker fa-fw"></i>  Stores</a>
                  </li>

                  <!-- <li class="treeview">
                    <a href="#">
                        <i class="fa fa-car fa-fw"></i> Transport <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li>
                          <a href="{{ URL::to('drivers') }}"><i class="fa fa-tasks fa-fw"></i>  Drivers</a>
                        </li>  

                        <li>
                          <a href="{{ URL::to('vehicles') }}"><i class="fa fa-tasks fa-fw"></i>  Vehicles</a>
                        </li>  

                        <li>
                          <a href="{{ URL::to('assigndrivers') }}"><i class="fa fa-tasks fa-fw"></i>  Assigned Drivers</a>
                        </li>     
                    </ul>
                   </li>           -->       

                  <li class="@if($header == 'Tax Rates'){{'active'}}@else{{''}}@endif">
                    <a href="{{ URL::to('taxes') }}"><i class="fa fa-tag fa-fw"></i> Taxes</a>
                  </li> 

                  <li class="@if($header == 'Reports'){{'active'}}@else{{''}}@endif">
                    <a href="{{ URL::to('erpReports') }}"><i class="fa fa-folder-open fa-fw"></i>  Reports</a>
                  </li>
                   
    </ul>
  </section>
</aside>
