<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('selected_navigation', 'plugins');
$ui->assign('_title', $_L['Store'] . '- ' . $config['CompanyName']);
$action = route(1, 'render');
$user = User::_info();
$ui->assign('user', $user);

switch ($action) {
    case 'render':
        $ui->assign('xheader', Asset::css(['modal']));
        $ui->assign('xfooter', Asset::js(['modal', 'js/apps']));

        view('apps');

        break;

    case 'modal_view_app':
        $id = route(2);

        view('modal_view_app');

        break;

    case 'disable':
        $module = route(2);

        updateOption($module, '0');

        _msglog('s', 'Plugins Deactivated Successfully');

        r2(U . 'settings/plugins/');

        break;

    case 'enable':
        $module = route(2);

        updateOption($module, '1');

        _msglog('s', 'Plugins Activated Successfully');

        r2(U . 'settings/plugins/');

        break;

    default:
        echo 'action not defined';
}
