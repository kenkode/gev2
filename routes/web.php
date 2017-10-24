<?php

use App\Http\Models\Audit;
use App\Http\Models\Organization;
use App\Http\Models\Client;
use Illuminate\Support\Facades\Auth;
use App\Http\Models\Erporder;
use App\Http\Models\Item;
use App\Http\Models\Location;
use App\Http\Models\Erporderitem;
use App\Http\Models\Payment;
use App\Http\Models\Tax;
use App\Http\Models\ItemTracker;
use App\Http\Models\Stock;
use App\Http\Models\Store;
use App\Http\Models\Notification;
use App\Http\Models\Driver;
use App\Http\Models\Vehicle;
use App\Http\Models\Price;
use App\Http\Models\TaxOrder;
use App\Http\Models\Account;
use App\Http\Models\Accounts;
use App\Http\Models\Paymentmethod;
use App\Http\Models\Expense;
use App\Http\Models\Bank;
use App\Http\Models\BBranch;
use Illuminate\Support\Facades\Input;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/register', function() {
  return view('coming', ['header'=>'Stock', 'description'=>'Live Stock']);
})->name('reg');

Auth::routes();

Route::middleware("auth")->group(function() {

  Route::get('/', 'GeController\GeController@index')->name('home');

  Route::get('/add_rider', 'GeController\GeController@addRider')->name('add_rider');

  Route::post('/add_rider', 'GeController\GeController@addRiderDetails');

  Route::get('/rider/{rider}', 'GeController\GeController@rider');

  Route::middleware("super")->group(function() {

    Route::get('/get_updates', 'GeController\GeController@getUpdate');

    Route::get('/orders', 'GeController\GeController@orders')->name('orders');

    Route::get('/subsidiaries', 'GeController\GeController@subsidiary')->name('subsidiary');

    Route::get('/orders/{order}', 'GeController\GeController@orderDetails');

    //Route::get('/users', 'GeController\GeController@users')->name('users');

    Route::get('/manage', 'GeController\GeController@manage')->name('manage');

    Route::get('/stock', 'GeController\GeController@stock')->name('stock');

    Route::post('/update_stock', 'GeController\GeController@addStock');

    Route::get('/suppliers', 'GeController\GeController@supplier')->name('suppliers');

    Route::post('/add_supplier', 'GeController\GeController@addSupplier');

    Route::post('/edit_supplier', 'GeController\GeController@editSupplier');

    Route::post('/delete_supplier', 'GeController\GeController@deleteSupplier');

    Route::post('/get_supplier', 'GeController\GeController@getSupplier');

  // Manage

    Route::post('/add_gas_type', 'GeController\GeController@addGasType');

    Route::post('/add_gas', 'GeController\GeController@addGas');

    Route::post('/add_product', 'GeController\GeController@addProduct');

    Route::post('/add_bulkgas', 'GeController\GeController@addBulkGas');

    Route::prefix("subsidiary")->group(function() {
        Route::post("/add_subsidiary", "GeController\SubsidiaryController@addSubsidiary");

        Route::get("/add_ride", "GeController\SubsidiaryController@addRide");
    });
  });
});

Route::prefix("rider")->group(function() {
  Route::get("get_token", "GeController\RiderController@getToken");
  Route::get("login/{email}/{password}", "GeController\RiderController@login");
  Route::get("earnings/{rider}", "GeController\RiderController@earnings");
  Route::get("ratings/{rider}", "GeController\RiderController@ratings");
  Route::get("edit/{rider}", "GeController\RiderController@edit");

  Route::get("set_rider/{rider}/{order}", "GeController\RiderController@setRider");
  Route::get("delivered/{order}", "GeController\RiderController@orderDelivered");
});

Route::prefix("customer")->group(function() {
  Route::get("firebase", function() {
    $fbc = new \App\Http\Controllers\GeController\FirebaseController();
  });
  Route::get("authenticate_user", "GeController\CustomerController@authenticateUser");
  Route::get("add_user", "GeController\CustomerController@addUser");
  Route::get("update_user", "GeController\CustomerController@updateUser");

  Route::get("get_items", "GeController\CustomerController@getOrderItems");
  //
  Route::get("rating", "GeController\CustomerController@submitRating");

  Route::get("my_orders", "GeController\CustomerController@getHistory");
  Route::get("add_location", "GeController\CustomerController@addLocation");
  Route::get("disable_location", "GeController\CustomerController@disableLocation");
  Route::get("place_order", "GeController\CustomerController@placeOrder");
  Route::get("get_accessories", "GeController\CustomerController@getAccessories");
  Route::get("get_gases", "GeController\CustomerController@getGases");
  Route::get("get_services", "GeController\CustomerController@getServices");
  Route::get("get_sizes", "GeController\CustomerController@getSizes");
  Route::get("get_bulk_gas", "GeController\CustomerController@getBulkGas");
  Route::get("my_locations", "GeController\CustomerController@getLocations");
});


Route::get('/dashboard', function()
{
  if (Auth::user()) {


        if(Auth::user()->user_type == 'admin'){

             
          //$employees = Employee::all();
           //return view('dashboard', compact('employees'));

return view('erpmgmt');

        }
       

      
        } else {
            return view('login', compact('account', 'organization'));
        }
});
//

Route::get('fpassword', function(){

  return view(Config::get('confide::forgot_password_form'));

});

Route::get('mail', function(){
  $mail = Mailsender::find(1);  
  Audit::logaudit('Mail Configuration', 'viewed mail configuration', 'viewed mail configuration in the system');
  return view('system.mail', compact('mail'));

});



Route::resource('payable', 'PayableController');

// Confide routes
Route::get('users', 'UsersController@index')->name('users');
Route::get('users/create', 'UsersController@create');
Route::get('users/edit/{user}', 'UsersController@edit');
Route::post('users/update/{user}', 'UsersController@update');
Route::post('users', 'UsersController@store');
Route::get('users/add', 'UsersController@add');
Route::post('users/newuser', 'UsersController@newuser');
Route::get('users/login', 'UsersController@login');
Route::post('users/login', 'UsersController@doLogin');
Route::get('users/confirm/{code}', 'UsersController@confirm');
Route::get('users/forgot_password', 'UsersController@forgotPassword');
Route::post('users/forgot_password', 'UsersController@doForgotPassword');
Route::get('users/reset_password/{token}', 'UsersController@resetPassword');
Route::post('users/reset_password', 'UsersController@doResetPassword');
Route::get('users/logout', 'UsersController@logout');
Route::get('users/activate/{user}', 'UsersController@activate');
Route::get('users/deactivate/{user}', 'UsersController@deactivate');
Route::get('users/destroy/{user}', 'UsersController@destroy');
Route::get('users/password/{user}', 'UsersController@Password');
Route::post('users/password/{user}', 'UsersController@changePassword2');
Route::get('users/profile/{user}', 'UsersController@profile');
Route::get('users/show/{user}', 'UsersController@show');

Route::get('notifications/index', 'NotificationController@index');
Route::get('notifications/markasread/{id}', 'NotificationController@markasread');
Route::get('notifications/markallasread', 'NotificationController@markallasread');

Route::post('users/pass', 'UsersController@changePassword2');

Route::group(['before' => 'manage_roles'], function() {

Route::resource('roles', 'RolesController');
Route::get('roles/create', 'RolesController@create');
Route::get('roles/edit/{id}', 'RolesController@edit');
Route::get('roles/show/{id}', 'RolesController@show');
Route::post('roles/update/{id}', 'RolesController@update');
Route::get('roles/delete/{id}', 'RolesController@destroy');

});

Route::get('import', function(){

    return view('import');
});


Route::group(['before' => 'manage_system'], function() {

Route::get('system', function(){


    $organization = Organization::find(1);
    $header='System Version';
    $description='View System Version';

    return view('system.index', compact('organization','header','description'));
});

});



Route::get('license', function(){


    $organization = Organization::find(1);

    return view('system.license', compact('organization'));
});




/**
* Organization routes
*/

Route::group(['before' => 'manage_organization'], function() {

Route::resource('organizations', 'OrganizationsController');

Route::post('organizations/update/{id}', 'OrganizationsController@update');
Route::post('organizations/logo/{id}', 'OrganizationsController@logo');

});

Route::get('language/{lang}', 
           array(
                  'as' => 'language.select', 
                  'uses' => 'OrganizationsController@language'
                 )
          );


Route::resource('clients', 'ClientsController');
Route::get('clients/edit/{id}', 'ClientsController@edit');
Route::post('clients/update/{id}', 'ClientsController@update');
Route::get('clients/delete/{id}', 'ClientsController@destroy');
Route::get('clients/show/{id}', 'ClientsController@show');


/**
 * SHOW ALL CLIENTS WITH BALANCES
 */
Route::get('client/balances', function(){
  $clients = Client::where('type', 'Customer')->get();
  $header='Clients';
  $description='View Clients` Balance';
  //return date('Y-m-d', strtotime('-3 months'));
  return view('clients.balances', compact('clients','header','description'));
});

Route::get('client/balances/report', 'ErpReportsController@clientBalancesReport');

/**
 * Select client statement period
 */
Route::get('client/selectPeriod/{id}', function($id){
    $header='Clients';
    $description='Select Period';
  return view('clients.selectPeriod', compact('id','header','description'));
});

/**
 * Return customer statement
 */
Route::get('erpReports/clientstatement', 'ErpReportsController@ClientStatement');


Route::resource('prices', 'PricesController');
Route::get('prices/edit/{id}', 'PricesController@edit');
Route::post('prices/update/{id}', 'PricesController@update');
Route::get('prices/delete/{id}', 'PricesController@destroy');
Route::get('prices/show/{id}', 'PricesController@show');
Route::get('approvepriceupdate/{client}/{item}/{discount}/{receiver}/{confirmer}/{key}/{id}', 'PricesController@approveprice');
Route::post('notificationapprovepriceupdate', 'PricesController@notificationapproveprice');
Route::get('notificationshowprice/{client}/{item}/{discount}/{receiver}/{confirmer}/{key}/{id}', 'PricesController@notificationshowprice');

Route::resource('items', 'ItemsController');
Route::get('items/edit/{id}', 'ItemsController@edit');
Route::get('approveitemupdate/{name}/{size}/{description}/{pprice}/{sprice}/{sku}/{tagid}/{reorderlevel}/{receiver}/{confirmer}/{key}/{id}', 'ItemsController@approveitem');
Route::get('notificationshowitemupdate/{name}/{size}/{description}/{pprice}/{sprice}/{sku}/{tagid}/{reorderlevel}/{receiver}/{confirmer}/{key}/{id}', 'ItemsController@notificationshowitem');
Route::post('notificationapproveitemupdate', 'ItemsController@notificationapproveitem');
Route::post('items/update/{id}', 'ItemsController@update');
Route::get('items/delete/{id}', 'ItemsController@destroy');
Route::get('items/code/{id}', 'ItemsController@code');
Route::post('items/generate/{id}', 'ItemsController@generate');

Route::resource('expenses', 'ExpensesController');
Route::get('expenses/edit/{id}', 'ExpensesController@edit');
Route::post('expenses/update/{id}', 'ExpensesController@update');
Route::get('expenses/delete/{id}', 'ExpensesController@destroy');

