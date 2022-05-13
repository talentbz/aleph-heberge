<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

$route_controller_directory =
    $config['route_controller_directory'] ?? 'default';
$login_controller_path =
    'system/controllers/' . $route_controller_directory . '/admin/login.php';
if (file_exists($login_controller_path)) {
    require $login_controller_path;
} else {
    $do = route(1);

    if ($do == '') {
        $do = 'login-display';
    }

    switch ($do) {
        case 'post':
            $username = _post('username');
            $username = filter_var($username, FILTER_SANITIZE_STRING);
            $username = addslashes($username);
            $password = _post('password');
            $password = addslashes($password);
            $auth = false;

            $after = route(2);

            if ($after != '') {
                $after = str_replace('*', '/', $after);
                $rd = U . $after . '/';
            } else {
                $rd = U . $config['redirect_url'] . '/';
            }

            setcookie("ib_rd", $rd, time() + 3600, "/");

            if (
                $config['recaptcha'] == '1' &&
                !empty($config['recaptcha_secretkey'])
            ) {
                $result = sp_verify_recaptcha(
                    $config['recaptcha_secretkey'],
                    _post('token')
                );

                if (!$result) {
                    responseWithError('A server error occurred.');
                }

                if ($result->success && $result->score >= 0.5) {
                    $auth = Admin::login($username, $password);
                } else {
                    responseWithError($_L['Recaptcha Verification Failed']);
                }
            } else {
                $auth = Admin::login($username, $password);
            }

            if ($auth) {
                api_response([
                    'success' => true,
                    'redirect_url' => $rd,
                ]);
            } else {
                responseWithError($_L['Invalid Username or Password']);
            }

            break;

        case 'login-display':
            Event::trigger('admin/login/');

            Admin::isLogged();

            view('auth', [
                'type' => 'admin_auth',
                'box_title' => 'Login',
            ]);

            break;

        case 'forgot-pw':
            view('auth', [
                'type' => 'forgot_password',
                'box_title' => 'Forgot Password?',
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
                    r2(
                        U . 'login/',
                        'e',
                        $_L['Invalid Password Reset Key'] . '!'
                    );
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
            Admin::isLogged();
            $after = route(2);

            $ui->assign('after', $after);

            view('auth', [
                'type' => 'admin_auth',
                'box_title' => 'Login',
            ]);

            break;

        default:
            Admin::isLogged();
            view('login');
            break;
    }
}
