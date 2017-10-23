<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\User;
use App\Http\Models\UserRepository;
use App\Http\Models\Audit;
use App\Http\Models\Role;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Hash;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use DB;

/**
 * UsersController Class
 *
 * Implements actions regarding user management
 */
class UsersController extends Controller
{


    /**
    * display a list of system users
    */
    public function index(){

        $users = User::all();
        $header='System Users';
        $description='View System Users';

        if (! Entrust::can('view_users') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        Audit::logaudit('System', 'viewed users', 'viewed system users');
        return view('users.index',compact('users','header','description'));
    }
    }


    /**
    * display the edit page
    */
    public function edit($user){

        if (! Entrust::can('update_users') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        $user = User::find($user);
        $header='System Users';
        $description='Update User';
        return view('users.edit',compact('user','header','description'));
    }
    }


     /**
    * updates the user
    */
    public function update($user){

        $user = User::find($user);

        $user->name = Input::get('username');
        $user->email = Input::get('email');
        $user->update();

        Audit::logaudit('System', 'updated profile', 'User '.Auth::user()->name.' updated their profile');

        return Redirect::to('users/profile/'.$user->id);
    }




    /**
     * Displays the form for account creation
     *
     * @return  Illuminate\Http\Response
     */
    public function create()
    {
        if (! Entrust::can('create_users') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        $roles = Role::all();
        $header='System Users';
        $description='Create User';
        return view('users.create', compact('roles','header','description'));
    }
    }

    /**
     * Stores new account
     *
     * @return  Illuminate\Http\Response
     */
    public function store()
    {

        $input = Input::all();



        
        
        $repo = App::make('UserRepository');
        $user = $repo->signup($input);



        if ($user->id) {
            if (Config::get('confide::signup_email')) {
                Mail::queueOn(
                    Config::get('confide::email_queue'),
                    Config::get('confide::email_account_confirmation'),
                    compact('user'),
                    function ($message) use ($user) {
                        $message
                            ->to($user->email, $user->username)
                            ->subject(Lang::get('confide::confide.email.account_confirmation.subject'));
                    }
                );
            }

           

            return Redirect::to('/');
                
        } else {
            $error = $user->errors()->all(':message');

            return Redirect::back()
                ->withInput(Input::except('password'))
                ->with('error', $error);
        }

        
    }

    /**
     * Displays the login form
     *
     * @return  Illuminate\Http\Response
     */
    public function login()
    {
        if (Auth::user()) {
            return Redirect::to('/dashboard');

        } else {
            return view('login');
        }
    }

    /**
     * Attempt to do login
     *
     * @return  Illuminate\Http\Response
     */
    public function doLogin()
    {
        $repo = App::make('UserRepository');
        $input = Input::all();

        if ($repo->login($input)) {
            return Redirect::intended('/dashboard');

            Audit::logaudit('System', 'login', 'User '.Auth::user()->username.' logged into the system');

        } else {
            if ($repo->isThrottled($input)) {
                $err_msg = Lang::get('confide::confide.alerts.too_many_attempts');

                Audit::logaudit('System', 'login', 'failed log in attempt');
            } elseif ($repo->existsButNotConfirmed($input)) {
                $err_msg = Lang::get('confide::confide.alerts.not_confirmed');
            } else {
                $err_msg = Lang::get('confide::confide.alerts.wrong_credentials');
            }

            return Redirect::action('UsersController@login')
                ->withInput(Input::except('password'))
                ->with('error', $err_msg);
        }
    }

    /**
     * Attempt to confirm account with code
     *
     * @param  string $code
     *
     * @return  Illuminate\Http\Response
     */
    public function confirm($code)
    {
        if (Confide::confirm($code)) {
            $notice_msg = Lang::get('confide::confide.alerts.confirmation');
            return Redirect::action('UsersController@login')
                ->with('notice', $notice_msg);
        } else {
            $error_msg = Lang::get('confide::confide.alerts.wrong_confirmation');
            return Redirect::action('UsersController@login')
                ->with('error', $error_msg);
        }
    }

    /**
     * Displays the forgot password form
     *
     * @return  Illuminate\Http\Response
     */
    public function forgotPassword()
    {
        return view(Config::get('confide::forgot_password_form'));
    }

    /**
     * Attempt to send change password link to the given email
     *
     * @return  Illuminate\Http\Response
     */
    public function doForgotPassword()
    {
        if (Confide::forgotPassword(Input::get('email'))) {
            $user = DB::table('users')->where('email',Input::get('email'))->first();
            $notice_msg = Lang::get('confide::confide.alerts.password_forgot');
            Audit::logaudit('System', 'forgot password', 'User '.$user->username.' has requested for a new password');
            return Redirect::action('UsersController@login')
                ->with('notice', $notice_msg);
        } else {
            $error_msg = Lang::get('confide::confide.alerts.wrong_password_forgot');
            return Redirect::action('UsersController@doForgotPassword')
                ->withInput()
                ->with('error', $error_msg);
        }
    }

    /**
     * Shows the change password form with the given token
     *
     * @param  string $token
     *
     * @return  Illuminate\Http\Response
     */
    public function resetPassword($token)
    {
        return view(Config::get('confide::reset_password_form'))
                ->with('token', $token);
    }

    /**
     * Attempt change password of the user
     *
     * @return  Illuminate\Http\Response
     */
    public function doResetPassword()
    {
        $repo = App::make('UserRepository');
        $input = array(
            'token'                 =>Input::get('token'),
            'password'              =>Input::get('password'),
            'password_confirmation' =>Input::get('password_confirmation'),
        );

        // By passing an array with the token, password and confirmation
        if ($repo->resetPassword($input)) {
            $notice_msg = Lang::get('confide::confide.alerts.password_reset');
            $user = DB::table('users')->where('email',Input::get('email'))->first();
            Audit::logaudit('System', 'reset password', 'User '.$user->username.' has reset their password');
            return Redirect::action('UsersController@login')
                ->with('notice', $notice_msg);
        } else {
            $error_msg = Lang::get('confide::confide.alerts.wrong_password_reset');
            return Redirect::action('UsersController@resetPassword', array('token'=>$input['token']))
                ->withInput()
                ->with('error', $error_msg);
        }
    }

