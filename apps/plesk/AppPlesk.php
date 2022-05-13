<?php
class AppPlesk
{
    public function hostBillingServer($data)
    {
        if (
            !empty($data['selected_type']) &&
            $data['selected_type'] === 'plesk'
        ) {
            $data['input_require_for_this_server_type'] = [
                'host' => [
                    'label' => 'Host/IP Address',
                ],
                'username' => [
                    'label' => 'Username',
                ],
                'password' => [
                    'label' => 'Password',
                ],
            ];
        }
    }

    public function hostBillingServers($data)
    {
        $data['buttons_for_server_type']['plesk'] = [
            [
                'name' => 'List Clients',
                'link' => 'plesk/app/clients',
            ],
        ];
    }

    public function hostBillingOrder($data)
    {
        if ($data['server']->type === 'plesk') {
            $data['form_fields'] = [
                'domain' => [
                    'label' => 'Domain Name',
                ],
                'first_name' => [
                    'label' => 'First Name',
                ],
                'last_name' => [
                    'label' => 'Last Name',
                ],
                'email' => [
                    'label' => 'Email',
                ],
                'username' => [
                    'label' => 'Username',
                    'help_block' => 'Give a username of this hosting',
                ],
                'password' => [
                    'label' => 'Password',
                ],
                'plan' => [
                    'label' => 'Plan',
                    'help_block' => 'Plesk Plan',
                ],
            ];
        }
    }

    public function hostBillingOrderRunAutomationCreateAccount($data)
    {
        $server = $data['server'];

        if ($server->type !== 'plesk') {
            return;
        }

        $validation = $data['validation'];
        $automation_data = $data['data'];
        $order = $data['order'];

        $validator = $validation->make($automation_data, [
            'domain' => 'required|string|max:150',
            'username' => 'required|string|max:100',
            'plan' => 'required|string|max:150',
            'first_name' => 'required|string|max:100',
            'last_name' => 'required|string|max:100',
            'email' => 'required|string|max:100',
            'password' => 'required|string|max:100',
        ]);

        if ($validator->fails()) {
            $data['response'] = [
                'success' => false,
                'errors' => $validator->errors(),
            ];
            return;
        }

        $accounts = [];
        $errors = false;

        try {
            $response = (new Http())
                ->withOptions([
                    'verify' => false,
                ])
                ->withBasicAuth($server->username, $server->password)
                ->post('https://' . $server->host . ':8443/api/v2/clients', [
                    'name' =>
                        $automation_data['first_name'] .
                        ' ' .
                        $automation_data['last_name'],
                    'login' => $automation_data['username'],
                    'email' => $automation_data['email'],
                    'owner_login' => $server->username,
                    'password' => $automation_data['password'],
                    'type' => 'customer',
                ]);
        } catch (\Exception $exception) {
            abort(500, $exception->getMessage());
        }
        $account = $response->json();
        try {
            $response = (new Http())
                ->withOptions([
                    'verify' => false,
                ])
                ->withBasicAuth($server->username, $server->password)
                ->post('https://' . $server->host . ':8443/api/v2/domains', [
                    'name' => $automation_data['domain'],
                    'type' => 'virtual',
                    'owner_client' => [
                        'id' => $account['id'] ?? 0,
                    ],
                    'plan' => [
                        'name' => $automation_data['plan'],
                    ],
                ]);
        } catch (\Exception $exception) {
            abort(500, $exception->getMessage());
        }

        jsonResponse([
            'success' => true,
        ]);
    }
}
