<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Models\Role;
use App\Http\Models\Audit;
use App\Http\Models\Permission;
use Illuminate\Http\Request;
use Redirect;
use Entrust;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Auth;
use DB;

/**
 * rolesController Class
 *
 * Implements actions regarding role management
 */
class RolesController extends Controller
{


    /**
    * display a list of system roles
    */
    public function index(){

        $roles = Role::all();
        $header='System Roles';
        $description='View System Roles';

        Audit::logaudit('Roles', 'viewed user roles', 'viewed user roles in the system');

        return view('roles.index',compact('roles','header','description'));
    }


    /**
    * display the edit page
    */
    public function edit($id){
        $roleperm = array();
        $role = Role::find($id);
        $permissions = Permission::all();
        $categories = DB::table('permissions')->select('category')->distinct()->get();

        foreach ($role->perms()->get() as $p) {
            $roleperm[] = $p->name;
        }

        $header='System Roles';
        $description='Update Role';
        
       return view('roles.edit', compact('role', 'permissions', 'categories', 'roleperm', 'header', 'description'));
    }



     /**
    * updates the role
    */
    public function update($id){

        $perms = Input::get('permission');

        $role = Role::find($id);

        $role->name = Input::get('name');
       
        $role->update();
        
        $role->perms()->sync($perms);

        Audit::logaudit('Roles', 'updated a user role', 'updated user role '.Input::get('name').' in the system');

        return Redirect::to('roles/show/'.$role->id);
    }




    /**
     * Displays the form for account creation
     *
     * @return  Illuminate\Http\Response
     */
    public function create()
    {

        $categories = DB::table('permissions')->select('category')->distinct()->get();
        $permissions = Permission::all();
        $header='System Roles';
        $description='Update Role';
        
        return view('roles.create', compact('permissions', 'categories','header','description'));
    }

    /**
     * Stores new account
     *
     * @return  Illuminate\Http\Response
     */
    public function store()
    {

        

        $perms = Input::get('permission');

        
        
        $role = new Role;

        $role->name = Input::get('name');

        $role->save();

        $role->perms()->sync($perms);

        Audit::logaudit('Roles', 'created a user role', 'created user role '.Input::get('name').' in the system');

        return Redirect::route('roles.index');

        

        


    }





    /**
    * Delete the role
    *
    */

    public function destroy($id){

        $role = Role::find($id);

        
        /*$role->delete();*/

        $role->users()->sync([]); // Delete relationship data
        $role->perms()->sync([]); // Delete relationship data

        $role->forceDelete();

        Audit::logaudit('Roles', 'deleted a user role', 'deleted user role '.$role->name.' in the system');

        return Redirect::to('roles');
    }



    public function show($id){

        $role = Role::find($id);
        $permissions = Permission::all();
        $categories = DB::table('permissions')->select('category')->distinct()->get();
        $roleperm = array();
        foreach ($role->perms()->get() as $p) {
            $roleperm[] = $p->name;
        }

        $header='System Roles';
        $description='View Role';
        
       Audit::logaudit('Roles', 'viewed a user role', 'viewed user role '.$role->name.' in the system');
       return view('roles.show', compact('role', 'permissions', 'categories', 'roleperm','header','description'));
    }


  











  



    



 



}
