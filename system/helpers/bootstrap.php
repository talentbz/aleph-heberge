<?php

// Copyright CloudOnex

/*
|--------------------------------------------------------------------------
| Create The Application
|--------------------------------------------------------------------------
|
| The first thing we will do is create a new application instance
| which serves as the "glue" for all the components of this application.
|
*/

session_start();

require 'system/data/constants.php';
require 'system/helpers/bin.php';
require 'system/helpers/common_functions.php';

$plugin_ui_header_admin = [];
$plugin_ui_header_admin_css = [];
$plugin_ui_header_client = [];
$plugin_ui_header_client_css = [];

$PluginManager = new Plugins();

$ui = ui();

foreach ($ps as $p) {
    $plugindir_path = 'apps/' . $p['c'];

    $ui->assign('plugin_directory', $plugindir_path);
    if (file_exists($plugindir_path)) {
        if (file_exists($plugindir_path . '/boot.php')) {
            require $plugindir_path . '/boot.php';
        }
    } else {
        $plugindir = $p['c'];
        _msglog(
            'e',
            "Plugin directory '$plugindir' does not exists! <a href='" .
                U .
                "settings/plugin_force_remove/$plugindir/' style='color: white; text-decoration: underline;'>[ Click Here ]</a> to Remove This Plugin Entry."
        );
    }
}

$hooks = glob('hooks/*{.php}', GLOB_BRACE);

if (count($hooks) != 0) {
    foreach ($hooks as $hook) {
        require_once $hook;
    }
}

$app->emit('routing_started', [&$_L, &$config, &$ui]);

$append_to_the_head_in_the_base_layout = [];
$app->emit('ui', [
    [
        'append_to_the_head_in_the_base_layout' => &$append_to_the_head_in_the_base_layout,
    ],
]);

$ui->assign(
    'append_to_the_head_in_the_base_layout',
    $append_to_the_head_in_the_base_layout
);

require 'system/helpers/plugged.php';

// variable initializations

$xheader = '';
$xfooter = '';
$xjq = '';

$pl_path = '';
//
$sys_render = 'system/controllers/' . $handler . '.php';
if (file_exists($sys_render)) {
    include $sys_render;
} else {
    $p1 = false;
    $p2 = false;

    if (isset($routes[0]) and $routes[0] != '') {
        $p1 = true;
    }

    if (isset($routes[1]) and $routes[1] != '') {
        $p2 = true;
    }

    if ($p1 and $p2) {
        $dir = $routes[0];
        $cont = $routes[1];
        $path = 'apps/' . $dir . '/' . $cont . '.php';
        $pl_path = 'apps/' . $dir . '/';

        if (file_exists($path)) {
            $_pd = 'apps/' . $dir;
            $app_path = 'apps/' . $dir;
            $ui->assign('_pd', 'apps/' . $dir); #depricated
            $ui->assign('app_path', 'apps/' . $dir);
            $ui->assign('app_view_path', '../../../apps/' . $dir . '/views');

            require $path;
        } else {
            abort();
        }
    } elseif ($p1 & !$p2) {
        $dir = $routes['0'];

        $path = 'apps/' . $dir . '/default.php';

        if (file_exists($path)) {
            $_pd = 'apps/' . $dir;

            $ui->assign('_pd', 'apps/' . $dir);

            require $path;
        } else {
            abort();
        }
    } else {
        abort();
    }
}
