<aside class="main-sidebar">

  <section class="sidebar">

    <div class="user-panel">
      <div class="pull-left image">
        <img src="{{ asset('dist/img/avatar.png') }}" class="img-circle" alt="User Image">
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
      <li class="active"><a href="{{ route('home') }}"><i class="fa fa-link"></i> <span>Dashboard</span></a></li>
      <li><a href="{{ route('subsidiary') }}"><i class="fa fa-link"></i> <span>Subsidiaries</span></a></li>
      <li><a href="{{ route('suppliers') }}"><i class="fa fa-link"></i> <span>Suppliers</span></a></li>
      <li><a href="{{ route('manage') }}"><i class="fa fa-link"></i> <span>Manage products</span></a></li>
      <li><a href="{{ route('stock') }}"><i class="fa fa-link"></i> <span>Stock</span></a></li>
      <li><a href="{{ route('users') }}"><i class="fa fa-link"></i> <span>Users</span></a></li>
      <!-- <li class="treeview">
        <a href="#"><i class="fa fa-link"></i> <span>Multilevel</span> <i class="fa fa-angle-left pull-right"></i></a>
        <ul class="treeview-menu">
          <li><a href="#">Link in level 2</a></li>
          <li><a href="#">Link in level 2</a></li>
        </ul>
      </li> -->
    </ul>
  </section>
</aside>
