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
    return view('register');
})->name('register');

Route::get('/login', function() {
    return view('login');
})->name('login');

Route::get('/', function () {
    return view('welcome');
});

Route::get('/home', function() {
    return view('dashboard', ['header'=>'Dashboard', 'description'=>'Admin Dashboard']);
})->name('home');

Route::get('/stock', function() {
    return view('stock', ['header'=>'Stock', 'description'=>'Live Stock']);
})->name('stock');

Route::get('/users', function() {
    return view('users', ['header'=>'Users', 'description'=>'Customers']);
})->name('users');

Route::get('/manage', function() {
    return view('manage', ['header'=>'Products', 'description'=>'Manage Products']);
})->name('manage');

Route::get('/suppliers', function() {
    return view('supplier', ['header'=>'Suppliers', 'description'=>'Suppliers']);
})->name('suppliers');
