<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('selected_navigation', 'invoices');
$ui->assign('_title', $_L['Sales'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);
$data = request()->all();
switch ($action) {
    case 'new':
        Event::trigger('quotes/new/');
        $extra_fields = '';
        $extra_jq = '';

        $ui->assign('extra_fields', $extra_fields);

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

        view('add-quote');

        break;

    case 'edit':
        Event::trigger('quotes/edit/');

        $id = $routes['2'];
        $d = ORM::for_table('sys_quotes')->find_one($id);
        if ($d) {
            $extra_fields = '';
            $extra_jq = '';

            Event::trigger('edit_quote');

            $ui->assign('extra_fields', $extra_fields);

            $ui->assign('i', $d);
            $items = ORM::for_table('sys_quoteitems')
                ->where('qid', $id)
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('items', $items);
            //find the user
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $ui->assign('a', $a);
            $ui->assign('d', $d);
            $c = ORM::for_table('crm_accounts')
                ->select('id')
                ->select('account')
                ->select('company')
                ->find_many();
            $ui->assign('c', $c);

            $t = ORM::for_table('sys_tax')->find_many();
            $ui->assign('t', $t);

            $ui->assign('idate', date('Y-m-d'));

            view('quote-edit');
        } else {
            echo 'Quote Not Found';
        }

        break;

    case 'view':
        Event::trigger('quotes/view/');

        $id = $routes['2'];
        $d = ORM::for_table('sys_quotes')->find_one($id);
        if ($d) {
            //find all activity for this user
            $items = ORM::for_table('sys_quoteitems')
                ->where('qid', $id)
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('items', $items);
            //find related transactions

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $ui->assign('a', $a);
            $ui->assign('d', $d);

            //find all custom fields

            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('cf', $cf);

            view('quote');
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'add-post':
        Event::trigger('quotes/add-post/');
        $cid = _post('cid');
        //find user with cid
        $u = ORM::for_table('crm_accounts')->find_one($cid);

        $msg = '';
        if ($cid == '') {
            $msg .= $_L['select_a_contact'] . ' <br> ';
        }

        $subject = $data['subject'];
        $proposal_text = $data['proposal_text'];
        $customer_notes = $data['customer_notes'];

        if ($subject == '') {
            $msg .= $_L['Subject is Required'] . ' <br> ';
        }

        if (isset($data['amount'])) {
            $amount = $data['amount'];
        } else {
            $msg .= $_L['at_least_one_item_required'] . ' <br> ';
        }

        $idate = _post('idate');
        $its = strtotime($idate);
        $edate = _post('edate');
        $dd = '';

        $currency_id = homeCurrency()->iso_code;

        if ($msg == '') {
            $qty = $data['qty'];
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
            $tax = _post('tid');
            $taxed_type = _post('taxed_type');
            if ($tax != '') {
                $dt = ORM::for_table('sys_tax')->find_one($tax);
                $taxrate = $dt['rate'];
                $taxname = $dt['name'];
                $taxtype = $dt['type'];
            }

            $taxed_amount = 0.0;

            $lamount = 0.0;

            foreach ($amount as $samount) {
                $samount = createFromCurrency($samount, $currency_id);
                $a[$i] = $samount;
                $sqty = $qty[$i];

                $sqty = createFromCurrency($sqty, $currency_id);

                $sTotal += $samount * $sqty;
                $lamount = $samount * $sqty;

                if ($taxed) {
                    $c_tax = $taxed[$i];
                } else {
                    $c_tax = 'No';
                }

                if ($c_tax == 'Yes') {
                    $taxed_amount += $lamount;
                } else {
                    $a_tax = 0.0;
                }

                $i++;
            }

            $invoicenum = _post('invoicenum');
            $cn = _post('cn');

            $fTotal = $sTotal;

            $discount_amount = _post('discount_amount');
            $discount_amount = createFromCurrency(
                $discount_amount,
                $currency_id
            );
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

            $actual_taxed_amount = $taxed_amount - $actual_discount;

            if ($actual_taxed_amount > 0) {
                $taxval = ($actual_taxed_amount * $taxrate) / 100;
            }

            if ($taxed_type != 'individual' and $tax != '') {
                $taxval = ($fTotal * $taxrate) / 100;
            }

            $fTotal += $taxval;

            $today = date('Y-m-d');

            $vtoken = _raid(10);
            $d = ORM::for_table('sys_quotes')->create();
            $d->subject = $subject;
            $d->stage = _post('stage');
            $d->validuntil = _post('edate');
            $d->userid = $cid;
            $d->account = $u['account'];
            $d->invoicenum = $invoicenum;
            $d->cn = $cn;
            $d->firstname = '';
            $d->lastname = '';
            $d->companyname = '';
            $d->email = '';
            $d->address1 = '';
            $d->address2 = '';
            $d->city = '';
            $d->state = '';
            $d->postcode = '';
            $d->country = '';
            $d->phonenumber = '';
            $d->currency = 1;
            $d->subtotal = $sTotal;
            $d->discount_type = $discount_type;
            $d->discount_value = $discount_value;
            $d->discount = $actual_discount;
            $d->taxname = $taxname;
            $d->taxrate = $taxrate;
            $d->tax1 = $taxval;
            $d->tax2 = '0.00';
            $d->total = $fTotal;
            $d->proposal = $proposal_text;
            $d->customernotes = $customer_notes;
            $d->adminnotes = '';
            $d->datecreated = $idate;
            $d->lastmodified = $today;
            $d->datesent = $today;
            $d->dateaccepted = $today;
            $d->vtoken = $vtoken;
            $d->save();

            $qid = $d->id();

            $description = $data['desc'];

            $i = '0';

            foreach ($description as $item) {
                $samount = $a[$i];
                $sqty = $qty[$i];
                $sqty = Finance::amount_fix($sqty);
                $samount = Finance::amount_fix($samount);

                $ltotal = $samount * $sqty;

                $d = ORM::for_table('sys_quoteitems')->create();

                $d->qid = $qid;
                $d->description = $item;

                $d->qty = $sqty;
                $d->amount = $samount;
                $d->discount = '0.00';
                $d->total = $ltotal;

                if ($taxed) {
                    if ($taxed[$i] == 'Yes') {
                        $d->taxable = '1';
                    } else {
                        $d->taxable = '0';
                    }
                } else {
                    $d->taxable = '0';
                }

                $d->itemcode = '';
                $d->save();
                $i++;
            }

            $code = _post('cn');
            update_option(
                'quotation_code_current_number',
                current_number_would_be($code)
            );

            echo $qid;
        } else {
            echo $msg;
        }

        break;

    case 'list':
        Event::trigger('quotes/list/');
        $view_type = 'filter';
        $total_quote = ORM::for_table('sys_quotes')->count();

        $ui->assign('total_quote', $total_quote);

        $d = ORM::for_table('sys_quotes')
            ->order_by_desc('id')
            ->find_array();

        $paginator['contents'] = '';

        $ui->assign('d', $d);
        $ui->assign('paginator', $paginator);

        view('quotes');

        break;

    case 'list-recurring':
        Event::trigger('quotes/list-recurring/');
        $d = ORM::for_table('sys_invoices')
            ->where_not_equal('r', '0')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('d', $d);

        view('list-recurring-invoices');

        break;

    case 'edit-post':
        Event::trigger('quotes/edit-post/');

        $cid = _post('cid');
        $iid = _post('qid');
        //find user with cid
        $u = ORM::for_table('crm_accounts')->find_one($cid);

        $msg = '';
        if ($cid == '') {
            $msg .= $_L['select_a_contact'] . ' <br> ';
        }

        $subject = $data['subject'];
        $proposal_text = $data['proposal_text'];
        $customer_notes = $data['customer_notes'];

        if ($subject == '') {
            $msg .= $_L['Subject is Required'] . ' <br> ';
        }

        if (isset($data['amount'])) {
            $amount = $data['amount'];
        } else {
            $msg .= $_L['at_least_one_item_required'] . ' <br> ';
        }

        $idate = _post('idate');
        $its = strtotime($idate);
        $edate = _post('edate');
        $dd = '';

        if ($msg == '') {
            $qty = $data['qty'];
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
            $tax = _post('tid');
            $taxed_type = _post('taxed_type');
            if ($tax != '') {
                $dt = ORM::for_table('sys_tax')->find_one($tax);
                $taxrate = $dt['rate'];
                $taxname = $dt['name'];
                $taxtype = $dt['type'];
                //
            }

            $taxed_amount = 0.0;

            $lamount = 0.0;

            foreach ($amount as $samount) {
                $samount = Finance::amount_fix($samount);
                $a[$i] = $samount;
                $sqty = $qty[$i];

                $sqty = Finance::amount_fix($sqty);

                $sTotal += $samount * $sqty;
                $lamount = $samount * $sqty;

                if ($taxed) {
                    $c_tax = $taxed[$i];
                } else {
                    $c_tax = 'No';
                }

                if ($c_tax == 'Yes') {
                    $taxed_amount += $lamount;
                } else {
                    $a_tax = 0.0;
                }

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

            $fTotal = $fTotal - $actual_discount;

            $actual_taxed_amount = $taxed_amount - $actual_discount;

            if ($actual_taxed_amount > 0) {
                $taxval = ($actual_taxed_amount * $taxrate) / 100;
            }

            if ($taxed_type != 'individual' and $tax != '') {
                $taxval = ($fTotal * $taxrate) / 100;
            }

            $fTotal = $fTotal + $taxval;

            $today = date('Y-m-d');

            $vtoken = _raid(10);

            $d = ORM::for_table('sys_quotes')->find_one($iid);
            if ($d) {
                $d->subject = $subject;
                $d->stage = _post('stage');
                $d->validuntil = _post('edate');
                $d->userid = $cid;
                $d->account = $u['account'];
                $d->invoicenum = $invoicenum;
                $d->cn = $cn;
                $d->firstname = '';
                $d->lastname = '';
                $d->companyname = '';
                $d->email = '';
                $d->address1 = '';
                $d->address2 = '';
                $d->city = '';
                $d->state = '';
                $d->postcode = '';
                $d->country = '';
                $d->phonenumber = '';
                $d->currency = 1;
                $d->subtotal = $sTotal;
                $d->discount_type = $discount_type;
                $d->discount_value = $discount_value;
                $d->discount = $actual_discount;
                $d->taxname = $taxname;
                $d->taxrate = $taxrate;
                $d->tax1 = $taxval;
                $d->tax2 = '0.00';
                $d->total = $fTotal;
                $d->proposal = $proposal_text;
                $d->customernotes = $customer_notes;
                $d->adminnotes = '';
                $d->datecreated = $idate;
                $d->lastmodified = $today;
                $d->datesent = $today;
                $d->dateaccepted = $today;
                $d->vtoken = $vtoken;
                $d->save();

                $qid = $d->id();

                $description = $data['desc'];

                $i = '0';
                $x = ORM::for_table('sys_quoteitems')
                    ->where('qid', $iid)
                    ->delete_many();
                foreach ($description as $item) {
                    $samount = $a[$i];
                    /* @since v 2.0 */
                    $sqty = $qty[$i];
                    $sqty = Finance::amount_fix($sqty);
                    $samount = Finance::amount_fix($samount);

                    $ltotal = $samount * $sqty;

                    $d = ORM::for_table('sys_quoteitems')->create();

                    $d->qid = $qid;
                    $d->description = $item;

                    $d->qty = $sqty;
                    $d->amount = $samount;
                    $d->discount = '0.00';
                    $d->total = $ltotal;
                    //  $d->taxable = '0';

                    if ($taxed) {
                        if ($taxed[$i] == 'Yes') {
                            $d->taxable = '1';
                        } else {
                            $d->taxable = '0';
                        }
                    } else {
                        $d->taxable = '0';
                    }
                    $d->itemcode = '';
                    $d->save();
                    $i++;
                }

                echo $qid;
            } else {
                $msg .= 'Quote Not Found';
            }
        } else {
            echo $msg;
        }

        break;
    case 'delete':
        Event::trigger('quotes/delete/');
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
        Event::trigger('quotes/print/');
        $id = $routes['2'];
        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            //find all activity for this user
            $items = ORM::for_table('sys_invoiceitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();

            //find the user
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);

            require 'system/lib/invoices/render.php';
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'pdf':
        Event::trigger('quotes/pdf/');
        $id = $routes['2'];

        $d = ORM::for_table('sys_quotes')->find_one($id);
        if ($d) {
            $items = ORM::for_table('sys_quoteitems')
                ->where('qid', $id)
                ->order_by_asc('id')
                ->find_many();

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);

            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();

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
            $mpdf->SetWatermarkText($d['status']);
            $mpdf->showWatermarkText = true;
            $mpdf->watermark_font = $ib_w_font;
            $mpdf->watermarkTextAlpha = 0.1;
            $mpdf->SetDisplayMode('fullpage');

            if ($config['pdf_font'] == 'AdobeCJK') {
                $mpdf->useAdobeCJK = true;
                $mpdf->autoScriptToLang = true;
                $mpdf->autoLangToFont = true;
            }

            ob_start();

            require 'system/lib/invoices/q-x2.php';

            $html = ob_get_contents();

            ob_end_clean();

            $mpdf->WriteHTML($html);

            if (isset($routes['3']) and $routes['3'] == 'dl') {
                $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'D'); # D
            } else {
                $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'I'); # D
            }
        }

        break;

    case 'mark_draft':
        Event::trigger('quotes/mark_draft/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_quotes')->find_one($iid);
        if ($d) {
            $d->stage = 'Draft';
            $d->save();
        } else {
            _msglog('e', 'Invoice not found');
        }
        break;

    case 'mark_delivered':
        Event::trigger('quotes/mark_delivered/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_quotes')->find_one($iid);
        if ($d) {
            $d->stage = 'Delivered';
            $d->save();
        } else {
            _msglog('e', 'Invoice not found');
        }
        break;

    case 'mark_on_hold':
        Event::trigger('quotes/mark_on_hold/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_quotes')->find_one($iid);
        if ($d) {
            $d->stage = 'On Hold';
            $d->save();
        } else {
            _msglog('e', 'Invoice not found');
        }
        break;

    case 'mark_accepted':
        Event::trigger('quotes/mark_accepted/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_quotes')->find_one($iid);
        if ($d) {
            $d->stage = 'Accepted';
            $d->save();
        } else {
            _msglog('e', 'Invoice not found');
        }
        break;

    case 'mark_lost':
        Event::trigger('quotes/mark_lost/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_quotes')->find_one($iid);
        if ($d) {
            $d->stage = 'Lost';
            $d->save();
        } else {
            _msglog('e', 'Invoice not found');
        }
        break;

    case 'mark_dead':
        Event::trigger('quotes/mark_dead/');
        $iid = _post('iid');
        $d = ORM::for_table('sys_quotes')->find_one($iid);
        if ($d) {
            $d->stage = 'Dead';
            $d->save();
        } else {
            _msglog('e', 'Invoice not found');
        }
        break;

    case 'mail_invoice_':
        $sid = $routes['2'];
        $etpl = $routes['3'];

        $d = ORM::for_table('sys_quotes')->find_one($sid);

        if ($etpl == 'created') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Quote:Quote Created')
                ->find_one();
        } elseif ($etpl == 'reminder') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Invoice:Invoice Payment Reminder')
                ->find_one();
        } elseif ($etpl == 'overdue') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Invoice:Invoice Overdue Notice')
                ->find_one();
        } elseif ($etpl == 'confirm') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Invoice:Invoice Payment Confirmation')
                ->find_one();
        } elseif ($etpl == 'refund') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Invoice:Invoice Refund Confirmation')
                ->find_one();
        } else {
            $d = false;
            $e = false;
        }

        if ($d) {
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);

            $subject = new Template($e['subject']);
            $subject->set('business_name', $config['CompanyName']);
            $subject->set('quote_subject', $d['subject']);
            $subj = $subject->output();
            $message = new Template($e['message']);
            $message->set('contact_name', $a['account']);
            $message->set('business_name', $config['CompanyName']);
            $message->set(
                'quote_url',
                U . 'client/q/' . $d['id'] . '/token_' . $d['vtoken']
            );
            $message->set(
                'valid_until',
                date($config['df'], strtotime($d['validuntil']))
            );

            $message_o = $message->output();

            echo '
