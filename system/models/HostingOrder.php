<?php
use Illuminate\Database\Eloquent\Model;

class HostingOrder extends Model
{
    public static function saveActivationData(
        $data,
        $send_email = false,
        $config = [],
        $_L = []
    ) {
        $order = HostingOrder::find($data['order_id']);
        if ($order) {
            $order->activation_subject = $data['activation_subject'] ?? null;
            $order->activation_message = $data['activation_message'] ?? null;
            $order->login_type = $data['login_type'] ?? null;
            $order->login_url = $data['login_url'] ?? null;
            $order->username = $data['username'] ?? null;
            $order->password = $data['password'] ?? null;
            $order->save();

            if ($send_email) {
                $contact = Contact::find($order->contact_id);
                if ($contact) {
                    Email::sendEmail(
                        $config,
                        $_L,
                        $contact->account,
                        $contact->email,
                        $data['activation_subject'],
                        $data['activation_message'],
                        $order->contact_id
                    );
                }
            }
        }
    }

    public static function validateActivationData($data, $language)
    {
        $validation = Validation::init($language);
        $validator = $validation->make($data, [
            'activation_subject' => 'nullable|string|max:150',
            'activation_message' => 'nullable|string|max:65000',
            'order_id' => 'required|integer',
        ]);
        return $validator;
    }

    public static function saveOrder($data)
    {
        $order = new self();
        $order->tracking_id = create_tracking_id();
        $order->type = $data['type'] ?? 'hosting';
        $order->status = $data['status'] ?? 'Pending';
        $order->contact_id = $data['contact_id'] ?? 0;
        $order->admin_id = $data['admin_id'] ?? 0;
        $order->plan_id = $data['plan_id'] ?? 0;
        $order->invoice_id = $data['invoice_id'] ?? 0;
        $order->domain = $data['domain'] ?? null;
        $order->domain_type = $data['domain_type'] ?? 'owned';
        $order->activation_subject = $data['activation_subject'] ?? '';
        $order->activation_message = $data['activation_message'] ?? '';
        $order->total = $data['total'] ?? 0;
        $order->date = $data['date'] ?? date('Y-m-d');
        $order->save();
        return $order;
    }

