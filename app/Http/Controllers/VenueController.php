<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreVenueRequest;
use App\Http\Requests\UpdateVenueRequest;
use App\Models\Venue;
use Illuminate\Http\Request;
use Inertia\Inertia;

class VenueController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        return Inertia::render('Venues/Index', [
            'venues' => Venue::all()
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreVenueRequest $request)
    {
        $venue = new Venue($request->validated());
        $venue->save();
        return response()->json (['success' => true, 'venue' => $venue]);
    }

    /**
     * Display the specified resource.
     */
    public function show(Venue $venue)
    {
        return response()->json ([
            //'success' => true, 
            'venue' => $venue->load('events')  // carga los eventos relacionados
            //'events' => $venue->events()->get() // carga los eventos relacionados
        ]);
        //return $venue; Opcion valida
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateVenueRequest $request, Venue $venue)
    {
        if($venue->update($request->validated())){
            return response()->json (['success' => true, 'venue' => $venue]);
        } 
        
        return response()->json (['success' => false, 'venue' => $venue]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Venue $venue)
    {
        if($venue->delete()){
            return response()->json (['success' => true]);
        } 
        
        return response()->json (['success' => false]);
    }
}
