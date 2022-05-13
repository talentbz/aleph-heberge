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
$form_controller_path =
    'system/controllers/' . $route_controller_directory . '/admin/form.php';
if (file_exists($form_controller_path)) {
    require $form_controller_path;
}
