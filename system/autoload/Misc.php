<?php
class Misc
{
    public static function check_permission_by_role_id($rid, $pid, $action)
    {
        $d = ORM::for_table('sys_staffpermissions')
            ->where('rid', $rid)
            ->where('pid', $pid)
            ->find_one();

        if ($d) {
            switch ($action) {
                case 'view':
                    if ($d->can_view == 1) {
                        return true;
                    } else {
                        return false;
                    }

                    break;

                case 'edit':
                    if ($d->can_edit == 1) {
                        return true;
                    } else {
                        return false;
                    }

                    break;

                case 'create':
                    if ($d->can_create == 1) {
                        return true;
                    } else {
                        return false;
                    }

                    break;

                case 'delete':
                    if ($d->can_delete == 1) {
                        return true;
                    } else {
                        return false;
                    }

                    break;

                case 'all_data':
                    if ($d->all_data == 1) {
                        return true;
                    } else {
                        return false;
                    }

                    break;

                default:
                    return false;
            }
        } else {
            return false;
        }
    }

    public static function transaction_attachment($path)
    {
        global $_L;

        $pathinfo = pathinfo($path);

        $ext = $pathinfo['extension'];

        if ($ext == 'pdf') {
            return '<a class="btn btn-primary" href="' .
                APP_URL .
                '/storage/transactions/' .
                $path .
                '">' .
                $_L['Download PDF'] .
                '</a>';
        } else {
            return '<img class="img-fluid" src="' .
                APP_URL .
                '/storage/transactions/' .
                $path .
                '" alt="">';
        }
    }

    public static function get_moment_format($df)
    {
        if ($df == 'd/m/Y') {
            return 'DD/MM/YYYY';
        } elseif ($df == 'd.m.Y') {
            return 'DD.MM.YYYY';
        } elseif ($df == 'd-m-Y') {
            return 'DD-MM-YYYY';
        } elseif ($df == 'm/d/Y') {
            return 'MM/DD/YYYY';
        } elseif ($df == 'Y/m/d') {
            return 'YYYY/MM/DD';
        } elseif ($df == 'Y-m-d') {
            return 'YYYY-MM-DD';
        } elseif ($df == 'M d Y') {
            return 'MMM DD YYYY';
        } elseif ($df == 'd M Y') {
            return 'DD MMM YYYY';
        } elseif ($df == 'jS M y') {
            return 'Do MMM YY';
        } else {
            return 'dddd, MMMM Do YYYY';
        }
    }

    public static function autoLogin(
        $username,
        $password,
        $where = 'admin',
        $r2 = 'dashboard/'
    ) {
        global $_L;

        switch ($where) {
            case 'admin':
                $d = ORM::for_table('sys_users')
                    ->where('username', $username)
                    ->find_one();
                if ($d) {
                    $d_pass = $d['password'];
                    if (Password::_verify($password, $d_pass) == true) {
                        $_SESSION['uid'] = $d['id'];
                        $d->last_login = date('Y-m-d H:i:s');
                        $d->save();
                        //login log

                        _log(
                            $_L['Login Successful'] . ' ' . $username,
                            'Admin',
                            $d['id']
                        );

                        r2(U . $r2);
                    } else {
                        _msglog('e', 'Invalid Username or Password');
                        _log($_L['Failed Login'] . ' ' . $username, 'Admin');
                        r2(U . 'login');
                    }
                } else {
                    _msglog('e', 'Invalid Username or Password');

                    r2(U . 'login/');
                }

                break;

            case 'client':
            case 'customer':
                $auth = Contacts::login($username, $password);

                if ($auth) {
                    // store authentication key in the cookies

                    setcookie(
                        'cloudonex_client_token',
                        $auth,
                        time() + 86400 * 30,
                        "/"
                    ); // 86400 = 1 day

                    if ($r2 == 'dashboard/' || $r2 == 'dashboard') {
                        r2(U . 'client/dashboard/');
                    } else {
                        r2(U . $r2);
                    }
                } else {
                    r2(
                        U . 'client/login/',
                        'e',
                        $_L['Invalid Username or Password']
                    );
                }

                break;
        }
    }

    public static function array_percentage($arr, $round = 1)
    {
        $total = array_sum($arr);

        $ret = [];

        foreach ($arr as $key => $value) {
            if ($value == 0) {
                $ret[$key]['percentage'] = 0;
            } else {
                $ret[$key]['percentage'] = round(
                    ($value / $total) * 100,
                    $round
                );
            }
        }

        return $ret;
    }

    #
    public static function random_string($length)
    {
        $key = '';
        $keys = array_merge(range(0, 9), range('a', 'z'));

        for ($i = 0; $i < $length; $i++) {
            $key .= $keys[array_rand($keys)];
        }

        return $key;
    }

    public static function systemInfo()
    {
        ob_start();
        phpinfo();
        $pinfo = ob_get_contents();
        ob_end_clean();

        $pinfo = preg_replace('%^.*<body>(.*)</body>.*$%ms', '$1', $pinfo);

        $pinfo = str_replace(
            '<table>',
            '<table class="table table-bordered sys_table">',
            $pinfo
        );
        $pinfo = str_replace('<h2>PHP License</h2>', '', $pinfo);

        $pinfo = preg_replace('/<a href=.*?>(.*?)<\/a>/', '', $pinfo);
        $pinfo = preg_replace("'<p>(.*?)</p>'si", '', $pinfo);
        $pinfo = preg_replace('/nights\s(.*)\spoodle/', '', $pinfo);

        return $pinfo;
    }
}
