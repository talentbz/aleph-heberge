<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

$ui->assign('selected_navigation', 'accounts');
$ui->assign('_title', $_L['Store'] . '- ' . $config['CompanyName']);
$action = $routes['1'];

$c = Contacts::details();

$ui->assign('user', $c);

switch ($action) {
    case 'add':
        $id = route(2);

        Cart::addItem($id);

        r2(U . 'cart/view/');

        break;

    case 'remove':
        $id = route(2);

        $removed = Cart::removeItem($id);

        r2(U . 'cart/view/');

        break;

    case 'delete':
        $id = route(2);

        $deleted = Cart::deleteItem($id);

        r2(U . 'cart/view/');

        break;

    case 'view':
        $user = Contacts::details();

        $shipping_addresses = ShippingAddress::where(
            'contact_id',
            $user->id
        )->get();

        $ui->assign('cart', Cart::details());
        $ui->assign('items', Cart::items());

        view('cart_view', [
            'user' => Contacts::details(),
            'shipping_addresses' => $shipping_addresses,
        ]);

        break;

    case 'clear':
        Cart::clearItems();
        r2(U . 'client/new-order/');

        break;

    case 'checkout':
        if ($config['order_method'] == 'create_invoice_later') {
            $order = Order::fromCart();

            if ($order) {
                r2(
                    U .
                        'client/order_view/' .
                        $order['id'] .
                        '/' .
                        $order['order_number'],
                    's',
                    'Thank you. Your order has been placed.'
                );
            } else {
                r2(U . 'client/orders');
            }
        } else {
            $iid = Invoice::fromCart();

            if ($iid) {
                $d = ORM::for_table('sys_invoices')->find_one($iid);
                $vtoken = $d->vtoken;
                r2(U . 'client/iview/' . $iid . '/token_' . $vtoken);
            } else {
                r2(U . 'client/login/');
            }
        }

        break;

    default:
        echo 'action not defined';
}
