<?php
class HostBilling
{
    public static function whois()
    {
    }

    public static function cPanelApiCall($server, $action, $params = [])
    {
        if (!$server->username || !$server->api_key || !$server->host) {
            return [
                'success' => false,
                'errors' => [
                    'api' =>
                        'Unable to init server, please verify username and api token',
                ],
            ];
        }

        $whm_host = $server->host;
        $whm_username = $server->username;
        $whm_token = $server->api_key;

        $data = $params;
        $data['api.version'] = 1;

        $http = new Http();

        try {
            $response = $http
                ->withHeaders([
                    'Authorization' => "whm $whm_username:$whm_token",
                ])
                ->withOptions([
                    'verify' => false,
                ])
                ->get(
                    'https://' . $whm_host . ':2087' . '/json-api/' . $action,
                    $data
                );

            return [
                'success' => true,
                'response' => $response->json(),
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'errors' => [
                    'api' => $e->getMessage(),
                ],
            ];
        }
    }

    public static function runMigrations()
    {
        global $file_build;

        $file_build = (int) $file_build;

        if ($file_build < 1010) {
            if (!DB::schema()->hasColumn('hosting_plans', 'api_name')) {
                DB::statement(
                    'ALTER TABLE `hosting_plans` ADD `api_name` VARCHAR(150) NULL DEFAULT NULL AFTER `type`, ADD `api_features` TEXT NULL DEFAULT NULL AFTER `welcome_email`, ADD `require_domain_name` tinyint(1) NOT NULL DEFAULT \'0\' AFTER `addons`, ADD `allow_multiple_quantities` tinyint(1) NOT NULL DEFAULT \'0\' AFTER `allow_free_domain`'
                );
                DB::statement(
                    'ALTER TABLE `hosting_orders` ADD `automation_run` TINYINT(1) NOT NULL DEFAULT \'0\' AFTER `addons`, ADD `automation_suspended` tinyint(1) NOT NULL DEFAULT \'0\' AFTER `automation_run`, ADD `automation_terminated` tinyint(1) NOT NULL DEFAULT \'0\' AFTER `automation_suspended`, ADD `nameservers` TEXT AFTER `activation_message`, ADD `automation_result` TEXT AFTER `automation_run`, ADD `ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `active`'
                );
            }
        }

        if ($file_build < 1020) {
            update_option('base_layout', 'hostbilling/layouts/base.tpl');
        }

        if (!DB::schema()->hasColumn('hosting_orders', 'server_id')) {
            DB::statement(
                'ALTER TABLE `hosting_orders` ADD `server_id` INT(10) UNSIGNED NOT NULL DEFAULT \'0\' AFTER `plan_id`'
            );
        }

        if (!DB::schema()->hasColumn('hosting_servers', 'port')) {
            DB::statement(
                'ALTER TABLE `hosting_servers` ADD `port` SMALLINT(5) NULL DEFAULT NULL AFTER `host`'
            );
        }

        if (!DB::schema()->hasColumn('hosting_orders', 'login_type')) {
            DB::statement(
                'ALTER TABLE `hosting_orders` ADD `login_type` VARCHAR(100) NULL DEFAULT NULL AFTER `ip`'
            );
        }
    }
}
