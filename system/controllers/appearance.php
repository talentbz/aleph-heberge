<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('_title', $_L['Appearance'] . '- ' . $config['CompanyName']);
$ui->assign('selected_navigation', 'appearance');
$action = $routes[1];
$user = User::_info();
$ui->assign('user', $user);

switch ($action) {
    case 'themes':
        $themes = glob('ui/theme/*');
        $themes = array_map('basename', array_filter($themes, 'is_dir'));
        $themes = array_diff($themes, ['frontend']);

        $ui->assign('themes', $themes);

        view('appearance_themes');

        break;

    case 'ui':
        view('appearance_user_interface');

        break;

    case 'customize':
        view('appearance_customize');

        break;

    case 'editor':
        $ui->assign(
            'xfooter',
            Asset::js(['ace/ace', 'ace/ext-modelist', 'settings/editor'])
        );
        $ui->assign('_include', 'box');

        view('appearance_editor');

        break;

    case 'themes_post':
        if (APP_STAGE == 'Demo') {
            r2(
                U . 'appearance/themes/',
                'e',
                'Sorry! This option is disabled in the demo mode.'
            );
        }

        $theme = _post('theme');

        $nstyle = _post('nstyle');

        $logo_inverse_for = [
            'light_blue',
            'purple',
            'indigo_blue',
            'dark_mode',
        ];

        if (in_array($nstyle, $logo_inverse_for)) {
            update_option('top_bar_is_dark', 1);
        } else {
            update_option('top_bar_is_dark', 0);
        }

        $d = ORM::for_table('sys_appconfig')
            ->where('setting', 'theme')
            ->find_one();
        $d->value = $theme;
        $d->save();

        $d = ORM::for_table('sys_appconfig')
            ->where('setting', 'nstyle')
            ->find_one();
        $d->value = $nstyle;
        $d->save();

        switch ($nstyle) {
            case 'light_blue':
                update_option('graph_primary_color', '2196f3');
                update_option('graph_secondary_color', 'eb3c00');

                break;

            case 'purple':
                update_option('graph_primary_color', '7CB5EC');
                update_option('graph_secondary_color', '434348');

                break;

            case 'indigo_blue':
                update_option('graph_primary_color', '002868');
                update_option('graph_secondary_color', 'dc171d');

                break;

            case 'blue_extra':
                update_option('graph_primary_color', '008fe5');
                update_option('graph_secondary_color', 'ff9a00');

                break;

            default:
                update_option('graph_primary_color', '2196f3');
                update_option('graph_secondary_color', 'eb3c00');
        }

        r2(U . 'appearance/themes/', 's', $_L['Settings Saved Successfully']);

        break;

    case 'enable-admin-dark-theme':
        update_option('admin_dark_theme', 'dark');
        update_option('nstyle', 'dark');
        update_option('graph_primary_color', '2196f3');
        update_option('graph_secondary_color', 'eb3c00');
        update_option('top_bar_is_dark', 1);
        r2(U . 'appearance/ui', 's', $_L['Settings Saved Successfully']);
        break;

    case 'disable-admin-dark-theme':
        remove_option('admin_dark_theme');
        update_option('nstyle', 'dark');
        update_option('graph_primary_color', '2196f3');
        update_option('graph_secondary_color', 'eb3c00');
        update_option('top_bar_is_dark', 1);
        r2(U . 'appearance/ui', 's', $_L['Settings Saved Successfully']);
        break;

    default:
        echo 'action not defined';
}
