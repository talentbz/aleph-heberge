<?php
/*
|--------------------------------------------------------------------------
| Various Custom Function used in this application
|--------------------------------------------------------------------------
|
*/

use Illuminate\Cache\CacheManager;
use Illuminate\Database\Capsule\Manager as DB;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use Sabre\Event\EventEmitter;
use Symfony\Component\HttpFoundation\Request;

$app = new EventEmitter();

$request = Request::createFromGlobals()->request;

$update_server = 'https://www.cloudonex.com';

/**
 * Redirect Function
 *
 * @param string $to
 * @param string $ntype
 * @param string $msg
 * @return void
 */

function r2($to, $ntype = 'e', $msg = '')
{
    if ($msg == '') {
        header("location: $to");
        exit();
    }
    $_SESSION['ntype'] = $ntype;
    $_SESSION['notify'] = $msg;
    header("location: $to");
    exit();
}

// Enable Error reporting when Dev mode is enabled.
if (strtolower(APP_STAGE) === 'dev') {
    $whoops = new \Whoops\Run();
    $whoops->pushHandler(new \Whoops\Handler\PrettyPageHandler());
    $whoops->register();
}

/**
 * Clean whitespace from string
 *
 * @param  string $value
 * @return string
 */
function safedata($value)
{
    $value = trim($value);
    return $value;
}

/**
 * shortcut function
 *
 * @param  string $param
 * @return string
 */
function _post($param, $defvalue = '')
{
    if (!isset($_POST[$param])) {
        return $defvalue;
    }
    $config = HTMLPurifier_Config::createDefault();
    $purifier = new HTMLPurifier($config);
    return trim($purifier->purify($_POST[$param]));
}

/**
 * @param $param
 * @param string $defvalue
 * @return string
 */
function _get($param, $defvalue = '')
{
    if (!isset($_GET[$param])) {
        return $defvalue;
    } else {
        return safedata($_GET[$param]);
    }
}