    /**
     * Log the user out of the application.
     *
     * @return  Illuminate\Http\Response
     */
    public function logout()
    {

        Audit::logaudit('System', 'logout', 'User '.Auth::user()->username.' logged out of the system');

        Confide::logout();



        return Redirect::to('/');
    }


    /**
    * Activate the user
    *
    */

    public function activate($user){

        $user = User::find($user);

        $user->confirmed = 1;
        $user->save();

        Audit::logaudit('System', 'activate user', 'activated user '.$user->username.' in the system');

        return Redirect::to('users');
    }


    /**
    * Deactivate the user
    *
    */

    public function deactivate($user){

        $user = User::find($user);

        $user->confirmed = 0;
        $user->save();

        Audit::logaudit('System', 'activate user', 'activated user '.$user->username.' in the system');

        return Redirect::to('users');
    }


    /**
    * Delete the user
    *
    */

    public function destroy($user){

        $user = User::find($user);
        if (! Entrust::can('delete_users') ) // Checks the current user
        {
        return Redirect::to('dashboard')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
        
        $user->delete();

        Audit::logaudit('System', 'deleted user', 'deleted user '.$user->username.' from the system');

        return Redirect::to('users');
    }
    }


    /**
    * change user password
    */
    public function changePassword($user){

        $user = User::find($user);

        $password_confirmation = Input::get('password_confirmation');
        $password = Input::get('password');

        if($password != $password_confirmation){

            return Redirect::to('users/password/'.$user->id)->with('error', 'passwords do not match');
        } 
        else
        {

            /*$user->password = Hash::make($password);
            $user->update();
            return Hash::make($password);*/

            DB::table('users')
            ->where('id', $user)
            ->update(array('password' => Hash::make($password)));

            return Redirect::to('users/profile/'.$user->id)->with('success', 'passwords successfully updated');
        }



    }


    public function password($user){

        $user = User::find($user);
        $header='System Users';
        $description='Update Password';
        return view('users.password', compact('user','header','description'));

    }





    public function profile($user){

        $user = User::find($user);
        $header='System Users';
        $description='User Profile';

        Audit::logaudit('System', 'viewed profile', 'User '.Auth::user()->username.' has viewed their profile');
        return view('users.profile', compact('user','header','description'));
    }


    public function add(){


         $user = new User;

    $user->username = 'admin';
    $user->email = 'admin@rental.com';

    $user->password = Hash::make('password123');
    $user->confirmation_code = 'eoioweq982jwe';
    $user->remember_token = 'jsadksjd928323';
    $user->confirmed = '1';
    $user->save();


    echo "user created";
    }







    public function changePassword2(){

        $user_id = Auth::user()->id;

        $oldpass = DB::table("users")->where("id",$user_id)->first();

        

        $password_confirmation = Input::get('password_confirmation');
        $password = Input::get('password');

        if (!password_verify(Input::get("oldpassword"), $oldpass->password)){

            return Redirect::back()->with('error', 'old password does not match your current password');
        }
        else if($password != $password_confirmation){

            return Redirect::back()->with('error', 'passwords do not match');
        }  
        else
        {
    
        $pass = bcrypt($password);

        DB::table('users')->where('id', $user_id)->update(array('password' => $pass));

        Audit::logaudit('System', 'changed password', 'changed their password in the system');

        return Redirect::to('users/profile/'.$user_id)->with('success', 'password successfully updated');



            

            
        }



    }


    public function password2(){

        $user = Auth::user()->id;
        return view('css.password', compact('user'));

    }


    public function tellers(){

        $tellers = DB::table('users')->where('user_type', '=', 'teller')->get();

        return view('tellers.index', compact('tellers'));
    }

    public function createteller($id){

        $user = User::findorfail($id);

        $user->user_type = 'teller';
        $user->is_active = true;
        $user->update();

        return Redirect::to('tellers');
    }


    public function activateteller($id){

        $user = User::findorfail($id);

        
        $user->is_active = true;
        $user->update();

        return Redirect::to('tellers');
    }


    public function deactivateteller($id){

        $user = User::findorfail($id);

        
        $user->is_active = false;
        $user->update();

        return Redirect::to('tellers');
    }


    public function newuser(){

        if(Input::get("password") != Input::get("password_confirmation")){
        return Redirect::to('users/create')->with("notice","Passwords don`t match!");
        }else{
        $input = Input::all();

        $roles = Input::get('role');

        /*$repo = App::make('UserRepository');
        $user = $repo->register($input);*/

        $user = new User;

        $user->email    = array_get($input, 'email');
        $user->password = bcrypt(array_get($input, 'password'));
        $user->type = 1;
        $user->name = array_get($input, 'username');
        $user->organization_id = 1;

        // The password confirmation will be removed from model
        // before saving. This field will be used in Ardent's
        // auto validation.

        // Generate a random confirmation code
        $user->confirmation_code     = md5(uniqid(mt_rand(), true));

        // Save if valid. Password field will be hashed before save
        $user->save();
         

            foreach ($roles as $role) {

                $user->attachRole($role);
            }
        
        Audit::logaudit('System', 'created user', 'created user '.$user->name.' in the system');

        return Redirect::to('users');
    }
    }


    public function show($id){

        

         Confide::logout();

        return Redirect::to('/');
    }


}