Route::resource('paymentmethods', 'PaymentmethodsController');
Route::get('approvepaymentupdate/{client}/{amount}/{paymentmethod}/{account}/{received_by}/{date}/{receiver}/{id}', 'PaymentsController@approvepaymentupdate');
Route::get('paymentmethods/edit/{id}', 'PaymentmethodsController@edit');
Route::post('paymentmethods/update/{id}', 'PaymentmethodsController@update');
Route::get('paymentmethods/delete/{id}', 'PaymentmethodsController@destroy');

Route::resource('payments', 'PaymentsController');
Route::get('payments/payable/create', 'PaymentsController@payable');
Route::get('payments/edit/{id}', 'PaymentsController@edit');
Route::post('payments/update/{id}', 'PaymentsController@update');
Route::get('payments/delete/{id}', 'PaymentsController@destroy');



Route::resource('currencies', 'CurrenciesController');
Route::get('currencies/edit/{id}', 'CurrenciesController@edit');
Route::post('currencies/update/{id}', 'CurrenciesController@update');
Route::get('currencies/delete/{id}', 'CurrenciesController@destroy');
Route::get('currencies/create', 'CurrenciesController@create');



/* PETTY CASH ROUTES */
Route::resource('petty_cash', 'PettyCashController');
Route::post('petty_cash/addMoney', 'PettyCashController@addMoney');
Route::post('petty_cash/addContribution', 'PettyCashController@addContribution');
Route::post('petty_cash/newTransaction', 'PettyCashController@newTransaction');
Route::post('petty_cash/commitTransaction', 'PettyCashController@commitTransaction');
Route::get('petty_cash/transaction/{id}', 'PettyCashController@receiptTransactions');

// Edit and delete petty cash items
Route::get('petty_cash/newTransaction/remove/{count}', 'PettyCashController@removeTransactionItem');



/* EXPENSE CLAIMS ROUTES */
Route::resource('expense_claims', 'ExpenseClaimController');
Route::get('expense_claims/newReceipt', 'ExpenseClaimController@show');
Route::get('expense_claims/editReceipt/{id}', 'ExpenseClaimController@edit');
Route::post('expense_claims/newItem', 'ExpenseClaimController@addReceiptItem');
Route::get('expense_claims/newReceipt/remove/{count}', 'ExpenseClaimController@removeItem');
Route::post('expense_claims/commitTransaction', 'ExpenseClaimController@commitTransaction');
Route::post('expense_claims/submitClaim', 'ExpenseClaimController@submitClaim');
Route::get('expense_claims/approveClaim/{id}', 'ExpenseClaimController@approveClaimView');
Route::get('expense_claims/approve/{id}', 'ExpenseClaimController@approveClaim');
Route::get('expense_claims/decline/{id}', 'ExpenseClaimController@declineClaim');
Route::get('expense_claims/payClaim/{id}', 'ExpenseClaimController@payClaimView');
Route::post('expense_claims/payClaim', 'ExpenseClaimController@payClaim');


/* ASSET MANAGEMENT */
Route::resource('assetManagement', 'AssetMgmtController');
Route::post('assetManagement/{id}', 'AssetMgmtController@update');
Route::get('assetManagement/dispose/{id}', 'AssetMgmtController@dispose');
Route::get('assetManagement/{id}/depreciate', 'AssetMgmtController@depreciate');

/*
* branches routes
*/

Route::group(['before' => 'manage_branches'], function() {

Route::resource('branches', 'BranchesController');
Route::post('branches/update/{id}', 'BranchesController@update');
Route::get('branches/delete/{id}', 'BranchesController@destroy');
Route::get('branches/edit/{id}', 'BranchesController@edit');
});
/*
* groups routes
*/
Route::group(['before' => 'manage_groups'], function() {

Route::resource('groups', 'GroupsController');
Route::post('groups/update/{id}', 'GroupsController@update');
Route::get('groups/delete/{id}', 'GroupsController@destroy');
Route::get('groups/edit/{id}', 'GroupsController@edit');
});


/**
 * Bank Account Routes &
 * Bank Reconciliation Routes
 */
Route::resource('bankAccounts', 'BankAccountController');
Route::get('bankAccounts/reconcile/{id}', 'BankAccountController@showReconcile');
Route::post('bankAccounts/uploadStatement', 'BankAccountController@uploadBankStatement');
Route::post('bankAccount/reconcile', 'BankAccountController@reconcileStatement');

Route::get('bankAccount/reconcile/add/{id}/{id2}/{id3}', 'BankAccountController@addStatementTransaction');
Route::post('bankAccount/reconcile/add', 'BankAccountController@saveStatementTransaction');

Route::get('bankReconciliation/report', 'ErpReportsController@displayRecOptions');
Route::post('bankReconciliartion/generateReport', 'ErpReportsController@showRecReport');


/*
* accounts routes
*/


Route::resource('accounts', 'AccountsController');
Route::post('accounts/update/{id}', 'AccountsController@update');
Route::get('accounts/delete/{id}', 'AccountsController@destroy');
Route::get('accounts/edit/{id}', 'AccountsController@edit');
Route::get('accounts/show/{id}', 'AccountsController@show');
Route::get('accounts/create/{id}', 'AccountsController@create');


/*
* journals routes
*/
Route::resource('journals', 'JournalsController');
Route::post('journals/update/{id}', 'JournalsController@update');
Route::get('journals/delete/{id}', 'JournalsController@destroy');
Route::get('journals/edit/{id}', 'JournalsController@edit');
Route::get('journals/show/{id}', 'JournalsController@show');

/*
* Account routes
*/


Route::resource('account', 'AccountController');
Route::get('account/create', 'AccountController@create');
Route::get('account/edit/{id}', 'AccountController@edit');
Route::post('account/update/{id}', 'AccountController@update');
Route::get('account/delete/{id}', 'AccountController@destroy');

Route::get('account/show/{id}', 'AccountController@show');

Route::get('account/bank', 'AccountController@show');
Route::post('account/bank', 'AccountController@recordbanking');

/*
* license routes
*/

Route::post('license/key', 'OrganizationsController@generate_license_key');
Route::post('license/activate', 'OrganizationsController@activate_license');
Route::get('license/activate/{id}', 'OrganizationsController@activate_license_form');

/*
* Audits routes
*/
Route::group(['before' => 'manage_audits'], function() {

Route::resource('audits', 'AuditsController');

});

/*
* backups routes
*/

Route::get('backups', function(){

   
    //$backups = Backup::getRestorationFiles('../app/storage/backup/');

    return view('backup');

});


Route::get('backups/create', function(){

    echo '<pre>';

    $instance = Backup::getBackupEngineInstance();

    print_r($instance);

    //Backup::setPath(public_path().'/backups/');

   //Backup::export();
    //$backups = Backup::getRestorationFiles('../app/storage/backup/');

    //return view('backup');

});







/*
* #####################################################################################################################
*/
Route::group(['before' => 'manage_holiday'], function() {

Route::resource('holidays', 'HolidaysController');
Route::get('holidays/edit/{id}', 'HolidaysController@edit');
Route::get('holidays/delete/{id}', 'HolidaysController@destroy');
Route::post('holidays/update/{id}', 'HolidaysController@update');

});

Route::group(['before' => 'manage_leavetype'], function() {

Route::resource('leavetypes', 'LeavetypesController');
Route::get('leavetypes/edit/{id}', 'LeavetypesController@edit');
Route::get('leavetypes/delete/{id}', 'LeavetypesController@destroy');
Route::post('leavetypes/update/{id}', 'LeavetypesController@update');

});


Route::resource('leaveapplications', 'LeaveapplicationsController');
Route::get('leaveapplications/edit/{id}', 'LeaveapplicationsController@edit');
Route::get('leaveapplications/delete/{id}', 'LeaveapplicationsController@destroy');
Route::post('leaveapplications/update/{id}', 'LeaveapplicationsController@update');
Route::get('leaveapplications/approve/{id}', 'LeaveapplicationsController@approve');
Route::post('leaveapplications/approve/{id}', 'LeaveapplicationsController@doapprove');
Route::get('leaveapplications/cancel', 'LeaveapplicationsController@cancel');
Route::get('leaveapplications/reject/{id}', 'LeaveapplicationsController@reject');
Route::get('leaveapplications/show/{id}', 'LeaveapplicationsController@show');

Route::get('leaveapplications/approvals', 'LeaveapplicationsController@approvals');
Route::get('leaveapplications/rejects', 'LeaveapplicationsController@rejects');
Route::get('leaveapplications/cancellations', 'LeaveapplicationsController@cancellations');
Route::get('leaveapplications/amends', 'LeaveapplicationsController@amended');



/*
* #####################################################################################################################
*/
/*
* banks routes
*/

Route::resource('banks', 'BanksController');
Route::post('banks/update/{id}', 'BanksController@update');
Route::get('banks/delete/{id}', 'BanksController@destroy');
Route::get('banks/edit/{id}', 'BanksController@edit');

/*
* departments routes
*/

Route::resource('departments', 'DepartmentsController');
Route::post('departments/update/{id}', 'DepartmentsController@update');
Route::get('departments/delete/{id}', 'DepartmentsController@destroy');
Route::get('departments/edit/{id}', 'DepartmentsController@edit');


/*
* bank branch routes
*/

Route::resource('bank_branch', 'BankBranchController');
Route::post('bank_branch/update/{id}', 'BankBranchController@update');
Route::get('bank_branch/delete/{id}', 'BankBranchController@destroy');
Route::get('bank_branch/edit/{id}', 'BankBranchController@edit');

/*
* allowances routes
*/

Route::resource('allowances', 'AllowancesController');
Route::post('allowances/update/{id}', 'AllowancesController@update');
Route::get('allowances/delete/{id}', 'AllowancesController@destroy');
Route::get('allowances/edit/{id}', 'AllowancesController@edit');

/*
* reliefs routes
*/

Route::resource('reliefs', 'ReliefsController');
Route::post('reliefs/update/{id}', 'ReliefsController@update');
Route::get('reliefs/delete/{id}', 'ReliefsController@destroy');
Route::get('reliefs/edit/{id}', 'ReliefsController@edit');

/*
* deductions routes
*/

Route::resource('deductions', 'DeductionsController');
Route::post('deductions/update/{id}', 'DeductionsController@update');
Route::get('deductions/delete/{id}', 'DeductionsController@destroy');
Route::get('deductions/edit/{id}', 'DeductionsController@edit');

/*
* nssf routes
*/

Route::resource('nssf', 'NssfController');
Route::post('nssf/update/{id}', 'NssfController@update');
Route::get('nssf/delete/{id}', 'NssfController@destroy');
Route::get('nssf/edit/{id}', 'NssfController@edit');

/*
* nhif routes
*/

Route::resource('nhif', 'NhifController');
Route::post('nhif/update/{id}', 'NhifController@update');
Route::get('nhif/delete/{id}', 'NhifController@destroy');
Route::get('nhif/edit/{id}', 'NhifController@edit');

/*
* job group routes
*/

