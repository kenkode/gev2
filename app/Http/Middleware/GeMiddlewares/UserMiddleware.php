<?php

namespace App\Http\Middleware\GeMiddlewares;

use Closure;
use Auth;

class UserMiddleware {

  public function handle($request, Closure $next) {
    $response = $next($request);

    if(!Auth::check()) {
        return redirect('login');
    }

    return $response;
  }


}



?>
