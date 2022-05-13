<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}
_auth();

$config['build'] = (int) $config['build'];
if ($file_build !== $config['build']) {
    if (empty($_SESSION['was_redirected'])) {
        redirect_to('updating/schema/');
    }
}

$ui->assign('_title', $_L['Dashboard'] . '- ' . $config['CompanyName']);
$user = User::_info();
$ui->assign('user', $user);
$ui->assign('selected_navigation', 'dashboard');
$recent_customers = Contact::orderBy('id', 'desc')
    ->limit(5)
    ->get();

$recent_invoices = Invoice::orderBy('id', 'desc')
    ->limit(5)
    ->get();

$recent_orders = HostingOrder::orderBy('id', 'desc')
    ->limit(5)
    ->get();

$recent_tickets = Ticket::orderBy('id', 'desc')
    ->limit(5)
    ->get();

$today = date('Y-m-d');
$seven_days_ago = date('Y-m-d', strtotime('-7 days'));

$orders_last_7_days = HostingOrder::whereBetween('date', [
    $seven_days_ago,
    $today,
])->get();

$orders_for_chart = [];

$total_last_7_days = 0;

foreach ($orders_last_7_days as $order) {
    if (isset($orders_for_chart[$order->date])) {
        $orders_for_chart[$order->date] += $order->total;
    } else {
        $orders_for_chart[$order->date] = $order->total;
    }

    $total_last_7_days += $order->total;
}

$total_customers = Contact::count();
$total_orders = HostingOrder::count();
$total_paid_invoice_amount = Invoice::where('status', 'Paid')->sum('total');

$total_active_order_amount = HostingOrder::where('status', 'Active')->sum(
    'total'
);

\view('hostbilling/admin/dashboard', [
    'recent_customers' => $recent_customers,
    'recent_invoices' => $recent_invoices,
    'recent_orders' => $recent_orders,
    'recent_tickets' => $recent_tickets,
    'orders_for_chart' => $orders_for_chart,
    'total_customers' => $total_customers,
    'total_orders' => $total_orders,
    'total_paid_invoice_amount' => $total_paid_invoice_amount,
    'total_active_order_amount' => $total_active_order_amount,
    'total_last_7_days' => $total_last_7_days,
]);
