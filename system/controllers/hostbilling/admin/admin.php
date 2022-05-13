<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}
$do = route(1);

if ($do == '') {
    $do = 'login-display';
}

switch ($do) {
    case 'login-display':
        \view('hostbilling/admin/auth', [
            'type' => 'admin_auth',
        ]);

        break;

    case 'forgot-pw':
        \view('hostbilling/admin/auth', [
            'type' => 'admin_password_reset',
        ]);

        break;

    case 'forgot-pw-post':
        $username = _post('username');
        $d = ORM::for_table('sys_users')
            ->where('username', $username)
            ->find_one();
        if ($d) {
            $xkey = _raid('10');
            $d->pwresetkey = $xkey;
            $d->keyexpire = time() + 3600;
            $d->save();
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Admin:Password Change Request')
                ->find_one();
            $subject = new Template($e['subject']);
            $subject->set('business_name', $config['CompanyName']);
            $subj = $subject->output();
            $message = new Template($e['message']);
            $message->set('name', $d['fullname']);
            $message->set('business_name', $config['CompanyName']);
            $message->set(
                'password_reset_link',
                U . 'login/pwreset-validate/' . $d['id'] . '/token_' . $xkey
            );
            $message->set('username', $d['username']);
            $message->set('ip_address', $_SERVER["REMOTE_ADDR"]);
            $message_o = $message->output();

            Email::sendEmail(
                $config,
                $_L,
                $d['fullname'],
                $d['username'],
                $subj,
                $message_o
            );

            _msglog('s', $_L['Check your email to reset Password']);
            r2(U . 'login/');
        } else {
            _msglog('e', $_L['User Not Found'] . '!');
            r2(U . 'login/forgot-pw/');
        }

        break;

    case 'pwreset-validate':
        $v_uid = $routes['2'];
        $v_token = $routes['3'];
        $v_token = str_replace('token_', '', $v_token);
        $d = ORM::for_table('sys_users')->find_one($v_uid);
        if ($d) {
            $d_token = $d['pwresetkey'];
            if ($v_token != $d_token) {
                r2(U . 'login/', 'e', $_L['Invalid Password Reset Key'] . '!');
            }

            $keyexpire = $d['keyexpire'];
            $ctime = time();
            if ($ctime > $keyexpire) {
                r2(U . 'login/', 'e', $_L['Password Reset Key Expired']);
            }

            $password = _raid('6');
            $npassword = Password::_crypt($password);
            $d->password = $npassword;
            $d->pwresetkey = '';
            $d->keyexpire = '0';
            $d->save();
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Admin:New Password')
                ->find_one();
            $subject = new Template($e['subject']);
            $subject->set('business_name', $config['CompanyName']);
            $subj = $subject->output();
            $message = new Template($e['message']);
            $message->set('name', $d['fullname']);
            $message->set('business_name', $config['CompanyName']);
            $message->set('login_url', U . 'login/');
            $message->set('username', $d['username']);
            $message->set('password', $password);
            $message_o = $message->output();

            Email::sendEmail(
                $config,
                $_L,
                $d['fullname'],
                $d['username'],
                $subj,
                $message_o
            );

            _msglog('s', $_L['Check your email to reset Password'] . '.');
            r2(U . 'login/');
        }

        break;

    case 'where':
        r2(U . 'login');
        break;

    case 'after':
        $after = route(2);
        $ui->assign('after', $after);
        view('login');
        break;

    default:
        abort(404);
        break;
}
