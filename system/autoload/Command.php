<?php
class Command extends \Illuminate\Console\Command
{
    protected $settings;
    protected $_L;
    public function __construct()
    {
        parent::__construct();
    }

    protected function appInit()
    {
        $db_config = [
            'driver' => 'mysql',
            'host' => DB_HOST,
            'database' => DB_NAME,
            'username' => DB_USER,
            'password' => DB_PASSWORD,
            'charset' => 'utf8',
            'collation' => 'utf8_unicode_ci',
            'prefix' => '',
        ];

        $db = new DB();
        $db->addConnection($db_config);
        $db->setAsGlobal();
        $db->bootEloquent();
        $settings = AppConfig::all();
        $settings_key_values = [];
        foreach ($settings as $setting) {
            $settings_key_values[$setting->setting] = $setting->value;
        }

        $this->settings = $settings_key_values;
        $language_file_path =
            'system/i18n/' . $this->settings['language'] . '.php';

        if (file_exists($language_file_path)) {
            $_L = require $language_file_path;
        } else {
            $_L = 'system/i18n/en.php';
        }

        $overrides_language_strings = [];

        if (file_exists('system/overrides/i18n.php')) {
            $overrides_language_strings = require 'system/overrides/i18n.php';
        }

        $this->_L = array_merge($_L, $overrides_language_strings);
        require 'system/helpers/common_functions.php';
    }
}