$request_method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
$req = _get('ng');
$routes = explode('/', $req);
$handler = $routes['0'];
if ($handler == '') {
    $handler = 'default';
}
$db = new DB();
$db->addConnection([
    'driver' => 'mysql',
    'host' => DB_HOST,
    'database' => DB_NAME,
    'username' => DB_USER,
    'password' => DB_PASSWORD,
    'charset' => 'utf8',
    'collation' => 'utf8_unicode_ci',
    'prefix' => '',
]);
// Make this Capsule instance available globally via static methods... (optional)
$db->setAsGlobal();
// Setup the Eloquent ORM... (optional; unless you've used setEventDispatcher())
$db->bootEloquent();
ORM::configure('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME);
ORM::configure('username', DB_USER);
ORM::configure('password', DB_PASSWORD);
ORM::configure('driver_options', [
    PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
]);
ORM::configure('return_result_sets', true); // returns result sets

$result = ORM::for_table('sys_appconfig');

$result = $result->find_array();

foreach ($result as $value) {
    $config[$value['setting']] = $value['value'];
}

date_default_timezone_set($config['timezone']);

$container = new \Illuminate\Container\Container();
$container->instance('app', $container);

$env = require 'system/env.php';
$container['config'] = new \Illuminate\Config\Repository($env);

$container['files'] = new Filesystem();

$cacheManager = new CacheManager($container);

// Get the default cache driver
$cache = $cacheManager->store();

/**
 * @param $msg
 * @param string $type
 */
function _notify($msg, $type = 'e')
{
    $_SESSION['ntype'] = $type;
    $_SESSION['notify'] = $msg;
}

if (isset($_SESSION['language']) && $_SESSION['language'] != '') {
    $ib_language_file_path = 'system/i18n/' . $_SESSION['language'] . '.php';
    $clx_language_code = $_SESSION['language'];
} else {
    $ib_language_file_path = 'system/i18n/' . $config['language'] . '.php';
    $clx_language_code = $config['language'];
}

if (file_exists($ib_language_file_path)) {
    $_L = require $ib_language_file_path;
} else {
    $_L = 'system/i18n/en.php';
}
$overrides_language_strings = [];
if (file_exists('system/overrides/i18n.php')) {
    $overrides_language_strings = require 'system/overrides/i18n.php';
}

$_L = array_merge($_L, $overrides_language_strings);

/**
 * @param $type
 * @param $msg
 */
function _msglog($type, $msg)
{
    $_SESSION['ntype'] = $type;
    $_SESSION['notify'] = $msg;
}

if ($config['url_rewrite'] == '1') {
    define('U', APP_URL . '/');
    define('BASE_URL', APP_URL . '/');
} else {
    define('U', APP_URL . '/?ng=');
    define('BASE_URL', APP_URL . '/?ng=');
}

$_theme = APP_URL . '/ui/theme/default';

$ps = ORM::for_table('sys_pl')
    ->where('status', '1')
    ->order_by_asc('sorder')
    ->find_array();

/**
 * @return bool
 */
function _auth()
{
    if (isset($_SESSION['uid'])) {
        return true;
    }

    $after = _get('ng');

    $after = str_replace('/', '*', $after);

    $after = rtrim($after, '*');

    r2(U . 'login/after/' . $after);
}

/**
 * void
 */
function _admin()
{
    if (isset($_SESSION['uid'])) {
        $d = ORM::for_table('user')->find_one($_SESSION['uid']);
        if ($d['user_type'] == 'Admin') {
            //  return true;
        } else {
            r2(U . 'login/');
        }
    } else {
        r2(U . 'login/');
    }
}

function authenticate_admin()
{
    if (!defined('APP_RUN')) {
        exit('No direct access allowed');
    }
    if (!isset($_SESSION['uid'])) {
        echo 'You have logged out. <a href="' .
            U .
            'login/">Click Here to Login.</a>';
        exit();
    }

    $user = User::find($_SESSION['uid']);

    if ($user) {
        global $ui;
        $ui->assign('user', $user);
        return $user;
    }
}

$resourceURL = 'https://www.cloudonex.com';

require 'ui/theme/' . 'default' . '/functions.php';

/**
 * @return Smarty
 */
function ui()
{
    global $config, $_L, $file_build, $resourceURL, $clx_language_code;
    $_theme = APP_URL . '/ui/theme/' . $config['theme'];
    $theme = APP_URL . '/ui/theme/';
    $assets = APP_URL . '/ui/assets/';
    $storage = APP_URL . '/storage/';
    $app_theme = $config['theme'];
    $ui = new Smarty();
    $ui->setTemplateDir('ui/theme/' . $app_theme . '/');
    $ui->setCompileDir('storage/compiled/');
    $ui->setCacheDir('storage/cache/');
    $ui->assign('config', $config);
    $ui->assign('_L', $_L);
    $ui->assign('app_theme', $app_theme);
    $ui->assign('_app_stage', APP_STAGE);
    $ui->assign('assets', $assets);
    $ui->assign('storage', $storage);
    $ui->assign('layouts_base', $config['base_layout'] ?? 'layouts/base.tpl');
    $ui->assign(
        'layouts_admin',
        $config['admin_layout'] ?? 'layouts/admin.tpl'
    );
    $ui->assign(
        'layouts_client',
        $config['client_layout'] ?? 'layouts/client.tpl'
    );
    $ui->assign('layouts_paper', 'layouts/paper.tpl');
    $ui->assign('app_url', APP_URL . '/');
    $ui->assign('clx_language_code', $clx_language_code);
    if ($config['url_rewrite'] == '1') {
        $ui->assign('_url', APP_URL . '/');
        $ui->assign('base_url', APP_URL . '/');
    } else {
        $ui->assign('_url', APP_URL . '/?ng=');
        $ui->assign('base_url', APP_URL . '/?ng=');
    }
    $ui->assign('_theme', $_theme);
    $ui->assign('theme', $theme);
    $ui->assign('resourceURL', $resourceURL);
    $ui->assign('file_build', $file_build);
    $ui->assign('selected_navigation', '');
    $ui->assign('_title', $config['CompanyName']);
    $ui->assign('_st', 'application');
    $ui->assign('_topic', 'dashboard');
    $ui->assign('content_inner', '');
    $ui->assign('jsvar', '');
    $ui->assign('tpl_footer', true);
    $ui->assign('tplheader', 'sections/' . $config['industry'] . '/header');
    $ui->assign('tplfooter', 'sections/' . $config['industry'] . '/footer');
    $ui->assign('admin_menu', 'sections/admin_menu');
    $ui->assign('client_menu', 'sections/client_menu');
    $ui->assign(
        'client_tplheader',
        'sections/header_client_' . $config['industry']
    );
    $ui->assign(
        'client_tplfooter',
        'sections/footer_client_' . $config['industry']
    );

    if (isset($_SESSION['notify'])) {
        $notify = $_SESSION['notify'];
        $ntype = $_SESSION['notification_type'] ?? ($_SESSION['ntype'] ?? '');
        if ($ntype === 's' || $ntype === 'success') {
            $ui->assign(
                'notify',
                '<div class="alert alert-success ks-solid ks-active-border">
								<button class="close" data-dismiss="alert">
									&times;
								</button>
								<i class="fa-fw fal fa-check"></i>
								' .
                    $notify .
                    '
							</div>'
            );
        } else {
            $ui->assign(
                'notify',
                '<div class="alert alert-danger ks-solid ks-active-border">
								<button class="close" data-dismiss="alert">
									&times;
								</button>
								<i class="fa-fw fal fa-times"></i>
								' .
                    $notify .
                    '
							</div>'
            );
        }

        if (!empty($_SESSION['notify'])) {
            unset($_SESSION['notify']);
        }

        if (!empty($_SESSION['ntype'])) {
            unset($_SESSION['ntype']);
        }

        if (!empty($_SESSION['notification_type'])) {
            unset($_SESSION['notification_type']);
        }
    }

    return $ui;
}

/**
 * @return mixed
 */
function get_client_ip()
{
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        $ip = $_SERVER['HTTP_CLIENT_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else {
        $ip = $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1';
    }

    return $ip;
}

/**
 * @param $param
 * @param string $defvalue
 * @return string
 */
function ib_post($param, $defvalue = '')
{
    if (!isset($_POST[$param])) {
        return $defvalue;
    }
    $config = HTMLPurifier_Config::createDefault();
    $purifier = new HTMLPurifier($config);
    return $purifier->purify($_POST[$param]);
}

/**
 * @param $description
 * @param string $type
 * @param string $userid
 */
function _log($description, $type = '', $userid = '0')
{
    $msg = '';
    if (is_array($description)) {
        foreach ($description as $key => $value) {
            $msg .= $key . ' : ' . $value;
        }
    } else {
        $msg = $description;
    }

    $d = ORM::for_table('sys_logs')->create();
    $d->date = date('Y-m-d H:i:s');
    $d->type = $type;
    $d->description = $msg;
    $d->userid = $userid;
    $d->ip = get_client_ip();
    $d->save();
}

$admin_extra_nav = [
    0 => '',
    1 => '',
    2 => '',
    3 => '',
    4 => '',
    5 => '',
    6 => '',
    7 => '',
    8 => '',
    9 => '',
    10 => '',
];
$client_extra_nav = [
    0 => '',
    1 => '',
    2 => '',
    3 => '',
    4 => '',
    5 => '',
    6 => '',
    7 => '',
    8 => '',
    9 => '',
    10 => '',
];

$sub_menu_admin = [];
$sub_menu_admin['settings'] = [];
$sub_menu_admin['appearance'] = [];
$sub_menu_admin['crm'] = [];
$sub_menu_admin['sales'] = [];
$sub_menu_admin['reports'] = [];
$sub_menu_admin['utilities'] = [];

/**
 * @param $parent
 * @param $name
 * @param $link
 * @depracated
 */
function add_sub_menu_admin($parent, $name, $link)
{
    global $sub_menu_admin;
    $sub_menu_admin[$parent][] =
        '<li><a href="' .
        $link .
        '">' .
        $name .
        '</a></li>
';
}

/**
 * @param $option
 * @param $value
 * @return bool
 */
function add_option($option, $value)
{
    $d = ORM::for_table('sys_appconfig')
        ->where('setting', $option)
        ->find_one();
    if ($d) {
        return false;
    } else {
        // add option

        $c = ORM::for_table('sys_appconfig')->create();
        $c->setting = $option;
        $c->value = $value;
        $c->save();
        return true;
    }
}

/**
 * @param $option
 * @return array|bool|mixed|null
 */
function get_option($option)
{
    $d = ORM::for_table('sys_appconfig')
        ->where('setting', $option)
        ->find_one();
    if ($d) {
        return $d['value'];
    } else {
        return false;
    }
}

/**
 * @param string $msg
 */
function ib_die($msg = '')
{
    echo $msg;
    exit();
}

/**
 * void
 */
function ib_close()
{
    exit();
}

/**
 * @param $fid
 * @param $rid
 * @return array|mixed|null
 */
function get_custom_field_value($fid, $rid)
{
    $d = ORM::for_table('crm_customfieldsvalues')
        ->where('fieldid', $fid)
        ->where('relid', $rid)
        ->find_one();
    if ($d) {
        return $d->fvalue;
    }
}

/**
 * @return int
 */
function ib_pg_count()
{
    $d = ORM::for_table('sys_pg')
        ->where('status', 'Active')
        ->count();
    return $d;
}

/**
 * @param $fieldid
 * @param $relid
 * @param $fvalue
 * @return bool
 */
function ib_add_field_value($fieldid, $relid, $fvalue)
{
    $d = ORM::for_table('crm_customfieldsvalues')->create();
    $d->fieldid = $fieldid;
    $d->relid = $relid;
    $d->fvalue = $fvalue;
    $d->save();
    return true;
}

/**
 * @return false|string
 */
function ib_today()
{
    return date('Y-m-d');
}

/**
 * @param string $from
 * @param string $format
 * @return false|string
 */
function ib_after_1_month($from = '', $format = 'mysql')
{
    if ($from == '') {
        $from = strtotime(date('Y-m-d'));
    }

    if ($format == 'mysql') {
        $format = 'Y-m-d';
    }

    return date($format, strtotime('+1 month', $from));
}

/**
 * @param $line
 * @param string $fallback
 * @return mixed|string
 */
function ib_lan_get_line($line, $fallback = '')
{
    global $_L;
    if (isset($_L[$line])) {
        return str_replace($line, $_L[$line], $line);
    } elseif ($fallback != '') {
        return $fallback;
    } else {
        return $line;
    }
}

/**
 * @param string $msg
 * Used for debug only
 */
function d2($msg = 'I am here!')
{
    if (is_array($msg)) {
        foreach ($msg as $m) {
            echo $m .
                ' |
';
        }
    } else {
        echo $msg;
    }

    exit();
}

/**
 * @param $data
 */
function d2c($data)
{
    if (is_array($data)) {
        $output =
            "<script>console.log( 'Debug Objects: " .
            implode(',', $data) .
            "' );</script>";
    } else {
        $output =
            "<script>console.log( 'Debug Objects: " . $data . "' );</script>";
    }
    echo $output;
}

/**
 * @return mixed
 */
function lan()
{
    global $config;
    return $config['language'];
}

/**
 * @param array $f
 * @param string $v
 * @return bool
 */
function add_js($f = [], $v = '')
{
    global $ui;
    global $pl_path;
    if ($v == '') {
        $ver = '';
    } else {
        $ver = '?ver=' . $v;
    }

    $gen = '';
    if (is_array($f)) {
        foreach ($f as $p) {
            $gen .=
                '<script type="text/javascript" src="' .
                $pl_path .
                'js/' .
                $p .
                '.js' .
                $ver .
                '"></script>
        ';
        }

        $ui->assign('xfooter', $gen);
        return true;
    }

    return false;
}

/**
 * @param array $url
 * @return bool|string
 */
function add_js_external($url = [])
{
    $gen = '';
    if (is_array($url)) {
        foreach ($url as $u) {
            $gen .=
                '<script type="text/javascript" src="' .
                APP_URL .
                '/' .
                $u .
                '.js"></script>
        ';
        }

        return $gen;
    }

    return false;
}

/**
 * @param array $paths
 * @return bool|string
 */
function add_js_internal($paths = [])
{
    $gen = '';
    if (is_array($paths)) {
        foreach ($paths as $u) {
            $gen .=
                '<script type="text/javascript" src="' .
                APP_URL .
                '/' .
                $u .
                '.js"></script>
        ';
        }

        return $gen;
    }

    return false;
}

/**
 * @param $path
 */
function set_tpl($path)
{
    global $ui;
    $ui->assign('tplheader', $path . 'header');
    $ui->assign('tplfooter', $path . 'footer');
}

/**
 * @param $path
 */
function set_admin_header($path)
{
    global $ui;
    $ui->assign('tplheader', $path);
}

/**
 * @param $path
 */
function set_admin_footer($path)
{
    global $ui;
    $ui->assign('tplfooter', $path);
}

// @deprecated

function set_admin_nav($path)
{
    global $ui;
    $ui->assign('admin_menu', $path);
}

/**
 * @param $path
 */
function set_admin_menu($path)
{
    global $ui;
    $ui->assign('admin_menu', $path);
}

/**
 * @param $path
 */
function set_client_menu($path)
{
    global $ui;
    $ui->assign('client_menu', $path);
}

/**
 * @param $path
 */
function language_append($path)
{
    global $_L;
    $file = 'apps/' . $path;
    include $file;
}

/**
 * @param $path
 */
function lan_register($path)
{
    $x = include $path;

    var_dump($x);
    exit();
}

/**
 * @param string $header
 */
function add_plugin_ui_header_admin($header = '')
{
    global $plugin_ui_header_admin;
    array_push($plugin_ui_header_admin, $header);
}

/**
 * @param $path
 */
function add_css_admin($path)
{
    global $plugin_ui_header_admin_css;
    array_push($plugin_ui_header_admin_css, $path);
}

/**
 * @param string $header
 */
function add_plugin_ui_header_client($header = '')
{
    global $plugin_ui_header_client;
    array_push($plugin_ui_header_client, $header);
}

/**
 * @param $path
 */
function add_css_client($path)
{
    global $plugin_ui_header_client_css;
    array_push($plugin_ui_header_client_css, $path);
}

/**
 * @param string $msg
 */
function i_close($msg = '')
{
    echo $msg;
    exit();
}

/**
 * @param $lk
 */
function inner_contents($lk)
{
    return;
}

/**
 * @param $url
 * @param string $method
 * @param array $params
 * @param array $headers
 * @param bool $resp_header
 * @param bool $follow_redirect
 * @return mixed|string
 * @throws Exception
 */
function ib_http_request(
    $url,
    $method = 'GET',
    $params = [],
    $headers = [],
    $resp_header = false,
    $follow_redirect = false
) {
    $response = '';
    if (!is_callable('curl_init')) {
        throw new Exception('CURL Not available in this Server.');
    }

    switch ($method) {
        case 'GET':
            $q = '';
            foreach ($params as $key => $value) {
                $value = urlencode($value);
                $q .= $key . '=' . $value . '&';
            }

            $req = $url;
            if ($q != '') {
                $q = rtrim($q, '&');
                $req = $url . '?' . $q;
            }

            try {
                $ch = curl_init();
                if (false === $ch) {
                    throw new Exception('failed to initialize');
                }
                if (!empty($headers)) {
                    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                }

                curl_setopt($ch, CURLOPT_AUTOREFERER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_URL, $req);
                if ($follow_redirect) {
                    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                }

                if ($resp_header) {
                    curl_setopt($ch, CURLOPT_HEADER, 1);
                }

                $response = curl_exec($ch);
                if (false === $response) {
                    throw new Exception(curl_error($ch), curl_errno($ch));
                }
                curl_close($ch);
            } catch (Exception $e) {
                throw new Exception($e->getCode() . ' ' . $e->getMessage());
            }

            break;

        case 'POST':
            try {
                $ch = curl_init();
                if (false === $ch) {
                    throw new Exception('failed to initialize');
                }
                if (!empty($headers)) {
                    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                }

                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($params));
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                if ($resp_header) {
                    curl_setopt($ch, CURLOPT_HEADER, 1);
                }

                $response = curl_exec($ch);
                if (false === $response) {
                    throw new Exception(curl_error($ch), curl_errno($ch));
                }
                curl_close($ch);
            } catch (Exception $e) {
                throw new Exception($e->getCode() . ' ' . $e->getMessage());
            }

            break;
    }

    return $response;
}

