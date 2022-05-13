<?php

/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('selected_navigation', 'contacts');
$ui->assign('_title', $_L['Customers'] . '- ' . $config['CompanyName']);
$action = route(1);
$user = User::_info();
$ui->assign('user', $user);

Event::trigger('accounts');

switch ($action) {
    case 'email':
        $email = route(2);
        $ui->assign('email', $email);

        view('modal_send_email');

        break;

    case 'send_email_post':
        $msg = '';
        $data = request()->all();
        $email = _post('to');

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            i_close($_L['Invalid Email']);
        }
        $email_e = explode('@', $email);
        $toname = $email_e[0];
        $subject = _post('subject');
        if ($subject == '') {
            $msg .= $_L['Subject is Empty'] . ' <br>';
        }
        $message = $data['message'] ?? '';
        if ($message == '') {
            $msg .= $_L['Message is Empty'] . ' <br>';
        }
        if ($msg == '') {
            Email::sendEmail($config, $_L, $toname, $email, $subject, $message);

            _msglog('s', $_L['Email Sent']);
            echo '1';
        } else {
            echo $msg;
        }

        break;

    case 'bulk_email':
        $ui->assign('_title', $_L['Email'] . '- ' . $config['CompanyName']);

        $data = request()->all();

        if (!isset($data['ids'])) {
            exit();
        }

        $ids_raw = $data['ids'];

        $ids = [];

        foreach ($ids_raw as $id_single) {
            $id = str_replace('row_', '', $id_single);
            $ids[] = $id;
        }

        $contacts = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('email')
            ->where_id_in($ids)
            ->find_array();

        $ui->assign('contacts', $contacts);

        view('handler_bulk_email');

        break;

    case 'bulk_email_post':
        $data = request()->all();
        $emails = $data['emails'];
        $emails = explode("\n", $emails);

        $subject = $data['subject'];
        $msg = $data['msg'];

        if ($subject == '') {
            echo $_L['Subject is Empty'];
            exit();
        }
        echo '1';

        break;

    case 'view_email_templates':
        $tpls = ORM::for_table('sys_email_templates')
            ->select('id')
            ->select('core')
            ->select('tplname')
            ->select('subject')
            ->order_by_desc('id')
            ->find_array();

        $ui->assign('tpls', $tpls);

        view('modal_view_email_templates');

        break;

    case 'json_eml_tpl':
        $id = route(2);
        $id = str_replace('es', '', $id);

        $contact_id = (int) route(3);
        $contact = false;

        if ($contact_id) {
            $contact = Contact::find($contact_id);
        }

        $eml = EmailTemplate::find($id);

        if ($eml) {
            $subject = $eml->subject;
            $message = $eml->message;

            if ($contact) {
                $subject_transform = new Template($subject);
                $subject_transform->set('name', $contact->account);
                $subject_transform->set('customer_name', $contact->account);
                $subject_transform->set('client_name', $contact->account);
                $subject_transform->set('company', $contact->company);
                $subject_transform->set(
                    'business_name',
                    $config['CompanyName']
                );
                $subject = $subject_transform->output();

                $message_transform = new Template($message);
                $message_transform->set('name', $contact->account);
                $message_transform->set('customer_name', $contact->account);
                $message_transform->set('client_name', $contact->account);
                $message_transform->set('company', $contact->company);
                $message_transform->set(
                    'business_name',
                    $config['CompanyName']
                );

                if ($contact->email) {
                    $message_transform->set('email', $contact->email);
                    $message_transform->set('client_email', $contact->email);
                }

                $message_transform->set(
                    'client_login_url',
                    BASE_URL . 'client/login/'
                );

                $message = $message_transform->output();
            }

            api_response([
                'subject' => $subject,
                'message' => $message,
            ]);
        }

        break;

    case 'groups':
        $gs = ORM::for_table('crm_groups')
            ->order_by_asc('sorder')
            ->find_array();

        $opt = '';

        foreach ($gs as $g) {
            $opt .=
                '<option value="' . $g['id'] . '">' . $g['gname'] . '</option>';
        }

        echo '<div class="form-group">
    <label for="input_assign_group">' .
            $_L['Group'] .
            '</label>
    <select class="form-control" id="input_assign_group">
<option value="0">' .
            $_L['Select Group'] .
            '...</option>
<option value="0">' .
            $_L['None'] .
            '</option>
' .
            $opt .
            '
</select>
  </div>
  
';

        break;

    default:
        echo 'action not defined';
}
