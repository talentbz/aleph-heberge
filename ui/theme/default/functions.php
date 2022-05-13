<?php

/*
 *
 * Create Menu dynamically for plugins and hooks
 *
 * @param string $name name of the menu
 * @param string $link link of the menu
 * @param string $c controller name to set menu active
 * @param string fontawesome or iBilling icon name
 * @param int $position position of the menu
 * @param array $submenu submenu items
 *
 * */

function add_menu_admin(
    $name,
    $link = '#',
    $base = '',
    $icon = '',
    $position = 5,
    $submenu = []
) {
    global $admin_extra_nav, $routes;

    $active = '';
    if (isset($routes['0']) and $routes['0'] == $base) {
        $active = 'active open';
    }

    if (!empty($submenu)) {
        $s = '';

        foreach ($submenu as $menu) {
            if (isset($menu['target'])) {
                $target = 'target="' . $menu['target'] . '"';
            } else {
                $target = '';
            }
            $s .=
                ' <li><a href="' .
                $menu['link'] .
                '" ' .
                $target .
                '>' .
                $menu['name'] .
                '</a></li>';
        }

        $admin_extra_nav[$position] .=
            '<li class="' .
            $active .
            '"> <a href="javascript:void(0);" class="waves-effect">' .
            $icon .
            ' <span class="nav-link-text"> ' .
            $name .
            ' </span></a>
                            <ul class="nav nav-second-level">
                                ' .
            $s .
            '
                            </ul>
                        </li>';
    } else {
        $admin_extra_nav[$position] .=
            '<li class="waves-effect ' .
            $active .
            '"> <a href="' .
            $link .
            '"  id="li_' .
            $base .
            '">' .
            $icon .
            ' <span class="nav-link-text">' .
            $name .
            '</span></a> </li>';
    }
}

function add_menu_client(
    $name,
    $link = '#',
    $base = '',
    $icon = 'icon-leaf',
    $position = 3,
    $submenu = [],
    $menu_id = '',
    $target = ''
) {
    global $client_extra_nav, $routes;
    $active = '';
    if (isset($routes['0']) and $routes['0'] == $base) {
        $active = 'active open';
    }

    if ($menu_id != '') {
        $menu_id = ' id="' . $menu_id . '"';
    }

    if ($target != '') {
        $target = ' target="' . $target . '"';
    }

    if (!empty($submenu)) {
        $s = '';
        foreach ($submenu as $menu) {
            if (isset($menu['target'])) {
                $target = 'target="' . $menu['target'] . '"';
            } else {
                $target = '';
            }

            $s .=
                ' <li><a href="' .
                $menu['link'] .
                '" ' .
                $target .
                '>' .
                $menu['name'] .
                '</a></li>';
        }

        $client_extra_nav[$position] .=
            '<li class="' .
            $active .
            '"> <a href="javascript:void(0);" class="waves-effect">' .
            $icon .
            ' <span class="nav-link-text"> ' .
            $name .
            ' </span></a>
                            <ul class="nav nav-second-level">
                                ' .
            $s .
            '
                            </ul>
                        </li>';
    } else {
        $client_extra_nav[$position] .=
            '<li class="waves-effect ' .
            $active .
            '"> <a href="' .
            $link .
            '"  id="li_' .
            $base .
            '">' .
            $icon .
            ' <span class="nav-link-text">' .
            $name .
            '</span></a> </li>';
    }
}
