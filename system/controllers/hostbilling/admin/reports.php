<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('_title', $_L['Reports'] . '- ' . $config['CompanyName']);
$ui->assign('selected_navigation', 'reports');
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);
$mdate = date('Y-m-d');
$tdate = date('Y-m-d', strtotime('today - 30 days'));

$first_day_month = date('Y-m-01');
$this_week_start = date('Y-m-d', strtotime('previous sunday'));
$before_30_days = date('Y-m-d', strtotime('today - 30 days'));
$month_n = date('n');
$data = request()->all();
switch ($action) {
    case 'statement':
        if (has_access($user->roleid, 'bank_n_cash', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $d = ORM::for_table('sys_accounts');

        if (!$all_data) {
            $d->where('owner_id', $user->id);
        }

        $d = $d->find_many();

        $ui->assign('d', $d);

        $ui->assign('mdate', $mdate);
        $ui->assign('tdate', $tdate);

        view('statement');

        break;

    case 'statement-view':
        $fdate = _post('fdate');
        $tdate = _post('tdate');
        $account = _post('account');
        $stype = _post('stype');
        $d = ORM::for_table('sys_transactions');
        $d->where('account', $account);
        if ($stype == 'credit') {
            $d->where('dr', '0.00');
        } elseif ($stype == 'debit') {
            $d->where('cr', '0.00');
        } else {
        }
        $d->where_gte('date', $fdate);
        $d->where_lte('date', $tdate);
        $d->order_by_desc('id');
        $x = $d->find_many();

        $ui->assign('d', $x);
        $ui->assign('fdate', $fdate);
        $ui->assign('tdate', $tdate);
        $ui->assign('account', $account);
        $ui->assign('stype', $stype);

        view('statement-view');
        break;

    case 'by-date':
        if (has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $d = ORM::for_table('sys_transactions')
            ->where('date', $mdate)
            ->order_by_desc('id');

        if (!$all_data) {
            $d->where('aid', $user->id);
        }

        $d = $d->find_many();

        $dr = ORM::for_table('sys_transactions')->where('date', $mdate);

        if (!$all_data) {
            $dr->where('aid', $user->id);
        }

        $dr = $dr->sum('dr');

        if ($dr == '') {
            $dr = '0.00';
        }

        $cr = ORM::for_table('sys_transactions')->where('date', $mdate);

        if (!$all_data) {
            $cr->where('aid', $user->id);
        }

        $cr = $cr->sum('cr');

        if ($cr == '') {
            $cr = '0.00';
        }
        $ui->assign('d', $d);
        $ui->assign('dr', $dr);
        $ui->assign('cr', $cr);

        $ui->assign('mdate', $mdate);

        $mdf = Misc::get_moment_format($config['df']);
        $today = date('Y-m-d');

        view('reports-by-date');

        break;

    case 'income':
        if (has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $d = ORM::for_table('sys_transactions')
            ->where('type', 'Income')
            ->limit(20)
            ->order_by_desc('id');

        if (!$all_data) {
            $d->where('aid', $user->id);
        }

        $d = $d->find_many();

        $ui->assign('d', $d);

        $a = ORM::for_table('sys_transactions');

        if (!$all_data) {
            $a->where('aid', $user->id);
        }

        $a = $a->sum('cr');

        if ($a == '') {
            $a = '0.00';
        }
        $ui->assign('a', $a);

        $m = ORM::for_table('sys_transactions')
            ->where('type', 'Income')
            ->where_gte('date', $first_day_month)
            ->where_lte('date', $mdate);

        if (!$all_data) {
            $m->where('aid', $user->id);
        }

        $m = $m->sum('cr');

        if ($m == '') {
            $m = '0.00';
        }
        $ui->assign('m', $m);

        $w = ORM::for_table('sys_transactions')
            ->where_gte('date', $this_week_start)
            ->where_lte('date', $mdate);

        if (!$all_data) {
            $w->where('aid', $user->id);
        }

        $w = $w->sum('cr');

        if ($w == '') {
            $w = '0.00';
        }

        $ui->assign('w', $w);

        $m3 = ORM::for_table('sys_transactions')
            ->where_gte('date', $before_30_days)
            ->where_lte('date', $mdate);

        if (!$all_data) {
            $m3->where('aid', $user->id);
        }

        $m3 = $m3->sum('cr');

        if ($m3 == '') {
            $m3 = '0.00';
        }
        $ui->assign('m3', $m3);

        $ui->assign('mdate', $mdate);
        $array = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
        ];
        $till = $month_n - 1;
        $gstring = '';

        $m_data = [];

        $i = 0;

        for ($m = 0; $m <= $till; $m++) {
            $mnth = $array[$m];
            $cal = ORM::for_table('sys_transactions')
                ->where_gte(
                    'date',
                    date('Y-m-d', strtotime("first day of $mnth"))
                )
                ->where_lte(
                    'date',
                    date('Y-m-d', strtotime("last day of $mnth"))
                );

            if (!$all_data) {
                $cal->where('aid', $user->id);
            }

            $cal = $cal->sum('cr');
            $gstring .= '["' . ib_lan_get_line($mnth) . '",' . $cal . '], ';

            $m_data[$i]['month'] = ib_lan_get_line($mnth);
            $m_data[$i]['value'] = $cal;

            $i++;
        }
        $gstring = rtrim($gstring, ',');

        $currencies = Currency::all();

        $latest_income = Transaction::where('type', 'Income')
            ->orderBy('date', 'desc')
            ->take(20);

        if (!$all_data) {
            $latest_income->where('aid', $user->id);
        }

        $latest_income = $latest_income->get();

        $incomes = Transaction::where('type', 'Income');
        if (!$all_data) {
            $incomes->where('aid', $user->id);
        }
        $incomes = $incomes->get();

        $collection = collect($incomes);

        $cats = $collection->unique('category');

        $cat_data = [];

        $i = 0;

        foreach ($cats as $cat) {
            $cat_data[$i]['category'] = $cat->category;

            $val = Transaction::where('Type', 'Income')->where(
                'category',
                $cat->category
            );
            if (!$all_data) {
                $val->where('aid', $user->id);
            }
            $val = $val->sum('amount');
            $cat_data[$i]['value'] = $val;

            $i++;
        }

        $total_income_all_time = Transaction::totalAmount(
            'Income',
            '',
            'all',
            $all_data
        );

        view('reports_income', [
            'currencies' => $currencies,
            'd' => $latest_income,
            'm_data' => $m_data,
            'cat_data' => $cat_data,
            'total_income_all_time' => $total_income_all_time,
            'all_data' => $all_data,
        ]);

        break;

    case 'expense':
        if (has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $d = ORM::for_table('sys_transactions')
            ->where('type', 'Expense')
            ->limit(20)
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('d', $d);
        $a = ORM::for_table('sys_transactions')->sum('dr');
        if ($a == '') {
            $a = '0.00';
        }
        $ui->assign('a', $a);
        $m = ORM::for_table('sys_transactions')
            ->where('type', 'Expense')
            ->where_gte('date', $first_day_month)
            ->where_lte('date', $mdate)
            ->sum('dr');
        if ($m == '') {
            $m = '0.00';
        }
        $ui->assign('m', $m);

        $w = ORM::for_table('sys_transactions')
            ->where_gte('date', $this_week_start)
            ->where_lte('date', $mdate)
            ->sum('dr');
        if ($w == '') {
            $w = '0.00';
        }
        $ui->assign('w', $w);

        $m3 = ORM::for_table('sys_transactions')
            ->where_gte('date', $before_30_days)
            ->where_lte('date', $mdate)
            ->sum('dr');
        if ($m3 == '') {
            $m3 = '0.00';
        }
        $ui->assign('m3', $m3);

        $ui->assign('mdate', $mdate);
        $array = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
        ];
        $till = $month_n - 1;
        $gstring = '';

        $m_data = [];

        $i = 0;

        for ($m = 0; $m <= $till; $m++) {
            $mnth = $array[$m];
            $cal = ORM::for_table('sys_transactions')
                ->where_gte(
                    'date',
                    date('Y-m-d', strtotime("first day of $mnth"))
                )
                ->where_lte(
                    'date',
                    date('Y-m-d', strtotime("last day of $mnth"))
                );

            if (!$all_data) {
                $cal->where('aid', $user->id);
            }

            $cal = $cal->sum('dr');

            $gstring .= '["' . ib_lan_get_line($mnth) . '",' . $cal . '], ';

            $m_data[$i]['month'] = ib_lan_get_line($mnth);
            $m_data[$i]['value'] = $cal;

            $i++;
        }
        $gstring = rtrim($gstring, ',');

        $currencies = Currency::all();

        $latest_expense = Transaction::where('type', 'Expense')
            ->orderBy('date', 'desc')
            ->take(20);

        if (!$all_data) {
            $latest_expense->where('aid', $user->id);
        }

        $latest_expense = $latest_expense->get();

        $incomes = Transaction::where('type', 'Expense');

        if (!$all_data) {
            $incomes->where('aid', $user->id);
        }

        $incomes = $incomes->get();

        $collection = collect($incomes);

        $cats = $collection->unique('category');

        $cat_data = [];

        $i = 0;

        foreach ($cats as $cat) {
            $cat_data[$i]['category'] = $cat->category;

            $val = Transaction::where('Type', 'Expense')->where(
                'category',
                $cat->category
            );

            if (!$all_data) {
                $val->where('aid', $user->id);
            }

            $val = $val->sum('amount');

            $cat_data[$i]['value'] = $val;

            $i++;
        }

        $total_expense_all_time = Transaction::totalAmount(
            'Expense',
            '',
            'all',
            $all_data
        );

        view('reports_expense', [
            'currencies' => $currencies,
            'd' => $latest_expense,
            'm_data' => $m_data,
            'cat_data' => $cat_data,
            'total_expense_all_time' => $total_expense_all_time,
            'all_data' => $all_data,
        ]);

        break;

    case 'income-vs-expense':
        if (has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $ai = ORM::for_table('sys_transactions');

        if (!$all_data) {
            $ai->where('aid', $user->id);
        }

        $ai = $ai->sum('cr');

        if ($ai == '') {
            $ai = '0.00';
        }
        $ui->assign('ai', $ai);

        $mi = ORM::for_table('sys_transactions')
            ->where_gte('date', $first_day_month)
            ->where_lte('date', $mdate);

        if (!$all_data) {
            $mi->where('aid', $user->id);
        }

        $mi = $mi->sum('cr');

        if ($mi == '') {
            $mi = '0.00';
        }
        $ui->assign('mi', $mi);

        $wi = ORM::for_table('sys_transactions')
            ->where_gte('date', $this_week_start)
            ->where_lte('date', $mdate);

        if (!$all_data) {
            $wi->where('aid', $user->id);
        }

        $wi = $wi->sum('cr');

        if ($wi == '') {
            $wi = '0.00';
        }
        $ui->assign('wi', $wi);

        $m3i = ORM::for_table('sys_transactions')
            ->where_gte('date', $before_30_days)
            ->where_lte('date', $mdate);

        if (!$all_data) {
            $m3i->where('aid', $user->id);
        }

        $m3i = $m3i->sum('cr');

        if ($m3i == '') {
            $m3i = '0.00';
        }

        $ui->assign('m3i', $m3i);

        $ae = ORM::for_table('sys_transactions');

        if (!$all_data) {
            $ae->where('aid', $user->id);
        }

        $ae = $ae->sum('dr');

        if ($ae == '') {
            $ae = '0.00';
        }
        $ui->assign('ae', $ae);

        $me = ORM::for_table('sys_transactions')
            ->where_gte('date', $first_day_month)
            ->where_lte('date', $mdate);

        if (!$all_data) {
            $me->where('aid', $user->id);
        }

        $me = $me->sum('dr');

        if ($me == '') {
            $me = '0.00';
        }
        $ui->assign('me', $me);

        $ui->assign('mdate', $mdate);
        $aime = $ai - $ae;
        $ui->assign('aime', $aime);
        $mime = $mi - $me;
        $ui->assign('mime', $mime);
        $array = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
        ];
        $till = $month_n - 1;
        $gstring = '';
        $egstring = '';
        for ($m = 0; $m <= $till; $m++) {
            $mnth = $array[$m];
            $cal = ORM::for_table('sys_transactions')
                ->where_gte(
                    'date',
                    date('Y-m-d', strtotime("first day of $mnth"))
                )
                ->where_lte(
                    'date',
                    date('Y-m-d', strtotime("last day of $mnth"))
                );

            if (!$all_data) {
                $cal->where('aid', $user->id);
            }

            $cal = $cal->sum('dr');

            if ($cal == '') {
                $cal = '0';
            }
            $egstring .= '["' . $m . '",' . $cal . '], ';
            $cal = ORM::for_table('sys_transactions')
                ->where_gte(
                    'date',
                    date('Y-m-d', strtotime("first day of $mnth"))
                )
                ->where_lte(
                    'date',
                    date('Y-m-d', strtotime("last day of $mnth"))
                );

            if (!$all_data) {
                $cal->where('aid', $user->id);
            }

            $cal = $cal->sum('cr');

            if ($cal == '') {
                $cal = '0';
            }
            $gstring .= '["' . $m . '",' . $cal . '], ';
        }
        $gstring = rtrim($gstring, ',');

        view('reports-income-vs-expense');

        break;

    case 'categories':
        $d = ORM::for_table('sys_cats')->find_many();
        $ui->assign('d', $d);

        $ui->assign('mdate', $mdate);
        $ui->assign('tdate', $tdate);

        view('reports-categories');

        break;

    case 'category-view':
        $fdate = _post('fdate');
        $tdate = _post('tdate');
        $cat = _post('cat');

        $d = ORM::for_table('sys_transactions');
        $d->where('category', $cat);

        $d->where_gte('date', $fdate);
        $d->where_lte('date', $tdate);
        $d->order_by_desc('id');
        $x = $d->find_many();

        $ui->assign('d', $x);
        $ui->assign('fdate', $fdate);
        $ui->assign('tdate', $tdate);

        view('report-common');
        break;

    case 'payees':
        $d = ORM::for_table('sys_payee')->find_many();
        $ui->assign('d', $d);

        $ui->assign('mdate', $mdate);
        $ui->assign('tdate', $tdate);

        view('reports-payees');

        break;

    case 'payees-view':
        $fdate = _post('fdate');
        $tdate = _post('tdate');
        $payee = _post('payee');

        $d = ORM::for_table('sys_transactions');
        $d->where('payee', $payee);

        $d->where_gte('date', $fdate);
        $d->where_lte('date', $tdate);
        $d->order_by_desc('id');
        $x = $d->find_many();

        $ui->assign('d', $x);
        $ui->assign('fdate', $fdate);
        $ui->assign('tdate', $tdate);

        view('report-common');
        break;

    case 'payers':
        $d = ORM::for_table('sys_payers')->find_many();
        $ui->assign('d', $d);

        $ui->assign('mdate', $mdate);
        $ui->assign('tdate', $tdate);

        view('reports-payers');

        break;

    case 'payer-view':
        $fdate = _post('fdate');
        $tdate = _post('tdate');
        $payer = _post('payer');

        $d = ORM::for_table('sys_transactions');
        $d->where('payer', $payer);

        $d->where_gte('date', $fdate);
        $d->where_lte('date', $tdate);
        $d->order_by_desc('id');
        $x = $d->find_many();

        $ui->assign('d', $x);
        $ui->assign('fdate', $fdate);
        $ui->assign('tdate', $tdate);

        view('report-common');
        break;

    case 'cats':

    case 'sales':
        if (has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        if ($all_data) {
            $invoice_items = ORM::for_table('sys_invoiceitems')->find_array();
        } else {
            $invoice_ids = Invoice::where('aid', $user->id)
                ->select('id')
                ->get()
                ->pluck('id')
                ->toArray();
            $invoice_items = InvoiceItem::whereIn('id', $invoice_ids)->get();
        }

        $ui->assign('invoice_items', $invoice_items);

        $mdate = date('Y-m-d');
        $ui->assign('mdate', $mdate);

        view('reports_sales');

        break;

    case 'sales_invoice_calendar':
        if (has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        header('Content-Type: application/json');

        $start = _get('start') . ' 00:00:00';
        $end = _get('end') . ' 23:59:00';

        $calendar_data = ORM::for_table('sys_invoices')
            ->where_gte('duedate', $start)
            ->where_lte('duedate', $end)
            ->select('id')
            ->select('account')
            ->select('duedate')
            ->select('invoicenum')
            ->select('cn')
            ->select('total')
            ->select('id', 'eventid')
            ->select('status');

        if (!$all_data) {
            $calendar_data->where('aid', $user->id);
        }

        $calendar_data = $calendar_data->find_array();

        $events = [];

        $i = 0;
        foreach ($calendar_data as $event) {
            if ($event['cn'] == '') {
                $inv_n = $event['id'];
            } else {
                $inv_n = $event['cn'];
            }
            $events[$i]['eventid'] = $event['id'];
            $events[$i]['title'] =
                '#' .
                $event['invoicenum'] .
                $inv_n .
                ' [ Amount: ' .
                $event['total'] .
                ' ]';
            $events[$i]['start'] = $event['duedate'];

            $i++;
        }

        echo json_encode($events);

        break;

    case 'invoices':
        if (has_access($user->roleid, 'sales', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $cid = route(2);
        if ($cid == '' || $cid == '0') {
            $ui->assign('p_cid', '');
        } else {
            $ui->assign('p_cid', $cid);
        }

        $logo_mime = 'image/png';

        $c = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('c', $c);

        $a = ORM::for_table('sys_accounts')->find_array();
        $ui->assign('a', $a);

        view('reports_invoices', []);

        break;

    case 'invoices_summary':
        if (has_access($user->roleid, 'sales', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $paginator = [];

        $mode_css = '';
        $mode_js = '';
        $view_type = 'default';

        $view_type = 'filter';

        $f = ORM::for_table('sys_invoices');

        if (route(3) != '') {
            $s_f = route(3);

            if ($s_f == 'paid') {
                $f->where('status', 'Paid');
            } elseif ($s_f == 'unpaid') {
                $f->where('status', 'Unpaid');
            } elseif ($s_f == 'partially_paid') {
                $f->where('status', 'Partially Paid');
            } elseif ($s_f == 'cancelled') {
                $f->where('status', 'Cancelled');
            } else {
            }
        }

        if (!$all_data) {
            $f->where('aid', $user->id);
        }

        $d = $f
            ->order_by_desc('id')
            ->limit(50)
            ->find_many();

        $paginator['contents'] = '';

        $ui->assign('view_type', $view_type);

        $ui->assign('d', $d);
        $ui->assign('paginator', $paginator);

        $last_12_months = lastTwelveMonths();

        $m = [];

        foreach ($last_12_months as $month) {
            //  echo date('Y-m-d', strtotime($month)).' ';

            $first_day = date('Y-m-d', strtotime($month));
            $last_day = date('Y-m-t', strtotime($month));

            $m['display'][] = $month;
            $t = Invoice::where('status', 'Paid')->whereBetween('datepaid', [
                $first_day,
                $last_day,
            ]);

            if (!$all_data) {
                $t = $t->where('aid', $user->id);
            }

            $m['data'][] = $t->sum('total');
        }

        if ($all_data) {
            $total_invoice = Invoice::count();
        } else {
            $total_invoice = Invoice::where('aid', $user->id)->count();
        }

        $total_invoice_items = InvoiceItem::sum('qty');

        if ($all_data) {
            $total_invoice_amount = Invoice::sum('total');
        } else {
            $total_invoice_amount = Invoice::where('aid', $user->id)->sum(
                'total'
            );
        }

        $total_invoice_amount = ib_money_format($total_invoice_amount, $config);

        view('reports_invoices_summary', [
            'm' => $m,
            'total_invoice_items' => $total_invoice_items,
            'total_invoice_amount' => $total_invoice_amount,
            'total_invoice' => $total_invoice,
            'all_data' => $all_data,
        ]);

        break;

    case 'invoices_expense':
        if (has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $last_12_months = lastTwelveMonths();

        $m = [];

        foreach ($last_12_months as $month) {
            $first_day = date('Y-m-d', strtotime($month));
            $last_day = date('Y-m-t', strtotime($month));

            $m['display'][] = $month;

            $invoice_total = Invoice::whereBetween('date', [
                $first_day,
                $last_day,
            ]);

            if ($all_data) {
                $invoice_total = $invoice_total->where('aid', $user->id);
            }

            $m['invoice_total'][] = $invoice_total->sum('total');

            $invoice_paid = Invoice::where(
                'status',
                'Paid'
            )->whereBetween('datepaid', [$first_day, $last_day]);

            if (!$all_data) {
                $invoice_paid->where('aid', $user->id);
            }

            $m['invoice_paid'][] = $invoice_paid->sum('total');

            $expense_total = Transaction::where(
                'type',
                'Expense'
            )->whereBetween('date', [$first_day, $last_day]);

            if (!$all_data) {
                $expense_total->where('aid', $user->id);
            }

            $m['expense_total'][] = $expense_total->sum('amount');

            $expense_type_1 = Transaction::where('type', 'Expense')
                ->where('sub_type', $config['expense_type_1'])
                ->whereBetween('date', [$first_day, $last_day]);

            if (!$all_data) {
                $expense_type_1 = $expense_type_1->where('aid', $user->id);
            }

            $m['expense_type_1'][] = $expense_type_1->sum('amount');

            $expense_type_2 = Transaction::where('type', 'Expense')
                ->where('sub_type', $config['expense_type_2'])
                ->whereBetween('date', [$first_day, $last_day]);

            if (!$all_data) {
                $expense_type_2 = $expense_type_2->where('aid', $user->id);
            }

            $m['expense_type_2'][] = $expense_type_2->sum('amount');
        }

        view('reports_invoices_expense', [
            'm' => $m,
        ]);

        break;

    case 'json_invoices':
        $columns = [];
        $columns[] = 'id';
        $columns[] = 'account';
        $columns[] = 'total';
        $columns[] = 'credit';
        $columns[] = 'due';
        $columns[] = 'date';
        $columns[] = 'manage';
        $order_by = $data['order'];
        $o_c_id = $order_by[0]['column'];
        $o_type = $order_by[0]['dir'];
        $a_order_by = $columns[$o_c_id];

        $d = ORM::for_table('sys_invoices');

        $cid = _post('cid');
        if ($cid != '') {
            $d->where('userid', $cid);
        }

        $reportrange = _post('reportrange');
        if ($reportrange != '') {
            $reportrange = explode('-', $reportrange);
            $from_date = trim($reportrange[0]);
            $to_date = trim($reportrange[1]);
            $d->where_gte('date', $from_date);
            $d->where_lte('date', $to_date);
        }

        if (!has_access($user->roleid, 'sales', 'all_data')) {
            $d->where('aid', $user->id);
        }

        $x = $d->find_array();
        $iTotalRecords = $d->count();

        $iDisplayLength = intval($_REQUEST['length']);
        $iDisplayLength =
            $iDisplayLength < 0 ? $iTotalRecords : $iDisplayLength;
        $iDisplayStart = intval($_REQUEST['start']);
        $sEcho = intval($_REQUEST['draw']);
        $records = [];
        $records["data"] = [];
        $end = $iDisplayStart + $iDisplayLength;
        $end = $end > $iTotalRecords ? $iTotalRecords : $end;
        if ($o_type == 'desc') {
            $d->order_by_desc($a_order_by);
        } else {
            $d->order_by_asc($a_order_by);
        }

        $d->limit($end);
        $d->offset($iDisplayStart);
        $x = $d->find_array();
        $i = $iDisplayStart;
        foreach ($x as $xs) {
            $invoice_id = $xs['invoicenum'] . ($xs['cn'] ?? $xs['id']);
            $due = $xs['total'] - $xs['credit'];
            $records["data"][] = [
                '<a href="' .
                U .
                'invoices/view/' .
                $xs['id'] .
                '">' .
                $invoice_id .
                '</a>',
                htmlentities($xs['account']),
                $xs['total'],
                $xs['credit'],
                $due,
                $xs['date'],
                '<a href="' .
                U .
                'invoices/view/' .
                $xs['id'] .
                '" class="btn btn-primary btn-xs"><i class="fal fa-file-alt"></i></a>',
            ];
        }

        $records["draw"] = $sEcho;
        $records["recordsTotal"] = $iTotalRecords;
        $records["recordsFiltered"] = $iTotalRecords;
        api_response($records);

        break;

    case 'purchases':
        if (has_access($user->roleid, 'sales', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $cid = route(2);
        if ($cid == '' || $cid == '0') {
            $ui->assign('p_cid', '');
        } else {
            $ui->assign('p_cid', $cid);
        }

        $c = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('c', $c);

        $a = ORM::for_table('sys_accounts')->find_array();
        $ui->assign('a', $a);

        view('reports_purchases');

        break;

    case 'json_purchases':
        $columns = [];
        $columns[] = 'id';
        $columns[] = 'account';
        $columns[] = 'total';
        $columns[] = 'credit';
        $columns[] = 'due';
        $columns[] = 'date';
        $columns[] = 'manage';
        $order_by = $data['order'];
        $o_c_id = $order_by[0]['column'];
        $o_type = $order_by[0]['dir'];
        $a_order_by = $columns[$o_c_id];

        $d = ORM::for_table('sys_purchases');

        $cid = _post('cid');
        if ($cid != '') {
            $d->where('userid', $cid);
        }

        $reportrange = _post('reportrange');
        if ($reportrange != '') {
            $reportrange = explode('-', $reportrange);
            $from_date = trim($reportrange[0]);
            $to_date = trim($reportrange[1]);
            $d->where_gte('date', $from_date);
            $d->where_lte('date', $to_date);
        }

        if (!has_access($user->roleid, 'sales', 'all_data')) {
            $d->where('aid', $user->id);
        }

        $x = $d->find_array();
        $iTotalRecords = $d->count();

        $iDisplayLength = intval($_REQUEST['length']);
        $iDisplayLength =
            $iDisplayLength < 0 ? $iTotalRecords : $iDisplayLength;
        $iDisplayStart = intval($_REQUEST['start']);
        $sEcho = intval($_REQUEST['draw']);
        $records = [];
        $records["data"] = [];
        $end = $iDisplayStart + $iDisplayLength;
        $end = $end > $iTotalRecords ? $iTotalRecords : $end;
        if ($o_type == 'desc') {
            $d->order_by_desc($a_order_by);
        } else {
            $d->order_by_asc($a_order_by);
        }

        $d->limit($end);
        $d->offset($iDisplayStart);
        $x = $d->find_array();
        $i = $iDisplayStart;
        foreach ($x as $xs) {
            $due = $xs['total'] - $xs['credit'];
            $records["data"][] = [
                '<a href="' .
                U .
                'purchases/view/' .
                $xs['id'] .
                '">' .
                $xs['id'] .
                '</a>',
                htmlentities($xs['account']),
                $xs['total'],
                $xs['credit'],
                $due,
                $xs['date'],
                '<a href="' .
                U .
                'purchases/view/' .
                $xs['id'] .
                '" class="btn btn-primary btn-xs"><i class="fal fa-file-alt"></i></a>',
            ];
        }

        $records["draw"] = $sEcho;
        $records["recordsTotal"] = $iTotalRecords;
        $records["recordsFiltered"] = $iTotalRecords;
        api_response($records);

        break;

    case 'purchases_summary':
        if (has_access($user->roleid, 'sales', 'all_data')) {
            $all_data = true;
        } else {
            $all_data = false;
        }

        $paginator = [];

        $view_type = 'default';

        $f = ORM::for_table('sys_purchases');

        if (route(3) != '') {
            $s_f = route(3);

            if ($s_f == 'paid') {
                $f->where('status', 'Paid');
            } elseif ($s_f == 'unpaid') {
                $f->where('status', 'Unpaid');
            } elseif ($s_f == 'partially_paid') {
                $f->where('status', 'Partially Paid');
            } elseif ($s_f == 'cancelled') {
                $f->where('status', 'Cancelled');
            } else {
            }
        }

        if (!$all_data) {
            $f->where('aid', $user->id);
        }

        $d = $f
            ->order_by_desc('id')
            ->limit(50)
            ->find_many();

        $paginator['contents'] = '';

        $ui->assign('view_type', $view_type);

        $ui->assign('d', $d);
        $ui->assign('paginator', $paginator);

        $last_12_months = lastTwelveMonths();

        $m = [];

        foreach ($last_12_months as $month) {
            $first_day = date('Y-m-d', strtotime($month));
            $last_day = date('Y-m-t', strtotime($month));

            $m['display'][] = $month;
            $t = Invoice::where('status', 'Paid')->whereBetween('datepaid', [
                $first_day,
                $last_day,
            ]);

            if (!$all_data) {
                $t = $t->where('aid', $user->id);
            }

            $m['data'][] = $t->sum('total');
        }

        if ($all_data) {
            $total_invoice = Invoice::count();
        } else {
            $total_invoice = Invoice::where('aid', $user->id)->count();
        }

        $total_invoice_items = InvoiceItem::sum('qty');

        if ($all_data) {
            $total_invoice_amount = Invoice::sum('total');
        } else {
            $total_invoice_amount = Invoice::where('aid', $user->id)->sum(
                'total'
            );
        }

        $total_invoice_amount = ib_money_format($total_invoice_amount, $config);

        view('reports_purchases_summary', [
            'm' => $m,
            'total_invoice_items' => $total_invoice_items,
            'total_invoice_amount' => $total_invoice_amount,
            'total_invoice' => $total_invoice,
            'all_data' => $all_data,
        ]);

        break;

    case 'export':
        $total_customers = Contact::count();
        $total_transactions = Transaction::count();
        $total_invoices = Invoice::count();
        $total_products = Item::count();

        view('reports_export', [
            'total_customers' => $total_customers,
            'total_transactions' => $total_transactions,
            'total_invoices' => $total_invoices,
            'total_products' => $total_products,
        ]);

        break;

    case 'export-customers':
        $data = [];

        $contacts = Contact::all();

        foreach ($contacts as $contact) {
            $data[] = [
                $contact->account,
                $contact->email,
                $contact->phone,
                $contact->company,
                $contact->address,
                $contact->city,
                $contact->state,
                $contact->zip,
                $contact->country,
                $contact->balance,
            ];
        }

        exportExcel(
            'customers.xlsx',
            [
                $_L['Name'],
                $_L['Email'],
                $_L['Phone'],
                $_L['Company'],
                $_L['Address'],
                $_L['City'],
                $_L['State Region'],
                $_L['ZIP Postal Code'],
                $_L['Country'],
                $_L['Balance'],
            ],
            $data
        );

        break;

    case 'export-transactions':
        $data = [];
        $transactions = Transaction::all();
        foreach ($transactions as $transaction) {
            $data[] = [
                $transaction->date,
                $transaction->account,
                $transaction->type,
                $transaction->category,
                $transaction->amount,
                $transaction->method,
                $transaction->ref,
                $transaction->description,
            ];
        }

        exportExcel(
            'transactions.xlsx',
            [
                $_L['Date'],
                $_L['Account'],
                $_L['Type'],
                $_L['Category'],
                $_L['Amount'],
                $_L['Method'],
                $_L['Ref'],
                $_L['Description'],
            ],
            $data
        );

        break;

    case 'export-invoices':
        $data = [];

        $invoices = Invoice::all();

        foreach ($invoices as $invoice) {
            $data[] = [
                $invoice->id,
                $invoice->date,
                $invoice->account,
                $invoice->subtotal,
                $invoice->total,
                $invoice->credit,
                $invoice->status,
            ];
        }

        exportExcel(
            'invoices.xlsx',
            [
                $_L['Invoice'],
                $_L['Date'],
                $_L['Customer'],
                'Sub Total',
                $_L['Total'],
                $_L['Credit'],
                $_L['Status'],
            ],
            $data
        );

        break;

    case 'export-pdf-invoices':
        exportPdf('dd');

        break;

    case 'tax':
        view('reports_tax', []);

        break;

    default:
        echo 'action not defined';
}
