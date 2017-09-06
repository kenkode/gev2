<?php

namespace App\Http\Controllers\GeController;

use App\Http\Controllers\Controller;
use Kreait\Firebase\Configuration;
use Kreait\Firebase\Firebase;

class FirebaseController extends Controller {

  public $firebase;

  function __construct() {
      $config = new Configuration();
      $config->setAuthConfigFile('google-services.json');
      $this->firebase = new Firebase('https://ge-driver.firebaseio.com/', $config);
  }

}



?>
