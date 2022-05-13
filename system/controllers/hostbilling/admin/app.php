<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}
_auth();
$user = User::_info();
$ui->assign('user', $user);
$ui->assign('selected_navigation', 'dashboard');

$action = route(1);
switch ($request_method) {
    case 'GET':
        switch ($action) {
            case 'update-schema':
                HostBilling::runMigrations();
                redirect_to('dashboard');
                break;
            case 'domain-pricing':
                $domain_prices = DomainPrice::all();

                $domain_registration_providers = DomainRegistrationProvider::all();

                $selected_domain_price = false;
                $id = route(2, 0);
                if ($id) {
                    $selected_domain_price = DomainPrice::find($id);
                }

                \view('hostbilling/admin/domain_pricing', [
                    'domain_prices' => $domain_prices,
                    'selected_navigation' => 'products_and_services',
                    'domain_registration_providers' => $domain_registration_providers,
                    'selected_domain_price' => $selected_domain_price,
                ]);

                break;

            case 'whois':
                \view('hostbilling/admin/whois', [
                    'selected_navigation' => 'products_and_services',
                ]);

                break;

            case 'whois-lookup':
                break;

            case 'hosting-plans':
            case 'services':
            case 'list-items-by-group':
                $type = 'hosting';
                if ($action === 'services') {
                    $type = 'service';
                }

                $hosting_plan = new HostingPlan();

                if ($action === 'list-items-by-group') {
                    $group_id = route(2);
                    $hosting_plan = $hosting_plan->where('group_id', $group_id);
                }

                if ($type === 'hosting') {
                    $hosting_plan = $hosting_plan->where('type', 'hosting');
                } elseif ($type === 'service') {
                    $hosting_plan = $hosting_plan->where('type', 'service');
                }

                $hosting_plan = $hosting_plan->limit(100)->get();

                \view('hostbilling/admin/hosting_plans', [
                    'selected_navigation' => 'products_and_services',
                    'hosting_plans' => $hosting_plan,
                    'type' => $type,
                ]);
                break;

            case 'hosting':
            case 'service':
                $id = route(2, false);
                $hosting_plan = false;
                if ($id) {
                    $hosting_plan = HostingPlan::find($id);
                }
                if ($hosting_plan && $hosting_plan->options) {
                    $options =  json_decode($hosting_plan->options);
                    $hosting_plan->linux = $options->linux;
                    $hosting_plan->dashboard = $options->dashboard;
                    $hosting_plan->data_center = $options->data_center;
                    $hosting_plan->managed_server = $options->managed_server;
                }
                $groups = HostingPlanGroup::all();
                $servers = HostingServer::all();
                \view('hostbilling/admin/hosting_plan', [
                    'hosting_plan' => $hosting_plan,
                    'type' => $action,
                    'groups' => $groups,
                    'selected_navigation' => 'products_and_services',
                    'servers' => $servers,
                ]);

                break;

            case 'groups':
                $groups = HostingPlanGroup::all();

                $selected_group = false;
                $id = route(2, false);
                if ($id) {
                    $selected_group = HostingPlanGroup::find($id);
                }

                \view('hostbilling/admin/groups', [
                    'groups' => $groups,
                    'selected_group' => $selected_group,
                    'selected_navigation' => 'products_and_services',
                ]);

                break;

            case 'delete-hosting-plan':
                $id = route(2, false);
                if ($id) {
                    $hosting_plan = HostingPlan::find($id);
                    if ($hosting_plan) {
                        $hosting_plan->delete();
                        redirect_to('hostbilling/hosting-plans', [
                            'success' => 'Deleted sucessfully.',
                        ]);
                    }
                }

                break;

            case 'delete-group':
                $id = route(2, false);
                if ($id) {
                    $group = HostingPlanGroup::find($id);
                    if ($group) {
                        $group->delete();
                        redirect_to('hostbilling/groups', [
                            'success' => 'Deleted sucessfully.',
                        ]);
                    }
                }

                break;

            case 'orders':
                $orders = HostingOrder::limit(500)
                    ->orderBy('id', 'desc')
                    ->get();

                $contacts = Contact::all()
                    ->keyBy('id')
                    ->all();

                $invoices = Invoice::all()
                    ->keyBy('id')
                    ->all();

                \view('hostbilling/admin/orders', [
                    'orders' => $orders,
                    'selected_navigation' => 'invoices',
                    'contacts' => $contacts,
                    'invoices' => $invoices,
                ]);

                break;

            case 'order':
                $id = route(2, false);
                $orders = HostingOrder::limit(500)
                    ->orderBy('id', 'desc')
                    ->get();

                $contact = false;

                if ($id) {
                    $order = HostingOrder::find($id);
                    if ($order) {
                        $server = false;
                        $plan = HostingPlan::find($order->plan_id);
                        if ($plan) {
                            if ($plan->hosting_provider_id) {
                                $server = HostingServer::find(
                                    $plan->hosting_provider_id
                                );
                            }
                        }
                        $contact = Contact::find($order->contact_id);

                        $name_array = explode(' ', $contact->account);

                        $contact = [
                            'name' => $contact->account,
                            'account' => $contact->account,
                            'first_name' => $name_array[0] ?? '',
                            'last_name' => $name_array[1] ?? '',
                            'email' => $contact->email,
                            'address' => $contact->address,
                            'city' => $contact->city,
                            'zip' => $contact->zip,
                            'state' => $contact->state,
                            'country' => $contact->country,
                        ];

                        $form_fields = [];

                        $app->emit('hostbilling_order', [
                            [
                                'server' => $server,
                                'form_fields' => &$form_fields,
                            ],
                        ]);

                        $hosting_servers = HostingServer::all();

                        $supported_server_types = HostingServer::getSupportedServerTypes();

                        \view('hostbilling/admin/order', [
                            'order' => $order,
                            'orders' => $orders,
                            'contact' => $contact,
                            'selected_navigation' => 'invoices',
                            'plan' => $plan,
                            'server' => $server,
                            'form_fields' => $form_fields,
                            'hosting_servers' => $hosting_servers,
                            'supported_server_types' => $supported_server_types,
                        ]);
                    }
                }

                break;

            case 'servers':
                $servers = HostingServer::all();
                $available_server_types = HostingServer::availableServertypes();

                $buttons_for_server_type = [];

                $app->emit('hostbilling_servers', [
                    [
                        'buttons_for_server_type' => &$buttons_for_server_type,
                        'servers' => &$servers,
                    ],
                ]);

                \view('hostbilling/admin/servers', [
                    'servers' => $servers,
                    'available_server_types' => $available_server_types,
                    'buttons_for_server_type' => $buttons_for_server_type,
                ]);

                break;

            case 'choose-server-type':
                $available_server_types = HostingServer::availableServertypes();

                \view('hostbilling/admin/choose_server_type', [
                    'available_server_types' => $available_server_types,
                ]);

                break;

            case 'server':
                $server = false;
                $available_server_types = HostingServer::availableServertypes();

                $id = route(2, false);

                if ($id) {
                    $server = HostingServer::find($id);
                    if (!$server) {
                        abort(404);
                    }
                }

                if (!$server) {
                    $selected_type = route(3);
                } else {
                    $selected_type = $server->type;
                }

                $input_require_for_this_server_type = [];

                $app->emit('hostbilling_server', [
                    [
                        'selected_type' => $selected_type,
                        'input_require_for_this_server_type' => &$input_require_for_this_server_type,
                    ],
                ]);

                \view('hostbilling/admin/server', [
                    'server' => $server,
                    'available_server_types' => $available_server_types,
                    'selected_type' => $selected_type,
                    'input_require_for_this_server_type' => $input_require_for_this_server_type,
                ]);

                break;

            case 'domain-order':
                $id = route(2, false);
                $domain_orders = DomainOrder::limit(500)
                    ->orderBy('id', 'desc')
                    ->get();
                $contacts = Contact::all()
                    ->keyBy('id')
                    ->all();

                if ($id) {
                    $domain_order = DomainOrder::find($id);
                    if ($domain_order) {
                        \view('hostbilling/admin/domain_order', [
                            'order' => $domain_order,
                            'domain_orders' => $domain_orders,
                            'contacts' => $contacts,
                        ]);
                    }
                }

                break;

            case 'domain-orders':
                $domain_orders = DomainOrder::orderBy('id', 'desc')
                    ->limit(500)
                    ->get();
                $contacts = Contact::all()
                    ->keyBy('id')
                    ->all();
                $invoices = Invoice::all()
                    ->keyBy('id')
                    ->all();

                \view('hostbilling/admin/domain_orders', [
                    'domain_orders' => $domain_orders,
                    'selected_navigation' => 'invoices',
                    'contacts' => $contacts,
                    'invoices' => $invoices,
                ]);

                break;

            case 'set-order-status':
                $id = (int) route(2);
                $set_status = route(3, false);
                $order = HostingOrder::find($id);
                if ($order && $set_status) {
                    switch ($set_status) {
                        case 'approve':
                            $order->status = 'Active';
                            break;
                        case 'cancel':
                            $order->status = 'Cancelled';
                            break;
                        case 'fraud':
                            $order->status = 'Fraud';
                            break;
                        case 'pending':
                            $order->status = 'Pending';
                            break;
                    }

                    $order->save();

                    redirect_to('hostbilling/order/' . $order->id);
                }

                break;

            case 'set-domain-order-status':
                $id = (int) route(2);
                $set_status = route(3, false);
                $order = DomainOrder::find($id);
                if ($order && $set_status) {
                    switch ($set_status) {
                        case 'approve':
                            $order->status = 'Active';
                            break;
                        case 'cancel':
                            $order->status = 'Cancelled';
                            break;
                        case 'fraud':
                            $order->status = 'Fraud';
                            break;
                        case 'pending':
                            $order->status = 'Pending';
                            break;
                    }

                    $order->save();

                    redirect_to('hostbilling/domain-order/' . $order->id);
                }
                break;

            case 'delete-order':
                $id = route(2, false);
                if ($id) {
                    $order = HostingOrder::find($id);
                    if ($order) {
                        $order->delete();
                    }
                }

                redirect_to('hostbilling/orders/');

                break;

            case 'delete-server':
                $id = route(2, false);
                if ($id) {
                    $server = HostingServer::find($id);
                    if ($server) {
                        $server->delete();
                    }
                }

                redirect_to('hostbilling/servers/');

                break;

            case 'delete-domain-order':
                $id = route(2, false);
                if ($id) {
                    $order = DomainOrder::find($id);
                    if ($order) {
                        $order->delete();
                    }
                }

                redirect_to('hostbilling/domain-orders/');
                break;

            case 'domain-registration-providers':
                $domain_registration_providers = DomainRegistrationProvider::all();

                \view('hostbilling/admin/domain_registration_providers', [
                    'domain_registration_providers' => $domain_registration_providers,
                    'selected_navigation' => 'products_and_services',
                ]);

                break;

            case 'choose-domain-registration-provider':
                $available_domain_registration_providers = DomainRegistrationProvider::availableProviders();

                \view('hostbilling/admin/choose_domain_registration_provider', [
                    'available_domain_registration_providers' => $available_domain_registration_providers,
                    'selected_navigation' => 'products_and_services',
                ]);

                break;

            case 'domain-registration-provider':
                $domain_registration_provider = false;
                $available_domain_registration_providers = DomainRegistrationProvider::availableProviders();

                $id = route(2, false);

                if ($id) {
                    $domain_registration_provider = DomainRegistrationProvider::find(
                        $id
                    );
                    if (!$domain_registration_provider) {
                        abort(404);
                    }
                }

                if (!$domain_registration_provider) {
                    $selected_type = route(3);
                } else {
                    $selected_type = $domain_registration_provider->type;
                }

                \view('hostbilling/admin/domain_registration_provider', [
                    'domain_registration_provider' => $domain_registration_provider,
                    'available_domain_registration_providers' => $available_domain_registration_providers,
                    'selected_type' => $selected_type,
                    'selected_navigation' => 'products_and_services',
                ]);

                break;

            case 'delete-domain-registration-provider':
                $id = (int) route(2);
                $domain_registration_provider = DomainRegistrationProvider::find(
                    $id
                );
                if ($domain_registration_provider) {
                    $domain_registration_provider->delete();
                }

                redirect_to('hostbilling/domain-registration-providers/');

                break;

            case 'delete-domain-pricing':
                $id = (int) route(2);

                if ($id) {
                    $domain_price = DomainPrice::find($id);
                    if ($domain_price) {
                        $domain_price->delete();
                    }
                }

                redirect_to('hostbilling/domain-pricing/');

                break;

            case 'run-migrations':
                HostBilling::runMigrations();
                redirect_to('dashboard');
                break;

            case 'server-list-accounts':
                $id = (int) route(2);

                if ($id) {
                    $server = HostingServer::find($id);

                    if ($server) {
                        $accounts = [];
                        $errors = false;
                        switch ($server->type) {
                            case 'cpanel':
                                $api_call = HostBilling::cPanelApiCall(
                                    $server,
                                    'listaccts'
                                );

                                if ($api_call['success']) {
                                    $accounts =
                                        $api_call['response']['data']['acct'];
                                } else {
                                    $errors = $api_call['errors'];
                                }

                                break;
                        }

                        \view('hostbilling/admin/server_list_accounts', [
                            'server' => $server,
                            'selected_navigation' => 'products_and_services',
                            'errors' => $errors,
                            'accounts' => $accounts,
                        ]);
                    }
                }
                break;

            default:
                abort(404);
        }

        break;

    case 'POST':
        switch ($action) {
            case 'hosting':
            case 'service':
                $data = $request->all();

                $validator = new Validator();

                $validation = $validator->validate($data, [
                    'id' => 'nullable|numeric',
                    'group_id' => 'required|numeric',
                    'name' => 'required|max:150',
                    'features' => 'nullable|array',
                    'hosting_provider_id' => 'nullable|integer'
                ]);

                if ($validation->fails()) {
                    $errors = $validation->errors();
                    responseWithError($errors->firstOfAll());
                } else {
                    $hosting_plan = false;

                    if (!empty($data['id'])) {
                        $hosting_plan = HostingPlan::find($data['id']);
                    }

                    if (!$hosting_plan) {
                        $hosting_plan = new HostingPlan();
                        $slug = Str::slug($data['name']);

                        if (
                            !$slug ||
                            HostingPlanGroup::where('slug', $slug)->first()
                        ) {
                            $slug = sp_uuid();
                        }

                        $hosting_plan->slug = $slug;
                    }

                    if (!empty($data['slug'])) {
                        $hosting_plan->slug = $data['slug'];
                    }

                    $hosting_plan->name = $data['name'];

                    $hosting_plan->group_id = $data['group_id'];

                    $type = 'hosting';
                    if ($action === 'service') {
                        $type = 'service';
                    }
                    $hosting_plan->type = $type;

                    $hosting_plan->description = $data['description'] ?? null;

                    $hosting_plan->one_time_fee = createFromCurrency(
                        $data['one_time_fee'] ?? 0,
                        $config['home_currency']
                    );

                    $hosting_plan->price_monthly = createFromCurrency(
                        $data['price_monthly'] ?? 0,
                        $config['home_currency']
                    );

                    $hosting_plan->price_quarterly = createFromCurrency(
                        $data['price_quarterly'] ?? 0,
                        $config['home_currency']
                    );

                    $hosting_plan->price_half_yearly = createFromCurrency(
                        $data['price_half_yearly'] ?? 0,
                        $config['home_currency']
                    );

                    $hosting_plan->price_yearly = createFromCurrency(
                        $data['price_yearly'] ?? 0,
                        $config['home_currency']
                    );

                    $hosting_plan->price_two_years = createFromCurrency(
                        $data['price_two_years'] ?? 0,
                        $config['home_currency']
                    );

                    $hosting_plan->price_three_years = createFromCurrency(
                        $data['price_three_years'] ?? 0,
                        $config['home_currency']
                    );

                    $hosting_plan->featured = sp_if_the_value_is_bollean(
                        $data,
                        'plan_is_featured'
                    );

                    $hosting_plan->allow_free_domain = sp_if_the_value_is_bollean(
                        $data,
                        'allow_free_domain'
                    );

                    $hosting_plan->require_domain_name = sp_if_the_value_is_bollean(
                        $data,
                        'require_domain_name'
                    );

                    if (!empty($data['features'])) {
                        $hosting_plan->features = sp_clean_and_create_line_json(
                            $data['features']
                        );
                    }

                    $hosting_plan->api_name = $data['api_name'] ?? null;

                    $hosting_provider_id = $data['hosting_provider_id'] ?? 0;
                    $hosting_provider_id = (int) $hosting_provider_id;

                    $hosting_plan->hosting_provider_id = $hosting_provider_id;
                    
                    $hosting_plan->options = json_encode(['linux' => $data['linux'],
                    'dashboard'=>$data['dashboard'],
                    'data_center' => $data['data_center'],
                    'managed_server' => $data['managed_server']]);
                    $hosting_plan->save();
                    api_response([
                        'id' =>$hosting_plan->id,
                    ]);
                }

                break;

            case 'domain-pricing':
                $data = $request->all();
                $validator = new Validator();
                $validation = $validator->validate($data, [
                    'extension' => 'required|max:50',
                    'register' => 'required',
                    'transfer' => 'required',
                    'renew' => 'required',
                    'registration_provider_id' => 'nullable|integer',
                    'id' => 'nullable|integer',
                ]);

                if ($validation->fails()) {
                    $errors = $validation->errors();
                    responseWithError($errors->firstOfAll());
                } else {
                    $domain_price = false;

                    if (!empty($data['id'])) {
                        $domain_price = DomainPrice::find($data['id']);
                    }

                    if (!$domain_price) {
                        $domain_price = new DomainPrice();
                    }

                    $domain_price->extension = $data['extension'];
                    $domain_price->register = createFromCurrency(
                        $data['register'],
                        $config['home_currency']
                    );
                    $domain_price->transfer = createFromCurrency(
                        $data['transfer'],
                        $config['home_currency']
                    );
                    $domain_price->renew = createFromCurrency(
                        $data['renew'],
                        $config['home_currency']
                    );

                    $domain_price->registration_provider_id =
                        $data['registration_provider_id'] ?? 0;

                    $domain_price->save();
                }

                break;

            case 'group':
                $data = $request->all();
                $validator = new Validator();
                $validation = $validator->validate($data, [
                    'name' => 'required|max:150',
                    'type' => 'required|max:150',
                    'id' => 'nullable|integer',
                    'slug' => 'nullable|max:150',
                ]);

                if ($validation->fails()) {
                    $errors = $validation->errors();
                    responseWithError($errors->firstOfAll());
                } else {
                    $group = false;

                    if (!empty($data['id'])) {
                        $group = HostingPlanGroup::where(
                            'id',
                            $data['id']
                        )->first();
                    }

                    if (!$group) {
                        $slug = Str::slug($data['name']);

                        if (
                            !$slug ||
                            HostingPlanGroup::where('slug', $slug)->first()
                        ) {
                            $slug = sp_uuid();
                        }

                        $group = new HostingPlanGroup();
                        $group->slug = $slug;
                    } else {
                        $group->slug =
                            $data['slug'] ?? Str::slug($data['name']);
                    }

                    $group->name = $data['name'];
                    $group->type = $data['type'];
                    $group->header_content = $data['header_content'] ?? null;
                    $group->body_content = $data['body_content'] ?? null;
                    $group->save();
                }

                break;
            case 'server':
                $data = $request->all();

                $validation = Validation::init($config['language']);
                $validator = $validation->make($data, [
                    'name' => 'required|string|max:150',
                    'type' => 'required',
                ]);

                if ($validator->fails()) {
                    responseWithError($validator->errors());
                }

                $type = $data['type'];

                $hosting_server = false;

                if (isset($data['id'])) {
                    $id = (int) $data['id'];
                    if ($id) {
                        $hosting_server = HostingServer::find($id);
                        if ($hosting_server) {
                            $type = $hosting_server->type;
                        }
                    }
                }

                if (!$hosting_server) {
                    $hosting_server = new HostingServer();
                    $hosting_server->type = $type;
                }

                switch ($type) {
                    case 'cpanel':
                        $validator = $validation->make($data, [
                            'host' => 'required|string|max:150',
                            'username' => 'required',
                            'api_key' => 'required',
                        ]);

                        if ($validator->fails()) {
                            responseWithError($validator->errors());
                        }

                        break;
                    case 'directadmin':
                        $validator = $validation->make($data, [
                            'host' => 'required|string|max:150',
                            'username' => 'required',
                            'password' => 'required',
                        ]);

                        if ($validator->fails()) {
                            responseWithError($validator->errors());
                        }
                        break;
                }

                if ($hosting_server) {
                    $hosting_server->name = $data['name'];
                    $hosting_server->login_url = $data['login_url'] ?? null;
                    $hosting_server->api_key = $data['api_key'] ?? null;
                    $hosting_server->api_secret = $data['api_secret'] ?? null;
                    $hosting_server->username = $data['username'] ?? null;
                    $hosting_server->password = $data['password'] ?? null;
                    $hosting_server->host = $data['host'] ?? null;
                    $hosting_server->port = $data['port'] ?? 0;
                    $hosting_server->save();
                }

                break;

            case 'save-order':
                $data = $request->all();

                $validator = HostingOrder::validateActivationData(
                    $data,
                    $config['language']
                );

                if ($validator->fails()) {
                    responseWithError($validator->errors());
                }

                HostingOrder::saveActivationData($data);

                break;

            case 'save-domain-order':
                $data = $request->all();

                $validator = HostingOrder::validateActivationData(
                    $data,
                    $config['language']
                );

                if ($validator->fails()) {
                    responseWithError($validator->errors());
                }

                DomainOrder::saveActivationData($data);

                break;

            case 'save-and-send-order-email':
                $data = $request->all();

                $validator = HostingOrder::validateActivationData(
                    $data,
                    $config['language']
                );

                if ($validator->fails()) {
                    responseWithError($validator->errors());
                }

                HostingOrder::saveActivationData($data, true, $config, $_L);

                break;

            case 'domain_registration_provider':
                $data = $request->all();

                $validation = Validation::init($config['language']);
                $validator = $validation->make($data, [
                    'name' => 'required|string|max:150',
                    'type' => 'required|string|max:50',
                    'id' => 'nullable|integer',
                ]);

                if ($validator->fails()) {
                    responseWithError($validator->errors());
                }

                $domain_registration_provider = false;

                if (!empty($data['id'])) {
                    $domain_registration_provider = DomainRegistrationProvider::find(
                        $data['id']
                    );
                }
                if (!$domain_registration_provider) {
                    $domain_registration_provider = new DomainRegistrationProvider();
                    $domain_registration_provider->type = $data['type'];
                }

                $domain_registration_provider->name = $data['name'];

                $domain_registration_provider->ip_address =
                    $data['ip_address'] ?? null;
                $domain_registration_provider->host = $data['host'] ?? null;
                $domain_registration_provider->username =
                    $data['username'] ?? null;
                $domain_registration_provider->password =
                    $data['password'] ?? null;
                $domain_registration_provider->api_key =
                    $data['api_key'] ?? null;
                $domain_registration_provider->api_secret =
                    $data['api_secret'] ?? null;
                $domain_registration_provider->login_url =
                    $data['login_url'] ?? null;

                $domain_registration_provider->save();

                break;

            case 'run-automation':
                $data = $request->all();

                $result = HostingOrder::runAutomation(
                    $data,
                    $config['language']
                );

                if (!$result['success']) {
                    responseWithError($result['errors']);
                }

                break;

            case 'change-automation-server-for-order':
                $order_id = _post('order_id');
                $server_id = (int) _post('server_id', 0);

                $order = HostingOrder::find($order_id);

                if ($order) {
                    $order->server_id = $server_id;
                    $order->save();
                }

                break;

            case 'sync-accounts':
                $id = (int) _post('id');

                if ($id) {
                    $server = HostingServer::find($id);

                    if ($server) {
                        $accounts = [];
                        $errors = false;
                        switch ($server->type) {
                            case 'cpanel':
                                $api_call = HostBilling::cPanelApiCall(
                                    $server,
                                    'listaccts'
                                );

                                if ($api_call['success']) {
                                    $accounts =
                                        $api_call['response']['data']['acct'];

                                    foreach ($accounts as $account) {
                                        $domain = $account['domain'];
                                        $username = $account['user'];
                                        $email = $account['email'];

                                        if (empty($email)) {
                                            $email = $username . '@' . $domain;
                                        }

                                        $owner = $account['owner'];
                                        $plan = $account['plan'];

                                        $contact = Contact::where(
                                            'email',
                                            $email
                                        )->first();

                                        if (!$contact) {
                                            $contact = new Contact();
                                            $contact->account = $username;
                                            $contact->email = $email;
                                            $contact->save();
                                        }

                                        $hosting_plan = HostingPlan::where(
                                            'api_name',
                                            $plan
                                        )->first();

                                        if (!$hosting_plan) {
                                            $hosting_plan = new HostingPlan();
                                            $hosting_plan->name = $plan;
                                            $hosting_plan->slug = \Illuminate\Support\Str::slug(
                                                $plan
                                            );
                                            $hosting_plan->type = 'hosting';
                                            $hosting_plan->api_name = $plan;
                                            $hosting_plan->save();
                                        }

                                        $order = HostingOrder::where(
                                            'contact_id',
                                            $contact->id
                                        )
                                            ->where('domain', $domain)
                                            ->first();

                                        if (!$order) {
                                            $order = new HostingOrder();
                                            $order->tracking_id = create_tracking_id();
                                            $order->contact_id = $contact->id;
                                            $order->type = 'hosting';
                                            $order->domain = $domain;
                                            $order->login_url =
                                                'https://' .
                                                $domain .
                                                '/cpanel';
                                            $order->username = $username;
                                            $order->plan_id = $hosting_plan->id;
                                            $order->status = 'Active';
                                            $order->date = date(
                                                'Y-m-d',
                                                strtotime($account['startdate'])
                                            );
                                            $order->save();
                                        }
                                    }
                                    jsonResponse([
                                        'success' => true,
                                    ]);
                                } else {
                                    $errors = $api_call['errors'];
                                }
                                break;
                        }
                    }
                }
                break;

            default:
                abort(404);
        }
        break;

    default:
        abort(404);
}
