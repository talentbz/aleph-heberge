<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

require_once 'apps/plesk/AppPlesk.php';

$app_twenty = new AppPlesk();

$app->on('hostbilling_server', [$app_twenty, 'hostBillingServer']);
$app->on('hostbilling_servers', [$app_twenty, 'hostBillingServers']);
$app->on('hostbilling_order', [$app_twenty, 'hostBillingOrder']);
$app->on('hostbilling_order_run_automation_create_account', [
    $app_twenty,
    'hostBillingOrderRunAutomationCreateAccount',
]);
