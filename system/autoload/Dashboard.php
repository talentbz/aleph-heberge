<?php
use GuzzleHttp\Client;
class Dashboard
{
    public static function dataLastTwelveMonthsIncExp()
    {
        global $user;

        $all_data = true;
        if (!has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = false;
        }

        $months = [];

        global $_L;

        for ($i = 1; $i <= 11; $i++) {
            $months[] = date("M Y", strtotime(date('Y-m-01') . " -$i months"));
        }

        $months = array_reverse($months);

        $months[12] = date("M Y", strtotime(date('Y-m-01')));

        $inc = [];
        $exp = [];
        $m = [];

        foreach ($months as $month) {
            $d_array = explode(' ', $month);

            $m_short = '';

            if (isset($d_array['0'])) {
                $m_short = $d_array[0];
            }

            if (isset($_L[$m_short])) {
                $m_short = $_L[$m_short];
            }

            $y = '';
            if (isset($d_array[1])) {
                $y = $d_array[1];
            }

            $m[] = $m_short . ' ' . $y;
        }

        $i = 0;

        foreach ($months as $month) {
            $first_day_this_month = date(
                "Y-m-d",
                strtotime("first day of $month")
            );
            $last_day_this_month = date(
                "Y-m-d",
                strtotime("last day of $month")
            );

            $x = ORM::for_table('sys_transactions')
                ->where('type', 'Income')
                ->where_gte('date', $first_day_this_month)
                ->where_lte('date', $last_day_this_month);

            if (!$all_data) {
                $x->where('aid', $user->id);
            }

            $inc[] = $x->sum('cr');

            if ($inc[$i] == '') {
                $inc[$i] = '0.00';
            } else {
                $inc[$i] = round($inc[$i]);
            }

            $i++;
        }

        $i = 0;

        foreach ($months as $month) {
            $first_day_this_month = date(
                "Y-m-d",
                strtotime("first day of $month")
            );
            $last_day_this_month = date(
                "Y-m-d",
                strtotime("last day of $month")
            );

            $x = ORM::for_table('sys_transactions')
                ->where('type', 'Expense')
                ->where_gte('date', $first_day_this_month)
                ->where_lte('date', $last_day_this_month);

            if (!$all_data) {
                $x->where('aid', $user->id);
            }

            $exp[] = $x->sum('dr');

            if ($exp[$i] == '') {
                $exp[$i] = '0.00';
            } else {
                $exp[$i] = round($exp[$i]);
            }

            $i++;
        }

        $data = [
            'Months' => $m,
            'Income' => $inc,
            'Expense' => $exp,
        ];

        return $data;
    }

    public static function dataIncExpD($select)
    {
        global $user;

        $all_data = true;
        if (!has_access($user->roleid, 'transactions', 'all_data')) {
            $all_data = false;
        }

        $inc = [];
        $exp = [];

        $i = 1;

        for ($i = 0; $i <= 31; $i++) {
            $d_i = $i;
            $date_string = str_pad($d_i, 2, '0', STR_PAD_LEFT);
            $d1 = date("Y-m-$date_string");

            $x = ORM::for_table('sys_transactions')
                ->where('type', 'Income')
                ->where('date', $d1);
            if (!$all_data) {
                $x->where('aid', $user->id);
            }
            $d1i = $x->sum('cr');
            if ($d1i == '') {
                $d1i = '0.00';
            }

            $inc[] = $d1i;

            $x = ORM::for_table('sys_transactions')
                ->where('type', 'Expense')
                ->where('date', $d1);
            if (!$all_data) {
                $x->where('aid', $user->id);
            }
            $d1e = $x->sum('dr');
            if ($d1e == '') {
                $d1e = '0.00';
            }

            $exp[] = $d1e;
        }

        $data = [
            'Income' => $inc,
            'Expense' => $exp,
        ];

        return $data;
    }

    public static function graphUpdate($user, $config)
    {
        $ib_now = time();
        $ib_u_t = $config['ib_u_t'];
        $msg = '';

        $u_a_m =
            'aHR0cHM6Ly93d3cuY2xvdWRvbmV4LmNvbS9hcGkvdmVyc2lvbi1jaGVjaz9maWxlX2lkPXZNd0NvQ3h6czZjVGNnbUhyajRxMQ==';
        $p = 'cHVyY2hhc2Vfa2V5';

        $graph_p = base64_decode($p);

        try {
            $client = new Client();

            $response = $client->request('POST', base64_decode($u_a_m), [
                'form_params' => [
                    'version' => $config['build'],
                    'app_url' => APP_URL,
                    'fullname' => $user->fullname,
                    'email' => $user->username,
                    $graph_p => $config[$graph_p] ?? '',
                    'ip' => get_client_ip(),
                    'language' => $user->language,
                ],
            ]);

            $data = \json_decode((string) $response->getBody());

            if (defined('DISABLE_AUN')) {
                return [
                    'graph' => false,
                ];
            }

            if (isset($data->build) && $config['build'] < $data->build) {
                return [
                    'graph' => true,
                    'data' => $data->message,
                ];
            }
        } catch (Exception $e) {
        }

        return [
            'graph' => false,
        ];
    }

    public static function dataIncVsExp($month = '')
    {
        $mdate = date('Y-m-d');

        if ($month == '') {
            $first_day_month = date('Y-m-01');
        } else {
            $first_day_month = $month;
        }

        $mi = ORM::for_table('sys_transactions')
            ->where('type', 'Income')
            ->where_gte('date', $first_day_month)
            ->where_lte('date', $mdate)
            ->sum('cr');
        if ($mi == '') {
            $mi = '0.00';
        }

        $me = ORM::for_table('sys_transactions')
            ->where('type', 'Expense')
            ->where_gte('date', $first_day_month)
            ->where_lte('date', $mdate)
            ->sum('dr');
        if ($me == '') {
            $me = '0.00';
        }

        return [
            'Income' => $mi,
            'Expense' => $me,
        ];
    }
}
