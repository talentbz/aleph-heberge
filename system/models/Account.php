<?php
use Illuminate\Database\Eloquent\Model;

class Account extends Model
{
    protected $table = 'sys_accounts';

    public static function getBalance($account_id, $currency_id)
    {
        $balance = Balance::where('account_id', $account_id)
            ->where('currency_id', $currency_id)
            ->first();

        if ($balance) {
            return $balance->balance;
        }

        return '0.00';
    }

    public static function getAllAccounts()
    {
        return Account::all();
    }

    public static function createSnapshot(
        $settings,
        $_L = [],
        $send_email = false
    ) {
        $msg = '';
        $last_day = date('Y-m-d', strtotime('Yesterday'));
        $msg .= 'Accounting Snapshot - Date: ' . $last_day . '<br>';
        $last_day_income = Transaction::where('date', $last_day)
            ->where('type', 'Income')
            ->sum('amount');
        if ($last_day_income === '') {
            $last_day_income = '0.00';
        }

        $msg .=
            'Total Income: ' .
            formatCurrencyNonGlobalConfig(
                $settings,
                $last_day_income,
                $settings['home_currency']
            ) .
            '<br>';

        $last_day_expense = Transaction::where('date', $last_day)
            ->where('type', 'Expense')
            ->sum('amount');
        if ($last_day_expense === '') {
            $last_day_expense = '0.00';
        }

        $msg .=
            'Total Expense: ' .
            formatCurrencyNonGlobalConfig(
                $settings,
                $last_day_expense,
                $settings['home_currency']
            ) .
            '<br>';

        if ($send_email) {
            if (!empty($settings['global_notifications_email'])) {
                Email::sendEmail(
                    $settings,
                    $_L,
                    $settings['CompanyName'],
                    $settings['global_notifications_email'],
                    'Accounting Snapshot',
                    $msg
                );
            }
        }

        return [
            'success' => true,
            'message' => $msg,
        ];
    }
}
