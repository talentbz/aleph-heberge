<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

if (isset($config['default_landing_page'])) {
    if (
        !empty($config['frontend_theme']) &&
        ($config['default_landing_page'] === 'client' ||
            $config['default_landing_page'] === 'client/login')
    ) {
        $route_controller_directory =
            $config['route_controller_directory'] ?? 'default';
        require 'system/controllers/' .
            $route_controller_directory .
            '/client/default.php';
    } else {
        r2(U . $config['default_landing_page'] . '/');
    }
} else {
    r2(U . 'login' . '/');
}
