<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('selected_navigation', 'purchase');
$ui->assign('_title', $_L['Purchase'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);
Event::trigger('invoices');
$data = request()->all();
switch ($action) {
    case 'add':
    case 'edit':
        $purchase = false;
        $purchase_items = [];

        if ($action === 'edit') {
            if (!has_access($user->roleid, 'sales', 'edit')) {
                permissionDenied();
            }
            $id = route(2, 0);

            $purchase = Purchase::find($id);

            $purchase_items = PurchaseItem::where('invoiceid', $purchase->id)
                ->orderBy('id', 'asc')
                ->get();
        }

        $extra_fields = '';
        $extra_jq = '';
        Event::trigger('add_invoice');
        $ui->assign('extra_fields', $extra_fields);
        if (isset($routes['2']) and $routes['2'] == 'recurring') {
            $recurring = true;
        } else {
            $recurring = false;
        }

        $currencies = Currency::all();
        $ui->assign('recurring', $recurring);
        $ui->assign('currencies', $currencies);
        if (isset($routes['3']) && $routes['3'] != '' && $routes['3'] != '0') {
            $p_cid = $routes['3'];
            $p_d = ORM::for_table('crm_accounts')->find_one($p_cid);
            if ($p_d) {
                $ui->assign('p_cid', $p_cid);
            }
        } else {
            $ui->assign('p_cid', '');
        }

        $c = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->where_like('type', '%Supplier%')
            ->find_many();
        $ui->assign('c', $c);
        $t = ORM::for_table('sys_tax')->find_many();
        $ui->assign('t', $t);
        $ui->assign('idate', date('Y-m-d'));

        $pos = route(4);

        Event::trigger('add_invoice_rendering_form');

        $tax_default = ORM::for_table('sys_tax')
            ->where('is_default', 1)
            ->find_one();

        \view('purchase', [
            'pos' => 'pos',
            'tax_default' => $tax_default,
            'purchase' => $purchase,
            'purchase_items' => $purchase_items,
        ]);

        break;

    case 'edit':
        if (!has_access($user->roleid, 'sales', 'edit')) {
            permissionDenied();
        }

        $pos = 'pos';

        $id = $routes['2'];
        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            $currencies = Currency::all();
            $ui->assign('currencies', $currencies);
            $ui->assign('i', $d);
            $items = ORM::for_table('sys_purchaseitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('items', $items);

            // find the user

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $ui->assign('a', $a);
            $ui->assign('d', $d);
            $c = ORM::for_table('crm_accounts')
                ->select('id')
                ->select('account')
                ->select('company')
                ->select('email')
                ->order_by_desc('id')
                ->where_like('type', '%Supplier%')
                ->find_many();
            $ui->assign('c', $c);
            $t = ORM::for_table('sys_tax')->find_many();
            $ui->assign('t', $t);

            // default idate ddate

            $ui->assign('idate', date('Y-m-d'));
            if ($config['i_driver'] == 'default') {
                $js_file = 'edit-invoice-v2';
                $tpl_file = 'edit-invoice';
            } elseif ($config['i_driver'] == 'v2') {
                $js_file = 'edit_invoice_v2n';
                $tpl_file = 'edit_invoice_v2';
            } else {
                $js_file = 'edit-invoice-v2';
                $tpl_file = 'edit-invoice';
            }

            $tax_default = ORM::for_table('sys_tax')
                ->where('is_default', 1)
                ->find_one();

            view('purchases_edit', [
                'pos' => $pos,
                'tax_default' => $tax_default,
            ]);
        } else {
            echo 'Invoice Not Found';
        }

        break;

    case 'edit-post':
        $data = request()->all();

        $cid = _post('cid');
        $iid = _post('iid');

        $show_quantity_as = _post('show_quantity_as');

        // find user with cid

        $u = ORM::for_table('crm_accounts')->find_one($cid);
        $msg = '';
        if ($cid == '') {
            $msg .= $_L['select_a_contact'] . ' <br /> ';
        }

        $notes = _post('notes');
        if (isset($data['amount'])) {
            $amount = $data['amount'];
        } else {
            $msg .= $_L['at_least_one_item_required'] . ' <br /> ';
        }

        // find currency

        $currency_id = _post('currency');
        $currency_find = Currency::where('iso_code', $currency_id)->first();
        if ($currency_find) {
            $currency = $currency_find->id;
            $currency_symbol = $currency_find->symbol;
            $currency_rate = $currency_find->rate;
        } else {
            $currency = 0;
            $currency_symbol = $config['currency_code'];
            $currency_rate = 1.0;
        }

        $idate = _post('idate');
        $its = strtotime($idate);
        $duedate = _post('ddate');
        $repeat = _post('repeat');
        $nd = $idate;
        if ($repeat == '0') {
            $r = '0';
        } elseif ($repeat == 'week1') {
            $r = '+1 week';
            $nd = date('Y-m-d', strtotime('+1 week', $its));
        } elseif ($repeat == 'weeks2') {
            $r = '+2 weeks';
            $nd = date('Y-m-d', strtotime('+2 weeks', $its));
        } elseif ($repeat == 'month1') {
            $r = '+1 month';
            $nd = date('Y-m-d', strtotime('+1 month', $its));
        } elseif ($repeat == 'months2') {
            $r = '+2 months';
            $nd = date('Y-m-d', strtotime('+2 months', $its));
        } elseif ($repeat == 'months3') {
            $r = '+3 months';
            $nd = date('Y-m-d', strtotime('+3 months', $its));
        } elseif ($repeat == 'months6') {
            $r = '+6 months';
            $nd = date('Y-m-d', strtotime('+6 months', $its));
        } elseif ($repeat == 'year1') {
            $r = '+1 year';
            $nd = date('Y-m-d', strtotime('+1 year', $its));
        } elseif ($repeat == 'years2') {
            $r = '+2 years';
            $nd = date('Y-m-d', strtotime('+2 years', $its));
        } elseif ($repeat == 'years3') {
            $r = '+3 years';
            $nd = date('Y-m-d', strtotime('+3 years', $its));
        } else {
            $msg .= 'Date Parsing Error <br /> ';
        }

        if ($msg == '') {
            $qty = $data['qty'];
            $item_number = $data['item_code'];
            if (isset($data['taxed'])) {
                $taxed = $data['taxed'];
            } else {
                $taxed = false;
            }

            $sTotal = '0';
            $taxTotal = '0';
            $i = '0';
            $a = [];
            $taxval = '0.00';
            $taxname = '';
            $taxrate = '0.00';

            $taxed_amount = 0.0;
            $lamount = 0.0;

            $taxval = '0.00';
            $taxname = '';

            foreach ($amount as $samount) {
                $samount = Finance::amount_fix($samount);
                $a[$i] = $samount;
                $sqty = $qty[$i];
                $sqty = Finance::amount_fix($sqty);
                $sTotal += $samount * $sqty;
                $lamount = $samount * $sqty;

                $lTaxRate = $taxed[$i];
                $lTaxRate = Finance::amount_fix($lTaxRate);

                $lTaxVal = ($lamount * $lTaxRate) / 100;

                $taxed_amount += $lTaxVal;

                $i++;
            }

            $invoicenum = _post('invoicenum');
            $cn = _post('cn');
            $fTotal = $sTotal;

            // calculate discount

            $discount_amount = _post('discount_amount');
            $discount_type = _post('discount_type');
            $discount_value = '0.00';
            if ($discount_amount == '0' or $discount_amount == '') {
                $actual_discount = '0.00';
            } else {
                if ($discount_type == 'f') {
                    $actual_discount = $discount_amount;
                    $discount_value = $discount_amount;
                } else {
                    $discount_type = 'p';
                    $actual_discount = ($sTotal * $discount_amount) / 100;
                    $discount_value = $discount_amount;
                }
            }

            $actual_discount = number_format(
                (float) $actual_discount,
                2,
                '.',
                ''
            );
            $fTotal = $fTotal - $actual_discount;
            if ($taxed_amount != 0.0) {
                $taxval = ($taxed_amount * $taxrate) / 100;
            }
            $fTotal = $fTotal + $taxval;
            $status = _post('status');

            $receipt_number = _post('receipt_number');

            $d = ORM::for_table('sys_purchases')->find_one($iid);
            if ($d) {
                $d->userid = $cid;
                $d->account = $u['account'];
                $d->date = $idate;
                $d->duedate = $duedate;
                $d->discount_type = $discount_type;
                $d->discount_value = $discount_value;
                $d->discount = $actual_discount;
                $d->subtotal = $sTotal;
                $d->total = $fTotal;
                $d->tax = $taxed_amount;
                $d->taxname = '';
                $d->taxrate = 0.0;
                $d->notes = $notes;
                $d->r = $r;
                $d->nd = $nd;
                $d->invoicenum = $invoicenum;
                $d->cn = $cn;

                if ($status == 'Draft') {
                    $d->status = 'Draft';
                } elseif ($status == 'Published') {
                    $d->status = 'Unpaid';
                } else {
                }

                $d->currency = $currency;
                $d->currency_symbol = $currency_symbol;
                $d->currency_rate = $currency_rate;
                $d->show_quantity_as = $show_quantity_as;

                $d->currency_iso_code = $currency_id;
                $d->receipt_number = $receipt_number;

                $d->subject = _post('subject');

                $d->save();

                $invoiceid = $iid;
                $description = $data['desc'];
                $i = '0';
                $inventory_items_adjust = ORM::for_table('sys_purchaseitems')
                    ->where('invoiceid', $iid)
                    ->find_array();
                foreach ($inventory_items_adjust as $i_adjust) {
                    Inventory::decreaseByItemNumber(
                        $i_adjust['itemcode'],
                        $i_adjust['qty']
                    );
                }

                $x = ORM::for_table('sys_purchaseitems')
                    ->where('invoiceid', $iid)
                    ->delete_many();
                foreach ($description as $item) {
                    $samount = $a[$i];
                    $samount = Finance::amount_fix($samount);
                    if ($item == '' && $samount == '0.00') {
                        $i++;
                        continue;
                    }

                    $tax_rate = $taxed[$i];
                    $sqty = $qty[$i];
                    $sqty = Finance::amount_fix($sqty);
                    $ltotal = $samount * $sqty;
                    $d = ORM::for_table('sys_purchaseitems')->create();
                    $d->invoiceid = $invoiceid;
                    $d->userid = $cid;
                    $d->description = $item;
                    $d->qty = $sqty;
                    $d->amount = $samount;
                    $d->total = $ltotal;

                    if ($tax_rate == '' || $taxrate == '0') {
                        $tax_rate = 0.0;
                        $d->taxed = '0';
                    } else {
                        $d->taxed = '1';
                    }

                    $d->type = '';
                    $d->relid = '0';
                    $d->itemcode = $item_number[$i];
                    $d->taxamount = '0.00';
                    $d->duedate = date('Y-m-d');
                    $d->paymentmethod = '';
                    $d->notes = '';
                    $d->save();

                    // decrease inventory

                    Inventory::increaseByItemNumber($item_number[$i], $sqty);
                    $i++;
                }

                echo $invoiceid;
            } else {
                // invoice not found
            }
        } else {
            echo $msg;
        }

        break;

    case 'list':
        $paginator = [];

        $view_type = 'default';
        $view_type = 'filter';

        $total_invoice = ORM::for_table('sys_purchases')->count();
        $ui->assign('total_invoice', $total_invoice);
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

        $d = $f->order_by_desc('id')->find_many();
        $paginator['contents'] = '';

        $ui->assign('view_type', $view_type);
        $ui->assign('d', $d);
        $ui->assign('paginator', $paginator);

        $paid = ORM::for_table('sys_purchases')
            ->where('status', 'Paid')
            ->count();
        $unpaid = ORM::for_table('sys_purchases')
            ->where('status', 'Unpaid')
            ->count();
        $partially_paid = ORM::for_table('sys_purchases')
            ->where('status', 'Partially Paid')
            ->count();
        $cancelled = ORM::for_table('sys_purchases')
            ->where('status', 'Cancelled')
            ->count();
        $arr = [
            'Paid' => $paid,
            'Unpaid' => $unpaid,
            'Partially Paid' => $partially_paid,
            'Cancelled' => $cancelled,
        ];
        $p = Misc::array_percentage($arr);
        $invoice_paid_amount = Purchase::where('status', 'Paid')->sum('total');
        $invoice_un_paid_amount = Purchase::where('status', 'Unpaid')->sum(
            'total'
        );
        $invoice_partially_paid_amount = Purchase::where(
            'status',
            'Partially Paid'
        )->sum('credit');
        $invoice_cancelled_amount = Purchase::where('status', 'Cancelled')->sum(
            'total'
        );
        $cancelled = Purchase::where('status', 'Cancelled')->count();

        view('purchase_list', [
            'paid' => $paid,
            'unpaid' => $unpaid,
            'partially_paid' => $partially_paid,
            'cancelled' => $cancelled,
            'invoice_paid_amount' => $invoice_paid_amount,
            'invoice_un_paid_amount' => $invoice_un_paid_amount,
            'invoice_cancelled_amount' => $invoice_cancelled_amount,
            'invoice_partially_paid_amount' => $invoice_partially_paid_amount,
            'p' => $p,
        ]);

        break;

    case 'view':
        $id = $routes['2'];
        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            $items = ORM::for_table('sys_purchaseitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('items', $items);

            $trs_c = ORM::for_table('sys_transactions')
                ->where('purchase_id', $id)
                ->count();
            $trs = ORM::for_table('sys_transactions')
                ->where('purchase_id', $id)
                ->order_by_desc('id')
                ->find_many();
            $ui->assign('trs', $trs);
            $ui->assign('trs_c', $trs_c);
            $emls_c = ORM::for_table('sys_email_logs')
                ->where('purchase_id', $id)
                ->count();
            $emls = ORM::for_table('sys_email_logs')
                ->where('purchase_id', $id)
                ->order_by_desc('id')
                ->find_many();
            $ui->assign('emls', $emls);
            $ui->assign('emls_c', $emls_c);
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $ui->assign('a', $a);
            $ui->assign('d', $d);
            $i_credit = $d['credit'];
            $i_due = '0.00';
            $i_total = $d['total'];
            if ($d['credit'] != '0.00') {
                $i_due = $i_total - $i_credit;
            } else {
                $i_due = $d['total'];
            }

            $i_due = number_format(
                $i_due,
                2,
                $config['dec_point'],
                $config['thousands_sep']
            );
            $ui->assign('i_due', $i_due);
            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('cf', $cf);

            $x_html = '';
            Event::trigger('view_invoice');
            $ui->assign('x_html', $x_html);

            $upload_max_size = ini_get('upload_max_filesize');
            $post_max_size = ini_get('post_max_size');
            $ui->assign('upload_max_size', $upload_max_size);
            $ui->assign('post_max_size', $post_max_size);

            // count attachments

            $inv_files = Invoice::files($id);
            $inv_files_c = count($inv_files);
            $ui->assign('inv_files_c', $inv_files_c);
            $ui->assign('inv_files', $inv_files);
            $access_logs = ORM::for_table('ib_invoice_access_log')
                ->where('iid', $id)
                ->order_by_desc('id')
                ->find_array();
            $ui->assign('access_logs', $access_logs);

            $currency_rate = 1;

            if ($a->cid != '' || $a->cid != 0) {
                $company = Company::find($a->cid);
            } else {
                $company = false;
            }

            view('purchases_view', [
                'currencies' => Currency::all(),
                'currency_rate' => $currency_rate,
                'company' => $company,
            ]);
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'save':
        Event::trigger('purchases/add-post/');
        $cid = _post('cid');

        // find user with cid

        $u = ORM::for_table('crm_accounts')->find_one($cid);
        $msg = '';
        if ($cid == '') {
            $msg .= $_L['select_a_contact'] . ' <br /> ';
        }

        $notes = _post('notes');

        $show_quantity_as = _post('show_quantity_as');

        // find currency

        $currency_id = _post('currency');
        $currency_find = Currency::find($currency_id);
        if ($currency_find) {
            $currency = $currency_id;
            $currency_symbol = $currency_find->symbol;
            $currency_rate = $currency_find->rate;
        } else {
            $currency = 0;
            $currency_symbol = $config['currency_code'];
            $currency_rate = 1.0;
        }

        if (isset($data['amount'])) {
            $amount = $data['amount'];
        } else {
            $msg .= $_L['at_least_one_item_required'] . ' <br /> ';
        }

        $idate = _post('idate');
        $its = strtotime($idate);
        $duedate = _post('duedate');
        $dd = '';
        if ($duedate == 'due_on_receipt') {
            $dd = $idate;
        } elseif ($duedate == 'days3') {
            $dd = date('Y-m-d', strtotime('+3 days', $its));
        } elseif ($duedate == 'days5') {
            $dd = date('Y-m-d', strtotime('+5 days', $its));
        } elseif ($duedate == 'days7') {
            $dd = date('Y-m-d', strtotime('+7 days', $its));
        } elseif ($duedate == 'days10') {
            $dd = date('Y-m-d', strtotime('+10 days', $its));
        } elseif ($duedate == 'days15') {
            $dd = date('Y-m-d', strtotime('+15 days', $its));
        } elseif ($duedate == 'days30') {
            $dd = date('Y-m-d', strtotime('+30 days', $its));
        } elseif ($duedate == 'days45') {
            $dd = date('Y-m-d', strtotime('+45 days', $its));
        } elseif ($duedate == 'days60') {
            $dd = date('Y-m-d', strtotime('+60 days', $its));
        } else {
            $msg .= 'Invalid Date <br /> ';
        }

        if (!$dd) {
            $msg .= 'Date Parsing Error <br /> ';
        }

        $repeat = _post('repeat');
        $nd = $idate;
        if ($repeat == '0') {
            $r = '0';
        } elseif ($repeat == 'week1') {
            $r = '+1 week';
            $nd = date('Y-m-d', strtotime('+1 week', $its));
        } elseif ($repeat == 'weeks2') {
            $r = '+2 weeks';
            $nd = date('Y-m-d', strtotime('+2 weeks', $its));
        } elseif ($repeat == 'month1') {
            $r = '+1 month';
            $nd = date('Y-m-d', strtotime('+1 month', $its));
        } elseif ($repeat == 'months2') {
            $r = '+2 months';
            $nd = date('Y-m-d', strtotime('+2 months', $its));
        } elseif ($repeat == 'months3') {
            $r = '+3 months';
            $nd = date('Y-m-d', strtotime('+3 months', $its));
        } elseif ($repeat == 'months6') {
            $r = '+6 months';
            $nd = date('Y-m-d', strtotime('+6 months', $its));
        } elseif ($repeat == 'year1') {
            $r = '+1 year';
            $nd = date('Y-m-d', strtotime('+1 year', $its));
        } elseif ($repeat == 'years2') {
            $r = '+2 years';
            $nd = date('Y-m-d', strtotime('+2 years', $its));
        } elseif ($repeat == 'years3') {
            $r = '+3 years';
            $nd = date('Y-m-d', strtotime('+3 years', $its));
        } else {
            $msg .= 'Date Parsing Error <br /> ';
        }

        if ($msg == '') {
            $qty = $data['qty'];
            $item_number = $data['item_code'];

            if (isset($data['taxed'])) {
                $taxed = $data['taxed'];
            } else {
                $taxed = false;
            }

            $sTotal = '0';
            $taxTotal = '0';
            $i = '0';
            $a = [];

            $taxval = '0.00';
            $taxname = '';
            $taxrate = '0.00';

            $taxed_amount = 0.0;
            $lamount = 0.0;

            foreach ($amount as $samount) {
                $samount = Finance::amount_fix($samount);
                $a[$i] = $samount;
                $sqty = $qty[$i];
                $sqty = Finance::amount_fix($sqty);

                $lTaxRate = $taxed[$i];
                $lTaxRate = Finance::amount_fix($lTaxRate);

                $sTotal += $samount * $sqty;
                $lamount = $samount * $sqty;

                $lTaxVal = ($lamount * $lTaxRate) / 100;

                $taxed_amount += $lTaxVal;

                $i++;
            }

            $invoicenum = _post('invoicenum');
            $cn = _post('cn');
            $fTotal = $sTotal;
            $discount_amount = _post('discount_amount');
            $discount_type = _post('discount_type');
            $discount_value = '0.00';
            if ($discount_amount == '0' or $discount_amount == '') {
                $actual_discount = '0.00';
            } else {
                if ($discount_type == 'f') {
                    $actual_discount = $discount_amount;
                    $discount_value = $discount_amount;
                } else {
                    $discount_type = 'p';
                    $actual_discount = ($sTotal * $discount_amount) / 100;
                    $discount_value = $discount_amount;
                }
            }

            $actual_discount = number_format(
                (float) $actual_discount,
                2,
                '.',
                ''
            );
            $fTotal = $fTotal + $taxed_amount - $actual_discount;

            $status = _post('status');
            if ($status != 'Draft') {
                $status = 'Unpaid';
            }

            $receipt_number = _post('receipt_number');

            $datetime = date("Y-m-d H:i:s");
            $vtoken = _raid(10);
            $ptoken = _raid(10);

            $purchase = false;

            if (_post('purchase_id')) {
                $purchase = Purchase::find(_post('purchase_id'));

                if ($purchase) {
                    PurchaseItem::where('invoiceid', $purchase->id)->delete();
                }
            }

            if (!$purchase) {
                $purchase = new Purchase();
                $purchase->vtoken = $vtoken;
                $purchase->ptoken = $ptoken;
            }

            $purchase->userid = $cid;
            $purchase->account = $u['account'];
            $purchase->date = $idate;
            $purchase->duedate = $dd;
            $purchase->datepaid = $datetime;
            $purchase->subtotal = $sTotal;
            $purchase->discount_type = $discount_type;
            $purchase->discount_value = $discount_value;
            $purchase->discount = $actual_discount;
            $purchase->total = $fTotal;
            $purchase->tax = $taxed_amount;
            $purchase->taxname = '';
            $purchase->taxrate = 0.0;

            $purchase->status = $status;
            $purchase->notes = $notes;
            $purchase->r = $r;
            $purchase->nd = $nd;

            $purchase->show_quantity_as = $show_quantity_as;

            $purchase->invoicenum = $invoicenum;
            $purchase->cn = $cn;
            $purchase->tax2 = '0.00';
            $purchase->taxrate2 = '0.00';
            $purchase->paymentmethod = '';

            $purchase->currency = $currency;
            $purchase->currency_symbol = $currency_symbol;
            $purchase->currency_rate = $currency_rate;

            $purchase->currency_iso_code = $currency_id;

            $purchase->receipt_number = $receipt_number;

            $purchase->subject = _post('subject');

            $purchase->save();
            $invoiceid = $purchase->id;
            $description = $data['desc'];

            $i = '0';
            foreach ($description as $item) {
                $samount = $a[$i];
                $samount = Finance::amount_fix($samount);
                if ($item == '' && $samount == '0.00') {
                    $i++;
                    continue;
                }

                $tax_rate = $taxed[$i];

                $sqty = $qty[$i];
                $sqty = Finance::amount_fix($sqty);
                $ltotal = $samount * $sqty;
                $d = ORM::for_table('sys_purchaseitems')->create();
                $d->invoiceid = $invoiceid;
                $d->userid = $cid;
                $d->description = $item;
                $d->qty = $sqty;
                $d->amount = $samount;
                $d->total = $ltotal;

                if ($tax_rate == '' || $taxrate == '0') {
                    $tax_rate = 0.0;
                    $d->taxed = '0';
                } else {
                    $d->taxed = '1';
                }

                $d->tax_rate = $tax_rate;

                $d->type = '';
                $d->relid = '0';
                $d->itemcode = $item_number[$i];
                $d->taxamount = '0.00';
                $d->duedate = date('Y-m-d');
                $d->paymentmethod = '';
                $d->notes = '';
                $d->save();

                Inventory::increaseByItemNumber($item_number[$i], $sqty);

                // Add Sales Count

                $item_r = Item::where('name', $item)->first();
                if ($item_r) {
                    $item_r->sold_count = $item_r->sold_count + $sqty;
                    $item_r->total_amount = $item_r->total_amount + $samount;
                    $item_r->save();
                }

                $i++;
            }

            $code = _post('cn');
            update_option(
                'purchase_code_current_number',
                current_number_would_be($code)
            );

            Event::trigger('add_invoice_posted');
            echo $invoiceid;
        } else {
            echo $msg;
        }

        break;

    case 'delete':
        Event::trigger('invoices/delete/');
        $id = $routes['2'];
        if (APP_STAGE == 'Demo') {
            r2(
                U . 'accounts/list',
                'e',
                'Sorry! Deleting Account is disabled in the demo mode.'
            );
        }

        $d = ORM::for_table('crm_accounts')->find_one($id);
        if ($d) {
            $d->delete();
            r2(U . 'accounts/list', 's', $_L['account_delete_successful']);
        }

        break;

    case 'print':
        Event::trigger('invoices/print/');
        $id = $routes['2'];
        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            // find all activity for this user

            $items = ORM::for_table('sys_purchaseitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();

            // find the user

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            require 'system/lib/invoices/render.php';
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'pdf':
        Event::trigger('invoices/pdf/');
        $id = $routes['2'];
        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            // find all activity for this user

            $items = ORM::for_table('sys_purchaseitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();
            $trs_c = ORM::for_table('sys_transactions')
                ->where('iid', $id)
                ->count();
            $trs = ORM::for_table('sys_transactions')
                ->where('iid', $id)
                ->order_by_desc('id')
                ->find_many();

            // find the user

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $i_credit = $d['credit'];
            $i_due = '0.00';
            $i_total = $d['total'];
            if ($d['credit'] != '0.00') {
                $i_due = $i_total - $i_credit;
            } else {
                $i_due = $d['total'];
            }

            $i_due = number_format(
                $i_due,
                2,
                $config['dec_point'],
                $config['thousands_sep']
            );
            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();
            if ($d['cn'] != '') {
                $dispid = $d['cn'];
            } else {
                $dispid = $d['id'];
            }

            $in = $d['invoicenum'] . $dispid;
            define('_MPDF_PATH', 'system/lib/mpdf/');
            require 'system/lib/mpdf/mpdf.php';

            $pdf_c = '';
            $ib_w_font = 'dejavusanscondensed';
            if ($config['pdf_font'] == 'default') {
                $pdf_c = 'c';
                $ib_w_font = 'Helvetica';
            }

            $mpdf = new mPDF($pdf_c, 'A4', '', '', 20, 15, 15, 25, 10, 10);
            $mpdf->SetProtection(['print']);
            $mpdf->SetTitle($config['CompanyName'] . ' Invoice');
            $mpdf->SetAuthor($config['CompanyName']);
            $mpdf->SetWatermarkText(ib_lan_get_line($d['status']));
            $mpdf->showWatermarkText = true;
            $mpdf->watermark_font = $ib_w_font;
            $mpdf->watermarkTextAlpha = 0.1;
            $mpdf->SetDisplayMode('fullpage');
            if ($config['pdf_font'] == 'AdobeCJK') {
                $mpdf->useAdobeCJK = true;
                $mpdf->autoScriptToLang = true;
                $mpdf->autoLangToFont = true;
            }

            Event::trigger('invoices/before_pdf_render/');
            ob_start();
            require 'system/lib/invoices/pdf-x2.php';

            $html = ob_get_contents();
            ob_end_clean();
            $mpdf->WriteHTML($html);
            $pdf_return = 'inline';
            if (isset($routes[3])) {
                $r_type = $routes[3];
            } else {
                $r_type = 'inline';
            }

            if ($r_type == 'dl') {
                $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'D'); // D
            } elseif ($r_type == 'inline') {
                $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'I'); // D
            } elseif ($r_type == 'store') {
                $mpdf->Output('storage/temp/Invoice_' . $in . '.pdf', 'F'); // D
            } else {
                $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'I'); // D
            }
        }

        break;

    case 'markpaid':
        $iid = _post('iid');
        $d = ORM::for_table('sys_purchases')->find_one($iid);
        if ($d) {
            $d->status = 'Paid';
            $d->save();
            Event::trigger('invoices/markpaid/', $invoice = $d);
            _msglog('s', 'Invoice marked as Paid');
        } else {
            _msglog('e', 'Invoice not found');
        }

        break;

    case 'markunpaid':
        Event::trigger('invoices/markunpaid/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_purchases')->find_one($iid);
        if ($d) {
            $d->status = 'Unpaid';
            $d->save();
            _msglog('s', 'Invoice marked as Un Paid');
        } else {
            _msglog('e', 'Invoice not found');
        }

        break;

    case 'markcancelled':
        Event::trigger('invoices/markcancelled/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_purchases')->find_one($iid);
        if ($d) {
            $d->status = 'Cancelled';
            $d->save();
            _msglog('s', 'Invoice marked as Cancelled');
        } else {
            _msglog('e', 'Invoice not found');
        }

        break;

    case 'markpartiallypaid':
        Event::trigger('invoices/markpartiallypaid/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_purchases')->find_one($iid);
        if ($d) {
            $d->status = 'Partially Paid';
            $d->save();
            _msglog('s', 'Invoice marked as Partially Paid');
        } else {
            _msglog('e', 'Invoice not found');
        }

        break;

    case 'add-payment':
        Event::trigger('invoices/add-payment/');
        $sid = $routes['2'];
        $d = ORM::for_table('sys_purchases')->find_one($sid);
        if ($d) {
            $itotal = $d['total'];
            $ic = $d['credit'];
            $np = $itotal - $ic;
            $a_opt = '';

            $a = ORM::for_table('sys_accounts')->find_many();
            foreach ($a as $acs) {
                $a_opt .=
                    '<option value="' .
                    $acs['id'] .
                    '">' .
                    $acs['account'] .
                    '</option>';
            }

            $pms_opt = '';

            $pms = ORM::for_table('sys_pmethods')
                ->order_by_asc('sorder')
                ->find_many();
            foreach ($pms as $pm) {
                $pms_opt .=
                    '<option value="' .
                    $pm['name'] .
                    '">' .
                    $pm['name'] .
                    '</option>';
            }

            $cats_opt = '';
            $cats = ORM::for_table('sys_cats')
                ->where('type', 'Expense')
                ->order_by_asc('sorder')
                ->find_many();
            foreach ($cats as $cat) {
                $cats_opt .=
                    '<option value="' .
                    $cat['name'] .
                    '">' .
                    $cat['name'] .
                    '</option>';
            }

            $currency_opt = '';

            $currencies = Currency::all();

            $currency_iso_code = $d->currency_iso_code;

            $currency = Currency::getAllCurrencies();

            $currency_symbol = $config['currency_code'];
            $currency_decimal_point = $config['dec_point'];
            $thousands_separator = $config['thousands_sep'];

            if (isset($currency[$currency_iso_code])) {
                $selected_currency = $currency[$currency_iso_code];
                $currency_symbol = $selected_currency['symbol'];
                $currency_decimal_point = $selected_currency['decimal_mark'];
                $thousands_separator =
                    $selected_currency['thousands_separator'];
            }

            $currency_opt =
                '<div class="form-group">
    <label for="amount">' .
                $_L['Amount'] .
                ' [' .
                $currency_iso_code .
                ']</label>
    <input type="text" id="amount" name="amount" class="form-control amount"   data-a-sign="' .
                $currency_symbol .
                ' " data-a-dec="' .
                $currency_decimal_point .
                '" data-a-sep="' .
                $thousands_separator .
                '"
data-d-group="3" value="">
  </div>';

            $secondary_currency = secondary_currency();
            $payment_amount = $np;
            if ($d['currency_symbol'] == '') {
                $invoice_currency = $config['currency_code'];
            } else {
                $invoice_currency = $d['currency_symbol'];
            }

            echo '
<div class="mx-auto" style="max-width: 650px;">
<div class="panel mb-0 rounded-0">
<div class="panel-hdr">

	<h2>' .
                $_L['Purchase'] .
                ' #' .
                $d['id'] .
                '</h2>
</div>

<div class="panel-container">
<div class="panel-content">


<div class="modal-body">
<h3>' .
                $_L['Invoice Total'] .
                ': <span class="amount" data-a-sign="' .
                $invoice_currency .
                ' ">' .
                $d['total'] .
                '</span></h3>
<hr>
<form class="form-horizontal" role="form" id="form_add_payment" method="post">
<div class="form-group">
    <label for="subject">' .
                $_L['Account'] .
                '</label>
    <select id="account" name="account">
                            <option value="">' .
                $_L['Choose an Account'] .
                '</option>

' .
                $a_opt .
                '

                        </select>
    </div>

<div class="form-group">
    <label for="date">' .
                $_L['Date'] .
                '</label>
    <input type="text" class="form-control datepicker"  value="' .
                date('Y-m-d') .
                '" name="date" id="date" datepicker data-date-format="yyyy-mm-dd" data-auto-close="true">
  </div>

<div class="form-group">
    <label for="description">' .
                $_L['Description'] .
                '</label>
    <input type="text" id="description" name="description" class="form-control" value="' .
                $_L['Purchase'] .
                ' ' .
                $d['id'] .
                ' ' .
                $_L['Payment'] .
                '">
  </div>
  
  
' .
                $currency_opt .
                '



  
  
<div class="form-group">
    <label for="cats">' .
                $_L['Category'] .
                '</label>
    <select id="cats" name="cats">
                             <option value="Uncategorized">' .
                $_L['Uncategorized'] .
                '</option>

' .
                $cats_opt .
                '

                        </select>
  </div>
  <div class="form-group">
    <label for="payer_name">' .
                $_L['Payee'] .
                '</label>
    <input type="text" id="payer_name" name="payer_name" class="form-control" value="' .
                $d['account'] .
                '" disabled>
  </div>

   <div class="form-group">
    <label for="subject" class="col-sm-3 control-label">' .
                $_L['Method'] .
                '</label>
    <select id="pmethod" name="pmethod">
                                <option value="">' .
                $_L['Select Payment Method'] .
                '</option>


                                ' .
                $pms_opt .
                '


                            </select>
  </div>

<input type="hidden" name="iid" value="' .
                $d['id'] .
                '">
<input type="hidden" name="payer" value="' .
                $d['userid'] .
                '">
<input type="hidden" name="currency" value="' .
                $d['currency_iso_code'] .
                '">
<button id="save_payment" class="btn btn-primary">' .
                $_L['Save'] .
                '</button>

</form>

</div>



</div>
</div>



</div>


</div>


<div class="modal-footer">

	

		';
        } else {
            exit('Invoice Not Found');
        }

        break;

    case 'add-payment-post':
        Event::trigger('invoices/add-payment-post/');
        $msg = '';
        $account = _post('account');

        if ($account == '') {
            $msg .= $_L['Select An Account'] . '<br />';
        }

        $date = _post('date');
        $amount = _post('amount');

        $currency_iso_code = _post('currency');

        $amount = createFromCurrency($amount, $currency_iso_code);

        $payerid = _post('payer');
        $pmethod = _post('pmethod');
        $ref = _post('ref');
        if ($payerid == '') {
            $payerid = '0';
        }

        $payer = '';

        if ($payerid != '0') {
            $payer_find = Contact::find($payerid);

            if ($payer_find) {
                $payer = $payer_find->account;
            }
        }

        $currencies = Currency::all();
        $tr_currency = '0';
        $tr_currency_symbol = '';
        $tr_currency_rate = '1.0000';

        $cat = _post('cats');
        $iid = _post('iid');
        if ($payerid == '') {
            $msg .= 'Payer Not Found' . '<br />';
        }

        $description = _post('description');

        if ($description == '') {
            $msg .= $_L['description_error'] . '<br />';
        }

        if (is_numeric($amount) == false) {
            $msg .= $_L['amount_error'] . '<br />';
        }

        if ($msg == '') {
            $account_find = Account::find($account);
            $d = ORM::for_table('sys_transactions')->create();
            $d->account = $account_find->account;
            $d->account_id = $account_find->id;
            $d->type = 'Expense';
            $d->payerid = '0';
            $d->payeeid = $payerid;
            $d->amount = $amount;
            $d->category = $cat;
            $d->method = $pmethod;
            $d->ref = $ref;
            $d->tags = '';
            $d->description = $description;
            $d->date = $date;
            $d->dr = $amount;
            $d->cr = '0.00';

            $d->purchase_id = $iid;
            $d->currency = $tr_currency;
            $d->currency_symbol = $tr_currency_symbol;
            $d->currency_rate = $tr_currency_rate;

            // others

            $d->payer = '';
            $d->payee = $payer;

            $d->status = 'Cleared';
            $d->tax = '0.00';
            $d->aid = 0;

            $d->vid = _raid(8);

            $d->updated_at = date('Y-m-d H:i:s');

            //

            $d->save();
            $tid = $d->id();
            _log(
                'New Expense: ' .
                    $description .
                    ' [TrID: ' .
                    $tid .
                    ' | Amount: ' .
                    $amount .
                    ']',
                'Admin',
                $user->id
            );
            _msglog('s', 'Transaction Added Successfully');

            $i = ORM::for_table('sys_purchases')->find_one($iid);
            if ($i) {
                $pc = $i['credit'];
                $it = $i['total'];
                $dp = $it + $pc;
                if ($dp == $amount or $dp < $amount) {
                    $i->status = 'Paid';
                } else {
                    $i->status = 'Partially Paid';
                }
                $i->credit = $pc + $amount;
                $i->save();
            }

            echo $tid;
        } else {
            echo '<div class="alert alert-danger fade in">' . $msg . '</div>';
        }

        break;

    case 'mail_invoice_':
        Event::trigger('invoices/mail_invoice_/');
        $sid = $routes['2'];
        $etpl = $routes['3'];
        $d = ORM::for_table('sys_purchases')->find_one($sid);
        if ($d) {
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $msg = Purchase::gen_email($sid, $etpl);
            if ($msg) {
                $subj = $msg['subject'];
                $message_o = $msg['body'];
                $email = $msg['email'];
                $name = $msg['name'];
            } else {
                $subj = '';
                $message_o = '';
                $email = '';
                $name = '';
            }

            if ($d['cn'] != '') {
                $dispid = $d['cn'];
            } else {
                $dispid = $d['id'];
            }

            $in = $d['invoicenum'] . $dispid;
            echo '
<div class="mx-auto" style="max-width: 650px;">
	<div class="panel mb-0 rounded-0">
	<div class="panel-hdr">
    <h3>' .
                __('Purchase') .
                ' #' .
                $d['id'] .
                '</h3>
</div>
<div class="panel-container">
<div class="panel-content">


<form class="form-horizontal" role="form" id="email_form" method="post">


<div class="form-group">
    <label for="toemail" class="col-sm-2 control-label">' .
                $_L['To'] .
                '</label>
    <input type="email" id="toemail" name="toemail" class="form-control" value="' .
                $email .
                '">
  </div>

  <div class="form-group">
    <label for="ccemail" class="col-sm-2 control-label">' .
                $_L['Cc'] .
                '</label>
    <input type="email" id="ccemail" name="ccemail" class="form-control" value="">
  </div>

  <div class="form-group">
    <label for="bccemail" class="col-sm-2 control-label">' .
                $_L['Bcc'] .
                '</label>
    <input type="email" id="bccemail" name="bccemail" class="form-control" value="">
      <span class="help-block"><a href="#" id="send_bcc_to_admin">' .
                $_L['Send Bcc to Admin'] .
                '</a></span>
  </div>

    <div class="form-group">
    <label for="subject" class="col-sm-2 control-label">' .
                $_L['Subject'] .
                '</label>
    <input type="text" id="subject" name="subject" class="form-control" value="' .
                $subj .
                '">
  </div>

  <div class="form-group">
    <label for="subject" class="col-sm-2 control-label">' .
                $_L['Message Body'] .
                '</label>
    <textarea class="form-control sysedit" rows="3" name="message" id="message">' .
                $message_o .
                '</textarea>
      <input type="hidden" id="toname" name="toname" value="' .
                $name .
                '">
      <input type="hidden" id="i_cid" name="i_cid" value="' .
                $a['id'] .
                '">
      <input type="hidden" id="i_iid" name="i_iid" value="' .
                $d['id'] .
                '">
  </div>


<div class="form-group">
    <label for="attach_pdf" class="col-sm-2 control-label">' .
                $_L['Attach PDF'] .
                '</label>
    <div class="col-sm-10">
      <div class="checkbox c-checkbox">
      <label>
                            <input type="checkbox" name="attach_pdf" id="attach_pdf" value="Yes" checked> ' .
                $_L['Purchase'] .
                '_' .
                $in .
                '.pdf
                          </label>
                          
                        </div>
    </div>
  </div>
<button id="send" class="btn btn-primary">' .
                $_L['Send'] .
                '</button>

</form>




</div>



	
</div>
	
	
';
        } else {
            exit('Invoice Not Found');
        }

        break;

    case 'send_email':
        Event::trigger('purchases/send_email/');
        $msg = '';
        $email = _post('toemail');
        $cc = _post('ccemail');
        $bcc = _post('bccemail');
        $subject = _post('subject');
        $toname = _post('toname');
        $cid = _post('i_cid');
        $iid = _post('i_iid');
        $d = ORM::for_table('sys_purchases')->find_one($iid);
        if ($d['cn'] != '') {
            $dispid = $d['cn'];
        } else {
            $dispid = $d['id'];
        }

        $in = $d['invoicenum'] . $dispid;
        $message = $data['message'];
        $attach_pdf = _post('attach_pdf');
        $attachment_path = '';
        $attachment_file = '';
        if ($attach_pdf == 'Yes') {
            Purchase::pdf($iid, 'store');
            $attachment_path =
                'storage/temp/' . __('Purchase') . '_' . $in . '.pdf';
            $attachment_file = __('Purchase') . '_' . $in . '.pdf';
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $msg .= 'Invalid Email <br />';
        }

        if (!filter_var($cc, FILTER_VALIDATE_EMAIL)) {
            $cc = '';
        }

        if (!filter_var($bcc, FILTER_VALIDATE_EMAIL)) {
            $bcc = '';
        }

        if ($subject == '') {
            $msg .= 'Subject is Required <br />';
        }

        if ($message == '') {
            $msg .= 'Message is Required <br />';
        }

        if ($msg == '') {
            Email::sendEmail(
                $config,
                $_L,
                $toname,
                $email,
                $subject,
                $message,
                $cid,
                $iid,
                $cc,
                $bcc,
                $attachment_path,
                $attachment_file
            );

            echo '<div class="alert alert-success fade in">Mail Sent!</div>';
        } else {
            echo '<div class="alert alert-danger fade in">' . $msg . '</div>';
        }

        break;

    case 'stop_recurring':
        Event::trigger('invoices/stop_recurring/');
        $id = $routes['2'];
        $id = str_replace('sid', '', $id);
        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            $d->r = '0';
            $d->save();
            r2(
                U . 'invoices/list-recurring',
                's',
                'Recurring Disabled for Invoice: ' . $id
            );
        } else {
            echo 'Invoice not found';
        }

        break;

    case 'export_csv':
        $fileName = 'transactions_' . time() . '.csv';
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header('Content-Description: File Transfer');
        header("Content-type: text/csv");
        header("Content-Disposition: attachment; filename={$fileName}");
        header("Expires: 0");
        header("Pragma: public");
        $fh = @fopen('php://output', 'w');
        $headerDisplayed = false;

        $results = db_find_array('sys_purchases');
        foreach ($results as $data) {
            if (!$headerDisplayed) {
                fputcsv($fh, array_keys($data));
                $headerDisplayed = true;
            }

            fputcsv($fh, $data);
        }

        fclose($fh);
        break;

    case 'payments':
        $d = ORM::for_table('sys_transactions')
            ->where_not_equal('iid', '0')
            ->limit(500)
            ->find_array();
        $ui->assign('d', $d);
        view('payments');
        break;

    case 'clone':
        $id = route(2);
        $new_id = Purchase::cloneInvoice($id);
        if ($new_id) {
            r2(
                U . 'purchases/edit/' . $new_id,
                's',
                $_L['Cloned successfully']
            );
        }

        break;

    case 'pos':
        $extra_fields = '';
        $extra_jq = '';
        $ui->assign('extra_fields', $extra_fields);
        if (isset($routes['2']) and $routes['2'] == 'recurring') {
            $recurring = true;
        } else {
            $recurring = false;
        }

        $currencies = Currency::all();
        $ui->assign('recurring', $recurring);
        $ui->assign('currencies', $currencies);
        if (isset($routes['3']) and $routes['3'] != '') {
            $p_cid = $routes['3'];
            $p_d = ORM::for_table('crm_accounts')->find_one($p_cid);
            if ($p_d) {
                $ui->assign('p_cid', $p_cid);
            }
        } else {
            $ui->assign('p_cid', '');
        }

        $c = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('c', $c);
        $t = ORM::for_table('sys_tax')->find_many();
        $ui->assign('t', $t);
        $ui->assign('idate', date('Y-m-d'));

        Event::trigger('add_invoice_rendering_form');

        view('pos');
        break;

    case 'set_stage':
        $stage = route(2);
        $id = _post('iid');

        $purchase = Purchase::find($id);

        if ($purchase) {
            switch ($stage) {
                case 'mark_stage_pending':
                    $s = 'Pending';

                    break;

                case 'mark_stage_accepted':
                    $s = 'Accepted';

                    break;

                case 'mark_stage_declined':
                    $s = 'Declined';

                    break;

                case 'mark_stage_on_hold':
                    $s = 'On Hold';

                    break;

                case 'mark_stage_cancelled':
                    $s = 'Cancelled';

                    break;

                default:
                    $s = 'Pending';
            }

            $purchase->stage = $s;

            $purchase->save();

            echo 'ok';
        }

        break;

    default:
        echo 'action not defined';
}
