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
require 'system/controllers/' . $route_controller_directory . '/client/app.php';