    public static function runAutomation($data, $language = 'en')
    {
        global $app;
        $validation = Validation::init($language);
        $validator = $validation->make($data, [
            'order_id' => 'required|integer',
            'action' => 'required|string|max:100',
        ]);

        if ($validator->fails()) {
            return [
                'success' => false,
                'errors' => $validator->errors(),
            ];
        }

        $order_id = (int) $data['order_id'];
        $order = self::find($order_id);

        if (!$order) {
            return [
                'success' => false,
                'errors' => [
                    'order' => 'Order not found.',
                ],
            ];
        }

        $plan_id = $order->plan_id;
        $plan = HostingPlan::find($plan_id);
        if (!$plan) {
            return [
                'success' => false,
                'errors' => [
                    'plan' => 'Plan not found!',
                ],
            ];
        }

        $server = HostingServer::find($plan->hosting_provider_id);

        if (!$server) {
            return [
                'success' => false,
                'errors' => [
                    'server' => 'Related server not found!',
                ],
            ];
        }

        switch ($data['action']) {
            case 'create_account':
                switch ($server->type) {
                    case 'cpanel':
                        $validator = $validation->make($data, [
                            'domain' => 'required|string|max:150',
                            'username' => 'required|string|max:8',
                            'password' => 'required|string|max:16',
                            'email' => 'required|email',
                            'plan' => 'required|string|max:150',
                        ]);

                        if ($validator->fails()) {
                            return [
                                'success' => false,
                                'errors' => $validator->errors(),
                            ];
                        }
                        # Documentation available in- https://documentation.cpanel.net/display/DD/WHM+API+1+Functions+-+createacct

                        $username = $data['username'];
                        $domain = $data['domain'];
                        $contactemail = $data['email'];
                        $password = $data['password'];
                        $plan = $data['plan'];

                        $api_call = HostBilling::cPanelApiCall(
                            $server,
                            'createacct',
                            [
                                'domain' => $domain,
                                'username' => $username,
                                'password' => $password,
                                'plan' => $plan,
                                'contactemail' => $contactemail,
                            ]
                        );

                        if (!$api_call['success']) {
                            return $api_call;
                        }

                        if (
                            isset(
                                $api_call['response']['metadata']['result']
                            ) &&
                            $api_call['response']['metadata']['result'] === 0
                        ) {
                            return [
                                'success' => false,
                                'errors' => [
                                    'api' =>
                                        $api_call['response']['metadata'][
                                            'reason'
                                        ] ?? 'API Call error',
                                ],
                            ];
                        }

                        $nameservers = [];

                        $order->automation_run = 1;
                        $order->domain = $data['domain'];
                        $order->username = $data['username'];
                        $order->password = $data['password'];
                        $order->login_type = 'cpanel';

                        if (!empty($server->host)) {
                            $order->login_url = $server->host . ':2083';
                        }

                        $order->automation_result =
                            $api_call['response']['metadata']['output'][
                                'raw'
                            ] ?? null;
                        $order->ip =
                            $api_call['response']['data']['ip'] ?? null;

                        if (
                            !empty($api_call['response']['data']['nameserver'])
                        ) {
                            $nameservers[] =
                                $api_call['response']['data']['nameserver'];
                        }
                        if (
                            !empty($api_call['response']['data']['nameserver2'])
                        ) {
                            $nameservers[] =
                                $api_call['response']['data']['nameserver2'];
                        }
                        if (
                            !empty($api_call['response']['data']['nameserver3'])
                        ) {
                            $nameservers[] =
                                $api_call['response']['data']['nameserver3'];
                        }

                        if (
                            !empty($api_call['response']['data']['nameserver4'])
                        ) {
                            $nameservers[] =
                                $api_call['response']['data']['nameserver4'];
                        }

                        $order->nameservers = \json_encode($nameservers);

                        $order->save();

                        return [
                            'success' => true,
                        ];

                        #Example Request: https://hostname.example.com:2087/cpsess##########/json-api/createacct?api.version=1&username=username&domain=example.com&bwlimit=unlimited&cgi=1&contactemail=username@example.com&cpmod=paper_lantern&customip=192.0.2.0&dkim=1&featurelist=feature_list&forcedns=0&frontpage=0&gid=123456789&hasshell=0&hasuseregns=1&homedir=/home/user&ip=n&language=en&owner=root&mailbox_format=mdbox&max_defer_fail_percentage=unlimited&max_email_per_hour=unlimited&max_emailacct_quota=1024&maxaddon=unlimited&maxftp=unlimited&maxlst=unlimited&maxpark=unlimited&maxpop=unlimited&maxsql=unlimited&maxsub=unlimited&mxcheck=auto&password=123456luggage&pkgname=my_new_package&plan=default

                        break;

                    case 'directadmin':
                        $validator = $validation->make($data, [
                            'domain' => 'required|string|max:150',
                            'username' => 'required|string|max:8',
                            'password' => 'required|string|max:16',
                            'email' => 'required|email',
                            'plan' => 'required|string|max:150',
                            'ip' => 'required|ipv4',
                        ]);

                        if ($validator->fails()) {
                            return [
                                'success' => false,
                                'errors' => $validator->errors(),
                            ];
                        }

                        $http = new Http();

                        $response = $http
                            ->withOptions([
                                'verify' => false,
                            ])
                            ->withBasicAuth(
                                $server->username,
                                $server->password
                            )
                            ->get(
                                'http://' .
                                    $server->host .
                                    ':2222/CMD_API_ACCOUNT_USER',
                                [
                                    'action' => 'create',
                                    'add' => 'Submit',
                                    'username' => $data['username'],
                                    'email' => $data['email'],
                                    'passwd' => $data['password'],
                                    'passwd2' => $data['password'],
                                    'domain' => $data['domain'],
                                    'package' => $data['plan'],
                                    'notify' => 'no',
                                    'ip' => $data['ip'],
                                ]
                            );

                        $result = $response->body();
                        $output = [];
                        parse_str($result, $output);

                        if (!empty($output['error']) && $output['error'] == 1) {
                            return [
                                'success' => false,
                                'errors' => [
                                    'api' => [
                                        ($output['text'] ?? '') .
                                        ' ' .
                                        ($output['details'] ??
                                            'API connection error.'),
                                    ],
                                ],
                            ];
                        }

                        return [
                            'success' => true,
                        ];

                        break;

                    default:
                        $response = [];
                        $app->emit(
                            'hostbilling_order_run_automation_create_account',
                            [
                                [
                                    'data' => &$data,
                                    'order' => &$order,
                                    'server' => &$server,
                                    'response' => &$response,
                                    'validation' => &$validation,
                                ],
                            ]
                        );

                        return $response;
                        break;
                }

                break;
        }

        return [
            'success' => false,
            'errors' => [
                'unknown' => 'An unknown error occurred.',
            ],
        ];
    }
}
