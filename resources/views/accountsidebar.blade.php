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
     
      <li class="@if($header == 'Accounting'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('accounts') }}"><i class="fa fa-calculator fa-fw"></i> <span>Chart of Accounts</span></a></li>
      
      <li class="@if($header == 'Journal Entries'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('journals') }}"><i class="fa fa-newspaper-o fa-fw"></i> Journal Entries</a></li>
                            
                    
                    <li class="treeview @if($header == 'Bank Accounts' || $header == 'Reconciliation Report'){{'active'}}@else{{''}}@endif">
                        <a href="#"><i class="fa fa-university fa-fw"></i> Banking<i class="fa fa-angle-left pull-right"></i></a>
                        <ul class="treeview-menu">
                            <li class="@if($header == 'Bank Accounts'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('bankAccounts') }}"><i class="fa fa-university fa-fw"></i> Bank Accounts</a></li>
                            <li class="@if($header == 'Reconciliation Report'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('bankReconciliation/report') }}"><i class="fa fa-file fa-fw"></i> Reconciliation Report</a></li>
                        </ul>
                    </li>

                    <li class="treeview @if($header == 'Expenses' || $header == 'Petty Cash' || $header == 'Expense Claims'){{'active'}}@else{{''}}@endif">
                        <a href="#"><i class="fa fa-list fa-fw"></i>Expenses<i class="fa fa-angle-left pull-right"></i></a>
                        <ul class="treeview-menu">
                            <li class="@if($header == 'Expenses'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('expenses') }}"><i class="fa fa-money fa-fw"></i>Expenses</a></li>
                            <li class="@if($header == 'Petty Cash'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('petty_cash') }}"><i class="fa fa-money fa-fw"></i>Petty Cash</a></li>
                            <li class="@if($header == 'Expense Claims'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('expense_claims') }}"><i class="fa fa-money fa-fw"></i>Expense Claims</a></li>
                        </ul>
                    </li> 

                    <li class="@if($header == 'Asset Management'){{'active'}}@else{{''}}@endif">
                        <a href="{{ URL::to('assetManagement') }}"><i class="fa fa-building fa-fw"></i>Asset Management</a>
                    </li>
    
                   
    </ul>
  </section>
</aside>