/**
 * @param $table
 * @param array $columns
 * @return array|IdiormResultSet
 */
function db_find_many($table, $columns = [])
{
    $d = ORM::for_table($table);
    foreach ($columns as $column) {
        $d->select($column);
    }

    $ret = $d->find_many();
    return $ret;
}

/**
 * @param $table
 * @param array $columns
 * @param string $order_by
 * @return array
 */
function db_find_array($table, $columns = [], $order_by = '')
{
    $d = ORM::for_table($table);
    foreach ($columns as $column) {
        $d->select($column);
    }

    if ($order_by != '') {
        $o = explode(':', $order_by);
        if ($o[0] == 'asc') {
            $d->order_by_asc($o[1]);
        } elseif ($o[0] == 'desc') {
            $d->order_by_desc($o[1]);
        } else {
            $d->order_by_desc($order_by);
        }
    }

    $ret = $d->find_array();
    return $ret;
}

/**
 * @param $table
 * @param $id
 * @return bool|ORM
 */
function db_find_one($table, $id)
{
    $d = ORM::for_table($table)->find_one($id);
    if ($d) {
        return $d;
    } else {
        return false;
    }
}

/**
 * @param $table
 * @param $id
 * @return bool
 */
function db_delete_row($table, $id)
{
    $d = ORM::for_table($table)->find_one($id);
    if ($d) {
        $d->delete();
        return true;
    } else {
        return false;
    }
}

/**
 * @param $table
 * @param $column
 * @return bool|ORM
 */
function db_column_exist($table, $column)
{
    return ORM::for_table($table)
        ->raw_query("SHOW COLUMNS FROM $table LIKE '$column'")
        ->find_one();
}

/**
 * @param $table
 * @return bool|ORM
 */
function db_table_exist($table)
{
    return ORM::for_table('crm_accounts')
        ->raw_query("SHOW TABLES LIKE '$table'")
        ->find_one();
}

/**
 * @param $id
 * @param string $default
 * @return string
 */
function route($id, $default = '')
{
    global $routes;
    if (isset($routes[$id]) && $routes[$id] != '') {
        return $routes[$id];
    } else {
        return $default;
    }
}

/**
 * void
 */
function is_dev()
{
    if (APP_STAGE != "Dev") {
        die("Unable to handle your request in Live Mode.");
    }
}

function is_demo()
{
    if (APP_STAGE === 'Demo') {
        return true;
    }

    return false;
}

/**
 * @param $amount
 * @param $config
 * @param string $symbol
 * @return string
 */
function ib_money_format($amount, $config, $symbol = '')
{
    if ($symbol == '') {
        $currency_code = $config['currency_code'];
    } else {
        $currency_code = $symbol;
    }

    $thousand_separator_placement = $config['thousand_separator_placement'];
    $currency_decimal_digits = $config['currency_decimal_digits'];
    $currency_symbol_position = $config['currency_symbol_position'];
    $dec_point = $config['dec_point'];
    $thousands_sep = $config['thousands_sep'];
    if ($currency_decimal_digits == 'true') {
        $dec_digit = 2;
    } else {
        $dec_digit = 0;
    }

    if ($currency_symbol_position == 's') {
        $retval =
            number_format($amount, $dec_digit, $dec_point, $thousands_sep) .
            $currency_code;
    } else {
        $retval =
            $currency_code .
            ' ' .
            number_format($amount, $dec_digit, $dec_point, $thousands_sep);
    }

    return $retval;
}

/**
 * @param $x
 * @param $y
 * @return float|int
 */
function ib_multiply($x, $y)
{
    return $x * $y;
}

/**
 * @param $x
 * @param $y
 * @return float|int
 */
function ib_division($x, $y)
{
    return $x / $y;
}

/**
 * @param array $values
 * @return int|mixed
 */
function ib_addition($values = [])
{
    $total = 0;
    foreach ($values as $val) {
        $total += $val;
    }

    return $total;
}

/**
 * @return bool|ORM
 */
function secondary_currency()
{
    global $config;
    $c_check = ORM::for_table('sys_currencies')->find_array();
    if (count($c_check) == 2) {
        $sc = ORM::for_table('sys_currencies')
            ->where_not_equal('iso_code', $config['currency_code'])
            ->find_one();
        return $sc;
    } else {
        return false;
    }
}

