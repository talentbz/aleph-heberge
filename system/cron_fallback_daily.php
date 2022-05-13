<?php
// If your hosting does not support per minutes cron, you can run this fallback cron and set this daily.
require './headless.php';
$cron_log = new CronLog();
$cron_log->date = date('Y-m-d');
$logs = date('D M Y h:i A') . PHP_EOL;
$logs .= '_______________________________________';
Invoice::generateRecurringInvoices($settings, $_L);
Invoice::sendPaymentReminder($settings, $_L);
$accounting_snapshot = Account::createSnapshot($settings, $_L, true);
$cron_log->logs = $logs . PHP_EOL . $cron_log->logs;
$cron_log->save();
api_response([
    'success' => true,
]);
