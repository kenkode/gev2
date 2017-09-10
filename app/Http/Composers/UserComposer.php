<?php

namespace App\Http\Composers;

use Auth;

class UserComposer {

  public function getUser() {
    return Auth::user();
  }


}


?>