Route::resource('job_group', 'JobGroupController');
Route::post('job_group/update/{id}', 'JobGroupController@update');
Route::get('job_group/delete/{id}', 'JobGroupController@destroy');
Route::get('job_group/edit/{id}', 'JobGroupController@edit');

/*
* employee type routes
*/

Route::resource('employee_type', 'EmployeeTypeController');
Route::post('employee_type/update/{id}', 'EmployeeTypeController@update');
Route::get('employee_type/delete/{id}', 'EmployeeTypeController@destroy');
Route::get('employee_type/edit/{id}', 'EmployeeTypeController@edit');

/*
* employees routes
*/

Route::resource('employees', 'EmployeesController');
Route::post('employees/update/{id}', 'EmployeesController@update');
Route::get('employees/delete/{id}', 'EmployeesController@destroy');
Route::get('employees/edit/{id}', 'EmployeesController@edit');

/*
* employee earnings routes
*/

Route::resource('other_earnings', 'EarningsController');
Route::post('other_earnings/update/{id}', 'EarningsController@update');
Route::get('other_earnings/delete/{id}', 'EarningsController@destroy');
Route::get('other_earnings/edit/{id}', 'EarningsController@edit');

/*
* employee reliefs routes
*/

Route::resource('employee_relief', 'EmployeeReliefController');
Route::post('employee_relief/update/{id}', 'EmployeeReliefController@update');
Route::get('employee_relief/delete/{id}', 'EmployeeReliefController@destroy');
Route::get('employee_relief/edit/{id}', 'EmployeeReliefController@edit');

/*
* employee allowances routes
*/

Route::resource('employee_allowances', 'EmployeeAllowancesController');
Route::post('employee_allowances/update/{id}', 'EmployeeAllowancesController@update');
Route::get('employee_allowances/delete/{id}', 'EmployeeAllowancesController@destroy');
Route::get('employee_allowances/edit/{id}', 'EmployeeAllowancesController@edit');

/*
* employee deductions routes
*/

Route::resource('employee_deductions', 'EmployeeDeductionsController');
Route::post('employee_deductions/update/{id}', 'EmployeeDeductionsController@update');
Route::get('employee_deductions/delete/{id}', 'EmployeeDeductionsController@destroy');
Route::get('employee_deductions/edit/{id}', 'EmployeeDeductionsController@edit');

/*
* payroll routes
*/


Route::resource('payroll', 'PayrollController');
Route::post('deleterow', 'PayrollController@del_exist');
Route::post('payroll/preview', 'PayrollController@create');


/*
* employees routes
*/
Route::resource('employees', 'EmployeesController');
Route::get('employees/show/{id}', 'EmployeesController@show');
Route::group(['before' => 'create_employee'], function() {
Route::get('employees/create', 'EmployeesController@create');
});
Route::get('employees/edit/{id}', 'EmployeesController@edit');
Route::post('employees/update/{id}', 'EmployeesController@update');
Route::get('employees/delete/{id}', 'EmployeesController@destroy');





Route::get('payrollReports', function(){

    return view('employees.payrollreports');
});

Route::get('statutoryReports', function(){

    return view('employees.statutoryreports');
});

Route::get('email/payslip', 'payslipEmailController@index');
Route::post('email/payslip/employees', 'payslipEmailController@sendEmail');

Route::get('reports/employeelist', 'ReportsController@employees');
Route::get('employee/select', 'ReportsController@emp_id');
Route::post('reports/employee', 'ReportsController@individual');
Route::get('payrollReports/selectPeriod', 'ReportsController@period_payslip');
Route::post('payrollReports/payslip', 'ReportsController@payslip');
Route::get('payrollReports/selectAllowance', 'ReportsController@employee_allowances');
Route::post('payrollReports/allowances', 'ReportsController@allowances');
Route::get('payrollReports/selectDeduction', 'ReportsController@employee_deductions');
Route::post('payrollReports/deductions', 'ReportsController@deductions');
Route::get('payrollReports/selectPayePeriod', 'ReportsController@period_paye');
Route::post('payrollReports/payeReturns', 'ReportsController@payeReturns');
Route::get('payrollReports/selectRemittancePeriod', 'ReportsController@period_rem');
Route::post('payrollReports/payRemittances', 'ReportsController@payeRems');
Route::get('payrollReports/selectSummaryPeriod', 'ReportsController@period_summary');
Route::post('payrollReports/payrollSummary', 'ReportsController@paySummary');
Route::get('payrollReports/selectNssfPeriod', 'ReportsController@period_nssf');
Route::post('payrollReports/nssfReturns', 'ReportsController@nssfReturns');
Route::get('payrollReports/selectNhifPeriod', 'ReportsController@period_nhif');
Route::post('payrollReports/nhifReturns', 'ReportsController@nhifReturns');

/*
*##########################ERP REPORTS#######################################
*/


Route::get('erpReports', function(){
if (! Entrust::can('view_erp_reports') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
    $header='Reports';
    $description='View Reports';
    return view('erpreports.erpReports',compact('header','description'));
  }
});



Route::get('erpReports/clients', 'ErpReportsController@clients');
Route::get('erpReports/selectClientsPeriod', 'ErpReportsController@selectClientsPeriod');




Route::post('erpReports/items', 'ErpReportsController@items');
Route::get('erpReports/selectItemsPeriod', 'ErpReportsController@selectItemsPeriod');

Route::post('erpReports/expenses', 'ErpReportsController@expenses');
Route::get('erpReports/selectExpensesPeriod', 'ErpReportsController@selectExpensesPeriod');


Route::get('erpReports/paymentmethods', 'ErpReportsController@paymentmethods');

Route::get('erpReports/payments', 'ErpReportsController@payments');
Route::get('erpReports/selectPaymentsPeriod', 'ErpReportsController@selectPaymentsPeriod');

Route::get('erpReports/invoice/{id}', 'ErpReportsController@invoice');
Route::get('erpReports/customerstatement/{id}', 'ErpReportsController@customerstatement');
Route::get('erpReports/delivery_note/{id}', 'ErpReportsController@delivery_note');


Route::post('erpReports/sales', 'ErpReportsController@sales');
Route::get('erpReports/sales_summary', 'ErpReportsController@sales_Summary');
Route::get('erpReports/selectSalesPeriod', 'ErpReportsController@selectSalesPeriod');
Route::get('erpReports/selectSalesComparisonPeriod', 'ErpReportsController@selectSalesComparisonPeriod');
Route::post('erpReports/getComparisonReport', 'ErpReportsController@getSalesComparison');
Route::get('erpReports/selectSalesSummaryMonth', 'ErpReportsController@getSelectSummaryMonth');
Route::post('erpReports/customerSalesSummary', 'ErpReportsController@customerSalesSummary');



Route::post('erpReports/purchases', 'ErpReportsController@purchases');
Route::get('erpReports/selectPurchasesPeriod', 'ErpReportsController@selectPurchasesPeriod');



Route::get('erpReports/quotation/{id}', 'ErpReportsController@quotation');
Route::get('erpReports/pricelist', 'ErpReportsController@pricelist');
Route::post('erpReports/receipt/{id}', 'ErpReportsController@receipt');
Route::get('erpReports/PurchaseOrder/{id}', 'ErpReportsController@PurchaseOrder');

Route::get('erpReports/locations', 'ErpReportsController@locations');

Route::post('erpReports/stocks', 'ErpReportsController@stock');
Route::get('erpReports/selectStockPeriod', 'ErpReportsController@selectStockPeriod');


Route::get('erpReports/accounts', 'ErpReportsController@accounts');

Route::post('erpReports/vehicles', 'ErpReportsController@vehicles');
Route::get('erpReports/selectVehiclesPeriod', 'ErpReportsController@selectVehiclesPeriod');
Route::get('erpReports/mergedReport', 'ErpReportsController@mergedReport');




Route::resource('taxes', 'TaxController');
Route::post('taxes/update/{id}', 'TaxController@update');
Route::get('taxes/delete/{id}', 'TaxController@destroy');
Route::get('taxes/edit/{id}', 'TaxController@edit');


Route::resource('salestargets', 'SalestargetController');
Route::post('salestargets/update/{id}', 'SalestargetController@update');
Route::get('salestargets/delete/{id}', 'SalestargetController@destroy');
Route::get('salestargets/edit/{id}', 'SalestargetController@edit');




Route::get('erpmgmt', function(){

  return view('erpmgmt');

});






Route::get('financialreports', function(){

    $header='Reports';
    $description='Financial Report';

    return view('pdf.financials.reports',compact('header','description'));
});



Route::get('reports/listing', 'ReportsController@members');
Route::get('reports/remittance', 'ReportsController@remittance');
Route::get('reports/blank', 'ReportsController@template');
Route::get('reports/loanlisting', 'ReportsController@loanlisting');

Route::get('reports/loanproduct/{id}', 'ReportsController@loanproduct');

Route::get('reports/savinglisting', 'ReportsController@savinglisting');

Route::get('reports/savingproduct/{id}', 'ReportsController@savingproduct');

Route::post('reports/financials', 'ReportsController@financials');



Route::get('erpReports/kenya/{id}', 'ErpReportsController@kenya');


/*
* orders controllers
*/
/*Route::resource('orders', 'OrdersController');
Route::post('orders/update/{id}', 'OrdersControler@update');
Route::get('orders/edit/{id}', 'OrdersControler@edit');
Route::get('orders/delete/{id}', 'OrdersControler@destroy');*/




/*
* purchase orders controllers
*/
Route::resource('purchases', 'PurchasesController');
Route::post('purchases/update/{id}', 'PurchasesController@update');
Route::get('purchases/edit/{id}', 'PurchasesController@edit');
Route::get('purchases/delete/{id}', 'PurchasesController@destroy');


/*
* purchase orders controllers
*/
Route::resource('quotations', 'QuotationsController');
Route::post('quotations/update/{id}', 'QuotationsController@update');
Route::get('quotations/edit/{id}', 'QuotationsController@edit');
Route::get('quotations/delete/{id}', 'QuotationsController@destroy');





/* ########################  ERP ROUTES ################################ */

/* 
* items routes here 
*/
Route::resource('items', 'ItemsController');


/*
* client routes come here
*/

Route::resource('clients', 'ClientsController');


Route::resource('paymentmethods', 'PaymentmethodsController');


Route::resource('locations', 'LocationsController');
Route::get('locations/edit/{id}', 'LocationsController@edit');
Route::get('locations/delete/{id}', 'LocationsController@destroy');
Route::post('locations/update/{id}', 'LocationsController@update');


Route::resource('expenses', 'ExpensesController');

Route::resource('erporders', 'ErpordersController');
Route::resource('erppurchases', 'ErppurchasesController');
Route::resource('erpquotations', 'ErpquotationsController');


Route::resource('erporderitems', 'ErporderitemsController');
Route::resource('erppurchaseitems', 'ErppurchaseitemsController');
Route::resource('erpquotationitems', 'ErpquotationitemsController');

Route::resource('payments', 'PaymentsController');
// GET DAILY PAYMENTS RECEIVED & GENERATE PDF
Route::get('daily_payments/today', 'PaymentsController@dailyPayments');
Route::get('daily_payments/pdf', 'ErpReportsController@dailyPaymentsPDF');


