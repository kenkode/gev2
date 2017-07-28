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

Auth::routes();

Route::middleware('auth')->group(function() {

  Route::get('/', 'GeController\GeController@index')->name('home');

  Route::get('/get_updates', 'GeController\GeController@getUpdate');

  Route::get('/orders', function() {
      return view('stock', ['header'=>'Stock', 'description'=>'Live Stock']);
  })->name('orders');

  Route::get('/orders/{order}', 'GeController\GeController@orderDetails');

  Route::get('/users', 'GeController\GeController@users')->name('users');

  Route::get('/manage', 'GeController\GeController@manage')->name('manage');

  Route::get('/stock', 'GeController\GeController@stock')->name('stock');

  Route::get('/suppliers', 'GeController\GeController@supplier')->name('suppliers');

  Route::post('/add_supplier', 'GeController\GeController@addSupplier');

  Route::post('/edit_supplier', 'GeController\GeController@editSupplier');

  Route::post('/delete_supplier', 'GeController\GeController@deleteSupplier');

});
