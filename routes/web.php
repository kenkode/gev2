<?php

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

Route::middleware('auth')->group(function() {

  Route::get('/', 'GeController\GeController@index')->name('home');

  Route::get('/get_updates', 'GeController\GeController@getUpdate');

  Route::get('/orders', 'GeController\GeController@orders')->name('orders');

  Route::get('/subsidiaries', 'GeController\GeController@subsidiary')->name('subsidiary');

  Route::get('/orders/{order}', 'GeController\GeController@orderDetails');

  Route::get('/users', 'GeController\GeController@users')->name('users');

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

Route::prefix("rider")->group(function() {
  Route::post("login", "GeController\RiderController@login");
  Route::get("earnings", "GeController\RiderController@earnings");
  Route::get("ratings", "GeController\RiderController@ratings");

  Route::get("pick_order", "GeController\RiderController@pickOrder");
  Route::get("order_delivered", "GeController\RiderController@orderDelivered");
});

Route::prefix("customer")->group(function() {
  Route::get("authenticate_user", "GeController\CustomerController@authenticateUser");
  Route::get("get_items", "GeController\CustomerController@getItems");
  //
  Route::get("rating", "GeController\CustomerController@rating");

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
