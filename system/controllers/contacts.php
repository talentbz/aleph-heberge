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
$contacts_controller_path =
    'system/controllers/' . $route_controller_directory . '/admin/contacts.php';
if (file_exists($contacts_controller_path)) {
    require $contacts_controller_path;
} else {
    require 'system/controllers/default/admin/contacts.php';
}