/*
 * @deprecated
 * use ib_posted_data
 * */

function ib_get_posted_data()
{
    $data = [];
    foreach ($_POST as $key => $value) {
        $data[$key] = trim($value);
    }

    return $data;
}

/**
 * @return array
 */
function ib_posted_data()
{
    $data = [];
    foreach ($_POST as $key => $value) {
        $data[$key] = trim($value);
    }

    return $data;
}

/**
 * @param $format
 * @param string $js
 * @return mixed
 */
function ib_js_date_format($format, $js = 'moment')
{
    if ($js == 'moment') {
        $format = str_replace('d', 'DD', $format);
        $format = str_replace('M', 'MMM', $format);
        $format = str_replace('m', 'MM', $format);
        $format = str_replace('Y', 'YYYY', $format);
        $format = str_replace('jS', 'Do', $format);
        return $format;
    } elseif ($js = 'picker') {
        $format = str_replace('d', 'dd', $format);
        $format = str_replace('m', 'mm', $format);
        $format = str_replace('Y', 'yyyy', $format);
        $format = str_replace('M', 'mmm', $format);
        $format = str_replace('jS', 'd', $format);
        return $format;
    } else {
        $format = str_replace('d', 'DD', $format);
        $format = str_replace('m', 'MM', $format);
        $format = str_replace('Y', 'YYYY', $format);
        $format = str_replace('M', 'MMM', $format);
        $format = str_replace('jS', 'Do', $format);
        return $format;
    }
}

/**
 * @param $rid
 * @param $shortname
 * @param string $action
 * @return bool
 */
