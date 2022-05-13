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
$reports_controller_path =
    'system/controllers/' . $route_controller_directory . '/admin/reports.php';
if (file_exists($reports_controller_path)) {
    require $reports_controller_path;
} else {
    require 'system/controllers/default/admin/reports.php';
}