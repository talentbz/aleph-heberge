<?php

use Illuminate\Database\Eloquent\Model;

class Quote extends Model
{
    protected $table = 'sys_quotes';

    public static function gen_email($iid, $etpl)
    {
        global $config;

        $sid = $iid;

        $d = ORM::for_table('sys_quotes')->find_one($sid);

        if ($etpl == 'created') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Quote:Quote Created')
                ->find_one();
        } elseif ($etpl == 'accepted') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Quote:Quote Accepted')
                ->find_one();
        } elseif ($etpl == 'cancelled') {
            $e = ORM::for_table('sys_email_templates')
                ->where('tplname', 'Quote:Quote Cancelled')
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

            $gen = [];

            $gen['cid'] = $a['id'];
            $gen['name'] = $a['account'];
            $gen['email'] = $a['email'];
            $gen['subject'] = $subj;
            $gen['body'] = $message_o;

            return $gen;
        }

        return false;
    }

    public static function pdf($id, $r_type = '', $token = '')
    {
        global $config, $_L;

        $d = ORM::for_table('sys_quotes')->find_one($id);
        if ($d) {
            if ($token != '') {
                $token = str_replace('token_', '', $token);
                $vtoken = $d->vtoken;
                if ($token != $vtoken) {
                    echo 'Sorry Token does not match!';
                    exit();
                }
            }

            $items = ORM::for_table('sys_quoteitems')
                ->where('qid', $id)
                ->order_by_asc('id')
                ->find_array();

            $trs_c = ORM::for_table('sys_quoteitems')
                ->where('qid', $id)
                ->count();

            $trs = ORM::for_table('sys_transactions')
                ->where('iid', $id)
                ->order_by_desc('id')
                ->find_array();

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

            $pdf_c = '';
            $ib_w_font = 'dejavusanscondensed';
            if ($config['pdf_font'] == 'default') {
                $pdf_c = 'c';
                $ib_w_font = 'Helvetica';
            }

            $mpdf = new \Mpdf\Mpdf();

            $mpdf->SetProtection(['print']);
            $mpdf->SetTitle($config['CompanyName'] . ' Invoice');
            $mpdf->SetAuthor($config['CompanyName']);
            $mpdf->SetWatermarkText(ib_lan_get_line($d['status']));
            $mpdf->showWatermarkText = true;
            $mpdf->watermark_font = $ib_w_font;
            $mpdf->watermarkTextAlpha = 0.1;
            $mpdf->SetDisplayMode('fullpage');

            if ($config['rtl'] == 1) {
                $mpdf->SetDirectionality('rtl');
            }

            if ($config['pdf_font'] == 'AdobeCJK') {
                $mpdf->useAdobeCJK = true;
                $mpdf->autoScriptToLang = true;
                $mpdf->autoLangToFont = true;
            }

            Event::trigger('quotes/before_pdf_render/');

            ob_start();

            require 'system/lib/invoices/q-x2.php';

            $html = ob_get_contents();

            ob_end_clean();

            $mpdf->WriteHTML($html);

            $name =
                'storage/temp/' .
                $_L['Quote'] .
                '-' .
                $d->id .
                '-' .
                date('Y-m-d') .
                '-' .
                _raid(4) .
                '.pdf';
            // $name = $in;

            if ($r_type == 'dl') {
                $mpdf->Output($name, 'D'); # D
            } elseif ($r_type == 'inline') {
                $mpdf->Output($name, 'I'); # D
            } elseif ($r_type == 'store') {
                $mpdf->Output('storage/temp/' . $in . '.pdf', 'F'); # D
            } else {
                $mpdf->Output($name, 'I'); # D
            }
        }
    }

    public static function genSMS($quoteID, $tpl)
    {
        global $config;

        $invoice = ORM::for_table('sys_quotes')->find_one($quoteID);

        if (!$invoice) {
            return false;
        }

        $customer = Contact::find($invoice->userid);

        if (!$customer) {
            return false;
        }

        switch ($tpl) {
            case 'accepted':
                $tpl = SMSTemplate::where('tpl', 'Quote Accepted')->first();

                break;

            case 'cancelled':
                $tpl = SMSTemplate::where('tpl', 'Quote Cancelled')->first();

                break;

            case 'created':
                $tpl = SMSTemplate::where('tpl', 'Quote Created')->first();

                break;

            case 'confirm':
                $tpl = SMSTemplate::where(
                    'tpl',
                    'Invoice Payment Confirmation'
                )->first();

                break;

            case 'cancelled_admin_notify':
                $tpl = SMSTemplate::where(
                    'tpl',
                    'Quote Cancelled: Admin Notification'
                )->first();

                break;

            case 'accepted_admin_notify':
                $tpl = SMSTemplate::where(
                    'tpl',
                    'Quote Accepted: Admin Notification'
                )->first();

                break;

            default:
                $tpl = false;

                break;
        }

        if ($invoice && $tpl) {
            $message = new Template($tpl->sms);

            $message->set('name', $customer->account);
            $message->set('customer_name', $customer->account);
            $message->set('client_name', $customer->account);
            $message->set('company', $customer->company);
            $message->set('business_name', $config['CompanyName']);
            $message->set(
                'quote_url',
                U . 'client/q/' . $invoice->id . '/token_' . $invoice->vtoken
            );

            $message->set('quote_id', $invoice->id);

            $message_o = $message->output();

            return [
                'to' => $customer->phone,
                'sms' => $message_o,
            ];
        } else {
            return false;
        }
    }
}
