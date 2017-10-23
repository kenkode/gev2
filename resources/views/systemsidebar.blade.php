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
     
      <li class="@if($header == 'Organization'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('organizations') }}"><i class="fa fa-calculator fa-fw"></i> <span>Organization</span></a></li>
      
      <li class="@if($header == 'System Users'){{'active'}}@else{{''}}@endif"><a href="{{ URL::to('users') }}"><i class="fa fa-newspaper-o fa-fw"></i> System Users</a></li>

      <li class="@if($header == 'System Roles'){{'active'}}@else{{''}}@endif">
        <a href="{{ URL::to('roles') }}"><i class="fa fa-bookmark fa-fw"></i> System Roles</a>
      </li>

      <li class="@if($header == 'Audit Trail'){{'active'}}@else{{''}}@endif">
         <a href="{{ URL::to('audits') }}"><i class="fa fa-list fa-fw"></i> Audit Trail</a>
      </li>

      <li class="@if($header == 'System Version'){{'active'}}@else{{''}}@endif">
         <a href="{{ URL::to('system') }}"><i class="fa fa-list fa-fw"></i> Version</a>
      </li>

      <!-- <li class="@if($header == 'Mail Configuration'){{'active'}}@else{{''}}@endif">
         <a href="{{ URL::to('mail') }}"><i class="fa fa-inbox fa-fw"></i> Mail Configuration</a>
      </li> -->
                    
                   
    </ul>
  </section>
</aside>
