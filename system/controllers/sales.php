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
$user = User::_info();
$ui->assign('user', $user);
Event::trigger('invoices');

if (has_access($user->roleid, 'sales', 'all_data')) {
    $sales_all_data = true;
} else {
    $sales_all_data = false;
}

$action = route(1);

switch ($action) {
    case 'delivery_challans':
        if (!db_table_exist('delivery_notes')) {
            r2(U . 'sales/update');
        }

        $delivery_notes = DeliveryNote::all();

        view('sales_delivery_notes', [
            'delivery_notes' => $delivery_notes,
        ]);

        break;

    case 'delivery_challan':
        $delivery_note = false;
        $contacts = Contact::all();
        view('sales_delivery_note', [
            'delivery_note' => $delivery_note,
            'contacts' => $contacts,
        ]);

        break;

    default:
        echo 'action not defined';
}
