<?php
_auth();
$ui->assign('selected_navigation', 'sms');
$ui->assign('_title', 'SMS' . ' - ' . $config['CompanyName']);
$ui->assign('_st', 'SMS');
$action = $routes['2'];
$user = User::_info();
$ui->assign('user', $user);

// SMS Driver

require 'system/lib/misc/smsdriver.php';
$data = request()->all();
switch ($action) {
    case 'send':
        if (isset($routes['3']) and $routes['3'] != '') {
            $p_cid = $routes['3'];
            $p_d = ORM::for_table('crm_accounts')->find_one($p_cid);
            if ($p_d) {
                $ui->assign('p_cid', $p_cid);
            }
        } else {
            $ui->assign('p_cid', '');
        }

        $c = ORM::for_table('crm_accounts')
            ->select('phone')
            ->where_not_equal('phone', '')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('c', $c);
        view('sms_send');
        break;

    case 'send_post':
        $from = _post('from');
        $to = _post('sms_to');
        $message = $data['message'];
        $sms_type = _post('sms_type');
        $sms_route = _post('sms_route');
        $resp = '';
        $alert = '';
        if ($to == '') {
            $alert .= 'Please choose Phone Number for receiver <br />';
        }

        if ($from == '') {
            $alert .= 'Please choose Sender Number <br />';
        }

        if ($message == '') {
            $alert .= 'Message is empty <br />';
        }

        if ($alert == '') {
            $resp = spSendSMS($to, $message, $from, 0, $sms_type, $sms_route);
            echo '<div class="alert alert-success alert-dismissible" role="alert">
  
  <strong>Success!</strong> Message Sent. Message Server Response: ' .
                $resp .
                '
</div>';
        } else {
            echo '<div class="alert alert-danger alert-dismissible" role="alert">
 
  <strong>Error: </strong> <br /> ' .
                $alert .
                '
</div>';
        }

        break;

    case 'bulk':
        $c = ORM::for_table('crm_accounts')
            ->select('phone')
            ->where_not_equal('phone', '')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('c', $c);
        $ui->assign('xheader', Asset::css(['multi-select/multi-select']));

        view('sms_bulk');
        break;

    case 'bulk_post':
        clxPerformLongProcess();
        $data = $request->all();
        $numbers = '';
        foreach ($data['contacts'] as $number) {
            $numbers .= $number . ',';
        }

        $numbers = rtrim($numbers, ',');
        $resp = spSendSMS($numbers, $data['message'], $data['from']);
        $alert = $resp;
        echo '<div class="alert alert-danger alert-dismissible" role="alert">
 
  <strong>Error: </strong> <br /> ' .
            $alert .
            '
</div>';
        break;

    case 'inbox':
        $paginator = Paginator::bootstrap('app_sms');
        $d = ORM::for_table('app_sms')
            ->offset($paginator['startpoint'])
            ->limit($paginator['limit'])
            ->order_by_desc('req_time')
            ->find_many();
        $ui->assign('d', $d);
        $ui->assign('paginator', $paginator);
        view('sms_inbox');
        break;

    case 'sent':
        $paginator = Paginator::bootstrap('app_sms');
        $d = ORM::for_table('app_sms')
            ->offset($paginator['startpoint'])
            ->limit($paginator['limit'])
            ->find_many();
        $ui->assign('d', $d);
        $ui->assign('paginator', $paginator);

        view('sms_sent');
        break;

    case 'templates':
        $templates = SMSTemplate::all();
        view('sms_templates', ['templates' => $templates]);
        break;

    case 'drivers':
        $d = ORM::for_table('app_sms_drivers')->find_array();
        $ui->assign('d', $d);
        view('sms_drivers');
        break;

    case 'notifications':
        view('sms_notifications');
        break;

    case 'delete_driver':
        $id = route(3);
        $d = ORM::for_table('app_sms_drivers')->find_one($id);
        if ($d) {
            $d->delete();
        }

        r2(U . 'sms/init/drivers/', 's', 'Deleted Successfully');
        break;

    case 'new_sms_driver':
        view('sms_new_sms_driver');
        break;

    case 'new_sms_driver_step_2':
        $handler = _post('handler');
        $ui->assign('handler', $handler);
        $h_name = ucwords($handler);
        $ui->assign('h_name', $h_name);
        $ui->assign('_st', 'Configure ' . $h_name);
        $l = [];
        switch ($handler) {
            case 'msg91':
                $l['api_key'] = 'Authentication key';
                break;
        }

        $ui->assign('l', $l);
        view('sms_new_sms_driver_step_2');
        break;

    case 'save_sms_driver':
        $dname = _post('dname');
        $handler = _post('handler');
        $weburl = _post('weburl');
        $description = _post('description');
        $url = _post('url');
        $incoming_url = _post('incoming_url');
        $method = _post('method');
        $username = _post('username');
        $password = _post('password');
        $api_key = _post('api_key');
        $api_secret = _post('api_secret');
        $route = _post('route');
        $sender_id = _post('sender_id');
        $placeholder = _post('placeholder');
        $status = _post('status');
        $is_active = _post('is_active');
        $d = ORM::for_table('app_sms_drivers')->create();
        $d->dname = $dname;
        $d->handler = $handler;
        $d->weburl = $weburl;
        $d->description = $description;
        $d->url = $url;
        $d->incoming_url = $incoming_url;
        $d->method = $method;
        $d->username = $username;
        $d->password = $password;
        $d->api_key = $api_key;
        $d->api_secret = $api_secret;
        $d->route = $route;
        $d->sender_id = $sender_id;
        $d->placeholder = $placeholder;
        $d->status = $status;
        $d->is_active = $is_active;
        $d->save();
        break;

    case 'edit':
        $id = route(3);
        $template = SMSTemplate::find($id);
        if ($template) {
            view('sms_template_edit', ['template' => $template]);
        }

        break;

    case 'edit_post':
        $id = _post('template_id');
        $message = _post('message');
        $template = SMSTemplate::find($id);
        if ($template) {
            $template->sms = $message;
            $template->save();
            echo $_L['Data Updated'];
        }

        break;

    case 'send_invoice':
        $to = _post('to');
        $from = _post('from');
        $invoice_id = _post('invoice_id');
        $message = _post('message');
        if ($to == '' || $from == '' || $invoice_id == '' || $message == '') {
            echo '<div class="alert alert-success fade in">All fields are required.</div>';
            exit();
        }

        spSendSMS($to, $message, $from, $invoice_id, 'text', 4);
        echo $_L['Sent'];
        break;

    case 'send_quote':
        $to = _post('to');
        $from = _post('from');

        $message = _post('message');
        spSendSMS($to, $message, $from);
        echo '<div class="alert alert-success fade in">SMS Sent!</div>';
        break;

    case 'settings':
        view('sms_settings', [
            'selected_navigation' => 'settings',
        ]);
        break;

    case 'save-sms-credentials':
        $sms_api_handler = _post('sms_api_handler');
        update_option('sms_api_handler', $sms_api_handler);
        $sms_auth_username = _post('sms_auth_username');
        update_option('sms_auth_username', $sms_auth_username);
        $sms_auth_password = _post('sms_auth_password');
        update_option('sms_auth_password', $sms_auth_password);
        $sms_sender_name = _post('sms_sender_name');
        update_option('sms_sender_name', $sms_sender_name);
        update_option('sms_req_url', _post('sms_req_url'));
        update_option('sms_request_method', _post('sms_request_method'));
        update_option('sms_http_params', $data['sms_http_params']);
        echo $_L['Data Updated'];
        break;

    default:
        echo 'action not defined';
}
