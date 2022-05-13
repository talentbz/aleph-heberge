<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/
_auth();
$ui->assign('selected_navigation', 'suppliers');
$ui->assign('_title', $_L['Suppliers'] . ' - ' . $config['CompanyName']);

$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);

switch ($action) {
    case 'add':
        if (!has_access($user->roleid, 'suppliers', 'create')) {
            permissionDenied();
        }

        $ui->assign('countries', Countries::all($config['country']));

        $companies = ORM::for_table('sys_companies')
            ->select('id')
            ->select('company_name')
            ->order_by_desc('id')
            ->find_array();

        $ui->assign('companies', $companies);

        // find all groups

        $gs = ORM::for_table('crm_groups')
            ->order_by_asc('sorder')
            ->find_array();

        $ui->assign('gs', $gs);

        $c_selected_id = route(3);

        if ($c_selected_id) {
            $ui->assign('c_selected_id', $c_selected_id);
        } else {
            $ui->assign('c_selected_id', '');
        }

        $currencies = Currency::all();

        view('suppliers_add', [
            'currencies' => $currencies,
        ]);

        break;

    case 'list':
        break;

    default:
        echo 'action not defined';
}
