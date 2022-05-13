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
$projects_controller_path =
    'system/controllers/' .
    $route_controller_directory .
    '/admin/projects.php';
if (file_exists($projects_controller_path)) {
    require $projects_controller_path;
} else {
    require 'system/controllers/default/admin/projects.php';
}
