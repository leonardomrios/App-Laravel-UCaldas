<?php

// Healthcheck endpoint simple
// Accesible en: /healthcheck o /health

Route::get('/healthcheck', function () {
    return response()->json([
        'status' => 'ok',
        'timestamp' => now(),
        'app' => config('app.name'),
        'env' => config('app.env'),
    ]);
});

Route::get('/health', function () {
    return 'OK';
});
