<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

$route_controller_directory =
    $config['route_controller_directory'] ?? 'default';
$controller_path =
    'system/controllers/' . $route_controller_directory . '/admin/webhook.php';
if (file_exists($controller_path)) {
    require $controller_path;
}
