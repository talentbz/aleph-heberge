<?php
class Repeating
{
    public static function _validate($f, $n)
    {
        return true;
    }

    public static function generate_date($date, $next)
    {
    }

    public static function confirm($id)
    {
        $d = ORM::for_table('sys_repeating')->find_one($id);
        if ($d) {
            $date = date('Y-m-d');
            $type = $d['type'];
            $amount = $d['amount'];
            $account = $d['account'];

            $a = ORM::for_table('sys_accounts')
                ->where('account', $d['account'])
                ->find_one();
            $cbal = $a['balance'];
            if ($type == 'Income') {
                $nbal = $cbal + $amount;
                $cr = $amount;
                $dr = 0.0;
            } else {
                $nbal = $cbal - $amount;
                $dr = $amount;
                $cr = 0.0;
            }

            $a->balance = $nbal;
            $a->save();
            $t = ORM::for_table('sys_transactions')->create();
            $t->account = $account;
            $t->type = $type;
            $t->payee = $d['payee'];
            $t->amount = $amount;
            $t->category = $d['category'];
            $t->method = $d['method'];
            $t->ref = $d['ref'];

            $t->description = $d['description'];
            $t->date = $date;
            $t->dr = $dr;
            $t->cr = $cr;
            $t->bal = $nbal;
            $t->save();
            $d->pdate = $date;
            $d->status = 'Cleared';
            $d->save();
            return true;
        }

        return false;
    }

    public static function partial($id, $amount)
    {
        $d = ORM::for_table('sys_repeating')->find_one($id);
        if ($d) {
            $actual_amount = $d['amount'];
            if ($actual_amount == $amount) {
                self::confirm($id);
            }
            if ($actual_amount < $amount) {
                return false;
            }
            if (!is_numeric($amount)) {
                return false;
            }
            if ($amount < 0) {
                return false;
            }
            $date = date('Y-m-d');
            $type = $d['type'];
            $namount = $actual_amount - $amount;
            $account = $d['account'];

            $a = ORM::for_table('sys_accounts')
                ->where('account', $d['account'])
                ->find_one();
            $cbal = $a['balance'];
            if ($type == 'Income') {
                $nbal = $cbal + $amount;
                $cr = $amount;
                $dr = 0.0;
            } else {
                $nbal = $cbal - $amount;
                $dr = $amount;
                $cr = 0.0;
            }

            $a->balance = $nbal;
            $a->save();
            $t = ORM::for_table('sys_transactions')->create();
            $t->account = $account;
            $t->type = $type;
            $t->payee = $d['payee'];
            $t->amount = $amount;
            $t->category = $d['category'];
            $t->method = $d['method'];
            $t->ref = $d['ref'];

            $t->description = $d['description'];
            $t->date = $date;
            $t->dr = $dr;
            $t->cr = $cr;
            $t->bal = $nbal;
            $t->save();
            //update the amount
            $d->amount = $namount;

            $d->save();
            return true;
        } else {
            return false;
        }
    }

    public static function mark_paid($id)
    {
        $d = ORM::for_table('sys_repeating')->find_one($id);
        if ($d) {
            $date = date('Y-m-d');

            $d->pdate = $date;
            $d->status = 'Cleared';
            $d->save();
            return true;
        }

        return false;
    }

    public static function delete_single($id)
    {
        $d = ORM::for_table('sys_repeating')->find_one($id);
        if ($d) {
            $d->delete();
            return true;
        }

        return false;
    }

    public static function delete_multiple($id)
    {
        $d = ORM::for_table('sys_repeating')->find_one($id);

        if ($d) {
            $description = $d['description'];
            ORM::for_table('sys_repeating')
                ->where('description', $description)
                ->delete_many();
            return true;
        } else {
            return false;
        }
    }
}
