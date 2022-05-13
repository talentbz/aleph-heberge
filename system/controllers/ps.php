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
$ps_controller_path =
    'system/controllers/' . $route_controller_directory . '/admin/ps.php';
if (file_exists($ps_controller_path)) {
    require $ps_controller_path;
} else {
    require 'system/controllers/default/admin/ps.php';
}