// Route::get('erppurchases/payment/{id}',    'ErppurchasesController@payment');
// Route::post('erppurchases/payment/{id}',    'ErppurchasesController@recordpayment');

Route::resource('vehicles', 'VehiclesController');
Route::get('vehicles/edit/{id}', 'VehiclesController@edit');
Route::get('vehicles/delete/{id}', 'VehiclesController@destroy');
Route::post('vehicles/update/{id}', 'VehiclesController@update');
Route::get('vehicles/show/{id}', 'VehiclesController@show');

Route::resource('drivers', 'DriversController');
Route::get('drivers/edit/{id}', 'DriversController@edit');
Route::get('drivers/delete/{id}', 'DriversController@destroy');
Route::post('drivers/update/{id}', 'DriversController@update');
Route::get('drivers/show/{id}', 'DriversController@show');

Route::resource('assigndrivers', 'AssigndriversController');
Route::get('assigndrivers/edit/{id}', 'AssigndriversController@edit');
Route::get('assigndrivers/delete/{id}', 'AssigndriversController@destroy');
Route::post('assigndrivers/update/{id}', 'AssigndriversController@update');
Route::get('assigndrivers/show/{id}', 'AssigndriversController@show');


Route::get('salesorders', function(){

  $header='Sales Order';
  $description='View Sales Orders';
  $orders = Erporder::whereNull("is_pending")
            ->where(function($query)
            {
                $query->whereNull('is_cancelled')
                      ->orWhere('is_cancelled',1);
            })->orderBy("id","DESC")->get();
  $items = Item::all();
  $locations = Store::all();
   


  if (! Entrust::can('view_sale_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

  Audit::logaudit('Sales Orders', 'viewed sales orders', 'viewed sales orders in the system');

  return view('erporders.index', compact('items', 'locations', 'orders','erporders','header','description'));
}
});



Route::get('purchaseorders', function(){

  $purchases = Erporder::orderBy("id","DESC")->get();
  $items = Item::all();
  $locations = Store::all();
  $header='Purchase Order';
  $description='View Purchase Order';

if (! Entrust::can('view_purchase_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
 Audit::logaudit('Purchase Order', 'viewed purchase orders', 'viewed purchase orders in the system');

  return view('erppurchases.index', compact('items', 'locations', 'purchases','header','description'));
}
});



Route::get('quotationorders', function(){

  $quotations = Erporder::all();
  $items = Item::all();
  $locations = Store::all();
  $items = Item::all();
  $locations = Location::all();

  $header='Quotations';
  $description='View Quotations';

  if (! Entrust::can('view_quotation') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

  return view('erpquotations.index', compact('items', 'locations', 'quotations','header','description'));
}
});


Route::get('salesorders/create', function(){

  $count = DB::table('erporders')->count();
  $order_number = date("Y/m/d/").str_pad($count+1, 4, "0", STR_PAD_LEFT);
  $items = Item::all();
  $locations = Store::all();
  $header='Sales Order';
  $description='Create Sales Orders';
  $clients = Client::all();

  if (! Entrust::can('create_sale_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  return view('erporders.create', compact('items', 'locations', 'order_number', 'clients','header','description'));
}
});


Route::get('purchaseorders/create', function(){

  $count = DB::table('erporders')->count();
  $order_number = date("Y/m/d/").str_pad($count+1, 4, "0", STR_PAD_LEFT);
  $items = Item::all();
  $locations = Store::all();
  $erporders = Erporder::all();
  $header='Purchase Order';
  $description='Create Purchase Order';
  $clients = Client::all();

if (! Entrust::can('create_purchase_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  return view('erppurchases.create', compact('items', 'locations', 'order_number', 'clients', 'erporders','header','description'));
}
});


Route::get('quotationorders/create', function(){

  $count = DB::table('erporders')->count();
  $order_number = date("Y/m/d/").str_pad($count+1, 4, "0", STR_PAD_LEFT);;
  $items = Item::all();
  $locations = Store::all();

  $clients = Client::all();

  $header='Quotations';
  $description='Create Quotation';

if (! Entrust::can('create_quotation') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  return view('erpquotations.create', compact('items', 'locations', 'order_number', 'clients','header','description'));
}
});

Route::post('erporders/create', function(){

  $data = Input::all();

  $header='Sales Order';
  $description='Create ERP Order';

  $client = Client::findOrFail(array_get($data, 'client'));

/*
  $erporder = array(
    'order_number' => array_get($data, 'order_number'), 
    'client' => $client,
    'date' => array_get($data, 'date')

    );
  */

  Session::put( 'erporder', array(
    'order_number' => array_get($data, 'order_number'), 
    'client' => $client,
    'date' => array_get($data, 'date'),
    'payment_type' => array_get($data, 'payment_type'),
    'percentage_discount' => array_get($data, 'percentage_discount')

    )
    );
  Session::put('orderitems', []);

  $orderitems =Session::get('orderitems');

 /*
  $erporder = new Erporder;

  $erporder->date = date('Y-m-d', strtotime(array_get($data, 'date')));
  $erporder->order_number = array_get($data, 'order_number');
  $erporder->client()->associate($client);
  $erporder->payment_type = array_get($data, 'payment_type');
  $erporder->type = 'sales';
  $erporder->save();

  */

  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();

  return view('erporders.orderitems', compact('erporder', 'items', 'locations', 'taxes','orderitems','header','description'));

});



Route::post('erppurchases/create', function(){

  $data = Input::all();
  $client = Client::findOrFail(array_get($data, 'client'));

  $header='Purchase Order';
  $description='Create Purchase Order';

/*
  $erporder = array(
    'order_number' => array_get($data, 'order_number'), 
    'client' => $client,
    'date' => array_get($data, 'date')

    );
  */

  Session::put( 'erporder', array(
    'order_number' => array_get($data, 'order_number'), 
    'client' => $client,
    'date' => array_get($data, 'date')

    )
    );
  Session::put('purchaseitems', []);

  $orderitems =Session::get('purchaseitems');

 /*
  $erporder = new Erporder;

  $erporder->date = date('Y-m-d', strtotime(array_get($data, 'date')));
  $erporder->order_number = array_get($data, 'order_number');
  $erporder->client()->associate($client);
  $erporder->payment_type = array_get($data, 'payment_type');
  $erporder->type = 'sales';
  $erporder->save();

  */

  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();

  return view('erppurchases.purchaseitems', compact('items', 'locations','taxes','orderitems','header','description'));

});





Route::post('erpquotations/create', function(){

  $data = Input::all();

  $client = Client::findOrFail(array_get($data, 'client'));

/*
  $erporder = array(
    'order_number' => array_get($data, 'order_number'), 
    'client' => $client,
    'date' => array_get($data, 'date')

    );
  */

  Session::put( 'erporder', array(
    'order_number' => array_get($data, 'order_number'), 
    'client' => $client,
    'date' => array_get($data, 'date'),
    'percentage_discount' => array_get($data, 'percentage_discount')

    )
    );
  Session::put('quotationitems', []);

  $orderitems =Session::get('quotationitems');

 /*
  $erporder = new Erporder;

  $erporder->date = date('Y-m-d', strtotime(array_get($data, 'date')));
  $erporder->order_number = array_get($data, 'order_number');
  $erporder->client()->associate($client);
  $erporder->payment_type = array_get($data, 'payment_type');
  $erporder->type = 'sales';
  $erporder->save();

  */

  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();

  $header='Quotations';
  $description='Create Quotation';

  return view('erpquotations.quotationitems', compact('items', 'locations','taxes','orderitems','header','description'));

});







Route::post('orderitems/create', function(){

  $data = Input::all();
  $header='Sales Order';
  $description='Create ERP Order';

  $item = Item::findOrFail(array_get($data, 'item'));

  $item_name = $item->item_make;
  $price = $item->selling_price;
  $quantity = Input::get('quantity');
  $duration = Input::get('duration');
  $item_id = $item->id;
  $location = Input::get('location');
  $discount_amount = Input::get('percentage_discount');

   Session::push('orderitems', [
      'itemid' => $item_id,
      'item' => $item_name,
      'price' => $price,
      'quantity' => $quantity,
      'duration' => $duration,
      'location' =>$location,
      'discount_amount'=>$discount_amount
    ]);



  $orderitems = Session::get('orderitems');

   $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();

  return view('erporders.orderitems', compact('items', 'locations', 'taxes','orderitems','header','description'));

});






Route::post('purchaseitems/create', function(){

  $data = Input::all();

  $item = Item::findOrFail(array_get($data, 'item'));

  $item_name = $item->item_make;
  $price = $item->purchase_price;
  $size = $item->item_size;
  $quantity = Input::get('quantity');
  $duration = Input::get('duration');
  $unitprice = Input::get('unitprice');
  $item_id = $item->id;

   Session::push('purchaseitems', [
      'itemid' => $item_id,
      'item' => $item_name,
      'price' => $price,
      'size' => $size,
      'quantity' => $quantity,
      'duration' => $duration,
      'unitprice' => $unitprice
    ]);



  $orderitems = Session::get('purchaseitems');

   $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();
  $header='Purchase Order';
  $description='Create Purchase Order';

  return view('erppurchases.purchaseitems', compact('items', 'locations', 'taxes','orderitems','header','description'));

});






Route::post('quotationitems/create', function(){

  $data = Input::all();

  $item = Item::findOrFail(array_get($data, 'item'));

  $item_name = $item->item_make;
  $price = $item->selling_price;
  $quantity = Input::get('quantity');
  $duration = Input::get('duration');
  $item_id = $item->id;
  $discount_amount = Input::get('percentage_discount');

   Session::push('quotationitems', [
      'itemid' => $item_id,
      'item' => $item_name,
      'price' => $price,
      'quantity' => $quantity,
      'duration' => $duration,
      'discount_amount'=>$discount_amount

    ]);



  $orderitems = Session::get('quotationitems');
  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();

  $header='Quotations';
  $description='Create Quotation';

  return view('erpquotations.quotationitems', compact('items', 'locations', 'taxes','orderitems','header','description'));

});




/**
 * STOCKS
 */
Route::resource('stocks', 'StocksController');

Route::get('stock/tracking', function(){
  $stocks = Stock::all();
  $items = Item::all();
  $clients = Client::all();
  $location = Store::all();
  $leased = ItemTracker::all();

  if (! Entrust::can('track_stock') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  return view('stocks/track', compact('stocks', 'items', 'clients', 'location', 'leased'));
}
});

Route::get('confirmstock/{id}/{name}/{confirmer}/{key}', function($id,$name,$confirmer,$key){
  $stock = Stock::find($id);
  if($stock->confirmation_code != $key){
  $stock->is_confirmed = 1;
  $stock->confirmed_id = $confirmer;
  $stock->confirmation_code = $key;
  $stock->update();

  /*$order = Erporder::findorfail($erporder_id);
  $order->status = 'delivered';
  $order->update();*/

  $notification = Notification::where('confirmation_code',$key)->first();
  $notification->is_read = 1;
  $notification->update();

  return "<strong><span style='color:green'>Stock for item ".$name." confirmed as received!</span></strong>";
}else{
  return "<strong><span style='color:red'>Stock for item ".$name." already received!</span></strong>";
}
});


Route::get('notificationshowstock/{id}/{client}/{erporder_id}/{confirmer}/{key}', function($id,$client,$erporder_id,$confirmer,$key){
  $stock = Stock::find($id);
  $header='Stocks';
  $description='Confirm Stock';
  if($stock->confirmation_code != $key){
  $notification = Notification::where('confirmation_code',$key)->where('user_id',$confirmer)->first();
  $notification->is_read = 1;
  $notification->update();

  $item = Item::find($stock->itm_id);

  $erporder = Erporder::find($erporder_id);

  return view('stocks.showstock', compact('stock','client','item','erporder_id','confirmer','key','erporder','header','description'));
}else{
  $item = Item::find($stock->itm_id);
  return Redirect::to('notifications/index')->withDeleteMessage("Stock for item ".$item->item_make." already received!");
}
});

Route::get('notificationshowexpense/{name}/{type}/{amount}/{date}/{account}/{receiver}/{confirmer}/{key}', function($name,$type,$amount,$date,$account,$receiver,$confirmer,$key){
  $expense = Expense::where('confirmation_code',$key)->count();
  if($expense == 0){
  $notification = Notification::where('confirmation_code',$key)->where('user_id',$confirmer)->first();
  $notification->is_read = 1;
  $notification->update();

  $acc = Account::find($account);
  $header='Expenses';
  $description='Check Expense';
  return view('expenses.checkexpense', compact('name','type','amount','date','account','receiver','confirmer','key','acc','header','description'));
}else{
  return Redirect::to('notifications/index')->withDeleteMessage("Expense for item ".$name." already checked!");
}
});

Route::post('notificationcheckexpense', function(){

    $notification = Notification::where('confirmation_code',Input::get("key"))->first();
    $notification->is_read = 1;
    $notification->update();

  $username = Auth::user()->name;

  $u = DB::table("users")->where("id",Input::get("receiver"))->first();

    $users = DB::table('roles')
    ->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
    ->join('users', 'assigned_roles.user_id', '=', 'users.id')
    ->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
    ->select("users.id","email","users.name")
    ->where("permission_id",141)->get();

        $key = md5(uniqid());

    foreach ($users as $user) {

    Notification::notifyUser($user->id,"Hello, Please approve expense inserted for item ".Input::get('name'),"approve expense","notificationshowapproveexpense/".Input::get('name')."/".Input::get('type')."/".Input::get('amount')."/".date("Y-m-d",strtotime(Input::get('date')))."/".Input::get('account')."/".Auth::user()->id."/".$user->id."/".Input::get("receiver")."/".$key,$key);
      }
   Audit::logaudit('Expenses', 'checked an expense', 'checked expense '.Input::get('name').' created by user '.$u->name.' in the system');

  return Redirect::to('notifications/index')->withFlashMessage("Expense for item ".Input::get('item')." confirmed as checked! A final approval is required");
});

Route::get('notificationshowapproveexpense/{name}/{type}/{amount}/{date}/{account}/{checker}/{confirmer}/{receiver}/{key}', function($name,$type,$amount,$date,$account,$checker,$confirmer,$receiver,$key){
  $expense = Expense::where('approve_code',$key)->count();
  if($expense == 0){
  $notification = Notification::where('confirmation_code',$key)->where('user_id',$confirmer)->first();
  $notification->is_read = 1;
  $notification->update();

  $acc = Account::find($account);
  $header='Expenses';
  $description='Approve Expense';
  return view('expenses.showexpense', compact('name','type','amount','date','account','receiver','confirmer','checker','key','acc','header','description'));
}else{
  return Redirect::to('notifications/index')->withDeleteMessage("Expense for item ".$name." already approved!");
}
});

Route::post('notificationconfirmstock', function(){
  $stock = Stock::find(Input::get("id"));
  $stock->is_confirmed = 1;
  $stock->confirmed_id = Input::get("confirmer");
  $stock->confirmation_code = Input::get("key");
  $stock->update();

  $user = DB::table("users")->where('id',$stock->receiver_id)->first();

  /*$order = Erporder::findorfail(Input::get("erporder_id"));
  $order->status = 'delivered';
  $order->update();*/

    $notification = Notification::where('confirmation_code',Input::get("key"))->first();
    $notification->is_read = 1;
    $notification->update();

    $erporder = Erporder::find(Input::get("erporder_id"));

    $item = Item::find($stock->itm_id);
    $client = Client::find($erporder->client_id);

  Audit::logaudit('Stocks', 'approve stocks', 'approved stock for item '.$item->item_make.' quantity received '.Input::get("quantity").' from supplier '.$client->name.' received by user '.$user->name.' in the system');

  return Redirect::to('notifications/index')->withFlashMessage("Stock for item ".Input::get('item')." confirmed as received!");
});

Route::post('notificationapproveexpense', function(){

  $expense = new Expense;

    $expense->name = Input::get('name');
    $expense->type = Input::get('type');
    $expense->amount = Input::get('amount');    
    $expense->date = date("Y-m-d",strtotime(Input::get('date')));
    $expense->account_id = Input::get('account');
    $expense->receiver_id = Input::get("receiver");
    $expense->confirmed_id = Input::get("confirmer");
    $expense->confirmation_code = Input::get("key");
    $expense->save();

        DB::table('accounts')
            ->join('expenses','accounts.id','=','expenses.account_id')
            ->where('accounts.id', Input::get('account'))
            ->decrement('accounts.balance', Input::get('amount'));

            $user = DB::table('users')->where('id',Input::get("receiver"))->first();

  /*$order = Erporder::findorfail(Input::get("erporder_id"));
  $order->status = 'delivered';
  $order->update();*/

  $notification = Notification::where('confirmation_code',Input::get("key"))->first();
    $notification->is_read = 1;
    $notification->update();

  Audit::logaudit('Expenses', 'approved an expense', 'approved expense '.Input::get('name').' created by user '.$user->name.' in the system');

  return Redirect::to('notifications/index')->withFlashMessage("Expense for item ".Input::get('item')." confirmed as approved!");
});


/**
 * LEASE AN ITEM
 */
Route::resource('lease', 'LeaseController');

Route::post('stock/lease', function(){
  $client_id = Input::get('client');
  $item_id = Input::get('item');
  $location_id = Input::get('location');
  $quantity = Input::get('lease_qty');

  $item = Item::findOrfail($item_id);
  $client = Client::find($client_id);
  $timestamp = date("Y-m-d H:i:s");
  $location = Store::findorfail($location_id);

  if($quantity > Stock::getStockAmountNew($item)){
    return Redirect::back()->with('warning', "Quantity Exceeds Total Stocks!");
  } else if($client_id === "" || $item_id === "" || $quantity === ""){
    return 'Enter all the fields!';
  } else{

    $track = new ItemTracker;
    $track->item_id = $item_id;
    $track->items_leased = $quantity;
    $track->location_id = $location_id;
    $track->client_id = $client_id;
    $track->status = "$quantity Item(s) Leased";
    $track->date_leased = date("Y-m-d");
    $track->save();

    $stock = DB::table('stocks')
    ->join("erporderitems","erporderitems.erporder_id","=","stocks.item_id")
    ->join("items","erporderitems.item_id","=","items.id")
    ->whereIn('items.id', array($item_id))
    ->where('stocks.is_confirmed', '=', 1)
    ->select('stocks.item_id')
    ->first();

    Stock::removeStock($track->id,$item_id, $location_id, $quantity, $timestamp);
    Audit::logaudit('Lease Item', 'leased item', 'leased item '.$item->item_make.' to customer '.$client->name.' in the system');
    return Redirect::back()->with('message', 'Item(s) successfully leased.');
  }

});


/**
 * RETURN LEASED ITEM(S)
 */
Route::post('stock/return', function(){
  $id = Input::get('track_id');
  $erporder_id = Input::get('erporder_id');
  $client_id = Input::get('client_id');
  $qty = Input::get('qty_returned');

  
  $timestamp = date("Y-m-d");
  $location = Store::findorfail(ItemTracker::where('id', $id)->pluck('location_id'));
  
  $returned = ItemTracker::findOrfail($id);
  $returned->items_returned = $returned->items_returned + $qty;
  $returned->status = "$qty Item(s) returned";
  $returned->date_returned = date("Y-m-d");
  $returned->update();

  $item = Item::findOrfail($returned->item_id);
  $client = Client::find($client_id);

  /*$stock = DB::table('stocks')
    ->join("erporderitems","erporderitems.erporder_id","=","stocks.item_id")
    ->join("items","erporderitems.item_id","=","items.id")
    ->whereIn('items.id', $returned->item_id)
    ->where('stocks.is_confirmed', '=', 1)
    ->select('stocks.item_id')
    ->first();*/

  Stock::addStock($client_id, $returned->item_id, $erporder_id, $returned->location_id, $qty, $timestamp);

  Audit::logaudit('Return Item', 'returned item', 'returned item '.$item->item_make.' leased to customer '.$client->name.' in the system');
  return Redirect::back()->with('message', 'Item(s) successfully returned.');

});



Route::resource('erporders', 'ErporderssController');






Route::post('erporder/commit', function(){

  $erporder = Session::get('erporder');

  $erporderitems = Session::get('orderitems');
  
   $total = Input::all();

 // $client = Client: :findorfail(array_get($erporder, 'client'));

 // print_r($total);


  $order = new Erporder;
  $order->order_number = array_get($erporder, 'order_number');
  $order->client()->associate(array_get($erporder, 'client'));
  $order->date = date('Y-m-d', strtotime(array_get($erporder, 'date')));
  $order->status = 'new';
  $order->discount_amount = array_get($total, 'discount');
  $order->type = 'sales';  
  $order->payment_type = array_get($erporder, 'payment_type');
  $order->save();

  $client = Client::find($order->client_id);
  

  foreach($erporderitems as $item){


    $itm = Item::findOrFail($item['itemid']);

    $ord = Erporder::findOrFail($order->id);


    
    $location_id = $item['location'];

     $location = Store::find($location_id);    
    
    $date = date('Y-m-d', strtotime(array_get($erporder, 'date')));

    $orderitem = new Erporderitem;
    $orderitem->erporder()->associate($ord);
    $orderitem->item()->associate($itm);
    $orderitem->price = $item['price'];
    $orderitem->quantity = $item['quantity'];
    $orderitem->duration = $item['duration'];
    $orderitem->client_discount = $item['discount_amount'] * $item['quantity'];
    $orderitem->save();

    $stock = DB::table('stocks')
    ->join("erporderitems","erporderitems.erporder_id","=","stocks.item_id")
    ->join("items","erporderitems.item_id","=","items.id")
    ->whereIn('items.id', array($itm->id))
    ->where('stocks.is_confirmed', '=', 1)
    ->select('stocks.item_id')
    ->first();

   Stock::removeStock($order->id, $itm->id, $location, $item['quantity'], $date);



  }
 

  $tax = Input::get('tax');
  $rate = Input::get('rate');





  for($i=0; $i < count($rate);  $i++){

    $txOrder = new TaxOrder;

    $txOrder->tax_id = $rate[$i];
    $txOrder->order_number = array_get($erporder, 'order_number');
    $txOrder->amount = $tax[$i];
    $txOrder->save();
    
  }
  
 
//Session::flush('orderitems');
//Session::flush('erporder');  
 
Audit::logaudit('Sales Order', 'created sales order', 'created a sales order with order number '.array_get($erporder, 'order_number').' for client '.$client->name.' in the system');

return Redirect::to('salesorders')->withFlashMessage('Order Successfully Placed!');



});


Route::get('erppurchase/commit', function(){

  //$orderitems = Session::get('erppurchase');

  $erporder = Session::get('erporder');

  $orderitems = Session::get('purchaseitems');
  
   $total = Input::all();

 // $client = Client: :findorfail(array_get($erporder, 'client'));

 // print_r($total);

  $order = new Erporder;
  $order->order_number = array_get($erporder, 'order_number');
  $order->client()->associate(array_get($erporder, 'client'));
  $order->date = date('Y-m-d', strtotime(array_get($erporder, 'date')));
  $order->status = 'new';
  //$order->discount_amount = array_get($total, 'discount');
  $order->type = 'purchases';
  $order->save();
  
  $client = Client::find($order->client_id);


  foreach($orderitems as $item){


    $itm = Item::findOrFail($item['itemid']);

    $ord = Erporder::findOrFail($order->id);

    $orderitem = new Erporderitem;
    $orderitem->erporder()->associate($ord);
    $orderitem->item()->associate($itm);
    $orderitem->price = $item['unitprice'];
    $orderitem->quantity = $item['quantity'];
    //s$orderitem->duration = $item['duration'];
    $orderitem->save();
  }
  
 
//Session::flush('orderitems');
//Session::flush('erporder');
Audit::logaudit('Purchase Order', 'created purchase order', 'created a purchase order with order number '.array_get($erporder, 'order_number').' for client '.$client->name.' in the system');

return Redirect::to('purchaseorders');



});


Route::post('erpquotation/commit', function(){

  $erporder = Session::get('erporder');

  $erporderitems = Session::get('quotationitems');
  
   $total = Input::all();

 // $client = Client: :findorfail(array_get($erporder, 'client'));

 // print_r($total);


  $order = new Erporder;
  $order->order_number = array_get($erporder, 'order_number');
  $order->client()->associate(array_get($erporder, 'client'));
  $order->date = date('Y-m-d', strtotime(array_get($erporder, 'date')));
  $order->status = 'new';
  $order->discount_amount = array_get($total, 'discount');
  $order->type = 'quotations';  
  $order->save();

  $client = Client::find($order->client_id);
  

  foreach($erporderitems as $item){


    $itm = Item::findOrFail($item['itemid']);

    $ord = Erporder::findOrFail($order->id);


    
    //$location_id = $item['location'];

     //$location = Location::find($location_id);    
    
    $date = date('Y-m-d', strtotime(array_get($erporder, 'date')));

    $orderitem = new Erporderitem;
    $orderitem->erporder()->associate($ord);
    $orderitem->item()->associate($itm);
    $orderitem->price = $item['price'];
    $orderitem->quantity = $item['quantity'];
    $orderitem->client_discount = $item['discount_amount'] * $item['quantity'];
    $orderitem->save();

     }
 

  $tax = Input::get('tax');
  $rate = Input::get('rate');





  for($i=0; $i < count($rate);  $i++){

    $txOrder = new TaxOrder;

    $txOrder->tax_id = $rate[$i];
    $txOrder->order_number = array_get($erporder, 'order_number');
    $txOrder->amount = $tax[$i];
    $txOrder->save();
    
  }
  
 
//Session::flush('orderitems');
//Session::flush('erporder');  
 
Audit::logaudit('Quotation', 'created quotation', 'created a quotation with order number '.array_get($erporder, 'order_number').' for client '.$client->name.' in the system');

return Redirect::to('quotationorders');


});


Route::get('erporders/cancel/{id}', function($id){

$order = Erporder::findorfail($id);

if (! Entrust::can('cancel_sale_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

  $order->status = 'cancelled';
  $order->update();

  return Redirect::to('salesorders');
}
  
});

Route::get('approve/cancel/{id}', function($id){

$order = Erporder::findorfail($id);
$header='Sales Order';
$description='Cancel Sale Order';

if (! Entrust::can('cancel_sale_order') ) // Checks the current user
  {
  return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
  }else{
  if (! Entrust::can('approve_cancel_sale_order') ){

  $users = DB::table('roles')
        ->join('assigned_roles', 'roles.id', '=', 'assigned_roles.role_id')
        ->join('users', 'assigned_roles.user_id', '=', 'users.id')
        ->join('permission_role', 'roles.id', '=', 'permission_role.role_id') 
        ->where("permission_id",140)
        ->select("users.id","email","users.name")
        ->get();

        $key = md5(uniqid());

  $order->cancelled_by = Auth::user()->id;
  $order->is_pending = 1;
  $order->update();

  foreach ($users as $user) {
  Notification::notifyUser($user->id,"Hello, Please approve cancellation of Sale order ".$order->order_number,"cancel sale order","erporders/notifyshow/".$key."/".$user->id."/".$id,$key);
  } 

  Audit::logaudit('Cancel Sale Order', 'cancelled sale order', 'cancelled sale order, order number '.$order->order_number.' but awaiting approval in the system');

  return Redirect::to('erporders/show/'.$id)->with('notice', 'Please await approval to complete cancellation');
  }else{

  $order->cancelled_by = Auth::user()->id;
  $order->approve_cancel_by = Auth::user()->id;
  $order->is_cancelled = 1;
  $order->status = 'cancelled';
  $order->update();

  Audit::logaudit('Cancel Sale Order', 'cancelled sale order', 'cancelled sale order, order number '.$order->order_number.' in the system');

  return Redirect::to('salesorders');
}
}
  
});

Route::get('notification/approve/cancel/{id}/{key}/{user}', function($id,$key,$user){

$order = Erporder::findorfail($id);


  $order->cancelled_by = $user;
  $order->approve_cancel_by = Auth::user()->id;
  $order->is_cancelled = 1;
  $order->is_pending = null;
  $order->status = 'cancelled';
  $order->update();

    $notification = Notification::where('confirmation_code',$key)->first();
    $notification->is_read = 1;
    $notification->update();

  Audit::logaudit('Approve Cancel Sale Order', 'approved cancellation of sale order', 'approved cancellation of sale order '.$order->order_number.' in the system');

  return Redirect::to('salesorders');

  
});


Route::get('notificationshowpayment/{preparedby}/{user}/{key}/{id}', function($preparedby,$user,$key,$id){

$notification = Notification::where('confirmation_code',$key)->where('user_id',$user)->first();
    $notification->is_read = 1;
    $notification->update();

    $header='Payments';
    $description='Approve Payment';

    $payment = Payment::find($id);
    $erporder = Erporder::find($payment->erporder_id);
    $account = Account::find($payment->account_id);
    $paymentmethod = Paymentmethod::find($payment->paymentmethod_id);

    if($payment->confirmation_code != $key){

    return view('payments.showpayment', compact('id','key','user','preparedby','payment','erporder','account','paymentmethod','header','description'));
  }else{
    return Redirect::to('notifications/index')->withDeleteMessage('Item has already been approved!');
  }

  
});

Route::post('payment/approvepayment', function(){

        $p = Payment::find(Input::get("id"));
        $p->confirmed_id = Auth::user()->id;
        $p->is_approved = 1;
        $p->confirmation_code = Input::get("key");
        $p->update();

    $notification = Notification::where('confirmation_code',Input::get("key"))->first();
    $notification->is_read = 1;
    $notification->update();

return Redirect::to('notifications/index')->withFlashMessage('Successfully approved payment!');

  
});

Route::get('erporders/delivered/{id}', function($id){

  $order = Erporder::findorfail($id);

  if (! Entrust::can('approve_delivered_sale_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  $order->status = 'delivered';
  $order->update();

  Audit::logaudit('Sales Order', 'delivered sales order', 'delivered sales order, order number '.$order->order_number.' in the system');

  return Redirect::to('salesorders');
  }
});


Route::get('erppurchases/cancel/{id}', function($id){

  $order = Erporder::findorfail($id);

  if (! Entrust::can('cancel_purchase_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  $order->status = 'cancelled';
  $order->update();

  Audit::logaudit('Purchase Order', 'cancelled purchase order', 'cancelled purchase order, order number '.$order->order_number.' in the system');

  return Redirect::to('purchaseorders');
  }
});



Route::get('erppurchases/delivered/{id}', function($id){

  $order = Erporder::findorfail($id);

  if (! Entrust::can('approve_delivered_purchase_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  $order->status = 'delivered';
  $order->update();

  Audit::logaudit('Purchase Order', 'delivered purchase order', 'delivered purchase order, order number '.$order->order_number.' in the system');

  return Redirect::to('purchaseorders');
  }
});




Route::get('erpquotations/cancel/{id}', function($id){

  $order = Erporder::findorfail($id);

  $order->status = 'cancelled';
  $order->update();

  return Redirect::to('quotationorders');
  
});




Route::get('erporders/show/{id}', function($id){

  $order = Erporder::findorfail($id);
  $client = Client::where("id",$order->client_id)->first();
  $items = Item::all();
  $location = Store::all();
  $leased = ItemTracker::where("client_id",$order->client_id)->get();
  $header='Sales Order';
  $description='View Sale Order';
  $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->first();

  $driver = Driver::all();
    //return $driver;

  if (! Entrust::can('view_sale_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{
  Audit::logaudit('Sales Order', 'viewed a sales order', 'viewed a sale order for customer '.$client->name.' order number '.$order->order_number.' in the system');

  return view('erporders.show', compact('order', 'driver', 'orders','id','client','items','location','leased','header','description'));
  }
});



Route::get('erppurchases/show/{id}', function($id){

  $order = Erporder::findorfail($id);
  $client = Client::find($order->client_id);
  $header='Purchase Order';
  $description='View Purchase Order';

  if (! Entrust::can('view_purchase_order') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

  Audit::logaudit('Purchase Order', 'viewed a purchase order', 'viewed a purchase order for supplier '.$client->name.' order number '.$order->order_number.' in the system');

  return view('erppurchases.show', compact('order','header','description'));
}  
});



Route::get('erppurchases/notifyshow/{key}/{user}/{id}', function($key,$user,$id){

    $notification = Notification::where('confirmation_code',$key)->first();
    $notification->is_read = 1;
    $notification->update();

    return Redirect::to('erppurchases/show/'.$id);
  
});


Route::get('erporders/notifyshow/{key}/{user}/{id}', function($key,$user,$id){

    $notification = Notification::where('confirmation_code',$key)->where('user_id',$user)->first();
    $notification->is_read = 1;
    $notification->update();

    $order = Erporder::findorfail($id);
  $client = Client::where("id",$order->client_id)->first();
  $items = Item::all();
  $location = Store::all();
  $leased = ItemTracker::where("client_id",$order->client_id)->get();
  $header='Sales Order';
  $description='Cancel Sale Order';

  $orders = DB::table('erporders')
                ->join('erporderitems', 'erporders.id', '=', 'erporderitems.erporder_id')
                ->join('items', 'erporderitems.item_id', '=', 'items.id')
                ->join('clients', 'erporders.client_id', '=', 'clients.id')
                ->where('erporders.id','=',$id)
                ->select('clients.name as client','items.item_make as item','quantity','clients.address as address',
                  'clients.phone as phone','clients.email as email','erporders.id as id',
                  'discount_amount','erporders.order_number as order_number','price','description')
                ->first();

  $driver = Driver::all();
    //return $driver;

  return view('erporders.showApprove', compact('order', 'driver', 'orders','id','client','items','location','leased','key','user','header','description'));
  
});


Route::get('erppurchases/payment/{id}', function($id){

  $payments = Payment::all();

  $purchase = Erporder::findorfail($id);    

  $account = Accounts::all();

  return view('erppurchases.payment', compact('payments', 'purchase', 'account'));
  
});



Route::get('erpquotations/show/{id}', function($id){

  $order = Erporder::findorfail($id);

  $client = Client::findorfail($order->client_id);

  $header='Quotations';
  $description='View Quotation';

  if (! Entrust::can('view_quotation') ) // Checks the current user
        {
        return Redirect::to('/')->with('notice', 'you do not have access to this resource. Contact your system admin');
        }else{

  Audit::logaudit('Quotation', 'viewed quotation', 'viewed quotation for customer '.$client->name.' order number '.$order->order_number.' in the system');

  return view('erpquotations.show', compact('order','header','description'));
}
  
});


/**
 * 
 * EDITING AND DELETING OF QUOTATIONS AND ORDERS (PURCHASES, SALES)
 * =================================================================
 * === QUOTATIONS ===
 * === EDITING ITEMS IN SESSION (IN CART) ===
 *** Deleting a session item 
 */
Route::get('quotationitems/remove/{count}', function($count){
  $items = Session::get('quotationitems');
  unset($items[$count]);
  $newItems = array_values($items);
  Session::put('quotationitems', $newItems);


  $orderitems = Session::get('quotationitems');
  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();

  $header='Quotations';
  $description='Create Quotation';

  return view('erpquotations.quotationitems', compact('items', 'locations', 'taxes','orderitems','header','description'));
  //return Session::get('quotationitems')[$count];
});


/**
 * EDITING QUOTATION ITEMS IN SESSION
 */
Route::get('quotationitems/edit/{count}', function($count){
  $editItem = Session::get('quotationitems')[$count];

  $header='Quotations';
  $description='Edit Quotation';
  return view('erpquotations.sessionedit', compact('editItem', 'count','header','description'));
});


Route::post('erpquotations/sessionedit/{count}', function($sesItemID){
  $quantity = Input::get('qty');
  $price = (float) Input::get('price');

  $ses = Session::get('quotationitems');
  
  $ses[$sesItemID]['quantity']=$quantity;
  $ses[$sesItemID]['price']=$price;
  Session::put('quotationitems', $ses);

  $orderitems = Session::get('quotationitems');
  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();

  $header='Quotations';
  $description='Create Quotation';

  return view('erpquotations.quotationitems', compact('items', 'locations', 'taxes','orderitems','header','description'));
});


/**
 * === EDITING SALES ORDER ===
 * Deleing items from order session
 */
Route::get('orderitems/remove/{count}', function($count){
  $items = Session::get('orderitems');
  unset($items[$count]);
  $newItems = array_values($items);
  Session::put('orderitems', $newItems);


  $orderitems = Session::get('orderitems');
  //dd($orderitems);
  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();
  $header='Sales Order';
  $description='Create ERP Order';

  return view('erporders.orderitems', compact('items', 'locations', 'taxes','orderitems','header','description'));
});


/**
 * EDITING SALES ORDER IN SESSION
 */
Route::get('orderitems/edit/{count}', function($count){
  $editItem = Session::get('orderitems')[$count];
  $header='Sales Order';
  $description='Edit ERP Order';

  return view('erporders.edit', compact('editItem', 'count','header','description'));
});

Route::post('orderitems/edit/{count}', function($sesItemID){
  $quantity = Input::get('qty');
  $price = (float) Input::get('price');
  //return $data['qty'].' - '.$data['price'];

  $ses = Session::get('orderitems');
  //unset($ses);
  $ses[$sesItemID]['quantity']=$quantity;
  $ses[$sesItemID]['price']=$price;
  Session::put('orderitems', $ses);

  $orderitems = Session::get('orderitems');
  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();
  $header='Sales Order';
  $description='Create ERP Order';

  return view('erporders.orderitems', compact('items', 'locations', 'taxes','orderitems','header','description'));
  
});


/**
 * === EDITING PURCHASE ORDERS === 
 * Deleting items from purchase order session
 */
Route::get('purchaseitems/remove/{count}', function($count){
  $items = Session::get('purchaseitems');
  unset($items[$count]);
  $newItems = array_values($items);
  Session::put('purchaseitems', $newItems);


  $orderitems = Session::get('purchaseitems');
  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();
  $header='Purchase Order';
  $description='Create Purchase Order';

  return view('erppurchases.purchaseitems', compact('items', 'locations', 'taxes','orderitems','header','description'));
});


/**
 * EDIT PURCHASE ITEMS IN SESSION
 */
Route::get('purchaseitems/edit/{count}', function($count){
  $editItem = Session::get('purchaseitems')[$count];
  $header='Purchase Order';
  $description='Edit Purchase Order';
  return view('erppurchases.edit', compact('editItem', 'count','header','description'));
});

Route::post('erppurchases/edit/{count}', function($sesItemID){
  $quantity = Input::get('qty');
  $price = (float) Input::get('price');
  //return $data['qty'].' - '.$data['price'];

  $ses = Session::get('purchaseitems');
  //unset($ses);
  $ses[$sesItemID]['quantity']=$quantity;
  $ses[$sesItemID]['unitprice']=$price;
  Session::put('purchaseitems', $ses);

  $orderitems = Session::get('purchaseitems');
  $items = Item::all();
  $locations = Store::all();
  $taxes = Tax::all();
  $header='Purchase Order';
  $description='Create Purchase Order';

  return view('erppurchases.purchaseitems', compact('items', 'locations', 'taxes','orderitems','header','description'));
  
});


/**
 * === END EDITING AND DELETING ===
 */


/**
 * QUOTATION ACTIONS (APPROVE, REJECT, MAIL)
 * === APPROVE QUOTATION 'X' ===
 */
Route::post('/erpquotations/approve', function(){
  $id = Input::get('order_id');
  $comment = Input::get('comment');

  $order = Erporder::findorfail($id);
  $client = Client::find($order->client_id);

  $order->status = 'APPROVED';
  if($comment === ''){
    $order->comment = 'No comment.';
  } else{
    $order->comment = $comment;
  }

  $order->update();

  Audit::logaudit('Quotation', 'approved quotation', 'approved quotation for client '.$client->name.' order number '.$order->order_number.' in the system');

  return Redirect::to('erpquotations/show/'.$id);
});


/**
 * REJECT QUOTATION 'X'
 */
Route::post('/erpquotations/reject', function(){
  $id = Input::get('order_id');
  $comment = Input::get('comment');

  $order = Erporder::findorfail($id);
  $client = Client::find($order->client_id);

  $order->status = 'REJECTED';
  if($comment === ''){
    $order->comment = 'No comment.';
  } else{
    $order->comment = $comment;
  }

  $order->update();

  Audit::logaudit('Quotation', 'rejected quotation', 'rejected quotation for client '.$client->name.' order number '.$order->order_number.' in the system');

  return Redirect::to('erpquotations/show/'.$id);
});


/**
 * MAIL ERP QUOTATION TO CLIENT 'X'
 */
Route::post('erpquotations/mail', 'ErpReportsController@sendMail_quotation');
Route::post('purchaseorders/mail', 'ErpReportsController@sendpomail');

/**
 * EDIT QUOTATION 'X'
 */
Route::get('erpquotations/edit/{id}', function($id){
  $order = Erporder::findorfail($id);
  $items = Item::all();
  $taxes = Tax::all();
  $header='Quotations';
  $description='Edit Quotation';
  $tax_orders = TaxOrder::where('order_number', $order->order_number)->orderBy('tax_id', 'ASC')->get();

  //return $tax_orders;
  return view('erpquotations.editquotation', compact('order', 'items', 'taxes', 'tax_orders','header','description'));

});


/**
 * ADD ITEMS TO EXISTING ORDER
 */
Route::post('erpquotations/edit/add', function(){
    $order_id = Input::get('order_id');
    $item_id = Input::get('item_id');
    $quantity = Input::get('quantity');

    $order = Erporder::find($order_id);

    $client = Client::find($order->client_id);
    
    $item = Item::findorfail($item_id);
    $item_price = $item->selling_price;

    $itemId = Erporderitem::where('erporder_id', $order_id)->where('item_id', $item_id)->get();
    
    if(count($itemId) > 0){
        return Redirect::back()->with('error', "Item already exists! You can edit the existing item.");
    } else{
        $order_item = new Erporderitem;
        
        $order_item->item_id = $item_id;
        $order_item->quantity = $quantity;
        $order_item->erporder_id = $order_id;   
        $order_item->price = $item_price;
        $order_item->save();

        Audit::logaudit('Quotation', 'edit quotation', 'edited quotation for client '.$client->name.' order number '.$order->order_number.' in the system');

        return Redirect::back(); 
    }
});


/**
 * COMMIT CHANGES
 */
Route::post('erpquotations/edit/{id}', function($id){
    $order = Erporder::findOrFail($id);

    foreach($order->erporderitems as $orderitem){
        $val = Input::get('newQty'.$orderitem->item_id);
        $price = Input::get('newPrice'.$orderitem->item_id);
        
        $orderitem->price = $price;
        $orderitem->quantity = $val;
        $orderitem->save();
    }  

    $discount = Input::get('discount');
    $order->discount_amount = $discount;

    $tax = Input::get('tax');
    $rate = Input::get('rate');

    for($i=0; $i < count($rate);  $i++){
        if(count(TaxOrder::getAmount($rate[$i],$order->order_number)) > 0){
            $txOrder = TaxOrder::findOrfail($rate[$i]);
            $txOrder->amount = $tax[$i];
            $txOrder->update();
        } else{
            $txOrder = new TaxOrder;
            $txOrder->tax_id = $rate[$i];
            $txOrder->order_number = array_get($order, 'order_number');
            $txOrder->amount = $tax[$i];
            $txOrder->save();
        }
    }

    $order->status = 'EDITED';
    $order->update();
    $header='Quotations';
  $description='View Quotation';
    return view('erpquotations.show', compact('order','header','description'));
});









Route::get('api/getrate', function(){
    $id = Input::get('option');
    $tax = Tax::find($id);
    return $tax->rate;
});

Route::get('api/getprice', function(){
    $id = Input::get('option');
    $item = Item::find($id);
    return $item->purchase_price;
});

Route::get('api/getdiscount', function(){
    $id = Input::get('option');
    $cid = Input::get('client');

    $price = Price::where('client_id',$cid)->where('Item_id',$id)->first();
    $count = Price::where('client_id',$cid)->where('Item_id',$id)->count();
   if($count == 0){
    return 0;
   }else{
    return $price->Discount;
  }
});

Route::get('api/getsellingprice', function(){
    $id = Input::get('option');
    $item = Item::find($id);
    return $item->selling_price;
});

Route::get('api/getcontact', function(){
    $id = Input::get('option');
    $driver = Driver::find($id);
    return $driver->contact;
});

Route::get('api/getmodel', function(){
    $id = Input::get('option');
    $vehicle = Vehicle::find($id);
    return $vehicle->model;
});



 Route::get('api/getpurchased', function(){
     $id = Input::get('option');
     $erporderitems = Erporderitem::find($id);
    return $erporderitems->item_id;
});

Route::get('api/bankbranches', function(){
    $id = Input::get('option');
    $bbranch = Bank::find($id)->bankbranch;
    return $bbranch->pluck('bank_branch_name', 'id');
});

Route::get('api/dropdown', function(){
    $id = Input::get('option');
    $erporderitems = Erporder::join('erporderitems','erporders.id','=','erporderitems.erporder_id')
                             ->join('items','erporderitems.item_id','=','items.id')
                             ->where('client_id',$id)
                             ->where(function($query)
                             {
                               $query->whereNull('erporders.is_paid')
                                     ->orWhere('erporders.is_paid', 0);
                             })
                             ->groupBy('erporders.id')
                             ->where('erporders.status','new')
                             ->havingRaw('balance > 0 or balance is null')
                             ->select('erporders.id',  DB::raw('CONCAT(order_number," : ",item_make," (Actual amount: ", sum(price * item_size * quantity),")") AS erporder'), DB::raw('(SELECT (sum(price * quantity * item_size) - sum(amount_paid)) FROM payments t WHERE t.erporder_id=erporders.id and t.client_id='.$id.') AS balance'))
                   ->get('erporder', 'id');
    return $erporderitems;
});

Route::get('api/salesdropdown', function(){
    $id = Input::get('option');
    $erporderitems = Erporder::join('erporderitems','erporders.id','=','erporderitems.erporder_id')
                             ->join('items','erporderitems.item_id','=','items.id')
                             /*->join(DB::raw('(select sum(discount) as discount, prices.client_id from prices left join erporderitems on prices.item_id=erporderitems.item_id where prices.client_id='.$id.' and prices.item_id = erporderitems.item_id group by erporder_id) as p'), function($join){
                                 $join->on('erporders.client_id', '=', 'p.client_id');
                            })*/
                             ->where('erporders.client_id',$id)
                             ->where(function($query)
                             {
                               $query->whereNull('erporders.is_paid')
                                     ->orWhere('erporders.is_paid', 0);
                             })
                             ->groupBy('erporders.id')
                             ->havingRaw('balance > 0 or balance is null')
                             ->where('erporders.status','new')
                             ->select(DB::raw('CONCAT(erporders.id," : ",items.id) AS eid'), DB::raw('CONCAT(order_number," : ",item_make," (Actual amount: ") AS erporder'), DB::raw('(SELECT (sum(price * quantity) - sum(amount_paid)) FROM payments t WHERE t.erporder_id=erporders.id and t.client_id='.$id.') AS balance'), DB::raw('(SELECT sum(discount) FROM prices p WHERE p.item_id=erporderitems.item_id and p.client_id='.$id.') AS discount'), DB::raw('sum(price * quantity) AS total'))
                   ->get('erporder', 'eid', 'discount','total');



    return $erporderitems;
});

Route::get('api/getpurchaseorders', function(){
    $id = Input::get('option');

    $data = array();

    Erporder::join('erporderitems','erporders.id','=','erporderitems.erporder_id')
                   ->join('items','erporderitems.item_id','=','items.id')
                   ->where('client_id',$id)
                   ->where('erporders.status','new')
                   ->whereNotNull('authorized_by')
                   ->select('erporders.id',  DB::raw('CONCAT(order_number," : ",item_make ," (Remaining qty: ", quantity,")") AS erporder'))
                   ->pluck('erporder', 'id');


      $nostockerps =  Erporderitem::join('items','erporderitems.item_id','=','items.id')
                   ->join('erporders','erporderitems.erporder_id','=','erporders.id')
                   ->where('client_id',$id)
                   ->where('erporders.status','new')
                   ->whereNotNull('authorized_by')
                   ->select(DB::raw('CONCAT(erporders.id," : ",items.id) AS eid'),  DB::raw('CONCAT(order_number," : ",item_make ," (Remaining qty: ", quantity,")") AS erporder'))
                   ->whereNotExists(function($query)
                     {  $query->select(DB::raw(1))
                      ->from('stocks')
                      ->whereRaw('stocks.itm_id = items.id and stocks.item_id = erporders.id');
                     })->get('erporder', 'eid');

      $data["nostock"] = $nostockerps;

      $temptable = DB::raw('(SELECT sum(quantity_in) as qty FROM stocks t WHERE t.itm_id=erporderitems.item_id and t.item_id=erporders.id) AS s');
  
      $hasstockerps = Erporderitem::join('items','erporderitems.item_id','=','items.id')
                   ->join('erporders','erporderitems.erporder_id','=','erporders.id')
                  // ->join($temptable, 'items.id', '=', 's.itm_id') 
                 //  ->join("stocks","erporders.id","=","stocks.item_id")
                   ->where('client_id',$id)
                   ->where('erporders.status','new')
                   ->whereNotNull('authorized_by')
                   ->havingRaw('balance > 0')
                   ->select(DB::raw('CONCAT(erporders.id," : ",items.id) AS eid'), DB::raw('(SELECT quantity-sum(quantity_in) FROM stocks t WHERE t.itm_id=erporderitems.item_id and t.item_id=erporders.id) AS balance'),DB::raw('(SELECT CONCAT(order_number," : ",item_make ," (Remaining qty: ", quantity-sum(quantity_in),")") as erporder FROM stocks t WHERE t.itm_id=erporderitems.item_id and t.item_id=erporders.id) AS erporder'))
                   ->groupBy('erporders.id','items.id')
                   ->whereIn( DB::raw('(erporders.id, items.id)'), function($query)
                      {
                          $query->select('item_id','itm_id')
                                ->from('stocks');
                      })->get('erporder', 'eid');
      $data["hasstock"] = $hasstockerps;
    

    return json_encode($data);
});


Route::get('api/total', function(){
    $id = Input::get('option');
    $price = Erporderitem::join('items','erporderitems.item_id','=','items.id')
           ->where('erporder_id',$id)->select(DB::raw('sum(price * quantity * item_size) AS total'))->first();
    $payment = Payment::where('erporder_id',$id)->sum('amount_paid');
    
    return ($price->total) - $payment;
});

Route::get('api/totalsales', function(){
    //$id = Input::get('option');
    $id = explode(" : ",Input::get('option'));
    $price = Erporderitem::where('erporder_id',$id[0])->select(DB::raw('sum(price * quantity) AS total'))->first();
    $payment = Payment::where('erporder_id',$id[0])->sum('amount_paid');
    $discount = Erporder::join('prices','erporders.client_id','=','prices.client_id')
                  ->where('erporders.id',$id[0])
                  ->where('item_id',$id[1])
                  ->sum('discount');
   // dd(Input::get('option'));
    return ($price->total ) - $payment - $discount;
});


Route::get('api/getmax', function(){
    $id = Input::get('option');

    $stock_in = DB::table('stocks')
    ->join("erporderitems","erporderitems.erporder_id","=","stocks.item_id")
    ->join("items","erporderitems.item_id","=","items.id")
    ->where('items.id', $id)
    ->where('stocks.is_confirmed', '=', 1)
    ->sum('quantity_in');

    $stock_out = DB::table('stocks')
    ->join("erporderitems","erporderitems.erporder_id","=","stocks.item_id")
    ->join("items","erporderitems.item_id","=","items.id")
    ->where('items.id', $id)
    ->where('stocks.is_confirmed', '=', 1)
    ->sum('quantity_out');
    return $stock_in-$stock_out;
});


/*Route::get('api/total', function(){
    $id = Input::get('option');
    $tax = Tax::find($id);
    $client = Client::find($id);

    $order = 0;
    

          if($client->type == 'Customer'){
            $order = DB::table('erporders')
                   ->join('erporderitems','erporders.id','=','erporderitems.erporder_id')
                   ->join('clients','erporders.client_id','=','clients.id')           
                   ->where('clients.id',$id)
                   ->where('erporders.type','=','sales')
                   ->where('erporders.status','!=','cancelled')
                   ->selectRaw('SUM(price * quantity)-COALESCE(SUM(discount_amount),0)- COALESCE(SUM(erporderitems.client_discount),0)  as total')
                   ->pluck('total');
          } else{
            $order = DB::table('erporders')
                   ->join('erporderitems','erporders.id','=','erporderitems.erporder_id')
                   ->join('clients','erporders.client_id','=','clients.id')           
                   ->where('clients.id',$id)
                   ->where('erporders.status', '!=', 'cancelled')
                   ->selectRaw('SUM(price * quantity)as total')
                   ->pluck('total');
          }

    $paid = DB::table('clients')
           ->join('payments','clients.id','=','payments.client_id')
           ->where('clients.id',$id) ->selectRaw('COALESCE(SUM(amount_paid),0) as due')
           ->pluck('due');

   /* $discount = DB::table('erporders')
              ->join('erporderitems','erporders.id','=','erporderitems.erporder_id')
              ->join('clients','erporders.client_id','=','clients.id') 
              ->select ('discount_amount')
              ->get();

    return number_format($order-$paid, 2);
});*/






Route::get('email/send', 'ErpReportsController@sendMail');
Route::get('email/send_sales', 'ErpReportsController@sendMail_sales');
Route::get('email/send_morning_sales', 'ErpReportsController@sendMail_morning_sales');
Route::get('email/send_sales_summary', 'ErpReportsController@sendMail_sales_summary');
Route::get('email/send_purchases', 'ErpReportsController@sendMail_purchases');
Route::get('email/send_expenses', 'ErpReportsController@sendMail_expenses');
Route::get('email/send_payments', 'ErpReportsController@sendMail_payments');
Route::get('email/send_morning_payments', 'ErpReportsController@sendMail_morning_payments');
Route::get('email/send_stock', 'ErpReportsController@sendMail_stock');
Route::get('email/send_morning_stock', 'ErpReportsController@sendMail_morning_stock');
Route::get('email/send_account', 'ErpReportsController@sendMail_account');
Route::get('email/send_merged','ErpReportsController@sendMail_MergedReport');

Route::get('authorizepurchaseorder/{id}','ErpReportsController@authorizepurchaseorder');
Route::get('reviewpurchaseorder/{id}','ErpReportsController@reviewpurchaseorder');
Route::get('submitpurchaseorder/{id}','ErpReportsController@submitpurchaseorder');

// Send Merged Report
Route::get('sendMergedMail', 'ErpReportsController@sendMailTo');


Route::resource('mails', 'MailsController');
Route::get('mailtest', 'MailsController@test');


Route::get('seedmail', function(){

  $mail = new Mailsender;

  $mail->driver = 'smtp';
  $mail->save();
});

