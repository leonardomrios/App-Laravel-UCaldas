<?php

use App\Http\Controllers\EventController;
use App\Http\Controllers\VenueController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;


Route::get('test', function (Request $request) {
    return response()->json(['status' => true, 'message' => 'Hola mundo']);
});

Route::post('login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
    
    // API Resources con nombres únicos
    Route::apiResource('events', EventController::class)->names([
        'index' => 'api.events.index',
        'store' => 'api.events.store', 
        'show' => 'api.events.show',
        'update' => 'api.events.update',
        'destroy' => 'api.events.destroy'
    ]);
    
    Route::apiResource('venues', VenueController::class)->names([
        'index' => 'api.venues.index',
        'store' => 'api.venues.store',
        'show' => 'api.venues.show', 
        'update' => 'api.venues.update',
        'destroy' => 'api.venues.destroy'
    ]);
    
    Route::apiResource('computers', \App\Http\Controllers\ComputerController::class)->names([
        'index' => 'api.computers.index',
        'store' => 'api.computers.store',
        'show' => 'api.computers.show',
        'update' => 'api.computers.update', 
        'destroy' => 'api.computers.destroy'
    ]);
});
