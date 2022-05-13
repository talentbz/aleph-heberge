<?php
use Illuminate\Database\Eloquent\Model;

class Email extends Model
{
    protected $table = 'sys_email_logs';
    public $timestamps = false;

    public static function _log($userid, $email, $subject, $message, $iid = '0')
    {
        $date = date('Y-m-d H:i:s');
        $d = ORM::for_table('sys_email_logs')->create();
        $d->userid = $userid;
        $d->sender = '';
        $d->email = $email;
        $d->subject = $subject;
        $d->message = $message;
        $d->date = $date;
        $d->iid = $iid;
        $d->save();
        $id = $d->id();
        return $id;
    }

    public static function sendEmail(
        $config,
        $_L,
        $name,
        $to,
        $subject,
        $message,
        $userid = '0',
        $iid = '0',
        $cc = '',
        $bcc = '',
        $attachment_path = '',
        $attachment_file = ''
    ) {
        $message = str_replace(
            BASE_URL . 'settings/email-templates/',
            '',
            $message
        );

        if (APP_STAGE == 'Demo') {
            return true;
        }

        $email_log = new self();
        $email_log->userid = $userid;
        $email_log->sender = '';
        $email_log->email = $to;
        $email_log->subject = $subject;
        $email_log->message = $message;
        $email_log->date = date('Y-m-d H:i:s');
        $email_log->iid = $iid;
        $email_log->save();

        $email_config = EmailConfig::first();

        $method = $email_config->method;

        switch ($method) {
            case 'smtp':
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
                break;
            case 'sparkpost':
                return;
                break;
            case 'mailgun':
                $mg = \Mailgun\Mailgun::create($config['mailgun_api_key']);

                if ($attachment_path != '') {
                    $mg->messages()->send($config['mailgun_domain'], [
                        'from' => $config['sysEmail'],
                        'to' => $to,
                        'subject' => $subject,
                        'html' => $message,
                        'attachment' => [
                            [
                                'filePath' => $attachment_path,
                                'filename' => $attachment_file,
                            ],
                        ],
                    ]);
                } else {
                    $mg->messages()->send($config['mailgun_domain'], [
                        'from' => $config['sysEmail'],
                        'to' => $to,
                        'subject' => $subject,
                        'html' => $message,
                    ]);
                }
                break;
            default:
                $transport = new Swift_SendmailTransport(
                    '/usr/sbin/sendmail -bs'
                );
                break;
        }

        $mailer = new Swift_Mailer($transport);

        $message = (new Swift_Message($subject))
            ->setFrom([
                $config['sysEmail'] => $config['CompanyName'],
            ])
            ->setTo([$to => $name])
            ->setBody($message, 'text/html');

        if (!empty($cc)) {
            $message->setCc([$cc]);
        }

        if (!empty($bcc)) {
            $message->setBcc([$bcc]);
        }

        if ($attachment_path != '') {
            $message->attach(Swift_Attachment::fromPath($attachment_path));
        }

        $mailer->send($message);
    }

    public static function send_client_welcome_email(
        $data,
        $send_password = false
    ) {
        $e = ORM::for_table('sys_email_templates')
            ->where('tplname', 'Client:Client Signup Email')
            ->find_one();

        if (!isset($data['account']) || !isset($data['email'])) {
            return false;
        }

        if ($e) {
            if ($e->send === 'No') {
                return false;
            }
            global $config;

            $subject = new Template($e['subject']);
            $subject->set('business_name', $config['CompanyName']);
            $subj = $subject->output();

            $message = new Template($e['message']);
            $message->set('client_name', $data['account']);
            $message->set('client_email', $data['email']);

            if ($send_password) {
                $message->set('client_password', $data['password']);
            } else {
                $message->set('client_password', '---Encrypted---');
            }

            $message->set('business_name', $config['CompanyName']);
            $message->set('client_login_url', U . 'client/login/');
            $message_o = $message->output();

            if (APP_STAGE === 'Demo') {
                return false;
            } else {
                if (isset($data['id'])) {
                    $cid = $data['id'];
                } else {
                    $cid = '0';
                }

                Email::sendEmail(
                    $config,
                    [],
                    $data['account'],
                    $data['email'],
                    $subj,
                    $message_o
                );

                return true;
            }
        }

        return false;
    }
}
