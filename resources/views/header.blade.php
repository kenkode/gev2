<!-- Main Header -->
<header class="main-header">

  <!-- Logo -->
  <a href="index2.html" class="logo">
    <span class="logo-mini"><b>A</b>LT</span>
    <span class="logo-lg">Gas Express</span>
  </a>
  <nav class="navbar navbar-static-top" role="navigation">
    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
      <span class="sr-only">Toggle navigation</span>
    </a>
    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav">
         <li class="dropdown notifications-menu">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
           Administration
          </a>
          <ul class="dropdown-menu">
             <li><a href="{{ URL::to('organizations') }}"><i class="fa fa-home fa-fw"></i>  Organization</a>
                             <li class="divider"></li>
                       
                        <li><a href="{{ URL::to('system') }}"><i class="fa fa-sign-out fa-fw"></i> System</a>
                        </li><li class="divider"></li>
                        <li>
                            <a  href="{{ URL::to('accounts')}}">
                                <i class="fa fa-calculator fa-fw"></i>  
                                Accounting
                            </a>
                          </li>
          </ul>
        </li> 

        <?php
         $notifications = App\Http\Models\Notification::where("user_id",Auth::user()->id)->where("is_read",0)->count();
        ?>

        <li class="notifications-menu">
          <a href="{{URL::to('notifications/index')}}">
            <i class="fa fa-bell-o"></i>
            <span class="label label-warning">{{$notifications}}</span>
          </a>
          
        </li> 

        <li class="dropdown user user-menu">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <img src="{{ asset('public/dist/img/avatar.png') }}" class="user-image" alt="User Image">
            <span class="hidden-xs">{{ Auth::user()->name }}</span>
          </a>
          <ul class="dropdown-menu">
            <li class="user-header">
              <img src="{{ asset('public/dist/img/avatar.png') }}" class="img-circle" alt="User Image">
              <p>
                {{ Auth::user()->name }}
                <small>{{ Auth::user()->email }}</small>
              </p>
            </li>
            <!-- <li class="user-body">
              <div class="row">
                <div class="col-xs-4 text-center">
                  <a href="#"></a>
                </div>
                <div class="col-xs-4 text-center">
                  <a href="#"></a>
                </div>
                <div class="col-xs-4 text-center">
                  <a href="#"></a>
                </div>
              </div>
            </li> -->
            <li class="user-footer">
              <div class="pull-right">
                <form action="{{ route('logout') }}" method="post">
                  {{ csrf_field() }}
                  <button class="btn btn-default btn-flat">Sign out</button>
                </form>
              </div>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </nav>
</header>
