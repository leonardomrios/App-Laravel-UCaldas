<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Venue;

class VenueSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Venue::create([
            'venue_name' => 'Teatro Nacional',
            'venue_address' => 'Calle 5 #12-34, Bogotá',
            'venue_max_capacity' => 500
        ]);

        Venue::create([
            'venue_name' => 'Centro de Convenciones',
            'venue_address' => 'Carrera 10 #45-67, Medellín',
            'venue_max_capacity' => 1000
        ]);

        Venue::create([
            'venue_name' => 'Auditorio Principal',
            'venue_address' => 'Avenida 15 #78-90, Cali',
            'venue_max_capacity' => 300
        ]);

        // Agregar más venues usando factory
        Venue::factory()->count(5)->create();
    }
}
