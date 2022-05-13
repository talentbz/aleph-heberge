<?php

use chillerlan\QRCode\QRCode;
use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{
    protected $table = 'sys_invoices';

    public static function createInvoice($data)
    {
        global $config;

        $datetime = date("Y-m-d H:i:s");

        $today = date('Y-m-d');

        $discount_type = 'f';
        $discount_value = '0.00';

        $actual_discount = '0.00';

        $taxval = '0.00';

        $taxname = '';

        $taxrate = '0.00';

        $notes = '';

        $invoicenum = '';

        $r = '0';
        $nd = $today;

        $currency = 0;
        $currency_symbol = $config['currency_code'];
        $currency_rate = 1.0;

        $u = ORM::for_table('crm_accounts')->find_one($data['contact_id']);

        $cid = $data['contact_id'];

        if (!$u) {
            return false;
        }

        $ticket_id = 0;

        if (isset($data['ticket_id'])) {
            $ticket_id = $data['ticket_id'];
        }

        $title = '';

        if (isset($data['title'])) {
            $title = $data['title'];
        }

        $cn = '';

        if (isset($data['cn'])) {
            $cn = $data['cn'];
        }

        $receipt_number = '';
        if (isset($data['receipt_number'])) {
            $receipt_number = $data['receipt_number'];
        }

        $fTotal = 0.0;

        $idate = $today;
        $its = strtotime($idate);

        if (isset($config['invoice_default_date'])) {
            $duedate = $config['invoice_default_date'];

            if ($duedate == 'due_on_receipt') {
                $dd = $today;
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
                $dd = $today;
            }
        }

        $vtoken = _raid(10);
        $ptoken = _raid(10);
        $d = ORM::for_table('sys_invoices')->create();
        $d->userid = $cid;
        $d->account = $u->account;
        $d->date = $today;
        $d->duedate = $dd;
        $d->datepaid = $datetime;
        $d->subtotal = $fTotal;
        $d->discount_type = $discount_type;
        $d->discount_value = $discount_value;
        $d->discount = $actual_discount;
        $d->total = $fTotal;
        $d->tax = $taxval;
        $d->taxname = $taxname;
        $d->taxrate = $taxrate;
        $d->vtoken = $vtoken;
        $d->ptoken = $ptoken;
        $d->status = 'Unpaid';
        $d->notes = $notes;
        $d->r = $r;
        $d->nd = $nd;

        $d->invoicenum = $invoicenum;
        $d->cn = $cn;
        $d->tax2 = '0.00';
        $d->taxrate2 = '0.00';
        $d->paymentmethod = '';

        $d->currency = $currency;
        $d->currency_symbol = $currency_symbol;
        $d->currency_rate = $currency_rate;

        $d->ticket_id = $ticket_id;

        $d->title = $title;

        $d->receipt_number = $receipt_number;

        $d->save();
        $invoiceid = $d->id();

        $current_items = $data['items'];

        foreach ($current_items as $e_i) {
            $d = ORM::for_table('sys_invoiceitems')->create();
            $d->invoiceid = $invoiceid;
            $d->userid = $cid;
            $d->description = $e_i['name'];
            $d->qty = $e_i['qty'];
            $d->amount = $e_i['price'];
            $d->total = $e_i['price'] * $e_i['qty'];

            $d->taxed = '0';

            //others
            $d->type = '';
            $d->relid = '0';
            $d->itemcode = '';
            $d->taxamount = '0.00';
            $d->duedate = date('Y-m-d');
            $d->paymentmethod = '';
            $d->notes = '';

            $d->save();
        }

        return $invoiceid;
    }

    private static function getInvoiceNumberFromInvoice($next_invoice)
    {
        $invoice_number = '';
        if (!empty($next_invoice->invoicenum)) {
            $invoice_number .= $next_invoice->invoicenum;
        }
        $invoice_number .= $next_invoice->cn ?? $next_invoice->id;

        return $invoice_number;
    }

    public function scopePaid($query)
    {
        return $query->where('status', '=', 'Paid');
    }

    public function scopeUnpaid($query)
    {
        return $query->where('status', '=', 'Unpaid');
    }

    public static function gen_email(
        $iid,
        $etpl,
        $config = false,
        $invoice = false
    ) {
        if (!$config) {
            global $config;
        }

        if (!$invoice) {
            $invoice = Invoice::find($iid);
        }

        if ($etpl === 'created') {
            $template_name = 'Invoice:Invoice Created';
        } elseif ($etpl === 'reminder') {
            $template_name = 'Invoice:Invoice Payment Reminder';
        } elseif ($etpl === 'overdue') {
            $template_name = 'Invoice:Invoice Overdue Notice';
        } elseif ($etpl === 'confirm') {
            $template_name = 'Invoice:Invoice Payment Confirmation';
        } elseif ($etpl === 'refund') {
            $template_name = 'Invoice:Invoice Refund Confirmation';
        } else {
            $invoice = false;
        }

        if ($invoice) {
            $client = Contact::find($invoice->userid);

            $email_template = EmailTemplate::where(
                'tplname',
                $template_name
            )->first();

            if ($email_template && $client) {
                if ($invoice->cn != '') {
                    $dispid = $invoice->cn;
                } else {
                    $dispid = $invoice->id;
                }
                $invoice_num = $invoice->invoicenum . $dispid;
                $total = $invoice->total;
                $credit = $invoice->credit;
                $due_amount = $total - $credit;
                $tax = $invoice->tax;
                $taxrate = $invoice->taxrate;
                $subtotal = $invoice->subtotal;
                $subject = new Template($email_template->subject);
                $subject->set('business_name', $config['CompanyName']);
                $subject->set('invoice_id', $invoice_num);
                $subj = $subject->output();
                $message = new Template($email_template->message);
                $message->set('name', $client->account);
                $message->set('customer_name', $client->account);
                $message->set('client_name', $client->account);
                $message->set('company', $client->company);
                $message->set('business_name', $config['CompanyName']);
                $message->set(
                    'invoice_url',
                    BASE_URL .
                        'client/iview/' .
                        $invoice->id .
                        '/token_' .
                        $invoice->vtoken
                );
                $message->set('invoice_id', $invoice_num);
                $message->set('invoice_status', $invoice->status);
                $message->set(
                    'invoice_amount_paid',
                    number_format(
                        $credit,
                        2,
                        $config['dec_point'],
                        $config['thousands_sep']
                    )
                );
                $message->set(
                    'invoice_due_amount',
                    number_format(
                        $due_amount,
                        2,
                        $config['dec_point'],
                        $config['thousands_sep']
                    )
                );
                $message->set('invoice_taxname', $invoice->taxname);
                $message->set(
                    'invoice_tax_amount',
                    number_format(
                        $tax,
                        2,
                        $config['dec_point'],
                        $config['thousands_sep']
                    )
                );
                $message->set(
                    'invoice_tax_rate',
                    number_format(
                        $taxrate,
                        2,
                        $config['dec_point'],
                        $config['thousands_sep']
                    )
                );
                $message->set(
                    'invoice_subtotal',
                    number_format(
                        $subtotal,
                        2,
                        $config['dec_point'],
                        $config['thousands_sep']
                    )
                );
                $message->set(
                    'invoice_due_date',
                    date($config['df'], strtotime($invoice->duedate))
                );
                $message->set(
                    'invoice_date',
                    date($config['df'], strtotime($invoice->date))
                );
                $message->set(
                    'invoice_amount',
                    number_format(
                        $total,
                        2,
                        $config['dec_point'],
                        $config['thousands_sep']
                    )
                );
                $message_o = $message->output();

                $gen = [];

                $gen['cid'] = $client->id;
                $gen['name'] = $client->account;
                $gen['email'] = $client->email;
                $gen['subject'] = $subj;
                $gen['body'] = $message_o;

                return $gen;
            }
        } else {
            return false;
        }
    }

    public static function pdf($id, $r_type = '', $token = '')
    {
        global $app, $config, $_L, $pdf_tpl, $extraHtml;

        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            if ($token != '') {
                $token = str_replace('token_', '', $token);
                $vtoken = $d->vtoken;
                if ($token != $vtoken) {
                    echo 'Sorry Token does not match!';
                    exit();
                }
            }

            $items = ORM::for_table('sys_invoiceitems')
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

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $i_credit = $d['credit'];
            $i_due = 0.0;
            $i_total = $d['total'];
            if ($d['credit'] != '0.00') {
                $i_due = $i_total - $i_credit;
            } else {
                $i_due = $d['total'];
            }

            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();

            $quote = false;

            if ($d->quote_id != '0') {
                $quote = ORM::for_table('sys_quotes')->find_one($d->quote_id);
            }

            if ($d['cn'] != '') {
                $dispid = $d['cn'];
            } else {
                $dispid = $d['id'];
            }

            $in = $d['invoicenum'] . $dispid;

            if ($a->cid != '' || $a->cid != 0) {
                $company = Company::find($a->cid);
            } else {
                $company = false;
            }

            $pdf_c = '';
            $ib_w_font = 'dejavusanscondensed';
            if ($config['pdf_font'] == 'default') {
                $pdf_c = 'c';
                $ib_w_font = 'Helvetica';
            }

            try {
                $mpdf = new \Mpdf\Mpdf();
                $mpdf->SetTitle($config['CompanyName'] . ' Invoice');
                $mpdf->SetAuthor($config['CompanyName']);
                $mpdf->SetWatermarkText(__($d['status']));

                if ($config['invoice_show_watermark'] == 1) {
                    $mpdf->showWatermarkText = true;
                    $mpdf->watermark_font = $ib_w_font;
                    $mpdf->watermarkTextAlpha = 0.1;
                }

                $mpdf->SetDisplayMode('fullpage');

                if ($config['rtl'] == 1) {
                    $mpdf->SetDirectionality('rtl');
                }

                if ($config['pdf_font'] == 'AdobeCJK') {
                    $mpdf->useAdobeCJK = true;
                    $mpdf->autoScriptToLang = true;
                    $mpdf->autoLangToFont = true;

                    if (
                        isset($config['pdf_watermark_font']) &&
                        file_exists(
                            'vendor/mpdf/mpdf/ttfonts/' .
                                $config['pdf_watermark_font']
                        )
                    ) {
                        $mpdf->watermark_font = $config['pdf_watermark_font'];
                    }
                }

                $invoice_append_footer = '';
                global $invoice_append_footer;

                $app->emit('client_invoice_printable', [&$d, &$a]);

                $creating_pdf = true;
                $pdf_tpl = __DIR__ . '/../lib/invoices/render.php';

                if (file_exists(__DIR__ . '/../overrides/invoice_pdf.php')) {
                    $pdf_tpl = __DIR__ . '/../overrides/invoice_pdf.php';
                }

                $format_currency_override = [];

                if (isset($config['decimal_places_products_and_services'])) {
                    $format_currency_override['precision'] =
                        $config['decimal_places_products_and_services'];
                }

                $invoice_url =
                    U . 'client/iview/' . $d->id . '/token_' . $d->vtoken;

                $qr_code = (new QRCode())->render($invoice_url);

                ob_start();
                require $pdf_tpl;
                $html = ob_get_contents();
                ob_end_clean();
                $mpdf->WriteHTML($html);
                if ($r_type == 'dl') {
                    $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'D'); # D
                } elseif ($r_type == 'inline') {
                    $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'I'); # D
                } elseif ($r_type == 'store') {
                    $mpdf->Output(
                        __DIR__ .
                            '/../../storage/temp/' .
                            __('Invoice') .
                            '_' .
                            $in .
                            '.pdf',
                        'F'
                    ); # D
                } else {
                    $mpdf->Output(date('Y-m-d') . _raid(4) . '.pdf', 'I'); # D
                }
            } catch (\Exception $e) {
                dd(
                    'An error occurred, probably related to your server! : ',
                    $e->getMessage(),
                    "\n"
                );
            }
        }
    }

    public static function forSingleItem(
        $cid,
        $item,
        $amount,
        $is_credit_invoice = '0'
    ) {
        global $config;

        $datetime = date("Y-m-d H:i:s");

        $today = date('Y-m-d');

        $discount_type = 'f';
        $discount_value = '0.00';

        $actual_discount = '0.00';

        $fTotal = $amount;

        $taxval = '0.00';

        $taxname = '';

        $taxrate = '0.00';

        $notes = '';

        $invoicenum = $config['invoice_code_prefix'];

        $r = '0';
        $nd = $today;

        $cn = str_pad(
            $config['invoice_code_current_number'],
            $config['number_pad'],
            '0',
            STR_PAD_LEFT
        );

        $currency = 0;
        $currency_symbol = $config['currency_code'];
        $currency_rate = 1.0;

        $u = ORM::for_table('crm_accounts')->find_one($cid);

        if (!$u) {
            return false;
        }

        $vtoken = _raid(10);
        $ptoken = _raid(10);
        $d = ORM::for_table('sys_invoices')->create();
        $d->userid = $cid;
        $d->account = $u->account;
        $d->date = $today;
        $d->duedate = $today;
        $d->datepaid = $datetime;
        $d->subtotal = $amount;
        $d->discount_type = $discount_type;
        $d->discount_value = $discount_value;
        $d->discount = $actual_discount;
        $d->total = $fTotal;
        $d->tax = $taxval;
        $d->taxname = $taxname;
        $d->taxrate = $taxrate;
        $d->vtoken = $vtoken;
        $d->ptoken = $ptoken;
        $d->status = 'Unpaid';
        $d->notes = $notes;
        $d->r = $r;
        $d->nd = $nd;
        $d->invoicenum = $invoicenum;
        $d->cn = $cn;
        $d->tax2 = '0.00';
        $d->taxrate2 = '0.00';
        $d->paymentmethod = '';

        $d->currency = $currency;
        $d->currency_symbol = $currency_symbol;
        $d->currency_rate = $currency_rate;

        $d->is_credit_invoice = $is_credit_invoice;

        $d->save();
        $invoiceid = $d->id();

        $sqty = 1;
        $samount = $amount;
        $ltotal = $amount;

        $d = ORM::for_table('sys_invoiceitems')->create();
        $d->invoiceid = $invoiceid;
        $d->userid = $cid;
        $d->description = $item;
        $d->qty = $sqty;
        $d->amount = $samount;
        $d->total = $ltotal;

        $d->taxed = '0';

        $d->type = '';
        $d->relid = '0';
        $d->itemcode = '';
        $d->taxamount = '0.00';
        $d->duedate = date('Y-m-d');
        $d->paymentmethod = '';
        $d->notes = '';

        $d->save();

        $invoice = [];
        $invoice['id'] = $invoiceid;
        $invoice['vtoken'] = $vtoken;

        update_option(
            'invoice_code_current_number',
            current_number_would_be($config['invoice_code_current_number'])
        );

        return $invoice;
    }

    public static function fromCart()
    {
        global $config;

        $datetime = date("Y-m-d H:i:s");

        $today = date('Y-m-d');

        $discount_type = 'f';
        $discount_value = '0.00';

        $actual_discount = '0.00';

        $taxval = '0.00';

        $taxname = '';

        $taxrate = '0.00';

        $notes = $config['invoice_terms'] ?? '';

        $invoicenum = $config['invoice_code_prefix'];

        $r = '0';
        $nd = $today;

        $cn = str_pad(
            $config['invoice_code_current_number'],
            $config['number_pad'],
            '0',
            STR_PAD_LEFT
        );

        $currency = 0;
        $currency_symbol = $config['currency_code'];
        $currency_rate = 1.0;

        if (isset($_COOKIE['ib_cart_secret'])) {
            $secret = $_COOKIE['ib_cart_secret'];

            $cart = ORM::for_table('sys_cart')
                ->where('secret', $secret)
                ->find_one();

            if ($cart) {
                $u = ORM::for_table('crm_accounts')->find_one($cart->cid);

                $cid = $cart->cid;

                if (!$u) {
                    return false;
                }

                $fTotal = $cart->total;

                $vtoken = _raid(10);
                $ptoken = _raid(10);
                $d = ORM::for_table('sys_invoices')->create();
                $d->userid = $cid;
                $d->account = $u->account;
                $d->date = $today;
                $d->duedate = $today;
                $d->datepaid = $datetime;
                $d->subtotal = $fTotal;
                $d->discount_type = $discount_type;
                $d->discount_value = $discount_value;
                $d->discount = $actual_discount;
                $d->total = $fTotal;
                $d->tax = $taxval;
                $d->taxname = $taxname;
                $d->taxrate = $taxrate;
                $d->vtoken = $vtoken;
                $d->ptoken = $ptoken;
                $d->status = 'Unpaid';
                $d->notes = $notes;
                $d->r = $r;
                $d->nd = $nd;
                //others
                $d->invoicenum = $invoicenum;
                $d->cn = $cn;
                $d->tax2 = '0.00';
                $d->taxrate2 = '0.00';
                $d->paymentmethod = '';

                $d->currency = $currency;
                $d->currency_symbol = $currency_symbol;
                $d->currency_rate = $currency_rate;

                $d->save();
                $invoiceid = $d->id();

                update_option(
                    'invoice_code_current_number',
                    current_number_would_be(
                        $config['invoice_code_current_number']
                    )
                );

                $current_items = $cart->items;
                $current_items_d = json_decode($current_items, true);

                foreach ($current_items_d as $e_i) {
                    $item_obj = Item::find($e_i['id']);

                    $d = ORM::for_table('sys_invoiceitems')->create();
                    $d->invoiceid = $invoiceid;
                    $d->userid = $cid;
                    $d->description = $e_i['name'];
                    $d->qty = $e_i['qty'];
                    $d->amount = $e_i['price'];
                    $d->total = $e_i['price'] * $e_i['qty'];

                    $d->taxed = '0';
                    $d->tax_code = $item_obj->tax_code ?? '';
                    $d->type = '';
                    $d->relid = '0';
                    $d->itemcode = '';
                    $d->taxamount = '0.00';
                    $d->duedate = date('Y-m-d');
                    $d->paymentmethod = '';
                    $d->notes = '';

                    $d->save();
                }

                $cart->delete();

                return $invoiceid;
            }
        }

        return false;
    }

    public static function files($invoice_id)
    {
        $file_ids = ORM::for_table('ib_doc_rel')
            ->where('rtype', 'invoice')
            ->where('rid', $invoice_id)
            ->find_array();

        $ids = [];

        foreach ($file_ids as $f) {
            $ids[] = $f['did'];
        }

        if (!empty($ids)) {
            $d = ORM::for_table('sys_documents')
                ->where_in('id', $ids)
                ->find_many();
        } else {
            $d = [];
        }

        return $d;
    }

    public static function cloneInvoice($id)
    {
        global $config;
        $inv = ORM::for_table('sys_invoices')->find_one($id);

        if ($inv) {
            $vtoken = _raid(10);
            $ptoken = _raid(10);
            $d = ORM::for_table('sys_invoices')->create();
            $d->userid = $inv->userid;
            $d->account = $inv->account;
            $d->date = $inv->date;
            $d->duedate = $inv->duedate;
            $d->datepaid = $inv->datepaid;
            $d->subtotal = $inv->subtotal;
            $d->discount_type = $inv->discount_type;
            $d->discount_value = $inv->discount_value;
            $d->discount = $inv->discount;
            $d->total = $inv->total;
            $d->tax = $inv->tax;
            $d->taxname = $inv->taxname;
            $d->taxrate = $inv->taxrate;
            $d->vtoken = $vtoken;
            $d->ptoken = $ptoken;
            $d->status = 'Unpaid';
            $d->notes = $inv->notes;
            $d->r = $inv->r;
            $d->nd = $inv->nd;

            $d->invoicenum = $inv->invoicenum;

            $cn = str_pad(
                $config['invoice_code_current_number'],
                $config['number_pad'],
                '0',
                STR_PAD_LEFT
            );

            $d->cn = $cn;

            update_option(
                'invoice_code_current_number',
                current_number_would_be($cn)
            );

            $d->tax2 = $inv->tax2;
            $d->taxrate2 = $inv->taxrate2;
            $d->paymentmethod = $inv->paymentmethod;

            $d->currency = $inv->currency;
            $d->currency_symbol = $inv->currency_symbol;
            $d->currency_rate = $inv->currency_rate;
            $d->save();
            $invoiceid = $d->id();

            $items = ORM::for_table('sys_invoiceitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_array();
            foreach ($items as $item) {
                $t = ORM::for_table('sys_invoiceitems')->create();
                $t->invoiceid = $invoiceid;
                $t->userid = $item['userid'];
                $t->description = $item['description'];
                $t->qty = $item['qty'];
                $t->amount = $item['amount'];
                $t->total = $item['total'];
                $t->taxed = $item['taxed'];
                $t->type = '';
                $t->relid = '0';
                $t->itemcode = '';
                $t->taxamount = '0.00';
                $t->duedate = date('Y-m-d');
                $t->paymentmethod = '';
                $t->notes = '';
                $t->save();
            }

            return $invoiceid;
        }

        return false;
    }

    public static function genSMS($invoiceID, $tpl)
    {
        global $config;

        $invoice = self::find($invoiceID);

        if (!$invoice) {
            return false;
        }

        $customer = Contact::find($invoice->userid);

        if (!$customer) {
            return false;
        }

        switch ($tpl) {
            case 'created':
                $tpl = SMSTemplate::where('tpl', 'Invoice Created')->first();

                break;

            case 'reminder':
                $tpl = SMSTemplate::where(
                    'tpl',
                    'Invoice Payment Reminder'
                )->first();

                break;

            case 'refund':
                $tpl = SMSTemplate::where(
                    'tpl',
                    'Invoice Refund Confirmation'
                )->first();

                break;

            case 'overdue':
                $tpl = SMSTemplate::where(
                    'tpl',
                    'Invoice Overdue Notice'
                )->first();

                break;

            case 'confirm':
                $tpl = SMSTemplate::where(
                    'tpl',
                    'Invoice Payment Confirmation'
                )->first();

                break;

            default:
                $tpl = false;

                break;
        }

        if ($invoice->cn != '') {
            $dispid = $invoice->cn;
        } else {
            $dispid = $invoice->id;
        }
        $invoice_num = $invoice->invoicenum . $dispid;

        $total = $invoice->total;
        $credit = $invoice->credit;
        $due_amount = $total - $credit;
        $tax = $invoice->tax;
        $taxrate = $invoice->taxrate;
        $subtotal = $invoice->subtotal;

        if ($invoice && $tpl) {
            $message = new Template($tpl->sms);

            $message->set('name', $customer->account);
            $message->set('customer_name', $customer->account);
            $message->set('client_name', $customer->account);
            $message->set('company', $customer->company);
            $message->set('business_name', $config['CompanyName']);
            $message->set(
                'invoice_url',
                U .
                    'client/iview/' .
                    $invoice->id .
                    '/token_' .
                    $invoice->vtoken
            );
            $message->set(
                'invoice_pdf_url',
                U . 'client/ipdf/' . $invoice->id . '/token_' . $invoice->vtoken
            );
            $message->set('invoice_id', $invoice_num);
            $message->set('invoice_status', $invoice->status);
            $message->set(
                'invoice_amount_paid',
                number_format(
                    $credit,
                    2,
                    $config['dec_point'],
                    $config['thousands_sep']
                )
            );
            $message->set(
                'invoice_due_amount',
                number_format(
                    $due_amount,
                    2,
                    $config['dec_point'],
                    $config['thousands_sep']
                )
            );
            $message->set('invoice_taxname', $invoice->taxname);
            $message->set(
                'invoice_tax_amount',
                number_format(
                    $tax,
                    2,
                    $config['dec_point'],
                    $config['thousands_sep']
                )
            );
            $message->set(
                'invoice_tax_rate',
                number_format(
                    $taxrate,
                    2,
                    $config['dec_point'],
                    $config['thousands_sep']
                )
            );
            $message->set(
                'invoice_subtotal',
                number_format(
                    $subtotal,
                    2,
                    $config['dec_point'],
                    $config['thousands_sep']
                )
            );
            $message->set(
                'invoice_due_date',
                date($config['df'], strtotime($invoice->duedate))
            );
            $message->set(
                'invoice_date',
                date($config['df'], strtotime($invoice->date))
            );
            $message->set(
                'invoice_amount',
                number_format(
                    $total,
                    2,
                    $config['dec_point'],
                    $config['thousands_sep']
                )
            );
            $message_o = $message->output();

            return [
                'to' => $customer->phone,
                'sms' => $message_o,
            ];
        } else {
            return false;
        }
    }

    public static function fromTicket($ticket_id, $extras)
    {
        $ticket = Ticket::find($ticket_id);

        if (!$ticket) {
            return [
                'success' => false,
                'error' => 'Ticket not found',
            ];
        }

        $invoice_exist = Invoice::where('ticket_id', $ticket_id)->first();

        if ($invoice_exist) {
            return [
                'success' => false,
                'error' => 'Invoice already exist for this ticket.',
            ];
        }

        $tasks = Task::where('rel_type', 'Ticket')
            ->where('rel_id', $ticket_id)
            ->get();

        $replies = TicketReply::where('tid', $ticket->id)
            ->orderBy('id', 'desc')
            ->first();

        $items = [];

        $reply = TicketReply::where('tid', $ticket->id)
            ->orderBy('id', 'desc')
            ->first();

        $qty = 1;

        $ttotal = $ticket->ttotal;

        if ($ttotal != '') {
            $ttotal = explode(':', $ttotal);

            if (isset($ttotal[0])) {
                $hour = $ttotal[0];
            }

            if (isset($ttotal[1])) {
                $minute = $ttotal[1];
                $minute = round($minute / 60, 2);
            }

            $qty = $hour + $minute;
        }

        $price = 0.0;

        $ticket_admin_id = $ticket->aid;

        if ($ticket_admin_id != '' || $ticket_admin_id != '0') {
            $ticket_admin = User::find($ticket_admin_id);
        }

        if ($reply) {
            $items[] = [
                'name' => $reply->message,
                'qty' => $qty,
                'price' => $price,
            ];
        }

        $receipt_number = '';

        if (isset($extras['receipt_number'])) {
            $receipt_number = $extras['receipt_number'];
        }

        $invoice = self::createInvoice([
            'contact_id' => $ticket->userid,
            'ticket_id' => $ticket_id,
            'cn' => $ticket->tid,
            'items' => $items,
            'receipt_number' => $receipt_number,
        ]);

        if ($invoice) {
            $ticket->status = 'Closed';
            $ticket->save();
            return [
                'success' => true,
                'invoice' => $invoice,
            ];
        }

        return [
            'success' => false,
            'error' => 'An error occurred',
        ];
    }

    public static function getInvoicesSummaryForCustomer($customer_id)
    {
        $total_invoice_amount = 0.0;
        $total_paid_amount = 0.0;
        $total_unpaid_amount = 0.0;
        $total_cancelled_amount = 0.0;
        $total_partially_paid_amount = 0.0;

        $invoices = Invoice::where('userid', $customer_id)->get();

        $currencies = Currency::all()
            ->keyBy('cname')
            ->toArray();

        $home_currency = homeCurrency();

        foreach ($invoices as $invoice) {
            if ($invoice->currency_iso_code != $home_currency->cname) {
                $rate = 1;
                if (isset($currencies[$invoice->currency_iso_code])) {
                    $rate = $currencies[$invoice->currency_iso_code]['rate'];
                }
            } else {
                $rate = 1;
            }

            $invoice_total = $invoice->total;
            $total_invoice_amount += $invoice_total * $rate;

            if ($invoice->status == 'Unpaid') {
                $total_unpaid_amount += $invoice_total * $rate;
            } elseif ($invoice->status == 'Paid') {
                $total_paid_amount += $invoice_total * $rate;
            } elseif ($invoice->status == 'Partially Paid') {
                $credit = $invoice->credit;
                $invoice_total = $invoice_total * $rate;
                $invoice_due = $invoice_total - $credit;
                $total_paid_amount += $credit;
                $total_unpaid_amount += $invoice_due;
                $total_partially_paid_amount += $credit;
            } elseif ($invoice->status == 'Cancelled') {
                $total_cancelled_amount += $invoice_total * $rate;
            }
        }

        return [
            'invoices' => $invoices,
            'total_invoiced_amount' => $total_invoice_amount,
            'total_paid_amount' => $total_paid_amount,
            'total_unpaid_amount' => $total_unpaid_amount,
            'total_partially_paid_amount' => $total_partially_paid_amount,
            'total_cancelled_amount' => $total_cancelled_amount,
        ];
    }

    public static function getInvoiceNumberById($id)
    {
        $invoice = Invoice::find($id);
        if ($invoice) {
            $ret_value = '';
            if ($invoice->invoicenum) {
                $ret_value .= $invoice->invoicenum;
            }
            if ($invoice->cn) {
                $ret_value .= $invoice->cn;
            }
            if (!empty($ret_value)) {
                return $ret_value;
            }
        }
        return $id;
    }

    public static function generateRecurringInvoices($settings, $_L)
    {
        $today = date('Y-m-d');

        $invoices_should_create_today = self::where('r', '!=', 0)
            ->where('nd', $today)
            ->get();

        foreach ($invoices_should_create_today as $previous_invoice) {
            $next_invoice_custom_number = str_pad(
                $settings['invoice_code_current_number'],
                $settings['number_pad'],
                '0',
                STR_PAD_LEFT
            );

            $previous_invoice_r = $previous_invoice->r;
            $previous_invoice_due_date_timestamp = strtotime(
                $previous_invoice->duedate
            );

            $next_invoice_date = $today;
            $next_invoice_due_date = $today;

            $previous_invoice_date = $previous_invoice->date;
            $previous_invoice_due_date = $previous_invoice->due_date;

            if ($previous_invoice_date && $previous_invoice_due_date) {
                $previous_invoice_date_obj = new DateTime(
                    $previous_invoice_date
                );
                $previous_invoice_due_date_obj = new DateTime(
                    $previous_invoice_due_date
                );
                $payment_terms = $previous_invoice_due_date_obj->diff(
                    $previous_invoice_date_obj
                );

                if ($payment_terms->days) {
                    $interval = $payment_terms->days;
                    $next_invoice_due_date = date(
                        'Y-m-d',
                        strtotime('+' . $interval)
                    );
                }
            }
            #nd = next date
            $next_invoice_nd = date('Y-m-d', strtotime($previous_invoice_r));

            $next_invoice = new self();
            $next_invoice->userid = $previous_invoice->userid;
            $next_invoice->account = $previous_invoice->account;
            $next_invoice->date = $next_invoice_date;
            $next_invoice->duedate = $next_invoice_due_date;
            $next_invoice->subtotal = $previous_invoice->subtotal;
            $next_invoice->total = $previous_invoice->total;
            $next_invoice->tax = $previous_invoice->tax;
            $next_invoice->taxname = $previous_invoice->taxname;
            $next_invoice->taxrate = $previous_invoice->taxrate;
            $next_invoice->vtoken = _raid(10);
            $next_invoice->ptoken = _raid(10);
            $next_invoice->status = 'Unpaid';
            $next_invoice->notes = $previous_invoice->notes;
            $next_invoice->currency_iso_code =
                $previous_invoice->currency_iso_code;
            $next_invoice->is_same_state = $previous_invoice->is_same_state;
            $next_invoice->r = $previous_invoice->r;
            $next_invoice->nd = $next_invoice_nd;
            $next_invoice->invoicenum = $settings['invoice_code_prefix'] ?? '';
            $next_invoice->cn = $next_invoice_custom_number;
            $next_invoice->tax2 = $previous_invoice->tax2;
            $next_invoice->taxrate2 = $previous_invoice->taxrate2;
            $next_invoice->paymentmethod = $previous_invoice->paymentmethod;
            $next_invoice->save();

            $previous_invoice->r = 0;
            $previous_invoice->save();

            update_option(
                'invoice_code_current_number',
                current_number_would_be($next_invoice_custom_number)
            );

            $previous_invoice_items = InvoiceItem::where(
                'invoiceid',
                $previous_invoice->id
            )
                ->orderBy('id', 'asc')
                ->get();

            foreach ($previous_invoice_items as $previous_invoice_item) {
                $new_invoice_item = new InvoiceItem();
                $new_invoice_item->invoiceid = $next_invoice->id;
                $new_invoice_item->userid = $previous_invoice_item->userid;
                $new_invoice_item->description =
                    $previous_invoice_item->description;
                $new_invoice_item->qty = $previous_invoice_item->qty;
                $new_invoice_item->amount = $previous_invoice_item->amount;
                $new_invoice_item->total = $previous_invoice_item->total;
                $new_invoice_item->itemcode = $previous_invoice_item->itemcode;
                $new_invoice_item->notes = $previous_invoice_item->notes;
                $new_invoice_item->paymentmethod =
                    $previous_invoice_item->paymentmethod;
                $new_invoice_item->relid = 0;
                $new_invoice_item->type = '';
                $new_invoice_item->taxed = $previous_invoice_item->taxed;
                $new_invoice_item->save();
            }

            $msg = Invoice::gen_email(
                $next_invoice->id,
                'created',
                $settings,
                $next_invoice
            );
            $subject = $msg['subject'];
            $body = $msg['body'];
            $email = $msg['email'];
            $name = $msg['name'];

            Invoice::pdf($next_invoice->id, 'store');
            $invoice_number = self::getInvoiceNumberFromInvoice($next_invoice);
            $attachment_path =
                'storage/temp/' .
                __('Invoice') .
                '_' .
                $invoice_number .
                '.pdf';
            $attachment_file = __('Invoice') . '_' . $invoice_number . '.pdf';

            Email::sendEmail(
                $settings,
                $_L,
                $name,
                $email,
                $subject,
                $body,
                0,
                $next_invoice->id,
                '',
                '',
                $attachment_path,
                $attachment_file
            );
        }
    }

    public static function sendPaymentReminder($settings, $_L)
    {
        $from = date('Y-m-d', strtotime('-3 days'));
        $to = date('Y-m-d', strtotime('-1 days'));
        $invoices = Invoice::where('status', 'Unpaid')
            ->whereBetween('duedate', [$from, $to])
            ->get();

        foreach ($invoices as $invoice) {
            $msg = Invoice::gen_email(
                $invoice->id,
                'reminder',
                $settings,
                $invoice
            );
            $subject = $msg['subject'];
            $body = $msg['body'];
            $email = $msg['email'];
            $name = $msg['name'];

            Email::sendEmail(
                $settings,
                $_L,
                $name,
                $email,
                $subject,
                $body,
                0,
                $invoice->id
            );
        }
    }

    public static function saveInvoice($data)
    {
        global $config;
        $total = 0;
        $tax = 0.0;
        $taxname = '';
        $tax2 = 0.0;
        $taxrate = 0.0;
        $taxrate2 = 0.0;
        $paymentmethod = '';
        $notes = $data['notes'] ?? '';
        $next_invoice_custom_number = str_pad(
            get_option('invoice_code_current_number'),
            $config['number_pad'],
            '0',
            STR_PAD_LEFT
        );

        $today = date('Y-m-d');

        foreach ($data['invoice_items'] as $item) {
            $line_total = $item['amount'] * $item['quantity'];
            $total += $line_total;
        }

        $invoice = new self();
        $invoice->userid = $data['contact']->id;
        $invoice->account = $data['contact']->account;
        $invoice->date = $today;
        $invoice->duedate = $data['due_date'] ?? $today;
        $invoice->subtotal = $total;
        $invoice->total = $total;
        $invoice->tax = $tax;
        $invoice->taxname = $taxname;
        $invoice->taxrate = $taxrate;
        $invoice->vtoken = _raid(10);
        $invoice->ptoken = _raid(10);
        $invoice->status = 'Unpaid';
        $invoice->notes = $notes;
        $invoice->currency_iso_code = $config['home_currency'];

        $invoice->invoicenum = $config['invoice_code_prefix'] ?? '';
        $invoice->cn = $next_invoice_custom_number;
        $invoice->tax2 = $tax2;
        $invoice->taxrate2 = $taxrate2;
        $invoice->paymentmethod = $paymentmethod;
        $invoice->save();

        foreach ($data['invoice_items'] as $item) {
            $line_total = $item['amount'] * $item['quantity'];
            $invoice_item = new InvoiceItem();
            $invoice_item->invoiceid = $invoice->id;
            $invoice_item->userid = $data['contact']->id;
            $invoice_item->relid = 0;
            $invoice_item->itemcode = '';
            $invoice_item->type = '';
            $invoice_item->taxed = 1;
            $invoice_item->description = $item['name'];
            $invoice_item->amount = $item['amount'];
            $invoice_item->total = $line_total;
            $invoice_item->qty = $item['quantity'];
            $invoice_item->paymentmethod = '';
            $invoice_item->notes = '';
            $invoice_item->save();
        }

        $invoice_code_current_number =
            (int) $config['invoice_code_current_number'];
        update_option(
            'invoice_code_current_number',
            $invoice_code_current_number + 1
        );

        return $invoice;
    }
}