function has_access($rid, $shortname, $action = 'view')
{
    if ($rid == 0) {
        return true;
    }

    $d = ORM::for_table('sys_staffpermissions')
        ->where('rid', $rid)
        ->where('shortname', $shortname)
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

/**
 * @param $pname
 * @param $shortname
 * @return array|bool|mixed|null
 * @throws Exception
 */
function addPermission($pname, $shortname)
{
    $d = ORM::for_table('sys_permissions')
        ->where('shortname', $shortname)
        ->find_one();
    if ($d) {
        return false;
    }

    $p = ORM::for_table('sys_permissions')->create();
    $p->pname = $pname;
    $p->shortname = $shortname;
    $p->save();
    return $p->id();
}

/**
 * @param $shortname
 * @return bool
 */
function deletePermission($shortname)
{
    $d = ORM::for_table('sys_permissions')
        ->where('shortname', $shortname)
        ->find_one();
    if ($d) {
        $d->delete();
        return true;
    } else {
        return false;
    }
}

/**
 * void
 */
function permissionDenied()
{
    r2(U . 'dashboard', 'e', 'Permission Denied');
}

/**
 * @return mixed
 */
function client_ip()
{
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        $ip = $_SERVER['HTTP_CLIENT_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else {
        $ip = $_SERVER['REMOTE_ADDR'];
    }

    return $ip;
}

/**
 * @param $num
 * @param int $zerofill
 * @return string
 */
function ib_zerofill($num, $zerofill = 5)
{
    return str_pad($num, $zerofill, '0', STR_PAD_LEFT);
}

/**
 * @param $aid
 * @return array|mixed|null|string
 */
function getAdminName($aid)
{
    $d = ORM::for_table('sys_users')->find_one($aid);
    if ($d) {
        return $d->fullname;
    } else {
        return '';
    }
}

/**
 * @param $company_id
 * @return array|mixed|null|string
 */
function getCompanyName($company_id)
{
    $d = ORM::for_table('sys_companies')->find_one($company_id);
    if ($d) {
        return $d->company_name;
    } else {
        return '';
    }
}

/**
 * @param $admin_id
 * @param int $size
 * @return array|mixed|null|string
 */
function getAdminImage($admin_id, $size = 100)
{
    $d = ORM::for_table('sys_users')
        ->select('img')
        ->find_one($admin_id);
    if ($d) {
        if ($d->img == 'gravatar') {
            $img =
                'http://www.gravatar.com/avatar/{($a->email)|md5}?s=' . $size;
        } elseif ($d->img != '') {
            //  $img = $d->img;
            $img = APP_URL . '/' . $d->img;
        } else {
            $img = APP_URL . '/ui/lib/img/default-user-avatar.png';
        }
    } else {
        $img = APP_URL . '/ui/lib/img/default-user-avatar.png';
    }

    return $img;
}

/**
 * @param string $code
 * @param string $text
 */
function abort($code = '404', $text = 'Page Not Found')
{
    http_response_code($code);
    exit($text);
}

/**
 * @param $column
 * @param $table
 * @return bool
 */
function hasColumn($column, $table)
{
    $x = ORM::for_table($table)
        ->raw_query(
            'SHOW COLUMNS FROM `' . $table . '` LIKE \'' . $column . '\''
        )
        ->find_one();
    if ($x) {
        return true;
    } else {
        return false;
    }
}

/**
 * @param $template
 * @param array $vars
 * @throws SmartyException
 */
function view($template, $vars = [])
{
    global $ui;
    global $app_theme;
    foreach ($vars as $key => $value) {
        $ui->assign($key, $value);
    }

    if (file_exists('ui/theme/' . $app_theme . '/' . $template . '.tpl')) {
        $ui->display($template . '.tpl');
    } else {
        $ui->display('../default/' . $template . '.tpl');
    }
}

function view_render($template, $vars = [])
{
    global $ui;
    global $app_theme;
    foreach ($vars as $key => $value) {
        $ui->assign($key, $value);
    }

    if (file_exists('ui/theme/' . $app_theme . '/' . $template . '.tpl')) {
        return $ui->fetch($template . '.tpl');
    }

    return $ui->fetch('../default/' . $template . '.tpl');
}

function view_from_the_app($template, $vars = [])
{
    global $ui;
    global $app_path;
    foreach ($vars as $key => $value) {
        $ui->assign($key, $value);
    }

    $ui->display('../../../' . $app_path . '/views/' . $template . '.tpl');
}

/**
 * @return string
 */
function assets()
{
    return APP_URL . '/ui/assets/';
}

/**
 * @param $name
 * @return string
 */
function namePresenter($name)
{
    $name = trim($name);
    if ($name == '') {
        $name = 'N A';
    }

    $colors = [
        'red',
        'pink',
        'purple',
        'deep_purple',
        'indigo',
        'blue',
        'light_blue',
        'cyan',
        'teal',
        'green',
        'light_green',
        'deep_orange',
        'brown',
        'grey',
        'blue_grey',
    ];
    $css_bg = $colors[array_rand($colors)];
    $full_name_e = explode(' ', $name);
    $first_name = $full_name_e[0];
    $first_name_letter = $first_name[0];
    if (isset($full_name_e[1])) {
        $last_name = $full_name_e[1];
        $last_name_letter = $last_name[0];
    } else {
        $last_name_letter = '';
    }

    $img =
        '<span class="ib_avatar ib_bg_' .
        $css_bg .
        '">' .
        $first_name_letter .
        $last_name_letter .
        '</span>';
    return $img;
}

/**
 * @return array
 */
function lastTwelveMonths()
{
    $months = [];
    for ($i = 1; $i <= 11; $i++) {
        $months[] = date("M Y", strtotime(date('Y-m-01') . " -$i months"));
    }

    $months = array_reverse($months);
    $months[12] = date("M Y", strtotime(date('Y-m-01')));
    $m = [];
    foreach ($months as $month) {
        $m[] = $month;
    }

    return $m;
}

/**
 * @param $string
 * @param int $length
 * @return string
 */
function strTrunc($string, $length = 12)
{
    return strlen($string) > $length
        ? substr($string, 0, $length) . "..."
        : $string;
}

/**
 * @param $key
 * @param string $def
 * @return string
 */
function inSession($key, $def = '')
{
    if (isset($_SESSION[$key])) {
        return $_SESSION[$key];
    } else {
        return $def;
    }
}

/**
 * @return mixed
 */
function homeCurrency()
{
    global $config;
    if (!empty($config['home_currency'])) {
        return Currency::where('iso_code', $config['home_currency'])->first();
    }
    return Currency::first();
}

/**
 * @param $table
 * @return int
 */
function predictNextRow($table)
{
    $d = DB::select(
        "SHOW TABLE STATUS FROM `" . DB_NAME . "` WHERE `name` LIKE '$table'"
    );

    if ($d) {
        $nextRow = $d[0]->Auto_increment;
    } else {
        $nextRow = 1;
    }

    return $nextRow;
}

/**
 * @param string $purchase_key
 * @return array
 */
function updateCheck($purchase_key = '')
{
    global $user, $config, $update_server;

    $arr = [
        'action' => 'version-check',
        'app_url' => APP_URL,
        'fullname' => $user->fullname,
        'email' => $user->username,
        'build' => $config['build'],
        'purchase_key' => $purchase_key,
    ];

    $remote_build = '';
    $changelog = '';
    $update_available = 'No';
    $msg = '';
    $server_check = false;

    $raw = '';

    try {
        $raw = ib_http_request($update_server . '/update-app', 'POST', $arr);
    } catch (Exception $e) {
        $msg = $e->getMessage();
    }

    $resp = json_decode($raw);

    if (json_last_error() === JSON_ERROR_NONE) {
        if (isset($resp->build)) {
            $remote_build = $resp->build;
            $changelog = $resp->changelog;

            $server_check = true;

            if ($config['build'] < $remote_build) {
                $update_available = 'Yes';
            }
        }
    } else {
        $msg = 'Unable to Connect Update Server';
    }

    $a = [
        'remote_build' => $remote_build,
        'changelog' => $changelog,
        'update_available' => $update_available,
        'msg' => $msg,
        'server_check' => $server_check,
    ];

    return $a;
}

/**
 * @param $template_name
 * @param $message
 * @return bool|SMSTemplate
 */
function addSmsTemplate($template_name, $message)
{
    $check = SMSTemplate::where('tpl', $template_name)->first();

    if ($check) {
        // already exisit

        return false;
    } else {
        $sms_template = new SMSTemplate();
        $sms_template->tpl = $template_name;
        $sms_template->sms = $message;
        $sms_template->save();

        return $sms_template;
    }
}

/**
 * @param $template_name
 * @param $subject
 * @param $message
 * @param string $core
 * @return bool|EmailTemplate
 */
function addEmailTemplate($template_name, $subject, $message, $core = 'Yes')
{
    $check = EmailTemplate::where('tplname', $template_name)->first();

    if ($check) {
        // already exisit

        return false;
    } else {
        $email_template = new EmailTemplate();
        $email_template->tplname = $template_name;
        $email_template->subject = $subject;
        $email_template->message = $message;
        $email_template->send = 'Yes';
        $email_template->core = $core;
        $email_template->save();

        return $email_template;
    }
}

/**
 * @param $setting
 * @param $value
 * @return AppConfig|bool
 */
function addOption($setting, $value)
{
    $check = AppConfig::where('setting', $setting)->first();

    if ($check) {
        return false;
    } else {
        $c = new AppConfig();
        $c->setting = $setting;
        $c->value = $value;
        $c->save();

        return $c;
    }
}

/**
 * @param $setting
 * @param $value
 * @param bool $create
 *
 * @return bool
 */
function updateOption($setting, $value, $create = false)
{
    $check = AppConfig::where('setting', $setting)->first();

    if ($check) {
        $check->setting = $setting;
        $check->value = $value;
        $check->save();
        return true;
    } else {
        if ($create) {
            // create option
            $create = new AppConfig();
            $create->setting = $setting;
            $create->value = $value;
            $create->save();
            return true;
        } else {
            return false;
        }
    }
}

function removeOption($key)
{
    $option = AppConfig::where('setting', $key)->first();
    if ($option) {
        $option->delete();
    }
}

/**
 * void
 */
function dieIfNotPOST()
{
    if ($_SERVER['REQUEST_METHOD'] != 'POST') {
        header('HTTP/1.1 405 Method Not Allowed', true, 405);
        header("Allow: POST");
        exit();
    }
}

/**
 * @param $key
 * @return bool
 */
function isValidApiKey($key)
{
    $apiKey = ApiKey::where('apikey', $key)->first();

    if ($apiKey) {
        return true;
    } else {
        return false;
    }
}

/**
 * Get hearder Authorization
 * */
function getAuthorizationHeader()
{
    $headers = null;

    if (isset($_SERVER['Authorization'])) {
        $headers = trim($_SERVER["Authorization"]);
    } elseif (isset($_SERVER['HTTP_AUTHORIZATION'])) {
        //Nginx or fast CGI
        $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    } elseif (function_exists('apache_request_headers')) {
        $requestHeaders = apache_request_headers();
        // Server-side fix for bug in old Android versions (a nice side-effect of this fix means we don't care about capitalization for Authorization)

        $requestHeaders = array_combine(
            array_map('ucwords', array_keys($requestHeaders)),
            array_values($requestHeaders)
        );
        //print_r($requestHeaders);
        if (isset($requestHeaders['Authorization'])) {
            $headers = trim($requestHeaders['Authorization']);
        }
    } else {
        //        var_dump($_SERVER);
        //        exit;
    }
    return $headers;
}

/**
 * get access token from header
 * */
function getBearerToken()
{
    $headers = getAuthorizationHeader();

    // HEADER: Get the access token from the header
    if (!empty($headers)) {
        if (preg_match('/Bearer\s(\S+)/', $headers, $matches)) {
            return $matches[1];
        }
    }
    return null;
}

// Api authenticaion
function apiAuth()
{
    if (isset($_GET['api_key'])) {
        $token = $_GET['api_key'];
    } else {
        $token = getBearerToken();
    }

    $key = ApiKey::where('apikey', $token)->first();
    if ($key) {
        return true;
    } else {
        jsonResponse(
            [
                'error' => true,
                'message' => 'No valid API key provided.',
            ],
            401
        );
    }
}

function clientApiAuth()
{
    $contact = false;
    if (isset($_GET['api_key'])) {
        $token = $_GET['api_key'];
    } else {
        $token = getBearerToken();
    }

    if ($token != '') {
        $contact = Contact::where('autologin', $token)->first();
    }
    if ($contact) {
        return $contact;
    } else {
        jsonResponse(
            [
                'error' => true,
                'message' => 'No valid API key provided.',
            ],
            401
        );
    }
}

/**
 * @param $message
 */
function showThenExit($message)
{
    echo $message;
    exit();
}

if (!function_exists('dd')) {
    /**
     * void
     */
    function dd()
    {
        http_response_code(500);
        $args = func_get_args();
        call_user_func_array('dump', $args);
        die();
    }
}
if (!function_exists('d')) {
    function d()
    {
        $args = func_get_args();
        call_user_func_array('dump', $args);
    }
}

/**
 * @param $relation_type
 * @param $relation_id
 * @param $key
 * @return mixed
 */
function getSharedPreferences($relation_type, $relation_id = 0, $key = 'key')
{
    return SharedPreference::where('relation_type', $relation_type)
        ->where('relation_id', $relation_id)
        ->where('key', $key)
        ->first();
}

/**
 * @param $relation_type
 * @param $relation_id
 * @param $key
 * @param $value
 * @return SharedPreference
 */
function setSharedPreferences($relation_type, $relation_id, $key, $value)
{
    $pref = SharedPreference::where('relation_type', $relation_type)
        ->where('relation_id', $relation_id)
        ->where('key', $key)
        ->first();

    if ($pref) {
        $pref->value = $value;
        $pref->save();
    } else {
        $pref = new SharedPreference();
        $pref->relation_type = $relation_type;
        $pref->relation_id = $relation_id;
        $pref->key = $key;
        $pref->value = $value;
        $pref->save();
    }

    return $pref;
}

/**
 * @param $string
 * @return bool|string
 */
function spGetLastFourDigit($string)
{
    return substr($string, -4);
}

# @deprecated
function clxPerformLongProcess()
{
    return;
}

/**
 * @param $config
 * @param $text
 * @return \Psr\Http\Message\StreamInterface
 */
function slackPost($config, $text)
{
    if ($config['slack_webhook_url'] != '') {
        $client = new \GuzzleHttp\Client([
            'headers' => ['Content-Type' => 'application/json'],
        ]);

        $response = $client->post($config['slack_webhook_url'], [
            'body' => json_encode([
                'text' => $text,
            ]),
        ]);

        $body = $response->getBody();
        return $body;
    }
}

/**
 * @param $file_name
 * @param $header
 * @param $data
 * @throws \PhpOffice\PhpSpreadsheet\Exception
 * @throws \PhpOffice\PhpSpreadsheet\Writer\Exception
 */
function exportExcel($file_name, $header, $data)
{
    global $config, $user;
    $spreadsheet = new Spreadsheet();
    // Set document properties
    $spreadsheet
        ->getProperties()
        ->setCreator($config['CompanyName'])
        ->setLastModifiedBy($user->fullname)
        ->setTitle('Office 2007 XLSX Test Document')
        ->setSubject('Office 2007 XLSX Test Document')
        ->setDescription(
            'Test document for Office 2007 XLSX, generated using PHP classes.'
        )
        ->setKeywords('office 2007 openxml php')
        ->setCategory('Test result file');
    // Add some data

    $i = 'A';
    foreach ($header as $header_value) {
        $spreadsheet
            ->setActiveSheetIndex(0)
            ->setCellValue($i . '1', $header_value);
        $i++;
    }

    $x = 2;
    foreach ($data as $value) {
        $i = 'A';
        foreach ($value as $cell) {
            $spreadsheet->setActiveSheetIndex(0)->setCellValue("$i$x", $cell);
            $i++;
        }

        $x++;
    }

    // Rename worksheet
    $spreadsheet->getActiveSheet()->setTitle('customers');
    // Set active sheet index to the first sheet, so Excel opens this as the first sheet
    $spreadsheet->setActiveSheetIndex(0);
    // Redirect output to a client’s web browser (Xlsx)
    header(
        'Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    );
    header('Content-Disposition: attachment;filename="' . $file_name . '"');
    header('Cache-Control: max-age=0');
    // If you're serving to IE 9, then the following may be needed
    header('Cache-Control: max-age=1');
    // If you're serving to IE over SSL, then the following may be needed
    header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
    header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT'); // always modified
    header('Cache-Control: cache, must-revalidate'); // HTTP/1.1
    header('Pragma: public'); // HTTP/1.0
    $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
    $writer->save('php://output');
}

/**
 * @param $message
 */
function responseWithError($message)
{
    if (is_array($message)) {
        jsonResponse($message, 422);
    } else {
        http_response_code(422);
        echo $message;
        exit();
    }
}

/**
 * @param $language_code
 * @return string
 */
function getMomentLocale($language_code)
{
    switch ($language_code) {
        case 'en':
            return 'en';
            break;

        case 'pt_br':
            return 'pt_br';
            break;

        case 'fr':
            return 'fr';
            break;

        case 'ar':
            return 'ar';
            break;

        case 'de':
            return 'de';
            break;

        case 'es':
            return 'es';
            break;

        case 'id':
            return 'id';
            break;

        case 'nl':
            return 'nl';
            break;

        case 'no':
            return 'no';
            break;

        case 'ro':
            return 'ro';
            break;

        case 'pt':
            return 'pt';
            break;

        case 'th':
            return 'th';
            break;

        case 'ru':
            return 'ru';
            break;

        case 'tr':
            return 'tr';
            break;

        case 'vi':
            return 'vi';
            break;

        case 'da':
            return 'da';
            break;

        case 'fil':
            return 'fi';
            break;

        case 'he':
            return 'he';
            break;

        case 'pl':
            return 'pl';
            break;

        case 'bn':
            return 'bn';
            break;

        default:
            return 'en';
            break;
    }
}

/**
 * @param $language_code
 * @return string
 */
function getFCLocale($language_code)
{
    switch ($language_code) {
        case 'en':
            return 'en';
            break;

        case 'pt_br':
            return 'pt-br';
            break;

        case 'fr':
            return 'fr';
            break;

        case 'ar':
            return 'ar';
            break;

        case 'de':
            return 'de';
            break;

        case 'es':
            return 'es';
            break;

        case 'id':
            return 'id';
            break;

        case 'nl':
            return 'nl';
            break;

        case 'no':
            return 'no';
            break;

        case 'ro':
            return 'ro';
            break;

        case 'pt':
            return 'pt';
            break;

        case 'th':
            return 'th';
            break;

        case 'ru':
            return 'ru';
            break;

        case 'tr':
            return 'tr';
            break;

        case 'vi':
            return 'vi';
            break;

        case 'da':
            return 'da';
            break;

        case 'fil':
            return 'fi';
            break;

        case 'he':
            return 'he';
            break;

        case 'pl':
            return 'pl';
            break;

        case 'bn':
            return 'bn';
            break;

        default:
            return 'en';
            break;
    }
}

/**
 * @param $amount
 * @param $tax_rate
 * @return float|int
 */
function gstIndiaSplitTaxValue($amount, $tax_rate)
{
    $tax_rate = $tax_rate / 2;
    return ($amount * $tax_rate) / 100;
}

/**
 * @return array
 */
function getBalances($user)
{
    if (has_access($user->roleid, 'bank_n_cash', 'all_data')) {
        $all_data = true;
    } else {
        $all_data = false;
    }

    if (!$all_data) {
        $transactions = Transaction::where('aid', $user->id)->get();
    } else {
        $transactions = Transaction::all();
    }

    $total_equity = 0.0;
    $total_income = 0.0;
    $total_expense = 0.0;
    $total_in = [];
    $total_out = [];
    $total_equity_bank = [];

    $home_currency = homeCurrency();

    if (!$home_currency) {
        $home_currency = Currency::first();
    }

    $currencies = Currency::all()->keyBy('iso_code');

    if ($all_data) {
        $banks = Account::all();
    } else {
        $banks = Account::where('owner_id', $user->id)->get();
    }

    foreach ($banks as $bank) {
        $total_in[$bank->id] = 0.0;
        $total_out[$bank->id] = 0.0;
        $total_equity_bank[$bank->id] = 0.0;
    }

    foreach ($transactions as $transaction) {
        if ($transaction->status == 'Uncleared') {
            continue;
        }
        $amount = $transaction->amount;
        $currency_name = $transaction->currency_iso_code;

        if ($currency_name != $home_currency->iso_code) {
            if (isset($currencies[$currency_name]->rate)) {
                $rate = $currencies[$currency_name]->rate;
                $amount = $rate * $amount;
            }
        }

        if ($transaction->type == 'Expense') {
            $total_expense += $amount;
            if (isset($total_out[$transaction->account_id])) {
                $total_out[$transaction->account_id] += $amount;
            }
        } elseif ($transaction->type == 'Income') {
            $total_income += $amount;
            if (isset($total_in[$transaction->account_id])) {
                $total_in[$transaction->account_id] += $amount;
            }
        } elseif ($transaction->type == 'In') {
            if (isset($total_in[$transaction->account_id])) {
                $total_in[$transaction->account_id] += $amount;
            }
        } elseif ($transaction->type == 'Out') {
            if (isset($total_out[$transaction->account_id])) {
                $total_out[$transaction->account_id] += $amount;
            }
        } elseif ($transaction->type == 'Equity') {
            $total_equity += $amount;
            if (isset($total_equity_bank[$transaction->account_id])) {
                $total_equity_bank[$transaction->account_id] += $amount;
            }
        }
    }

    $balances = [];
    foreach ($banks as $bank) {
        $balances[$bank->id] =
            $total_equity_bank[$bank->id] +
            $total_in[$bank->id] -
            $total_out[$bank->id];
    }

    $net_worth = $total_equity + $total_income - $total_expense;

    return [
        'home_currency' => $home_currency,
        'total_equity' => $total_equity,
        'total_income' => $total_income,
        'total_expense' => $total_expense,
        'net_worth' => $net_worth,
        'currencies' => $currencies,
        'banks' => $banks,
        'balances' => $balances,
        'total_equity_bank' => $total_equity_bank,
        'total_in_bank' => $total_in,
        'total_out_bank' => $total_out,
    ];
}

/**
 * @param $number
 * @param $currency_iso_code
 * @return float|mixed
 */
function createFromCurrency($number, $currency_iso_code)
{
    $currency = Currency::getAllCurrencies();

    if (isset($currency[$currency_iso_code])) {
        $selected_currency = $currency[$currency_iso_code];
        $currency_symbol = $selected_currency['symbol'];
        $currency_decimal_point = $selected_currency['decimal_mark'];
        $number = str_replace($currency_symbol, '', $number);
        $number = str_replace(' ', '', $number);
        if ($currency_decimal_point == ',') {
            $number = str_replace('.', '', $number);
            $number = str_replace(',', '.', $number);
        } else {
            $number = str_replace(',', '', $number);
        }

        return (float) $number;
    }

    return $number;
}

/**
 * @param $template
 * @param array $vars
 * @return string
 * @throws SmartyException
 */
function getRenderOutput($template, $vars = [])
{
    global $ui;

    foreach ($vars as $key => $value) {
        $ui->assign($key, $value);
    }

    return $ui->fetch($template . '.tpl');
}

/**
 * @param $html_contents
 * @param string $file_name
 * @param bool $download
 */
function exportPdf($html_contents, $file_name = '', $download = false)
{
    $mpdf = new \Mpdf\Mpdf();
    $mpdf->WriteHTML($html_contents);

    $output_type = 'I';

    if ($download) {
        $output_type = 'D';
    }

    if ($file_name == '') {
        $file_name = date('Y-m-d') . '-' . time() . '.pdf';
    }

    $mpdf->Output($file_name, $output_type);
}

/**
 * @param $invoice
 * @return string
 */
function getInvoiceDueAmount($invoice)
{
    $i_credit = $invoice->credit;
    $i_due = '0.00';
    $i_total = $invoice->total;
    if ($invoice->credit != '0.00') {
        $i_due = $i_total - $i_credit;
    } else {
        $i_due = $invoice->total;
    }

    return $i_due;
}

/**
 * @param $invoice
 * @return string
 */
function getInvoiceNumber($invoice)
{
    if ($invoice->cn != '') {
        $s = $invoice->cn;
    } else {
        $s = $invoice->id;
    }

    return $invoice->invoicenum . ' ' . $s;
}

/**
 * @param $invoice
 * @return string
 */
function getInvoicePreviewUrl($invoice)
{
    if ($invoice) {
        return U .
            'client/iview/' .
            $invoice->id .
            '/token_' .
            $invoice->vtoken;
    }
    return U;
}

/**
 * @return array
 */
function getActiveCurrencies()
{
    $currencies = Currency::all();

    $all_currencies = Currency::getAllCurrencies();

    $ret = [];
    foreach ($currencies as $currency) {
        $iso_code = $currency->iso_code;
        if (isset($all_currencies[$iso_code])) {
            $ret[$iso_code] = $all_currencies[$iso_code];
        }
    }

    return $ret;
}

/**
 * @param $number
 * @param $currency_iso_code
 * @param bool $precision
 * @return string
 */
function numberFormatUsingCurrency(
    $number,
    $currency_iso_code,
    $precision = false
) {
    if ($currency_iso_code == 'USD') {
        return $number;
    }

    $currency = Currency::getAllCurrencies();

    if (isset($currency[$currency_iso_code])) {
        $selected_currency = $currency[$currency_iso_code];

        if ($precision === false) {
            $precision = $selected_currency['precision'];
        }

        $number = number_format(
            $number,
            $precision,
            $selected_currency['decimal_mark'],
            $selected_currency['thousands_separator']
        );
    }

    return $number;
}

/**
 * @param $table
 * @param $column
 * @param string $type
 * @param bool $is_null
 * @return bool
 */
function db_add_column($table, $column, $type = 'INT(10)', $is_null = true)
{
    $null_statements = '';

    if ($is_null) {
        $null_statements = 'NULL DEFAULT NULL';
    }

    if (!db_column_exist($table, $column)) {
        ORM::execute(
            "ALTER TABLE `$table` ADD `$column` $type $null_statements"
        );
        return true;
    }
    return false;
}

/**
 * @param $table
 * @param $column
 * @return bool
 */
function db_remove_column($table, $column)
{
    if (db_column_exist($table, $column)) {
        ORM::execute("ALTER TABLE `$table` DROP `$column`");
        return true;
    }
    return false;
}

/**
 * @param $table
 * @return bool
 */
function db_remove_table($table)
{
    if (db_table_exist($table)) {
        ORM::execute("DROP TABLE `$table`");
        return true;
    }
    return false;
}

/**
 * @param $data
 * @param $key
 * @param string $default
 * @return string
 */
function get_data($data, $key, $default = '')
{
    if (isset($data[$key]) && $data[$key] != '') {
        return $data[$key];
    } else {
        return $default;
    }
}

/**
 * @param $data
 * @param $key
 * @return bool
 */
function has_data($data, $key)
{
    if (isset($data[$key]) && $data[$key] != '') {
        return true;
    }

    return false;
}

function predict_next_serial($config, $type)
{
    switch ($type) {
        case 'customer':
            return $config['customer_code_prefix'] .
                str_pad(
                    $config['customer_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;

        case 'company':
            return $config['company_code_prefix'] .
                str_pad(
                    $config['company_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;

        case 'income':
            return $config['income_code_prefix'] .
                str_pad(
                    $config['income_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;

        case 'expense':
            return $config['expense_code_prefix'] .
                str_pad(
                    $config['expense_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;

        case 'invoice':
            return $config['invoice_code_prefix'] .
                str_pad(
                    $config['invoice_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;

        case 'purchase':
            return $config['purchase_code_prefix'] .
                str_pad(
                    $config['purchase_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;

        case 'quote':
            return $config['quotation_code_prefix'] .
                str_pad(
                    $config['quotation_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;

        case 'supplier':
            return $config['supplier_code_prefix'] .
                str_pad(
                    $config['supplier_code_current_number'],
                    $config['number_pad'],
                    '0',
                    STR_PAD_LEFT
                );

            break;
    }
}

function getOwners($user)
{
    if ($user->roleid == 0) {
        $owners = User::all();
    } else {
        $owners = [$user];
    }

    return $owners;
}

function getContactFormattedAddress($config, $contact, $html = true)
{
    if (isset($config['address_format'])) {
        $address_format = $config['address_format'];
    } else {
        $address_format = 'default';
    }

    $address = $contact->address;
    $city = $contact->city;
    $state = $contact->state;
    $zip = $contact->zip;
    $country = $contact->country;

    if ($html) {
        $new_line = ' <br>';
    } else {
        $new_line = PHP_EOL;
    }

    switch ($address_format) {
        case 'eu':
            $address_full =
                $address .
                $new_line .
                $zip .
                ' ' .
                $city .
                $new_line .
                $state .
                $new_line .
                $country;

            break;

        case 'default':
        default:
            $address_full =
                $address .
                $new_line .
                $city .
                $new_line .
                $state .
                ' ' .
                $zip .
                $new_line .
                $country;

            break;
    }

    return $address_full;
}

function translate_date_string($string, $language)
{
    $string_arr = explode(' ', $string);

    if (isset($string_arr[0]) && isset($language[$string_arr[0]])) {
        $string_arr[0] = $language[$string_arr[0]];
    }

    if (isset($string_arr[1]) && isset($language[$string_arr[1]])) {
        $string_arr[1] = $language[$string_arr[1]];
    }

    return implode(' ', $string_arr);
}

function sp_get_contact_image($contact)
{
    $full_name = $contact->account;

    if ($contact->img == '') {
        $full_name_e = explode(' ', $full_name);

        $fn_count = count($full_name_e);

        if ($fn_count == 0) {
            $first_name = '';
        } else {
            $first_name = $full_name_e[0];
        }

        if ($first_name == '') {
            $first_name_letter = 'N';
        } else {
            $first_name_letter = $first_name[0];
        }

        if (isset($full_name_e[1])) {
            $last_name = $full_name_e[1];
            if (isset($last_name[0])) {
                $last_name_letter = $last_name[0];
            } else {
                $last_name_letter = '';
            }
        } else {
            $last_name_letter = '';
        }

        $two_l = strtoupper(
            htmlentities($first_name_letter . $last_name_letter)
        );

        if ($two_l == '') {
            $two_l = 'NA';
        }

        $img = '<span class="clx-avatar">' . $two_l . '</span>';
    } else {
        $img =
            '<span class="rounded-circle profile-image-32 d-block " style="background-image:url(\'' .
            APP_URL .
            '/' .
            $contact->img .
            '\'); background-size: cover;"></span>';
    }

    return $img;
}

function create_alert_message($message, $type = 'info')
{
    return '<div class="alert alert-' .
        $type .
        ' alert-dismissible fade show" role="alert">
                                                    <div class="d-flex align-items-center">
                                                        <div class="alert-icon">
                                                            <i class="fal fa-info-circle"></i>
                                                        </div>
                                                        <div class="flex-1">
                                                            ' .
        $message .
        '
                                                        </div>
                                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                                                    </button>
                                                    </div>
                                                </div>';
}

function get_or_default($config, $option, $default = '')
{
    return $config[$option] ?? $default;
}

function sp_get_host_by_ip($ip)
{
    try {
        return gethostbyaddr($ip);
    } catch (\Exception $exception) {
        return '';
    }
}

function sp_verify_recaptcha($secret_key, $token)
{
    try {
        $url = 'https://www.google.com/recaptcha/api/siteverify';
        $data = [
            'secret' => $secret_key,
            'response' => $token,
            'remoteip' => $_SERVER['REMOTE_ADDR'],
        ];
        $options = [
            'http' => [
                'header' =>
                    "Content-type: application/x-www-form-urlencoded\r\n",
                'method' => 'POST',
                'content' => http_build_query($data),
            ],
        ];

        $context = stream_context_create($options);
        $result = file_get_contents($url, false, $context);
        return json_decode($result);
    } catch (Exception $e) {
        _log($e->getMessage());
        return false;
    }
}

function cloudonex_get_invoice_number($invoice)
{
    $invoice_number = '';

    if (!empty($invoice->invoicenum)) {
        $invoice_number .= $invoice->invoicenum;
    }

    if (!empty($invoice->cn)) {
        $invoice_number .= $invoice->cn;
    } else {
        $invoice_number .= $invoice->id;
    }

    return $invoice_number;
}

function cloudonex_get_invoice_status_with_badge($status)
{
    global $_L;
    if ($status === 'Paid') {
        return '<span class="badge badge-primary">' . $_L['Paid'] . '</span>';
    }

    if ($status === 'Unpaid') {
        return '<span class="badge badge-danger">' . $_L['Unpaid'] . '</span>';
    }

    if ($status === 'Cancelled') {
        return '<span class="badge badge-secondary">' .
            $_L['Cancelled'] .
            '</span>';
    }

    return '<span class="badge badge-primary">' . $status . '</span>';
}

function cloudonex_get_ticket_status_with_badge($status)
{
    global $_L;
    if ($status === 'Closed') {
        return '<span class="badge badge-secondary">' .
            $_L['Closed'] .
            '</span>';
    }

    if ($status === 'Open') {
        return '<span class="badge badge-danger">' . $_L['Open'] . '</span>';
    }

    if ($status === 'On Hold') {
        return '<span class="badge badge-success">' .
            $_L['On Hold'] .
            '</span>';
    }

    return '<span class="badge badge-primary">' . $status . '</span>';
}

function cloudonex_get_order_status_with_badge($status)
{
    global $_L;
    if ($status === 'Active') {
        return '<span class="badge badge-success">' . $_L['Active'] . '</span>';
    }

    if ($status === 'Pending') {
        return '<span class="badge badge-danger">' . $_L['Pending'] . '</span>';
    }

    return '<span class="badge badge-primary">' . $status . '</span>';
}

function redirect_to($to, $data = [])
{
    $to = U . $to;
    foreach ($data as $key => $value) {
        $_SESSION[$key] = $value;
    }
    header("location: $to");
    exit();
}

function get_available_terms()
{
    return [
        'one_time' => [
            'name' => 'One Time',
        ],
        'monthly' => [
            'name' => 'Monthly',
        ],
        'quarterly' => [
            'name' => 'Quarterly',
        ],
        'half_yearly' => [
            'name' => 'Half Yearly',
        ],
        'yearly' => [
            'name' => 'Yearly',
        ],
        'two_years' => [
            'name' => 'Two Years',
        ],
        'three_years' => [
            'name' => 'Three Years',
        ],
    ];
}

function get_available_item_pricing_terms($item)
{
    $terms = [];
    if ($item->one_time_fee && $item->one_time_fee > 0) {
        $terms['one_time'] = [
            'name' => 'One Time Fee',
            'price' => $item->one_time_fee,
        ];
    }

    if ($item->price_monthly && $item->price_monthly > 0) {
        $terms['monthly'] = [
            'name' => 'Monthly',
            'price' => $item->price_monthly,
        ];
    }

    if ($item->price_quarterly && $item->price_quarterly > 0) {
        $terms['quarterly'] = [
            'name' => 'Quarterly',
            'price' => $item->price_quarterly,
        ];
    }

    if ($item->price_half_yearly && $item->price_half_yearly > 0) {
        $terms['half_yearly'] = [
            'name' => 'Half Yearly',
            'price' => $item->price_half_yearly,
        ];
    }

    if ($item->price_yearly && $item->price_yearly > 0) {
        $terms['yearly'] = [
            'name' => 'Yearly',
            'price' => $item->price_yearly,
        ];
    }

    if ($item->price_two_years && $item->price_two_years > 0) {
        $terms['two_years'] = [
            'name' => 'Two Years',
            'price' => $item->price_two_years,
        ];
    }

    if ($item->price_three_years && $item->price_three_years > 0) {
        $terms['three_years'] = [
            'name' => 'Three Years',
            'price' => $item->price_three_years,
        ];
    }

    return $terms;
}

function get_pricing_term_first_price($item)
{
    $pricing = get_available_item_pricing_terms($item);
    $term = reset($pricing);
    if (!empty($term['price'])) {
        return $term['price'];
    }
    return 0;
}

function get_term_to_db_term($term)
{
    $terms = [
        'one_time' => 'one_time_fee',
        'monthly' => 'price_monthly',
        'quarterly' => 'price_quarterly',
        'half_yearly' => 'price_half_yearly',
        'yearly' => 'price_yearly',
        'two_years' => 'price_two_years',
        'three_years' => 'price_three_years',
    ];

    return $terms[$term] ?? false;
}

function csrf_token()
{
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function csrf_field()
{
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return '<input type="hidden" name="_token" value="' .
        $_SESSION['csrf_token'] .
        '">';
}

function verify_csrf_token()
{
    $token = _post('token');
    if (!empty($token)) {
        if (hash_equals($_SESSION['csrf_token'], $token)) {
            return;
        }
    }

    abort(401, 'CSRF token does not match.');
}

function response_with_error_message($validation_errors)
{
    $msg = '';
    foreach ($validation_errors->getMessages() as $key => $value) {
        foreach ($value as $error) {
            $msg .= $error . ' <br>';
        }
    }
    return $msg;
}

function sp_purify_data($data)
{
    $config = HTMLPurifier_Config::createDefault();
    $purifier = new HTMLPurifier($config);

    $purified_data = [];
    foreach ($data as $key => $value) {
        if (is_string($value)) {
            $purified_data[$key] = trim($purifier->purify($value));
        } else {
            $purified_data[$key] = $value;
        }
    }
    return $purified_data;
}

function __($string)
{
    global $_L;
    if (!empty($_L[$string])) {
        return $_L[$string];
    }
    return $string;
}

function get_config($param, $default = '')
{
    global $config;
    if (isset($config[$param])) {
        return $config[$param];
    }
    return $default;
}

function get_theme_file($file)
{
    global $config, $ui, $base_theme;
    $frontend_theme_file_path = $base_theme . '/client/' . $file;
    if (!empty($config['frontend_theme'])) {
        if (
            file_exists(
                'ui/theme/frontend/' .
                    $config['frontend_theme'] .
                    '/' .
                    $file .
                    '.tpl'
            )
        ) {
            $frontend_theme_file_path =
                '../frontend/' . $config['frontend_theme'] . '/' . $file;
        }
    }
    return $frontend_theme_file_path;
}

function view_share($data)
{
    global $ui;
    foreach ($data as $key => $value) {
        $ui->assign($key, $value);
    }
}

function request()
{
    return Request::createFromGlobals()->request;
}

function sp_if_exist_and_true($data, $key)
{
    if ((isset($data[$key]) || isset($data->$key)) && $data[$key]) {
        return true;
    }
    return false;
}

function sp_get_value($data, $key, $default = '')
{
    if ((isset($data[$key]) || isset($data->$key)) && $data[$key]) {
        return $data[$key];
    }
    return $default;
}