<div class="mx-auto" style="max-width: 650px;">
    <div class="panel mb-0 rounded-0">
    
    <div class="panel-hdr">
    <h3>' .
                $_L['Quote'] .
                ' #' .
                $d['id'] .
                '</h3>
</div>

<div class="panel-container">
<div class="panel-content">
<form class="form-horizontal" role="form" id="email_form" method="post">


<div class="form-group">
    <label for="subject" class="col-sm-2 control-label">' .
                $_L['To'] .
                '</label>
    <input type="text" id="toemail" name="toemail" class="form-control" value="' .
                $a['email'] .
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
                $a['account'] .
                '">
      <input type="hidden" id="i_cid" name="i_cid" value="' .
                $a['id'] .
                '">
      <input type="hidden" id="i_iid" name="i_iid" value="' .
                $d['id'] .
                '">
  </div>

<div class="form-group">
    <label for="attach_pdf">Attach PDF?</label>
    <div class="checkbox c-checkbox">
                          <label>
                            <input type="checkbox" name="attach_pdf" id="attach_pdf" value="Yes" checked>  quote_' .
                $sid .
                '.pdf
                          </label>
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
            exit('Quote Not Found');
        }

        break;

    case 'send_email':
        Event::trigger('quotes/send_email/');

        $msg = '';
        $email = _post('toemail');
        $cc = _post('ccemail');
        $bcc = _post('bccemail');
        $subject = _post('subject');
        $toname = _post('toname');
        $cid = _post('i_cid');
        $iid = _post('i_iid');

        $d = ORM::for_table('sys_quotes')->find_one($iid);

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
            Quote::pdf($iid, 'store');

            $attachment_path = 'storage/temp/' . $in . '.pdf';
            $attachment_file = $in . '.pdf';
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $msg .= 'Invalid Email <br>';
        }

        if (!filter_var($cc, FILTER_VALIDATE_EMAIL)) {
            $cc = '';
        }

        if (!filter_var($bcc, FILTER_VALIDATE_EMAIL)) {
            $bcc = '';
        }

        if ($subject == '') {
            $msg .= 'Subject is Required <br>';
        }

        if ($message == '') {
            $msg .= 'Message is Required <br>';
        }

        if ($msg == '') {
            $email_config = EmailConfig::first();

            if ($email_config) {
                if ($email_config->method == 'smtp') {
                    $transport = (new Swift_SmtpTransport(
                        $email_config->host,
                        $email_config->port,
                        $email_config->secure
                    ))
                        ->setUsername($email_config->username)
                        ->setPassword($email_config->password)
                        ->setStreamOptions([
                            'ssl' => [
                                'allow_self_signed' => true,
                                'verify_peer' => false,
                            ],
                        ]);
                } else {
                    $transport = new Swift_SendmailTransport(
                        '/usr/sbin/sendmail -bs'
                    );
                }

                $mailer = new Swift_Mailer($transport);

                $receiver = [];

                $receiver[] = [
                    $email => $toname,
                ];

                $message = (new Swift_Message($subject))
                    ->setFrom([$config['sysEmail'] => $config['CompanyName']])
                    ->setTo([$email => $toname])
                    ->setBody($message, 'text/html');

                if (!empty($cc)) {
                    $message->setCc([$cc]);
                }

                if (!empty($bcc)) {
                    $message->setBcc([$bcc]);
                }

                if ($attachment_path != '') {
                    $message->attach(
                        Swift_Attachment::fromPath($attachment_path)
                    );
                }

                if (isset($data['attach_file'])) {
                    $other_files = $data['attach_file'];

                    foreach ($other_files as $other_file) {
                        $file = Document::find($other_file);

                        if ($file) {
                            $message->attach(
                                Swift_Attachment::fromPath(
                                    'storage/docs/' . $file->file_path
                                )->setFilename(
                                    $file->title . '.' . $file->file_mime_type
                                )
                            );
                        }
                    }
                }

                $result = $mailer->send($message);
            }

            // Now check for

            echo $_L['Email Sent'];
        } else {
            echo '<div class="alert alert-danger fade in">' . $msg . '</div>';
        }

        break;

    case 'convert_invoice':
        Event::trigger('quotes/convert_invoice/');
        $iid = _post('iid');
        $q = ORM::for_table('sys_quotes')->find_one($iid);

        if ($q) {
            $cid = $q['userid'];
            $u = ORM::for_table('crm_accounts')->find_one($cid);

            $msg = '';
            if ($cid == '') {
                $msg .= $_L['select_a_contact'] . ' <br> ';
            }

            $notes = _post('notes');

            $today = date('Y-m-d');

            $idate = $today;
            $its = strtotime($idate);
            $duedate = $today;

            $dd = $today;

            $nd = $idate;
            $r = '0';

            if ($msg == '') {
                $invoicenum = $config['invoice_code_prefix'] ?? 'INV-';

                $vtoken = _raid(10);
                $ptoken = _raid(10);
                $d = ORM::for_table('sys_invoices')->create();
                $d->userid = $q['userid'];
                $d->account = $q['account'];
                $d->date = $idate;
                $d->duedate = $dd;
                $d->subtotal = $q['subtotal'];
                $d->discount_type = $q['discount_type'];
                $d->discount_value = $q['discount_value'];
                $d->discount = $q['discount'];
                $d->total = $q['total'];
                $d->tax = $q['tax1'];
                $d->taxname = $q['taxname'];
                $d->taxrate = $q['taxrate'];
                $d->vtoken = $vtoken;
                $d->ptoken = $ptoken;
                $d->status = 'Unpaid';
                $d->notes = '';
                $d->r = $r;
                $d->nd = $nd;
                $d->quote_id = $iid;
                $d->invoicenum = $invoicenum;
                $d->tax2 = '0.00';
                $d->taxrate2 = '0.00';
                $d->paymentmethod = '';
                $d->save();

                $invoiceid = $d->id();

                $taxed = '0';
                $i = '0';

                $items = ORM::for_table('sys_quoteitems')
                    ->where('qid', $iid)
                    ->order_by_asc('id')
                    ->find_many();

                foreach ($items as $item) {
                    $d = ORM::for_table('sys_invoiceitems')->create();
                    $d->invoiceid = $invoiceid;
                    $d->userid = $cid;
                    $d->description = $item['description'];
                    $d->qty = $item['qty'];
                    $d->amount = $item['amount'];
                    $d->total = $item['total'];

                    $d->taxed = '0';

                    $d->type = '';
                    $d->relid = '0';
                    $d->itemcode = '';
                    $d->taxamount = '0.00';
                    $d->duedate = date('Y-m-d');
                    $d->paymentmethod = '';
                    $d->notes = '';

                    $d->save();
                    $i++;
                }

                _msglog('s', $_L['Invoice Created']);

                echo $invoiceid;
            } else {
                echo $msg;
            }
        } else {
            _msglog('e', 'Invoice not found');
        }

        break;

    case 'sms_quote_':
        $sid = $routes['2'];
        $mtpl = $routes['3'];

        $sms = Quote::genSMS($sid, $mtpl);

        if ($sms) {
            $message = $sms['sms'];
            $to = $sms['to'];
        } else {
            $message = '';
            $to = '';
        }
        view('modal_sms_quote', [
            'message' => $message,
            'to' => $to,
            'quote_id' => $sid,
        ]);

        break;

    default:
        echo 'action not defined';
}
