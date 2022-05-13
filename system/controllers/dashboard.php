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
$dashboard_controller_path =
    'system/controllers/' .
    $route_controller_directory .
    '/admin/dashboard.php';
if (file_exists($dashboard_controller_path)) {
    require $dashboard_controller_path;
} else {
    require 'system/controllers/default/admin/dashboard.php';
}
