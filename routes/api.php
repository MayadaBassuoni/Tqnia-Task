<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

//Auth Routes
Route::post('register', 'AuthController@register');
Route::post('login', 'AuthController@login');
Route::post('verify_account', 'AuthController@verify');
Route::post('logout', 'AuthController@logout');

Route::middleware('auth:sanctum')->group(function () {
    //Tags
    Route::resource('tags', 'TagsController');

    //View Deleted Posts
    Route::get('posts/view_deleted', 'PostsController@deletedPosts');
    //Restore Post
    Route::post('posts/restore_deleted_posts/{id}', 'PostsController@restorePost');
    //Posts
    Route::resource('posts', 'PostsController');
});

//stats
Route::get('stats', 'StatsController@getStats');

//User Profile
Route::get('profile', 'ProfileController@index');
