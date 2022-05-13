<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

$ui->assign('selected_navigation', 'invoices');
$ui->assign('_title', $_L['Accounts'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$id = $routes['2'];
$d = ORM::for_table('sys_invoices')->find_one($id);

if ($d) {
    $token = $routes['3'];
    $token = str_replace('token_', '', $token);
    $vtoken = $d['vtoken'];
    if ($token != $vtoken) {
        echo 'Sorry Token does not match!';
        exit();
    }

    $items = ORM::for_table('sys_invoiceitems')
        ->where('invoiceid', $id)
        ->order_by_asc('id')
        ->find_many();

    $trs_c = ORM::for_table('sys_transactions')
        ->where('iid', $id)
        ->count();

    $trs = ORM::for_table('sys_transactions')
        ->where('iid', $id)
        ->order_by_desc('id')
        ->find_many();

    $a = ORM::for_table('crm_accounts')->find_one($d['userid']);

    $i_credit = $d['credit'];
    $i_due = '0.00';
    $i_total = $d['total'];
    if ($d['credit'] != '0.00') {
        $i_due = $i_total - $i_credit;
    } else {
        $i_due = $d['total'];
    }

    $cf = ORM::for_table('crm_customfields')
        ->where('showinvoice', 'Yes')
        ->order_by_asc('id')
        ->find_many();

    if ($a->cid != '' || $a->cid != 0) {
        $company = Company::find($a->cid);
    } else {
        $company = false;
    }

    $quote = false;

    if (isset($config['decimal_places_products_and_services'])) {
        $format_currency_override['precision'] =
            $config['decimal_places_products_and_services'];
    }

    require 'system/lib/invoices/render.php';
} else {
    r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
}
