<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('_title', $_L['Transactions'] . '- ' . $config['CompanyName']);
$ui->assign('_st', 'Transactions');
$ui->assign('selected_navigation', 'transactions');
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);
$mdate = date('Y-m-d');
switch ($action) {
    case 'balance-sheet':
        $home_currency = Currency::where(
            'iso_code',
            $config['home_currency']
        )->first();

        $net_worth = Balance::where('currency_id', $home_currency->id)->sum(
            'balance'
        );

        $net_worth = Balance::where('currency_id', $home_currency->id)->sum(
            'balance'
        );

        if ($net_worth == '') {
            $net_worth = 0;
        }

        $accounts = Account::all();
        $currencies = Currency::all();

        view('accounts_balances', [
            'accounts' => $accounts,
            'currencies' => $currencies,
            'net_worth' => $net_worth,
        ]);

        break;

    default:
        echo 'action not defined';
}
