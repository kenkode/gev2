<?php

namespace App\Http\Middleware\GeMiddlewares;

use Closure;
use Auth;

class SuperUserMiddleware {

  public function handle($request, Closure $next) {
    $response = $next($request);

    if(Auth::user()->type != 1) {
        return redirect('/');
    }

    return $response;
  }


}



?>
