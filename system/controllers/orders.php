<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/
_auth();
$ui->assign('selected_navigation', 'orders');
$ui->assign('_title', $_L['Orders'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);

Event::trigger('orders');

switch ($action) {
    case 'list':
        $d = ORM::for_table('sys_orders')
            ->order_by_desc('id')
            ->find_many();

        $ui->assign('d', $d);

        view('orders_list');

        break;

    case 'add':
        // find all customers

        $c = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('c', $c);

        // find all products

        $p = ORM::for_table('sys_items')
            ->select('id')
            ->select('name')
            ->find_array();

        $ui->assign('p', $p);

        if (isset($routes['3']) and $routes['3'] != '') {
            $p_cid = $routes['3'];
            $p_d = ORM::for_table('crm_accounts')->find_one($p_cid);
            if ($p_d) {
                $ui->assign('p_cid', $p_cid);
            }
        } else {
            $ui->assign('p_cid', '');
        }

        view('orders_add');

        break;

    case 'post':
        $pid = _post('pid');

        $cid = _post('cid');
        $status = _post('status');
        $billing_cycle = _post('billing_cycle');

        $amount = _post('price');
        $amount = Finance::amount_fix($amount);

        if ($pid == '' || $cid == '') {
            i_close($_L['All Fields are Required']);
        }

        $p = ORM::for_table('sys_items')->find_one($pid);

        if (!$p) {
            i_close($_L['Item Not Found']);
        }

        $c = ORM::for_table('crm_accounts')->find_one($cid);

        if (!$c) {
            i_close($_L['User Not Found']);
        }

        $today = date('Y-m-d');

        $generate_invoice = _post('generate_invoice');

        if ($generate_invoice == 'Yes') {
            $invoice = Invoice::forSingleItem($cid, $p->name, $amount);

            $iid = $invoice['id'];
        } else {
            $iid = 0;
        }

        $order = ORM::for_table('sys_orders')->create();

        $order->stitle = $p->name;
        $order->pid = $pid;
        $order->cid = $cid;
        $order->cname = $c->account;
        $order->date_added = $today;
        $order->amount = $amount;
        $order->ordernum = _raid(10);
        $order->status = $status;
        $order->billing_cycle = $billing_cycle;
        $order->iid = $iid;
        $order->save();

        echo $order->id();

        break;

    case 'view':
        $oid = route(2);

        $order = ORM::for_table('sys_orders')->find_one($oid);

        if ($order) {
            $ui->assign('order', $order);

            view('orders_view');
        } else {
            i_close('Order Not Found');
        }

        break;

    case 'set':
        $id = route(2);
        $status = route(3);

        $allowed_status = [
            'Pending',
            'Active',
            'Cancelled',
            'Fraud',
            'Processing',
        ];

        if (in_array($status, $allowed_status)) {
        } else {
            $msg = 'Invalid Status';
        }

        $d = ORM::for_table('sys_orders')->find_one($id);

        if ($d) {
            $d->status = $status;
            $d->save();

            $msg = $_L['Data Updated'];
        } else {
            $msg = 'Order not found';
        }

        r2(U . 'orders/view/' . $id . '/', 's', $msg);

        break;

    case 'save_activation':
        $oid = _post('oid');

        $data = request()->all();

        $activation_subject = $data['activation_subject'];

        $activation_message = $data['activation_message'];

        $send_email = _post('send_email');

        if ($activation_message == '' || $activation_message == '') {
            i_close($_L['All Fields are Required']);
        }

        $d = ORM::for_table('sys_orders')->find_one($oid);

        if ($d) {
            $cid = $d->cid;

            $d->activation_subject = $activation_subject;
            $d->activation_message = $activation_message;

            $d->save();

            if ($send_email == 'yes') {
                $client = ORM::for_table('crm_accounts')->find_one($cid);
            }

            echo $d->id();
        } else {
            echo 'Order not found';
        }

        break;

    case 'module':
        $id = route(2);

        $d = ORM::for_table('sys_orders')->find_one($id);

        if ($d) {
            Event::trigger('orders/modules/');

            r2(U . 'orders/view/' . $id . '/', 's', $_L['Data Updated']);
        } else {
            $msg = 'Order not found';
        }

        break;

    default:
        echo 'action not defined';
}
