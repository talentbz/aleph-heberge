<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('_title', $_L['Settings'] . '- ' . $config['CompanyName']);
$ui->assign('_pagehead', '<i class="fa fa-cogs lblue"></i> Settings');
$ui->assign('selected_navigation', 'settings');
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);
$ui->assign('_user', $user);
if ($user['user_type'] != 'Admin') {
    r2(U . "dashboard", 'e', $_L['You do not have permission']);
}
if (isset($routes['1'])) {
    $do = $routes['1'];
} else {
    $do = 'sys_cats';
}
$data = request()->all();
switch ($do) {
    #################### All Ajax Post ###############################
    case 'reorder-post':
        $action = $data['action'];
        $updateRecordsArray = $data['recordsArray'];

        $listingCounter = 1;
        foreach ($updateRecordsArray as $recordIDValue) {
            $d = ORM::for_table($action)->find_one($recordIDValue);
            $d->sorder = $listingCounter;
            $d->save();
            $listingCounter = $listingCounter + 1;
        }

        echo create_alert_message($_L['Updated']);

        break;

    case 'pg':
        $d = ORM::for_table('sys_pg')
            ->order_by_asc('sorder')
            ->find_many();
        $ui->assign('ritem', 'Payment Gateway');
        $ui->assign('d', $d);

        $ui->assign('display_name', 'name');

        view('reorder', [
            'action' => 'sys_pg',
        ]);

        break;

    case 'groups':
        $d = ORM::for_table('crm_groups')
            ->order_by_asc('sorder')
            ->find_many();
        $ui->assign('ritem', $_L['Groups']);
        $ui->assign('d', $d);
        $ui->assign('display_name', 'gname');
        $ui->assign('xjq', Reorder::js('crm_groups'));
        view('reorder', [
            'action' => 'crm_groups',
        ]);

        break;

    case 'expense_types':
        $d = ORM::for_table('expense_types')
            ->order_by_asc('sorder')
            ->find_many();
        $ui->assign('ritem', 'Expense Types');
        $ui->assign('d', $d);
        $ui->assign('display_name', 'name');
        $ui->assign('xjq', Reorder::js('expense_types'));
        view('reorder', [
            'action' => 'expense_types',
        ]);

        break;
}
