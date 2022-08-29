<?php

use Illuminate\Support\Facades\Route;

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

Route::get('/', function () {
    return view('home');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
Route::get('/editar_enquete/{id_enquete}', 'adminController@editar_enquete')->name('editar_enquete');
Route::post('/cadastrar_enquete', 'adminController@cadastrar_enquete')->name('cadastrar_enquete');
Route::post('/listar_enquetes', 'adminController@listar_enquetes')->name('listar_enquetes');
Route::post('/salvar_alteracoes_enquete', 'adminController@salvar_alteracoes_enquete')->name('salvar_alteracoes_enquete');
Route::post('/excluirEnquete', 'adminController@excluirEnquete')->name('excluirEnquete');
Route::post('/salvarRespostaEnquete', 'adminController@salvarRespostaEnquete')->name('salvarRespostaEnquete');
