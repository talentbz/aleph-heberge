<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('selected_navigation', 'invoices');
$ui->assign('_title', $_L['Sales'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);

switch ($action) {
    case 'all':
        $items = Item::all();

        $data = [];

        foreach ($items as $item) {
            $data[] = [
                'id' => $item->id,
                'name' => $item->name,
                'image' => $item->image,
                'sales_price' => numberFormatUsingCurrency(
                    $item->sales_price,
                    $config['home_currency']
                ),
                'cost_price' => numberFormatUsingCurrency(
                    $item->cost_price,
                    $config['home_currency']
                ),
                'item_number' => $item->item_number,
            ];
        }

        api_response($data);

        break;

    default:
        echo 'action not defined';
}
