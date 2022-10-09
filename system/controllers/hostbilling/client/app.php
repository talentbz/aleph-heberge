<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

require 'system/controllers/hostbilling/client/init.php';

switch ($action) {
    case '':
    case 'contact-us':
        \view(get_theme_file('contact_us'), [
        ]);

        break;
    case 'contact-form-post':
        $data = $request->all();
        // contact information

        $recipient_email = 'noreply@aleph-heberge.fr';
        $contact_name = $data['title'];
        $contact_email = $data['email'];
        $phone = $data['phone'];
        $message = 'Full Name: '. $contact_name.' Email Address: '. $contact_email. ' Phone Number: '.$phone.' Message :'.$data['contents'];
        $subject = 'Contact Form';

        // Email header
        $headers[] = 'MIME-Version: 1.0';
        $headers[] = 'Content-type: text/html; charset=utf-8';
        $headers[] = "To: $recipient_email";
        $headers[] = "From: $contact_email";
        $header = implode('\r\n', $headers);

        mail($recipient_email, $subject, $message, $header);

        return 'success';

        break;
    case 'espace-client':
        \view(get_theme_file('espace_client'), [
        ]);

        break;
    case 'home':
        //add domain (Auth: Danila)
        $domain_extensions = DomainPrice::all();

        \view(get_theme_file('home'), [
            'type' => 'client_auth',
            'admin' => User::admin(),
            'domain_extensions' => $domain_extensions,
        ]);

        break;

    case 'items':
        $slug = route(2, false);
        $items = [];
        $group = false;
        if ($slug) {
            $group = HostingPlanGroup::where('slug', $slug)->first();
            if ($group) {
                $items = HostingPlan::where('group_id', $group->id)->get();
            }
        }
        \view('hostbilling/client/items', [
            'items' => $items,
            'group' => $group,
        ]);

        break;

    case 'item':
        $slug = route(2, false);
        if ($slug) {
            $item = HostingPlan::where('slug', $slug)->first();
            $item->options = json_decode($item->options);
            $item->linux =  array(
                (object) [
                    'name' => "centos 8",
                    'price' => "15",
                ],
                (object) [
                    "name" => "centos 7",
                    "price" => "20"
                ],
                (object) [
                    "name" => "debian 10",
                    "price" => "10"
                ],
                (object) [
                    "name" => "debian 9",
                    "price" => "18"
                ],
                (object) [
                    "name" => "Ubuntu 16.04",
                    "price" => "30"
                ],
                (object) [
                    "name" => "Ubuntu 17.10",
                    "price" => "56"
                ]
            );
            $item->dashboard = array(
                (object)[
                    "name" => "Cpanel",
	                "price" => 60
                ],
                (object)[
                    "name" => "Plesk Onyx Web Host Edition",
                    "price" => 20
                ],
                (object)[
                    "name" => "Plesk Onyx Web Pro Edition",
                    "price" => 10
                ],
                (object)[
                    "name" => "Plesk Onyx Web Admin Edition",
                    "price" => 18
                ],
                (object)[
                    "name" => "sans",
                    "price" => 0
                ]
            );
            $item->data_center = array(
                (object)[
                    "name" => "France (Lyon)",
                    "price" => 0
                ],
                (object)[
                    "name" => "Europe (Allemagne)",
                    "price" => 0
                ],
                (object)[
                    "name" => "Etats Unis (Missouri)",
                    "price" => 0
                ]
            );
            $item->managed_server = array(
                (object)[
                    "name" => "oui",
                    "price" => 100
                ],
                (object)[
                    "name" => "non",
                    "price" => 0
                ]
            );
            if ($item) {
                \view('hostbilling/client/item', [
                    'item' => $item,
                ]);
            }
        }

        break;

    case 'buy-now':
        $slug = route(2, false);
        $term = route(3, false);

        if ($slug) {
            $contact = Contact::isLoggedIn();
            $item = HostingPlan::where('slug', $slug)->first();
            if ($item) {
                $items = [];
                $total = 0;

                if ($shopping_cart) {
                    if ($shopping_cart && !empty($shopping_cart->items)) {
                        $items = json_decode($shopping_cart->items, true);
                        $total = $shopping_cart->total;
                    }

                    if (!empty($items['hosting'][$item->id])) {
                        # already exist
                        redirect_to('client/checkout');
                    }
                }

                if (!$shopping_cart) {
                    $shopping_cart = new ShoppingCart();
                    if ($contact) {
                        $shopping_cart->contact_id = $contact->id;
                    }
                }

                $terms = get_available_item_pricing_terms($item);

                if ($term && isset($terms[$term])) {
                    $price = $terms[$term]['price'] ?? 0;
                } else {
                    $term = key($terms) ?? 'monthly';
                    $price = reset($terms)['price'] ?? 0;
                }

                $total += $price;

                $items['hosting'][$item->id] = [
                    'quantity' => 1,
                    'term' => $term,
                    'price' => $price,
                ];

                $shopping_cart->items = json_encode($items);
                $shopping_cart->total = hostbilling_get_shopping_cart_total(
                    $items
                );
                $shopping_cart->items_count = hostbilling_count_shopping_cart_items(
                    $items
                );
                $shopping_cart->save();

                $_SESSION['shopping_cart_id'] = $shopping_cart->id;

                redirect_to('client/checkout');
            }
        }

        break;

    case 'remove-shopping-cart-item':
        $item_id = (int) route(2, false);

        if ($shopping_cart) {
            if ($shopping_cart->items) {
                $items = json_decode($shopping_cart->items, true);
                if (isset($items['hosting'][$item_id])) {
                    unset($items['hosting'][$item_id]);
                    $shopping_cart->total = hostbilling_get_shopping_cart_total(
                        $items
                    );
                    $shopping_cart->items = json_encode($items);
                    $shopping_cart->items_count = hostbilling_count_shopping_cart_items(
                        $items
                    );
                    $shopping_cart->save();
                }
            }
        }

        redirect_to('client/checkout');

        break;

    case 'remove-shopping-cart-domain':
        $item_id = (int) route(2, false);

        if ($shopping_cart) {
            if ($shopping_cart->items) {
                $items = json_decode($shopping_cart->items, true);
                if (isset($items['domains'][$item_id])) {
                    unset($items['domains'][$item_id]);
                    $shopping_cart->total = hostbilling_get_shopping_cart_total(
                        $items
                    );
                    $shopping_cart->items = json_encode($items);
                    $shopping_cart->items_count = hostbilling_count_shopping_cart_items(
                        $items
                    );
                    $shopping_cart->save();
                }
            }
        }

        redirect_to('client/checkout');

        break;

    case 'delete-shopping-cart':
        if ($shopping_cart) {
            $shopping_cart->delete();
        }

        redirect_to('client/');

        break;

    case 'shopping-cart-update-term':
        $item_id = (int) route(2, false);
        $term = route(3);
        if ($shopping_cart) {
            if ($shopping_cart->items) {
                $items = json_decode($shopping_cart->items, true);
                $allowed_terms = array_keys(get_available_terms());
                $item = HostingPlan::find($item_id);
                $db_term = get_term_to_db_term($term);
                if (
                    isset($items['hosting'][$item_id]) &&
                    in_array($term, $allowed_terms) &&
                    $item &&
                    $db_term
                ) {
                    $items['hosting'][$item_id]['term'] = $term;
                    $items['hosting'][$item_id]['price'] = $item->$db_term;

                    $shopping_cart->items = json_encode($items);
                    $shopping_cart->total = hostbilling_get_shopping_cart_total(
                        $items
                    );
                    $shopping_cart->items_count = hostbilling_count_shopping_cart_items(
                        $items
                    );
                }
                $options = json_decode($item->options);
                if (intval(urldecode($_GET["OS"])) > -1) {
                    $items['hosting'][$item_id]['options']['linux'] =  ((array)$options->linux)[intval(urldecode($_GET["OS"]))]; 
                } else {
                    $items['hosting'][$item_id]['options']['linux'] = (object) ['name' => '', 'price' =>0];
                }
                if (intval(urldecode($_GET["dashboard"])) > -1) {
                    $items['hosting'][$item_id]['options']['dashboard'] = ((array)$options->dashboard)[intval(urldecode($_GET["dashboard"]))];
                } else {
                    $items['hosting'][$item_id]['options']['dashboard'] = (object) ['name' => '', 'price' =>0];
                }
                

                if (intval(urldecode($_GET["data_center"])) > -1) {
                    $items['hosting'][$item_id]['options']['data_center'] = ((array)$options->data_center)[intval(urldecode($_GET["data_center"]))];
                } else {
                    $items['hosting'][$item_id]['options']['data_center'] = (object) ['name' => '', 'price' =>0];
                }
                if (intval(urldecode($_GET["managed_server"])) > -1) {
                    $items['hosting'][$item_id]['options']['managed_server'] = ((array)$options->managed_server)[intval(urldecode($_GET["managed_server"]))];
                } else {
                    $items['hosting'][$item_id]['options']['managed_server'] = (object) ['name' => '', 'price' =>0];
                }
                $shopping_cart->total = hostbilling_get_shopping_cart_total($items);
                $shopping_cart->items = json_encode($items);
                $shopping_cart->save();

            }
        }

        redirect_to('client/checkout');

        break;

    case 'set-domain-for-hosting':
        $id = (int) _post('id');
        $domain = _post('domain');

        if ($shopping_cart) {
            $items = json_decode($shopping_cart->items, true);

            if (isset($items['hosting'][$id])) {
                $items['hosting'][$id]['domain_name'] = $domain;
                $shopping_cart->items = json_encode($items);
                $shopping_cart->save();
            }
        }

        break;

    case 'checkout':
        $items = [];
        $shopping_cart_items = [];
        if ($shopping_cart) {
            if ($shopping_cart && $shopping_cart->items) {
                $shopping_cart_items = json_decode($shopping_cart->items, true);
                if (!empty($shopping_cart_items['hosting'])) {
                    $items_ids = array_keys($shopping_cart_items['hosting']);
                    $items = HostingPlan::whereIn('id', $items_ids)->get();
                }
            }
        }
        $listItems = [];
        foreach($items as $item) {
            if (!empty($item->options)) {
                $options = json_decode($item->options);
                $item->linux = $options->linux;
                $item->dashboard = $options->dashboard;
                $item->data_center = $options->data_center;
                $item->managed_server = $options->managed_server;
                array_push($listItems, $item);
            }
        }
        
        \view('hostbilling/client/checkout', [
            'shopping_cart' => $shopping_cart,
            'shopping_cart_items' => $shopping_cart_items,
            'items' => $items,
        ]);

        break;

    case 'checkout-commit':
        if ($shopping_cart && $shopping_cart->items && $contact) {
            $shopping_cart_items = json_decode($shopping_cart->items, true);
            $invoice_items = [];

            $items = $shopping_cart->items;
            $items = json_decode($items, true);
            $create_hosting_orders = [];
            if (!empty($items['hosting'])) {
                foreach ($items['hosting'] as $key => $value) {
                    $hosting_plan = HostingPlan::find($key);
                    if ($hosting_plan) {
                        if ($value['options']) {
                            $price = hostbilling_get_shopping_cart_total(
                                $items
                            );
                        } else {
                            $price = $value['price'];
                        }
                        $name = $hosting_plan->name .
                        ' (' .
                        $value['term'] .
                        ')';
                        if ($value['options']) {
                            foreach($value['options'] as $key => $option) {
                                $option_key = '';
                                if ($key  === 'linux') {
                                    $option_key = 'OS';
                                } else if ($key === 'managed_server') {
                                    $option_key = 'Serveur managé';
                                } else if ($key === 'data_center') {
                                    $option_key = 'Data center';
                                } else if ($key === 'dashboard') {
                                    $option_key = 'Panneau d\'administration';
                                }
                                if ($option['price'] !== 0) {
                                    $name = $name . '<br>' .
                                    $option_key . ' : ' .$option['name'];
                                }
                            }
                        }
                        
                        $create_hosting_orders[] = [
                            'plan_id' => $hosting_plan->id,
                            'domain_name' => $value['domain_name'] ?? '',
                            'total' => $price,
                        ];

                        $invoice_items[] = [
                            'name' => $name,
                            'amount' => $price,
                            'quantity' => $value['quantity'],
                        ];
                    }
                }
            }

            $create_domain_orders = [];

            if (!empty($items['domains'])) {
                foreach ($items['domains'] as $key => $value) {
                    $domain_price = DomainPrice::find($key);
                    if ($domain_price) {
                        $create_domain_orders[] = [
                            'extension_id' => $domain_price->id,
                            'domain_name' => $value['name'],
                            'total' => $value['price'],
                        ];

                        $term = (int) $value['term'];
                        if ($term === 1) {
                            $term_name = '1 year';
                        } else {
                            $term_name = $term . ' years';
                        }
                        $invoice_items[] = [
                            'name' => $value['name'] . ' (' . $term_name . ')',
                            'amount' => $value['price'],
                            'quantity' => 1,
                        ];
                    }
                }
            }
            $invoice = Invoice::saveInvoice([
                'contact' => $contact,
                'items' => $invoice_items,
                'invoice_items' => $invoice_items,
            ]);

            if ($invoice) {
                $shopping_cart->delete();

                foreach ($create_hosting_orders as $create_hosting_order) {
                    $tracking_id = strtoupper(sp_random_strings(10));
                    $tracking_id =
                        substr($tracking_id, 0, 4) .
                        '-' .
                        substr($tracking_id, 4);
                    $hosting_order = new HostingOrder();
                    $hosting_order->tracking_id = $tracking_id;
                    $hosting_order->contact_id = $contact->id;
                    $hosting_order->invoice_id = $invoice->id;
                    $hosting_order->total =
                        $create_hosting_order['total'] ?? 0.0;
                    $hosting_order->plan_id = $create_hosting_order['plan_id'];
                    $hosting_order->domain =
                        $create_hosting_order['domain_name'];
                    $hosting_order->date = date('Y-m-d');
                    $hosting_order->save();
                }

                foreach ($create_domain_orders as $create_domain_order) {
                    $tracking_id = strtoupper(sp_random_strings(10));
                    $tracking_id =
                        substr($tracking_id, 0, 4) .
                        '-' .
                        substr($tracking_id, 4);
                    $domain_order = new DomainOrder();
                    $domain_order->tracking_id = $tracking_id;
                    $domain_order->contact_id = $contact->id;
                    $domain_order->invoice_id = $invoice->id;
                    $domain_order->extension_id =
                        $create_domain_order['extension_id'];
                    $domain_order->domain = $create_domain_order['domain_name'];
                    $domain_order->save();
                }

                redirect_to(
                    'client/iview/' .
                        $invoice->id .
                        '/token_' .
                        $invoice->vtoken
                );
            }
        } else {
            redirect_to('client');
        }

        break;

    case 'whois':
        \view(get_theme_file('whois'), []);

        break;

    case 'domain-register':
        $domain_extensions = DomainPrice::all();

        \view('hostbilling/client/domain_register', [
            'domain_extensions' => $domain_extensions,
        ]);

        break;

    case 'domain-register-post':
        $whois = Whois::createDefault();

        $data = $request->all();

        $validation = Validation::init($config['language']);
        $validator = $validation->make($data, [
            'domain_name' => 'required|alpha_dash|max:150',
            'extension' => 'required',
        ]);

        if ($validator->fails()) {
            responseWithError([
                'errors' => [
                    'domain' => [__('Invalid domain name')],
                ],
            ]);
        }

        $domain_name = $data['domain_name'];
        $extension = $data['extension'];
        $domain_name_full = $domain_name . $extension;

        $domain_price = DomainPrice::where('extension', $extension)->first();

        $available = false;

        $cache_key = 'domain_availability_' . $domain_name;

        if ($whois->isDomainAvailable($domain_name_full)) {
            $available = true;
        }

        if (!$cache->has($cache_key)) {
            if ($whois->isDomainAvailable($domain_name_full)) {
                $available = true;
            }
            $cache->put($cache_key, $available, $cache_ttl);
        }

        $available = $cache->get($cache_key);

        \view('hostbilling/client/domain_register_result', [
            'domain_name_full' => $domain_name_full,
            'available' => $available,
            'domain_price' => $domain_price,
            'extension' => $extension,
            'domain_name' => $domain_name,
        ]);

        break;

    case 'buy-now-domain':
        $data = $request->all();

        $validation = Validation::init($config['language']);
        $validator = $validation->make($data, [
            'domain_name' => 'required|alpha_dash|max:150',
            'extension' => 'required',
            'term' => 'required|integer',
        ]);

        if ($validator->fails()) {
            responseWithError($validator->errors());
        }

        $domain_price = DomainPrice::where(
            'extension',
            $data['extension']
        )->first();
        if ($domain_price) {
            $contact = Contact::isLoggedIn();
            $total = 0;
            if (!empty($_SESSION['shopping_cart_id'])) {
                $shopping_cart = ShoppingCart::find(
                    $_SESSION['shopping_cart_id']
                );

                if ($shopping_cart && !empty($shopping_cart->items)) {
                    $items = json_decode($shopping_cart->items, true);
                    $total = $shopping_cart->total;
                }

                if (!empty($items['domains'][$domain_price->id])) {
                    # already exist
                    redirect_to('client/checkout');
                }
            }

            if (!$shopping_cart) {
                $shopping_cart = new ShoppingCart();
                if ($contact) {
                    $shopping_cart->contact_id = $contact->id;
                }
            }

            $term = $data['term'];
            $price = $domain_price->register * $term;
            $total += $price;

            $items['domains'][$domain_price->id] = [
                'term' => $term,
                'price' => $price,
                'name' => $data['domain_name'] . $data['extension'],
            ];

            $shopping_cart->items = json_encode($items);
            $shopping_cart->total = $total;
            $shopping_cart->items_count = hostbilling_count_shopping_cart_items(
                $items
            );
            $shopping_cart->save();

            $_SESSION['shopping_cart_id'] = $shopping_cart->id;

            redirect_to('client/checkout');
        }

        break;

    case 'whois-post':
        // verify_csrf_token();
        $whois = Whois::createDefault();

        $data = $request->all();

        $validation = Validation::init($config['language']);
        $validator = $validation->make($data, [
            'domain_name' => 'required|regex:/^[A-Za-z. -]+$/|max:150',
        ]);

        if ($validator->fails()) {
            responseWithError($validator->errors());
        }

        $domain_name = $data['domain_name'];
        $domain_name = trim($domain_name);
        $cache_key = 'whois_' . $domain_name;

        if (!$cache->has($cache_key)) {
            $response = $whois->loadDomainInfo($domain_name);
            $cache->put($cache_key, json_encode($response), $cache_ttl);
        }

        $result = json_decode($cache->get($cache_key));

        if (!empty($result->creationDate)) {
            view('hostbilling/client/whois_result', [
                'result' => $result,
            ]);
        } else {
            echo 'Data not found.';
        }

        break;

    case 'domain-orders':
        $domain_orders = DomainOrder::where('contact_id', $contact->id)
            ->limit(500)
            ->get();

        \view('hostbilling/client/domain_orders', [
            'domain_orders' => $domain_orders,
        ]);

        break;

    case 'hosting-orders':
        $orders = HostingOrder::where('contact_id', $contact->id)
            ->limit(500)
            ->get();

        $invoices = Invoice::all()
            ->keyBy('id')
            ->all();

        \view('hostbilling/client/hosting_orders', [
            'orders' => $orders,
            'selected_navigation' => 'invoices',

            'invoices' => $invoices,
        ]);

        break;

    case 'view-order':
        $id = route(2, false);
        if ($id) {
            $order = HostingOrder::where('contact_id', $contact->id)
                ->where('id', $id)
                ->first();
            if ($order) {
                $invoice = Invoice::find($order->invoice_id);

                $server = false;

                if ($order->server_id) {
                    $server = HostingServer::find($order->server_id);
                }

                $buttons = [];

                $app->emit('hostbilling_client_view_order', [
                    [
                        'order' => &$order,
                        'server' => &$server,
                        'buttons' => &$buttons,
                    ],
                ]);

                \view('hostbilling/client/view_order', [
                    'order' => $order,
                    'selected_navigation' => 'invoices',
                    'server' => $server,
                    'invoice' => $invoice,
                    'buttons' => $buttons,
                ]);
            }
        }
        break;

    case 'view-domain':
        $id = route(2, false);
        if ($id) {
            $order = DomainOrder::where('contact_id', $contact->id)
                ->where('id', $id)
                ->first();
            if ($order) {
                $invoice = Invoice::find($order->invoice_id);
                \view('hostbilling/client/view_domain', [
                    'order' => $order,
                    'selected_navigation' => 'invoices',

                    'invoice' => $invoice,
                ]);
            }
        }
        break;

    case 'kb':
        $knowledgebases = Knowledgebase::all()
            ->keyBy('id')
            ->all();
        $knowledgebases_groups = KnowledgebaseGroup::all()
            ->keyBy('id')
            ->all();

        $knowledgebases_group_relations = KnowledgebaseGroupRelation::all()
            ->groupBy('gid')
            ->all();

        \view(get_theme_file('knowledgebase'), [
            'knowledgebases' => $knowledgebases,
            'knowledgebases_groups' => $knowledgebases_groups,
            'knowledgebases_group_relations' => $knowledgebases_group_relations,
            'selected_navigation' => 'kb',
        ]);

        break;

    case 'view-article':
        $id = route(2, false);

        if ($id) {
            $article = Knowledgebase::find($id);

            \view(get_theme_file('view_article'), [
                'article' => $article,
                'selected_navigation' => 'kb',
            ]);
        }

        break;

    case 'iview':
        Event::trigger('client/iview/');
        
        $has_login_token = Contact::hasLoginToken();

        $today = date('Y-m-d H:i:s');

        $id = $routes['2'];
        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            $token = $routes['3'];

            $render = route(4, 'invoice');

            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $items = ORM::for_table('sys_invoiceitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('items', $items);
            //find related transactions
            $trs_c = ORM::for_table('sys_transactions')
                ->where('iid', $id)
                ->count();

            $trs = ORM::for_table('sys_transactions')
                ->where('iid', $id)
                ->order_by_desc('id')
                ->find_many();
            $ui->assign('trs', $trs);
            $ui->assign('trs_c', $trs_c);
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $ui->assign('a', $a);
            $ui->assign('d', $d);

            $i_credit = $d['credit'];
            $i_due = '0.00';
            $i_total = $d['total'];
            if ($d['credit'] != '0.00') {
                $i_due = $i_total - $i_credit;
            } else {
                $i_due = $d['total'];
            }

            $ui->assign('i_due', $i_due);

            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('cf', $cf);

            $x_html = '';

            Event::trigger('view_invoice');

            $ui->assign('x_html', $x_html);

            $inv_files = Invoice::files($id);

            $inv_files_c = count($inv_files);

            $ui->assign('inv_files_c', $inv_files_c);

            $ui->assign('inv_files', $inv_files);

            //

            if (!isset($_SESSION['uid'])) {
                $ip = get_client_ip();
                // log invoice access log

                $country = $_L['Unknown'];
                $city = $_L['Unknown'];
                $lat = '';
                $lon = '';

                if (isset($_SERVER['HTTP_REFERER'])) {
                    $referer = $_SERVER['HTTP_REFERER'];
                } else {
                    $referer = '';
                }

                if (isset($_SERVER['HTTP_USER_AGENT'])) {
                    $browser = $_SERVER['HTTP_USER_AGENT'];
                } else {
                    $browser = '';
                }

                if ($config['maxmind_installed'] == 1) {
                    $l_data = Ip2Location::getDetails($ip);

                    $country = $l_data['country'];
                    $city = $l_data['city'];
                    $lat = $l_data['lat'];
                    $lon = $l_data['lon'];
                }

                $ial = ORM::for_table('ib_invoice_access_log')->create();
                $ial->iid = $id;
                $ial->ip = $ip;
                $ial->browser = $browser;
                $ial->referer = $referer;
                $ial->country = $country;
                $ial->city = $city;
                $ial->viewed_at = $today;
                $ial->customer = $d->account;
                $ial->save();
            }

            //

            if ($a->cid != '' || $a->cid != 0) {
                $company = Company::find($a->cid);
            } else {
                $company = false;
            }

            // find the quote

            $quote = false;

            if ($d->quote_id != '0') {
                $quote = ORM::for_table('sys_quotes')->find_one($d->quote_id);
            }

            $plugin_extra_js = '';

            $app->emit('client_viewing_invoice', [&$d, &$a]);

            $currencies_all = Currency::getAllCurrencies();

            if (isset($currencies_all[$d->currency_iso_code])) {
                $data_a_sign = $currencies_all[$d->currency_iso_code]['symbol'];
                $data_a_sep =
                    $currencies_all[$d->currency_iso_code][
                        'thousands_separator'
                    ];
                $data_a_dec =
                    $currencies_all[$d->currency_iso_code]['decimal_mark'];

                if ($currencies_all[$d->currency_iso_code] == true) {
                    $data_p_sign = 'p';
                } else {
                    $data_p_sign = 's';
                }
            } else {
                $data_a_sign = $config['currency_code'];
                $data_a_sep = $config['thousands_sep'];
                $data_a_dec = $config['dec_point'];
                $data_p_sign = $config['currency_symbol_position'];
            }

            $payment_gateways = PaymentGateway::where('status', 'Active')
                ->orderBy('sorder', 'asc')
                ->get();
            $payment_gateways_by_processor = $payment_gateways
                ->keyBy('processor')
                ->toArray();

            $format_currency_override = [];

            if (isset($config['decimal_places_products_and_services'])) {
                $format_currency_override['precision'] =
                    $config['decimal_places_products_and_services'];
            }
            
            // custom code for get stripe key (20022.10.09)
            $stripe_key =  ORM::for_table('sys_pg')
                            ->where('processor', 'stripe')
                            ->find_one()->value;
            
            view('client-iview', [
                'company' => $company,
                'quote' => $quote,
                'plugin_extra_js' => $plugin_extra_js,
                'data_a_sign' => $data_a_sign,
                'data_a_sep' => $data_a_sep,
                'data_a_dec' => $data_a_dec,
                'data_p_sign' => $data_p_sign,
                'payment_gateways' => $payment_gateways,
                'payment_gateways_by_processor' => $payment_gateways_by_processor,
                'has_login_token' => $has_login_token,
                'render' => $render,
                'format_currency_override' => $format_currency_override,
                'stripe_key' => $stripe_key,
            ]);
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'q':
        Event::trigger('client/q/');

        $id = $routes['2'];
        $d = ORM::for_table('sys_quotes')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $items = ORM::for_table('sys_quoteitems')
                ->where('qid', $id)
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('items', $items);

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $ui->assign('a', $a);
            $ui->assign('d', $d);

            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('cf', $cf);

            $x_html = '';

            $ui->assign('x_html', $x_html);

            view('client-quote');
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'iprint':
        Event::trigger('client/iprint/');

        $id = $routes['2'];
        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            //find all activity for this user
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
            //find the user
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $i_credit = $d['credit'];
            $i_due = '0.00';
            $i_total = $d['total'];
            if ($d['credit'] != '0.00') {
                $i_due = $i_total - $i_credit;
            }
            $format_currency_override = [];

            $quote = false;

            if (isset($config['decimal_places_products_and_services'])) {
                $format_currency_override['precision'] =
                    $config['decimal_places_products_and_services'];
            }
            require 'system/lib/invoices/render.php';
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'ipdf':
        Event::trigger('client/ipdf/');

        $id = (int) route(2, 0);
        $token = route(3, 'required');

        $extraHtml = '';

        $app->emit('generatingPDFInvoice', [&$id]);

        Invoice::pdf($id, 'inline', $token);

        break;

    case 'qpdf':
        Event::trigger('client/qpdf/');

        $id = route(2);
        $token = route(3, 'required');

        Quote::pdf($id, route(4), $token);

        break;

    case 'shipping-addresses':
        $user = Contacts::details();

        $shipping_addresses = ShippingAddress::where(
            'contact_id',
            $user->id
        )->get();

        view('client_shipping_addresses', [
            'user' => Contacts::details(),
            'shipping_addresses' => $shipping_addresses,
            'selected_navigation' => 'profile',
        ]);

        break;

    case 'shipping-address':
        $user = Contacts::details();
        $id = route(2, false);
        $shipping_address = false;

        $countries = Countries::all($config['country']);

        if ($id) {
            $shipping_address = ShippingAddress::where('contact_id', $user->id)
                ->where('id', $id)
                ->first();
        }

        view('client_add_address', [
            'user' => Contacts::details(),
            'countries' => $countries,
            'shipping_address' => $shipping_address,
        ]);

        break;

    case 'delete-shipping-address':
        $user = Contacts::details();
        $id = route(2, false);
        $shipping_address = false;

        $countries = Countries::all($config['country']);

        if ($id) {
            $shipping_address = ShippingAddress::where('contact_id', $user->id)
                ->where('id', $id)
                ->first();
        }
        if ($shipping_address) {
            $shipping_address->delete();
            r2(U . 'client/shipping-addresses', 's', $_L['delete_successful']);
        }

        break;

    case 'set-default-shipping-address':
        $user = Contacts::details();
        ShippingAddress::where('contact_id', $user->id)
            ->where('is_default', 1)
            ->update([
                'is_default' => 0,
            ]);

        $id = route(2);

        $shipping_address = ShippingAddress::where('contact_id', $user->id)
            ->where('id', $id)
            ->first();

        if ($shipping_address) {
            $shipping_address->is_default = 1;
            $shipping_address->save();

            r2(U . 'client/shipping-addresses', 's', $_L['Updated']);
        }

        break;

    case 'ipay':
        Event::trigger('client/ipay/');

        $id = $routes[2];

        $token = $routes[3];

        $pg = _post('pg');

        if ($pg == '') {
            $pg = route(4);
        }

        Event::trigger('client/ipay/pg', [$pg, $id, $token]);

        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            //check pg
            $ui->assign('d', $d);

            $i_credit = $d['credit'];
            $i_due = '0.00';
            $i_total = $d['total'];

            $amount = $i_total - $i_credit;
            $invoiceid = $d['id'];
            $vtoken = $d['vtoken'];
            $ptoken = $d['ptoken'];

            //get user details

            $u = ORM::for_table('crm_accounts')->find_one($d->userid);

            $ui->assign('a', $u);

            switch ($pg) {
                case 'paypal':
                    $p = ORM::for_table('sys_pg')
                        ->where('processor', 'paypal')
                        ->find_one();

                    if ($p) {
                        // get currency

                        $currency_id = $d['currency'];

                        $currency_find = Currency::find($currency_id);

                        if ($currency_find) {
                            $currency = $currency_id;
                            $currency_code = $currency_find->cname;
                            $currency_rate = $currency_find->rate;
                        } else {
                            $currency = 0;
                            $currency_code = $p['c1'];
                            $currency_rate = 1.0;
                        }

                        $ppemail = $p['value'];
                        //

                        $c2 = $p['c2'];
                        if ($c2 != '' and is_numeric($c2) and $c2 != '1') {
                            $amount = $amount / $c2;
                            $amount = round($amount, 2);
                        }

                        $url = 'https://www.paypal.com/cgi-bin/webscr';

                        $params = [
                            ['name' => "business", 'value' => $ppemail],
                            [
                                'name' => "return",
                                'value' =>
                                    U .
                                    "client/ipay_submitted/$invoiceid/token_$vtoken/",
                            ],
                            [
                                'name' => "cancel_return",
                                'value' =>
                                    U .
                                    "client/ipay_cancel/$invoiceid/token_$vtoken/",
                            ],
                            [
                                'name' => "notify_url",
                                'value' =>
                                    U .
                                    "client/ipay_ipn/$invoiceid/token_$ptoken/",
                            ],
                            [
                                'name' => "item_name",
                                'value' => "Payment For INV # $invoiceid",
                            ],
                            ['name' => "amount", 'value' => $amount],
                            ['name' => "cmd", 'value' => '_xclick'],
                            ['name' => "no_shipping", 'value' => '1'],
                            ['name' => "rm", 'value' => '2'],
                            [
                                'name' => "currency_code",
                                'value' => $currency_code,
                            ],
                        ];

                        Fsubmit::form($url, $params);
                    } else {
                        echo 'Paypal is Not Found!';
                    }

                    break;

                case 'manualpayment':
                    Event::trigger('client/manualpayment/');

                    $p = ORM::for_table('sys_pg')
                        ->where('processor', 'manualpayment')
                        ->find_one();

                    if ($p) {
                        $ui->assign('user', $u);

                        $ui->assign('i_due', $amount);
                        $ui->assign('ins', $p['value']);
                        view('client-ipay');
                    }

                    break;

                case 'stripe':
                    $p = ORM::for_table('sys_pg')
                        ->where('processor', 'stripe')
                        ->find_one();

                    if ($p) {
                        $a = ORM::for_table('crm_accounts')->find_one(
                            $d['userid']
                        );
                        $it = $i_total - $i_credit;
                        $amount = $it * 100;
                        //                        $ins = ' <script
                        //                                        src="https://checkout.stripe.com/v2/checkout.js" class="stripe-button"
                        //                                        data-key="'.$p['value'].'"
                        //                                        data-amount="'.$amount.'"
                        //                                        data-name="INV #'.$d['id'].'"
                        //                                        data-email="'.$a['email'].'"
                        //                                        data-currency="'.$p['c1'].'"
                        //                                        data-description="Payment for Invoice # '.$d['id'].'">
                        //                                </script>';
                        //
                        //                        $ui->assign('ins',$ins);

                        view('stripe');
                    }

                    break;

                case 'stripe_post':
                    $p = ORM::for_table('sys_pg')
                        ->where('processor', 'stripe')
                        ->find_one();
                    if ($p) {
                        $a = ORM::for_table('crm_accounts')->find_one(
                            $d['userid']
                        );
                        $it = $i_total - $i_credit;
                        $amount = $it * 100;

                        if ($d->currency != 0) {
                            $currency = ORM::for_table(
                                'sys_currencies'
                            )->find_one($d->currency);

                            if ($currency) {
                                $currency_code = $currency->iso_code;
                            }
                        } else {
                            $currency_code = $p['c1'];
                        }

                        //  require_once('system/lib/stripe/init.php');

                        $description = "Payment For INV # $invoiceid";

                        $cardNumber = _post('cardNumber');

                        $cardExpiry = _post('cardExpiry');

                        $ce = explode('/', $cardExpiry);

                        $cardCVC = _post('cardCVC');

                        $myCard = [
                            'name' => $u->email,
                            'number' => $cardNumber,
                            'exp_month' => $ce['0'],
                            'exp_year' => $ce['1'],
                        ];

                        try {
                            \Stripe\Stripe::setApiKey($p['value']);
                            $charge = \Stripe\Charge::create([
                                'card' => $myCard,
                                'amount' => $amount,
                                'currency' => $currency_code,
                                "description" => $description,
                            ]);

                            $charge = str_replace(
                                'Stripe\Charge JSON:',
                                '',
                                $charge
                            );
                            $resp = json_decode($charge, true);
                            $trid = $resp['id'];
                            $last4 = $resp['source']['last4'];
                            $captured = $resp['captured'];

                            if ($captured == true) {
                                $inv = ORM::for_table('sys_invoices')->find_one(
                                    $id
                                );
                                if ($inv) {
                                    $inv->status = 'Paid';
                                    $inv->save();
                                    Event::trigger(
                                        'invoices/markpaid/',
                                        $invoice = $inv
                                    );
                                    _msglog('s', 'Payment Successful');
                                    r2(
                                        U .
                                            'client/iview/' .
                                            $d['id'] .
                                            '/' .
                                            'token_' .
                                            $d['vtoken']
                                    );
                                }
                            } else {
                                _msglog(
                                    'e',
                                    'This API call cannot be made with a publishable API key. Please use a secret API key. You can find a list of your API keys at https://dashboard.stripe.com/account/apikeys.'
                                );
                                r2(
                                    U .
                                        'client/iview/' .
                                        $d['id'] .
                                        '/' .
                                        'token_' .
                                        $d['vtoken']
                                );
                            }
                        } catch (\Stripe\Error\Card $e) {
                            // Since it's a decline, \Stripe\Error\Card will be caught
                            $body = $e->getJsonBody();
                            $err = $body['error'];

                            print 'Status is:' . $e->getHttpStatus() . "\n";
                            print 'Type is:' . $err['type'] . "\n";
                            print 'Code is:' . $err['code'] . "\n";
                            // param is '' in this case
                            print 'Param is:' . $err['param'] . "\n";
                            print 'Message is:' . $err['message'] . "\n";
                        } catch (\Stripe\Error\InvalidRequest $e) {
                            // Invalid parameters were supplied to Stripe's API
                        } catch (\Stripe\Error\Authentication $e) {
                            // Authentication with Stripe's API failed
                            // (maybe you changed API keys recently)
                            echo 'Authentication with Stripe\'s API failed';
                        } catch (\Stripe\Error\ApiConnection $e) {
                            // Network communication with Stripe failed
                            echo 'Network communication with Stripe failed';
                        } catch (\Stripe\Error\Base $e) {
                            // Display a very generic error to the user, and maybe send
                            // yourself an email
                        } catch (Exception $e) {
                            // Something else happened, completely unrelated to Stripe
                            var_dump($e);
                        }
                    }

                    break;

                case 'authorize_net':
                    $p = ORM::for_table('sys_pg')
                        ->where('processor', 'authorize_net')
                        ->find_one();

                    if ($p) {
                        $invoiceid = $d['id'];
                        $amount = $i_total - $i_credit;
                        $url =
                            'https://secure.authorize.net/gateway/transact.dll';
                        $loginID = $p['value'];

                        $transactionKey = $p['c1'];

                        $description = "Invoice Payment - $invoiceid";

                        // an invoice is generated using the date and time
                        $invoice = $invoiceid;
                        // a sequence number is randomly generated
                        $sequence = rand(1, 1000);
                        // a timestamp is generated
                        $timeStamp = time();

                        $testMode = "false";
                        if (phpversion() >= '5.1.2') {
                            $fingerprint = hash_hmac(
                                "md5",
                                $loginID .
                                    "^" .
                                    $sequence .
                                    "^" .
                                    $timeStamp .
                                    "^" .
                                    $amount .
                                    "^",
                                $transactionKey
                            );
                        } else {
                            $fingerprint = bin2hex(
                                mhash(
                                    MHASH_MD5,
                                    $loginID .
                                        "^" .
                                        $sequence .
                                        "^" .
                                        $timeStamp .
                                        "^" .
                                        $amount .
                                        "^",
                                    $transactionKey
                                )
                            );
                        }
                        $params = [
                            ['name' => "x_login", 'value' => $loginID],
                            ['name' => "x_amount", 'value' => $amount],
                            [
                                'name' => "x_description",
                                'value' => $description,
                            ],
                            ['name' => "x_invoice_num", 'value' => $invoice],
                            ['name' => "x_fp_sequence", 'value' => $sequence],
                            ['name' => "x_fp_timestamp", 'value' => $timeStamp],
                            ['name' => "x_fp_hash", 'value' => $fingerprint],
                            ['name' => "x_test_request", 'value' => $testMode],
                            [
                                'name' => "x_show_form",
                                'value' => "PAYMENT_FORM",
                            ],
                        ];

                        Fsubmit::form($url, $params);
                    }

                    break;

                case 'ccavenue':
                    $p = ORM::for_table('sys_pg')
                        ->where('processor', 'ccavenue')
                        ->find_one();

                    if ($p) {
                        require 'system/lib/misc/ccavenue.php';

                        $currency_code = $p['c2'];
                        $c3 = $p['c3'];

                        if ($c3 != '' and is_numeric($c3) and $c3 != '1') {
                            $amount = $amount / $c3;
                        }

                        $Merchant_Id = $p['value']; //Given to merchant by ccavenue

                        $WorkingKey = $p['c1']; //Given to merchant by ccavenue

                        $redirect_url =
                            U . "client/ipay_ipn/$invoiceid/token_$ptoken/";

                        require 'system/lib/misc/ccform.php';
                    }

                    break;

                case 'braintree':
                    break;

                case 'quickpay':
                    $p = ORM::for_table('sys_pg')
                        ->where('processor', 'quickpay')
                        ->find_one();

                    if ($p) {
                    }

                    break;

                default:
                    echo 'Payment Gateway Not Found!';
            }
        } else {
            echo 'Sorry Invoice Not Found!';
            exit();
        }

        break;

    /*
     * CCAvenue
     *
     *
     */

    case 'ipay_cancel':
        Event::trigger('client/ipay_cancel/');

        $id = $routes['2'];
        $token = $routes['3'];
        r2(U . "client/iview/$id/$token/", 'e', $_L['Payment Cancelled']);

        break;

    case 'ipay_submitted':
        Event::trigger('client/ipay_submitted/');

        $id = $routes['2'];
        $token = $routes['3'];
        r2(U . "client/iview/$id/$token/", 's', $_L['Payment Successful']);

        break;

    case 'ipay_ipn':
        Event::trigger('client/ipay_success/');

        $id = $routes['2'];
        $token = $routes['3'];
        //   r2(U."client/iview/$id/$token/",'s',$_L['Payment Successful']);

        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $ptoken = $d->ptoken;
            $vtoken = $d->vtoken;
            if ($token != $ptoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $d->status = 'Paid';
            $d->save();

            Event::trigger('invoices/markpaid/', $invoice = $d);

            // send email

            $msg = Invoice::gen_email($id, 'confirm');

            $subj = $msg['subject'];
            $message_o = $msg['body'];
            $email = $msg['email'];
            $name = $msg['name'];
            //            Notify_Email::_send(
            //                $name,
            //                $email,
            //                $subj,
            //                $message_o,
            //                $d->userid,
            //                $id
            //            );

            Email::sendEmail(
                $config,
                $_L,
                $name,
                $email,
                $subj,
                $message_o,
                $d->userid,
                $id
            );

            //
            r2(U . "client/iview/$id/$vtoken/", 's', $_L['Payment Successful']);
        }

        break;

    case 'ipay_success':
        Event::trigger('client/ipay_success/');

        $id = $routes['2'];
        $token = $routes['3'];
        //   r2(U."client/iview/$id/$token/",'s',$_L['Payment Successful']);

        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $ptoken = $d->ptoken;
            $vtoken = $d->vtoken;
            if ($token != $ptoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $d->status = 'Paid';
            $d->save();

            Event::trigger('invoices/markpaid/', $invoice = $d);

            // send email

            $msg = Invoice::gen_email($id, 'confirm');

            $subj = $msg['subject'];
            $message_o = $msg['body'];
            $email = $msg['email'];
            $name = $msg['name'];
            Email::sendEmail(
                $config,
                $_L,
                $name,
                $email,
                $subj,
                $message_o,
                $d->userid,
                $id
            );

            //
            r2(U . "client/iview/$id/$vtoken/", 's', $_L['Payment Successful']);
        }

        break;

    case 'btpay_submitted':
        Event::trigger('client/btpay_submitted/');

        $id = $routes['2'];
        $d = ORM::for_table('sys_invoices')->find_one($id);
        $ui->assign('d', $d);
        $token = $routes['3'];
        $p = ORM::for_table('sys_pg')
            ->where('processor', 'braintree')
            ->find_one();
        if ($p) {
            $merchantId = $p["value"];
            $publicKey = $p["c1"];
            $privateKey = $p["c2"];
            $account = $p["c3"];
            $environment = $p["c4"];
            $accountname = $p["name"];

            Braintree_Configuration::environment($environment);
            Braintree_Configuration::merchantId($merchantId);
            Braintree_Configuration::publicKey($publicKey);
            Braintree_Configuration::privateKey($privateKey);
            $nonce = isset($_POST["payment_method_nonce"])
                ? $_POST["payment_method_nonce"]
                : 0;
            if ($nonce) {
                // get user
                $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
                // get invoice
                $id = $routes['2'];
                $iid = $id; // invoice ID
                $i = ORM::for_table('sys_invoices')->find_one($iid);
                $d = ORM::for_table('sys_invoices')->find_one($id);
                if ($d) {
                    // we have an invoice, validate token...
                    $token = $routes['3'];
                    $token = str_replace('token_', '', $token);
                    $vtoken = $d['vtoken'];
                    if ($token != $vtoken) {
                        echo 'Sorry Token does not match!';
                        exit();
                    } else {
                        // echo 'TOKEN MATCHES!!!!!!!!!!!!!!!!';
                        $i_credit = $d['credit'];
                        $i_due = '0.00';
                        $i_total = $d['total'];
                        $amount = $i_total - $i_credit;
                        $invoiceid = $d['id'];

                        $result = Braintree_Transaction::sale([
                            'amount' => $amount,
                            'orderId' => $id,
                            'paymentMethodNonce' => $nonce,
                            'options' => [
                                'submitForSettlement' => true,
                            ],
                        ]);

                        if ($result->success) {
                            $invoiceview =
                                U .
                                "invoices/pdf/$invoiceid/view/token_$vtoken";
                            $invoiceprint =
                                U . "iview/print/$invoiceid/token_$vtoken";

                            // Thank you! Your payment has been successfully processed for $16.95
                            $ins = "Success!: Thank you for your payment.";
                            //                            $ins.= "<br />".'To PRINT your invoice click here <br> <a class="btn btn-primary" href="'.$invoiceprint.'" target="_blank">Print Invoice</a>';
                            //                            $date = $result->transaction->createdAt->date; //"2015-06-15 18:52:57.000000"
                            //                            $amount = $result->transaction->amount;
                            //                            $amount = Finance::amount_fix($amount);
                            //                            $payerid = $a["id"];
                            //                            $pmethod = 'Braintree';
                            //                            $amount = str_replace($config['currency_code'], '', $amount);
                            //                            $amount = str_replace(',', '', $amount);
                            //                            if (!is_numeric($amount)) {
                            //                                $msg .= 'Invalid Amount' . '<br>';
                            //                            }
                            //                            $cat = 'Consulting'; //77; // Consulting income. This should already be defined on the invoice or line item.

                            //                            $description = $p["name"]; //'Braintree Payment';
                            //                            $a = ORM::for_table('sys_accounts')->where('id', $account)->find_one(); // get braintree balance
                            //                            $cbal = $a['balance']; // customer balance
                            //                            $nbal = $cbal + $amount;
                            //                            $a->balance = $nbal;
                            //                            $a->save(); // update customer balance
                            //                            $d = ORM::for_table('sys_transactions')->create(); // BOF add a transaction
                            //                            $d->account = $accountname;
                            //                            $d->type = 'Income';
                            //                            $d->payerid = $payerid;
                            //
                            //                            $d->amount = $amount;
                            //                            $d->category = $cat;
                            //                            $d->method = $pmethod;
                            //                            $d->description = 'Invoice '.$id .' Payment'; //$description;
                            //                            $d->date = date('Y-m-d');//"2015-06-15 18:52:57.000000"
                            //                            $d->dr = '0.00';
                            //                            $d->cr = $amount;
                            //                            $d->bal = $nbal;
                            //                            $d->iid = $iid;
                            //                            $d->save(); // BOF add a transaction
                            //                            $tid = $d->id();
                            //                            // log it...
                            //                            _log('New Deposit: ' . $description . ' [TrID: ' . $tid . ' | Amount: ' . $amount . ']', 'Admin',$payerid);
                            //                            _msglog('s', 'Transaction Added Successfully');

                            if ($i) {
                                $pc = $i['credit'];
                                $it = $i['total'];
                                $dp = $it - $pc;
                                if ($dp == $amount or $dp < $amount) {
                                    $i->status = 'Paid';
                                    $i->datepaid = date('Y-m-d H:i:s');
                                    Event::trigger(
                                        'invoices/markpaid/',
                                        $invoice = $i
                                    );
                                } else {
                                    $i->status = 'Partially Paid';
                                }
                                $i->credit = $pc + $amount;
                                $i->paymentmethod = $accountname;
                                $i->save();
                            } //if ($i) {
                        } elseif ($result->transaction) {
                            $ins = "Error processing transaction:";
                            $ins .=
                                "\n  code: " .
                                $result->transaction->processorResponseCode;
                            $ins .=
                                "\n  text: " .
                                $result->transaction->processorResponseText;
                        } else {
                            $ins = "Validation errors: \n";
                            $ins .= $result->errors->deepAll();
                        }
                        //                        $ui->assign('ins',$ins);
                        //                        $ui->display('client-ipay.tpl');
                        r2(
                            U .
                                'client/iview/' .
                                $i->id .
                                '/' .
                                $i->vtoken .
                                '/',
                            's',
                            $ins
                        );
                    }
                }
            }
            /* eof bernie changes */
        } else {
            echo 'Payment Gateway Not Found!';
        }

        break;

    case 'ccsubmit':
        $p = ORM::for_table('sys_pg')
            ->where('processor', 'ccavenue')
            ->find_one();

        if ($p) {
            require 'system/lib/misc/ccavenue.php';

            $currency_code = $p['c2'];
            $c3 = $p['c3'];

            if ($c3 != '' and is_numeric($c3) and $c3 != '1') {
                $amount = $amount / $c3;
            }

            $Merchant_Id = $p['value']; //Given to merchant by ccavenue

            $WorkingKey = $p['c1']; //Given to merchant by ccavenue

            $redirect_url = U . "client/ipay_ipn/$invoiceid/token_$ptoken/";

            require 'system/lib/misc/ccsubmit.php';
        }

        break;

    case 'login':
        Event::trigger('client/login/');

        Contacts::isLogged();

        view('hostbilling/client/auth', [
            'type' => 'client_auth',
            'admin' => User::admin(),
        ]);

        break;

    case 'register':
        if ($config['allow_customer_registration'] == 0) {
            abort('404');
        }

        $app->emit('client/register');

        $extra_fields = [];
        $ui->assign('extra_fields', $extra_fields);
        Event::trigger('client/register/');

        Contacts::isLogged();

        view('hostbilling/client/auth', [
            'type' => 'client_register',
            'admin' => User::admin(),
        ]);

        break;

    case 'forgot_pw':
        Event::trigger('client/forgot_pw/');

        view('hostbilling/client/auth', [
            'type' => 'client_password_reset',
        ]);

        break;

    case 'forgot_pw_post':
        Event::trigger('client/forgot_pw_post/');

        $username = _post('username');

        if ($username == '') {
            r2(
                U . 'client/forgot_pw/',
                'e',
                __('No User found with this Email')
            );
        }

        $d = ORM::for_table('crm_accounts')
            ->where('email', $username)
            ->find_one();

        if ($d) {
            //

            $fullname = $d->account;

            $password = Misc::random_string(8);

            $password_hash = Password::_crypt($password);

            $d->password = $password_hash;

            $d->save();

            $subject = 'Password Reset for ' . $config['CompanyName'];
            $message =
                '<p>Your Password has been reset to: ' .
                $password .
                ' Go to this link to login with new password- ' .
                U .
                'client/login/</p>';

            Email::sendEmail(
                $config,
                $_L,
                $fullname,
                $username,
                $subject,
                $message,
                $d->id()
            );

            r2(
                U . 'client/login/',
                's',
                'New Password has been sent to your email.'
            );
        } else {
            r2(
                U . 'client/forgot_pw/',
                'e',
                __('No User found with this Email')
            );
        }

        break;

    case 'auth':
        Event::trigger('client/auth/');

        $username = _post('username');
        $password = _post('password');

        $remember_me = _post('remember_me');
        $auth = false;

        if (
            $config['recaptcha'] == '1' &&
            !empty($config['recaptcha_secretkey'])
        ) {
            $result = sp_verify_recaptcha(
                $config['recaptcha_secretkey'],
                _post('token')
            );

            if (!$result) {
                responseWithError('A server error occurred.');
            }

            if ($result->success && $result->score >= 0.5) {
                $auth = Contacts::login($username, $password);
            } else {
                responseWithError($_L['Recaptcha Verification Failed']);
            }
        } else {
            $auth = Contacts::login($username, $password);
        }

        if ($auth) {
            // store authentication key in the cookies

            // _log('Client Login Successful','Client',);

            if ($remember_me == 'yes') {
                setcookie(
                    'cloudonex_client_token',
                    $auth,
                    time() + 86400 * 30,
                    "/"
                ); // 86400 = 1 day
            } else {
                $_SESSION['cloudonex_client_token'] = $auth;
            }

            // $app->emit('client_auth_successful');
            //            r2(U . 'client/dashboard/');

            $redirect_url = U . 'client/dashboard/';
            if ($shopping_cart) {
                $redirect_url = U . 'client/checkout';
            }

            api_response([
                'success' => true,
                'redirect_url' => $redirect_url,
            ]);
        } else {
            //            r2(U . 'client/login/', 'e', $_L['Invalid Username or Password']);
            responseWithError($_L['Invalid Username or Password']);
        }

        break;

    case 'choose-language':
        $language_iso_code = route(2);

        $user = Contacts::details();
        $user->language = $language_iso_code;
        $user->save();

        $_SESSION['language'] = $language_iso_code;

        r2(U . 'client/dashboard');

        break;

    case 'auto_login':
        Event::trigger('client/auto_login/');

        break;

    case 'register_post':
        if ($config['allow_customer_registration'] == 0) {
            abort('404');
        }

        $msg = '';

        $data = [];

        Event::trigger('client/register_post/');
        $app->emit('client/register_post');

        if (
            $config['recaptcha'] == '1' &&
            !empty($config['recaptcha_secretkey'])
        ) {
            $result = sp_verify_recaptcha(
                $config['recaptcha_secretkey'],
                _post('token')
            );

            if (!$result) {
                responseWithError('A server error occurred.');
            }

            if (!$result->success || $result->score < 0.5) {
                responseWithError($_L['Recaptcha Verification Failed']);
            }
        }

        $data['account'] = _post('fullname');
        $data['email'] = _post('email');
        $data['password'] = _post('password');
        $data['password2'] = _post('password2');

        $o_password = $data['password'];

        if ($data['account'] == '') {
            $msg .= 'Fullname is required <br>';
        }

        if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $msg .= $_L['Invalid Email'] . ' <br>';
        }

        if ($data['email'] != '') {
            $f = ORM::for_table('crm_accounts')
                ->where('email', $data['email'])
                ->find_one();

            if ($f) {
                $msg .= $_L['Email already exist'] . ' <br>';
            }
        }

        if ($data['password'] != '') {
            if ($data['password'] != $data['password2']) {
                $msg .= 'Passwords does not match' . '<br>';
            }

            $data['password'] = Password::_crypt($data['password']);
        } else {
            $msg .= 'Password is required <br>';
        }

        // API call for extra fields

        //

        // optional params

        $data['phone'] = _post('phone');
        $data['address'] = _post('address');
        $data['city'] = _post('city');
        $data['zip'] = _post('zip');
        $data['state'] = _post('');
        $data['country'] = _post('country');
        $data['company'] = _post('company');
        $data['created_at'] = date('Y-m-d H:i:s');
        $data['updated_at'] = date('Y-m-d H:i:s');
        $data['email_verified'] = 'No';
        $ip = get_client_ip();
        $data['signed_up_ip'] = $ip;
        $isp = sp_get_host_by_ip($ip);

        if (!$isp) {
            $isp = '';
        }

        $data['isp'] = $isp;
        $data['balance'] = '0.00';
        $data['status'] = 'Active';
        $data['notes'] = '';
        $data['token'] = '';
        $data['img'] = '';
        $data['web'] = '';
        $data['facebook'] = '';
        $data['google'] = '';
        $data['linkedin'] = '';
        $data['twitter'] = '';
        $data['skype'] = '';

        Event::trigger('client_register_post_data_posted');

        if ($msg == '') {
            $d = ORM::for_table('crm_accounts')->create();

            $d->account = $data['account'];
            $d->email = $data['email'];
            $d->phone = $data['phone'];
            $d->address = $data['address'];
            $d->city = $data['city'];
            $d->zip = $data['zip'];
            $d->state = $data['state'];
            $d->country = $data['country'];
            $d->tags = '';

            //others
            $d->fname = '';
            $d->lname = '';
            $d->company = $data['company'];
            $d->jobtitle = '';
            $d->cid = '0';
            $d->o = '0';
            $d->balance = $data['balance'];
            $d->status = $data['status'];
            $d->notes = $data['notes'];
            $d->password = $data['password'];
            $d->token = '';
            $d->ts = '';
            $d->img = $data['img'];
            $d->web = $data['web'];
            $d->facebook = $data['facebook'];
            $d->google = $data['google'];
            $d->linkedin = $data['linkedin'];

            // v 4.2

            $d->gname = '';
            $d->gid = 0;

            $d->signed_up_ip = $ip;
            $d->isp = $data['isp'];

            //

            $d->created_at = $data['created_at'];

            //

            $d->save();
            $cid = $d->id();

            $data['id'] = $cid;

            _log(
                $_L['New Contact Added'] .
                    ' ' .
                    $data['account'] .
                    ' [CID: ' .
                    $cid .
                    ']',
                'Portal Registration'
            );

            $send_email = Email::send_client_welcome_email($data);

            $auth = Contacts::login($data['email'], $o_password);

            if ($auth) {
                // store authentication key in the cookies

                setcookie(
                    'cloudonex_client_token',
                    $auth,
                    time() + 86400 * 30,
                    "/"
                ); // 86400 = 1 day
            }

            //  r2(U . 'client/dashboard/');

            //  Event::trigger('client/client_registered', $data);
            api_response([
                'success' => true,
                'redirect_url' => U . 'client/dashboard/',
            ]);
        } else {
            // echo $msg;
            // r2(U . 'client/register/', 'e', $msg);
            responseWithError($msg);
        }

        break;

    case 'dashboard':
        if (!$contact) {
            redirect_to('client/login');
        }

        $invoices = Invoice::where('userid', $contact->id)
            ->orderBy('id', 'desc')
            ->limit(5)
            ->get();

        $hosting_orders_count = HostingOrder::where(
            'contact_id',
            $contact->id
        )->count();
        $domains_count = DomainOrder::where(
            'contact_id',
            $contact->id
        )->count();
        $tickets_count = Ticket::where('userid', $contact->id)->count();
        $invoices_count = Invoice::where('userid', $contact->id)->count();

        $recent_orders = HostingOrder::where('contact_id', $contact->id)
            ->orderBy('id', 'desc')
            ->limit(5)
            ->get();

        $recent_tickets = Ticket::where('userid', $contact->id)
            ->orderBy('id', 'desc')
            ->limit(5)
            ->get();

        $recent_domains = DomainOrder::where('contact_id', $contact->id)
            ->orderBy('id', 'desc')
            ->limit(5)
            ->get();

        \view('hostbilling/client/dashboard', [
            'selected_navigation' => 'dashboard',
            'invoices' => $invoices,
            'hosting_orders_count' => $hosting_orders_count,
            'domains_count' => $domains_count,
            'tickets_count' => $tickets_count,
            'invoices_count' => $invoices_count,
            'recent_orders' => $recent_orders,
            'recent_tickets' => $recent_tickets,
            'recent_domains' => $recent_domains,
        ]);

        break;

    case 'company':
        $user = Contacts::details();

        if ($user->cid) {
            $company = Company::find($user->cid);
            if ($company) {
                $tab = 'summary';
                \view('client_company', [
                    'user' => $user,
                    'company' => $company,
                    'tab' => $tab,
                    'selected_navigation' => 'company',
                ]);
            }
        }

        break;

    case 'company_summary':
        $user = Contacts::details();

        if ($user->cid) {
            $d = ORM::for_table('sys_companies')->find_one($user->cid);

            if ($d) {
                $url = $d->url;

                if ($url == 'http://') {
                    $url = '';
                }

                echo '<p>

                            <strong>' .
                    $_L['Company Name'] .
                    ': </strong>  ' .
                    $d->company_name .
                    '<br>
                            <strong>' .
                    $_L['URL'] .
                    ': </strong>  ' .
                    $url .
                    '<br>
                            <strong>' .
                    $_L['Email'] .
                    ': </strong>  ' .
                    ($d->email != ''
                        ? '<a href="#" class="send_email">' . $d->email . '</a>'
                        : '') .
                    '<br>
                            <strong>' .
                    $_L['Phone'] .
                    ': </strong>  ' .
                    $d->phone .
                    '<br>
                         
                            
                            



                        </p>

                       
                        
                        ';
            }
        }

        break;

    case 'company_customers':
        $user = Contacts::details();

        if ($user->cid) {
            $cid = $user->cid;

            $customers = ORM::for_table('crm_accounts')
                ->select('id')
                ->select('account')
                ->select('email')
                ->select('phone')
                ->where('cid', $cid)
                ->find_array();

            $tr_customers = '';

            foreach ($customers as $customer) {
                $link_to_sub =
                    'data-fancybox data-type="ajax" data-src="' .
                    U .
                    'client/client_view_sub_client/' .
                    $customer['id'] .
                    '"';

                $tr_customers .=
                    '<tr>
         <th scope="row"><a href="javascript:;" ' .
                    $link_to_sub .
                    '>' .
                    $customer['id'] .
                    '</a></th>
         <td><a href="javascript:;" ' .
                    $link_to_sub .
                    '>' .
                    $customer['account'] .
                    '</a></td>
         <td>' .
                    $customer['email'] .
                    '</td>
         <td>' .
                    $customer['phone'] .
                    '</td>
      </tr>';
            }

            if ($tr_customers == '') {
                $tr_customers =
                    '<tr><td colspan="4">' .
                    $_L['No Data Available'] .
                    '</td></tr>';
            }

            echo '
<h4>' .
                $_L['Customers'] .
                '</h4>
<hr>
<table class="table table-bordered">
   <thead>
      <tr>
         <th>#</th>
         <th>' .
                $_L['Name'] .
                '</th>
         <th>' .
                $_L['Email'] .
                '</th>
         <th>' .
                $_L['Phone'] .
                '</th>
      </tr>
   </thead>
   <tbody>
      ' .
                $tr_customers .
                '
   </tbody>
</table>';
        }

        break;

    case 'client_view_sub_client':
        $user = Contacts::details();

        if (!$user->is_primary_contact) {
            abort('Unauthorised!');
        }

        if (!$user->cid) {
            abort('Does not have sub contact!');
        }

        $id = route(2);

        $client = Contact::find($id);
        if ($client && $client->cid == $user->cid) {
            \view('client_sub_client', [
                'client' => $client,
            ]);
        }

        break;

    case 'company_invoices':
        $user = Contacts::details();

        if ($user->cid) {
            $cid = $user->cid;
            $customers = Contacts::findByCompany($cid);

            if ($customers) {
                $invoices = Invoice::whereIn('userid', $customers)->get();

                $total_invoice_issued_amount = 0;
                $total_paid_amount = 0;
                $total_unpaid_amount = 0;

                foreach ($invoices as $invoice) {
                    $total_invoice_issued_amount += $invoice->total;
                    if ($invoice->status == 'Paid') {
                        $total_paid_amount += $invoice->total;
                    } elseif ($invoice->status == 'Unpaid') {
                        $total_unpaid_amount += $invoice->total;
                    } elseif ($invoice->status == 'Partially Paid') {
                        $total_paid_amount += $invoice->credit;
                        $total_unpaid_amount +=
                            $invoice->total - $invoice->credit;
                    }
                }

                \view('client_sub_invoices', [
                    'invoices' => $invoices,
                    'total_invoice_issued_amount' => $total_invoice_issued_amount,
                    'total_paid_amount' => $total_paid_amount,
                    'total_unpaid_amount' => $total_unpaid_amount,
                ]);
            }
        }

        break;

    case 'company_quotes':
        $user = Contacts::details();

        if ($user->cid) {
            $cid = $user->cid;

            $customers = Contacts::findByCompany($cid);

            if ($customers) {
                $quotes = ORM::for_table('sys_quotes')
                    ->where_in('userid', $customers)
                    ->find_array();

                $dt = '';

                foreach ($quotes as $quote) {
                    $dt .=
                        '<tr>
            <td>' .
                        $quote['id'] .
                        ' </td>
            <td><a href="' .
                        U .
                        'contacts/view/' .
                        $quote['userid'] .
                        '/">' .
                        $quote['account'] .
                        '</a></td>
            <td><a href="' .
                        U .
                        'quotes/view/' .
                        $quote['id'] .
                        '/">' .
                        $quote['subject'] .
                        '</a></td>
            <td class="amount" data-a-dec="." data-a-sep="," data-a-pad="true" data-p-sign="p" data-a-sign="$ " data-d-group="3">' .
                        $quote['total'] .
                        '</td>
            <td>' .
                        $quote['datecreated'] .
                        '</td>
            <td>' .
                        $quote['validuntil'] .
                        '</td>
            <td>' .
                        $quote['stage'] .
                        '</td>
          
        </tr>';
                }

                if ($dt == '') {
                    $tds =
                        '<tr><td colspan="8">' .
                        $_L['No Data Available'] .
                        '</td> </tr>';
                } else {
                    $tds = $dt;
                }
            } else {
                $tds =
                    '<tr><td colspan="8">' .
                    $_L['No Data Available'] .
                    '</td> </tr>';
            }

            echo '<table class="table table-bordered table-hover sys_table">
    <thead>
    <tr>
        <th>#</th>
        <th>' .
                $_L['Customer'] .
                '</th>
        <th>' .
                $_L['Subject'] .
                '</th>
        <th>' .
                $_L['Amount'] .
                '</th>
        <th>' .
                $_L['Date Created'] .
                '</th>
        <th>' .
                $_L['Expiry Date'] .
                '</th>
        <th>' .
                $_L['Stage'] .
                '</th>
    </tr>
    </thead>
    <tbody>

            
           ' .
                $tds .
                ' 
    

    </tbody>
</table>';
        }

        break;

    case 'company_orders':
        $user = Contacts::details();

        if ($user->cid) {
            $cid = $user->cid;

            $customers = Contacts::findByCompany($cid);

            if ($customers) {
                $orders = ORM::for_table('sys_orders')
                    ->where_in('cid', $customers)
                    ->find_array();

                $dt = '';

                foreach ($orders as $order) {
                    $dt .=
                        '<tr>
           
            <td><a href="' .
                        U .
                        'orders/view/' .
                        $order['id'] .
                        '">' .
                        $order['ordernum'] .
                        '</a> </td>
            <td>' .
                        date($config['df'], strtotime($order['date_added'])) .
                        '</td>
            <td><a href="' .
                        U .
                        'contacts/view/' .
                        $order['cid'] .
                        '">' .
                        $order['cname'] .
                        '</a> </td>
            <td>' .
                        $order['amount'] .
                        '</td>
            <td>' .
                        $order['status'] .
                        '</td>
            
            
        </tr>';
                }

                if ($dt == '') {
                    $tds =
                        '<tr><td colspan="5">' .
                        $_L['No Data Available'] .
                        '</td> </tr>';
                } else {
                    $tds = $dt;
                }
            } else {
                $tds =
                    '<tr><td colspan="6">' .
                    $_L['No Data Available'] .
                    '</td> </tr>';
            }

            echo '<table class="table table-bordered table-hover sys_table" style="width: 100%;">
    <thead>
    <tr>
        
                        <th>' .
                $_L['Order'] .
                ' #</th>
                        <th>' .
                $_L['Date'] .
                '</th>
                        <th>' .
                $_L['Customer'] .
                '</th>
                        <th>' .
                $_L['Total'] .
                '</th>
                        <th>' .
                $_L['Status'] .
                '</th>
                        
    </tr>
    </thead>
    <tbody>

            
           ' .
                $tds .
                ' 
    

    </tbody>
</table>';
        }

        break;

    case 'company_transactions':
        $user = Contacts::details();

        if ($user->cid) {
            $cid = $user->cid;
            $customers = Contacts::findByCompany($cid);
            if ($customers) {
                $transactions_payer = ORM::for_table('sys_transactions')
                    ->where_in('payerid', $customers)
                    ->find_array();
                $transactions_payee = ORM::for_table('sys_transactions')
                    ->where_in('payeeid', $customers)
                    ->find_array();

                $transactions = array_merge(
                    $transactions_payer,
                    $transactions_payee
                );

                $dt = '';

                foreach ($transactions as $transaction) {
                    $dt .=
                        '<tr>
            <td>' .
                        $transaction['id'] .
                        ' </td>
            <td>' .
                        $transaction['date'] .
                        '</td>
            <td>' .
                        $transaction['account'] .
                        '</td>
            <td>' .
                        $transaction['type'] .
                        '</td>
          
            <td class="amount" data-a-dec="." data-a-sep="," data-a-pad="true" data-p-sign="p" data-a-sign="$ " data-d-group="3">' .
                        $transaction['amount'] .
                        '</td>
            <td>' .
                        $transaction['description'] .
                        '</td>
            <td>' .
                        $transaction['dr'] .
                        '</td>
            <td>' .
                        $transaction['cr'] .
                        '</td>
            <td>' .
                        $transaction['bal'] .
                        '</td>
            
        </tr>';
                }

                if ($dt == '') {
                    $tds =
                        '<tr><td colspan="10">' .
                        $_L['No Data Available'] .
                        '</td> </tr>';
                } else {
                    $tds = $dt;
                }
            } else {
                $tds =
                    '<tr><td colspan="10">' .
                    $_L['No Data Available'] .
                    '</td> </tr>';
            }

            echo '<table class="table table-bordered table-hover sys_table">
    <thead>
    <tr>
        <th>#</th>
        <th>' .
                $_L['Date'] .
                '</th>
        <th>' .
                $_L['Account'] .
                '</th>
        <th>' .
                $_L['Type'] .
                '</th>
        <th>' .
                $_L['Amount'] .
                '</th>
        <th>' .
                $_L['Description'] .
                '</th>
        <th>' .
                $_L['Dr'] .
                '</th>
        <th>' .
                $_L['Cr'] .
                '</th>
        <th>' .
                $_L['Balance'] .
                '</th>
       
    </tr>
    </thead>
    <tbody>

            
           ' .
                $tds .
                ' 
    

    </tbody>
</table>';
        }

        break;

    case 'invoices':
        Event::trigger('client/invoices/');

        $app->emit('client/invoices/');

        $ui->assign('selected_navigation', 'invoices');
        $ui->assign('_title', $config['CompanyName'] . ' - ' . $_L['Invoices']);

        $c = Contacts::details();

        $ui->assign('user', $c);

        $d = ORM::for_table('sys_invoices')
            ->where('userid', $c->id)
            ->order_by_desc('id')
            ->find_array();

        $count_paid = ORM::for_table('sys_invoices')
            ->where('userid', $c->id)
            ->where('status', 'Paid')
            ->count();

        if ($count_paid == '') {
            $count_paid = 0;
        }

        $count_unpaid = ORM::for_table('sys_invoices')
            ->where('userid', $c->id)
            ->where('status', 'Unpaid')
            ->count();

        if ($count_unpaid == '') {
            $count_unpaid = 0;
        }

        $count_partially_paid = ORM::for_table('sys_invoices')
            ->where('userid', $c->id)
            ->where('status', 'Partially Paid')
            ->count();

        if ($count_partially_paid == '') {
            $count_partially_paid = 0;
        }

        $count_cancelled = ORM::for_table('sys_invoices')
            ->where('userid', $c->id)
            ->where('status', 'Cancelled')
            ->count();

        if ($count_cancelled == '') {
            $count_cancelled = 0;
        }

        $invoices_summary = Invoice::getInvoicesSummaryForCustomer($c->id);

        $total_unpaid_amount = $invoices_summary['total_unpaid_amount'];

        $balance = $c->balance;

        $due_amount = $total_unpaid_amount - $balance;

        $ui->assign('due_amount', $due_amount);
        $ui->assign('d', $d);

        $ui->assign('total_invoice', count($d));

        $xfooter = Asset::js(['chart/echarts.min', 'client/invoices']);

        $ui->assign('xfooter', $xfooter);

        view('client_invoices', [
            'total_paid_amount' => $invoices_summary['total_paid_amount'],
            'total_unpaid_amount' => $invoices_summary['total_unpaid_amount'],
            'total_partially_paid_amount' =>
                $invoices_summary['total_partially_paid_amount'],
            'total_cancelled_amount' =>
                $invoices_summary['total_cancelled_amount'],
            'count_paid' => $count_paid,
            'count_unpaid' => $count_unpaid,
            'count_partially_paid' => $count_partially_paid,
            'count_cancelled' => $count_cancelled,
        ]);

        break;

    case 'quotes':
        Event::trigger('client/quotes/');
        $ui->assign('selected_navigation', 'quotes');
        $ui->assign('_title', $config['CompanyName'] . ' - ' . $_L['Quotes']);

        $c = Contacts::details();

        $ui->assign('user', $c);

        $d = ORM::for_table('sys_quotes')
            ->where_not_equal('stage', 'Draft')
            ->where('userid', $c->id)
            ->find_array();

        $ui->assign('d', $d);

        $ui->assign('total_quotes', count($d));

        $ui->assign(
            'xjq',
            ' $(\'.amount\').autoNumeric(\'init\', {

    aSign: \'' .
                $config['currency_code'] .
                ' \',
    dGroup: ' .
                $config['thousand_separator_placement'] .
                ',
    aPad: ' .
                $config['currency_decimal_digits'] .
                ',
    pSign: \'' .
                $config['currency_symbol_position'] .
                '\',
    aDec: \'' .
                $config['dec_point'] .
                '\',
    aSep: \'' .
                $config['thousands_sep'] .
                '\',
vMax: \'9999999999999999.00\',
                vMin: \'-9999999999999999.00\'

    });'
        );

        view('client_quotes');

        break;

    case 'transactions':
        Event::trigger('client/transactions/');
        $ui->assign('selected_navigation', 'transactions');
        $ui->assign(
            '_title',
            $config['CompanyName'] . ' - ' . $_L['Transactions']
        );

        $c = Contacts::details();

        $cid = $c->id;

        $ui->assign('user', $c);

        if (
            isset($config['hide_expense_client']) &&
            $config['hide_expense_client']
        ) {
            $d = ORM::for_table('sys_transactions')
                ->where(['payerid' => $cid])
                ->find_many();
        } else {
            $d = ORM::for_table('sys_transactions')
                ->where_any_is([['payerid' => $cid], ['payeeid' => $cid]])
                ->find_many();
        }

        $ui->assign('d', $d);

        $ti = ORM::for_table('sys_transactions')
            ->where('payerid', $cid)
            ->sum('cr');
        if ($ti == '') {
            $ti = '0';
        }
        $ui->assign('ti', $ti);
        $te = ORM::for_table('sys_transactions')
            ->where('payeeid', $cid)
            ->sum('dr');
        if ($te == '') {
            $te = '0';
        }

        $ui->assign('total_quotes', count($d));

        $ui->assign(
            'xjq',
            ' $(\'.amount\').autoNumeric(\'init\', {

    aSign: \'' .
                $config['currency_code'] .
                ' \',
    dGroup: ' .
                $config['thousand_separator_placement'] .
                ',
    aPad: ' .
                $config['currency_decimal_digits'] .
                ',
    pSign: \'' .
                $config['currency_symbol_position'] .
                '\',
    aDec: \'' .
                $config['dec_point'] .
                '\',
    aSep: \'' .
                $config['thousands_sep'] .
                '\',
vMax: \'9999999999999999.00\',
                vMin: \'-9999999999999999.00\'

    });'
        );

        view('client_transactions');

        break;

    case 'profile':
        Event::trigger('client/profile/');
        $ui->assign('selected_navigation', 'profile');
        $ui->assign('_title', $config['CompanyName'] . ' - ' . $_L['Profile']);

        $c = Contacts::details();

        $ui->assign('user', $c);

        $ui->assign('d', $c);

        $ui->assign('countries', Countries::all($c->country));

        $cf = ORM::for_table('crm_customfields')
            ->where('ctype', 'crm')
            ->order_by_asc('id')
            ->find_many();
        $ui->assign('cf', $cf);

        view('client_profile');

        break;

    case 'profile-picture-upload':
        $c = Contacts::details();

        if (APP_STAGE == 'Demo') {
            r2(
                U . 'client/profile/',
                'e',
                'Sorry, this option is disabled in the demo mode.'
            );
        }

        $uploader = new Uploader();
        $uploader->setDir('storage/contacts/');
        // $uploader->sameName(true);
        $uploader->setExtensions(['jpg', 'jpeg', 'png']); //allowed extensions list//
        if ($uploader->uploadFile('file')) {
            //txtFile is the filebrowse element name //
            $uploaded = $uploader->getUploadName(); //get uploaded file name, renames on upload//

            $path = 'storage/contacts/' . $uploaded;
            $cropped_path =
                'storage/contacts/contact_' . $c->id . '_' . $uploaded;

            // open file a image resource
            $img = Image::make($path);

            $img->crop(300, 300);

            $img->save($cropped_path);

            $c->img = $cropped_path;

            $c->save();

            r2(U . 'client/profile/', 's', $_L['Data Updated']);
        } else {
            //upload failed
            _msglog('e', $uploader->getMessage()); //get upload error message
        }

        break;

    case 'remove-profile-picture':
        $c = Contacts::details();
        if (APP_STAGE == 'Demo') {
            r2(
                U . 'client/profile/',
                'e',
                'Sorry, this option is disabled in the demo mode.'
            );
        }

        $c->img = '';

        $c->save();

        r2(U . 'client/profile/', 's', $_L['Data Updated']);

        break;

    case 'profile_edit_post':
        Event::trigger('client/profile_edit_post/');
        $c = Contacts::details();
        $id = $c->id;
        $d = ORM::for_table('crm_accounts')->find_one($id);
        if ($d) {
            $account = _post('account');
            $company = _post('company');

            $email = _post('edit_email');

            $phone = _post('phone');
            $address = _post('address');
            $city = _post('city');
            $state = _post('state');
            $zip = _post('zip');
            $country = _post('country');

            $business_number = _post('business_number');

            $msg = '';

            if ($account == '') {
                $msg .= $_L['Account Name is required'] . ' <br>';
            }

            if ($email != $d['email']) {
                $f = ORM::for_table('crm_accounts')
                    ->where('email', $email)
                    ->find_one();

                if ($f) {
                    $msg .= $_L['Email already exist'] . ' <br>';
                }
            }

            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $msg .= $_L['Invalid Email'] . ' <br>';
            }

            $password = _post('password');

            if ($msg == '') {
                $d = ORM::for_table('crm_accounts')->find_one($id);
                $d->account = $account;
                $d->company = $company;

                $d->email = $email;

                $d->phone = $phone;
                $d->address = $address;
                $d->city = $city;
                $d->zip = $zip;
                $d->state = $state;
                $d->country = $country;

                $d->business_number = $business_number;

                if ($password != '') {
                    $d->password = Password::_crypt($password);
                }

                $d->save();

                _msglog('s', $_L['account_updated_successfully']);

                echo $id;
            } else {
                echo $msg;
            }
        } else {
            r2(U . $myCtrl . '/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'logout':
        Event::trigger('client/logout/');
        $c = Contacts::details();

        session_destroy();

        Contacts::logout_using_token($c->token);

        setcookie('cloudonex_client_token', 'expired', 1, "/");

        r2(U . 'client/login/', 's', 'You have successfully logged out.');

        break;

    case 'where':
        r2(U . 'client/home');

        break;

    case 'q_accept':
        $id = route(2);

        $d = ORM::for_table('sys_quotes')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $d->stage = 'Accepted';
            $d->save();

            // Send email confirmations

            $eml = Quote::gen_email($id, 'accepted');

            Email::sendEmail(
                $config,
                $_L,
                $eml['name'],
                $eml['email'],
                $eml['subject'],
                $eml['body']
            );

            $sms = Quote::genSMS($id, 'accepted');

            SMS::send($sms['to'], $sms['sms']);

            //

            // Send to admins

            $users = User::all();

            foreach ($users as $u) {
                if ($u->email_notify == '1') {
                    $message =
                        'Quote- ' .
                        $d->id .
                        ' has been Accepted. You can view this quote- ' .
                        U .
                        'client/q/' .
                        $d->id .
                        '/token_' .
                        $d->vtoken;

                    Email::sendEmail(
                        $config,
                        $_L,
                        $config['CompanyName'],
                        $u->username,
                        $config['CompanyName'] . ' Quote Accpeted',
                        $message
                    );
                }

                if ($u->sms_notify == '1') {
                    $sms = Quote::genSMS($id, 'accepted_admin_notify');

                    SMS::send($u->phonenumber, $sms['sms']);
                }
            }

            r2(U . 'client/q/' . $id . '/token_' . $vtoken . '/');
        }

        break;

    case 'q_decline':
        $id = route(2);

        $d = ORM::for_table('sys_quotes')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $d->stage = 'Lost';
            $d->save();

            // Send email confirmations

            $eml = Quote::gen_email($id, 'cancelled');

            Email::sendEmail(
                $config,
                $_L,
                $eml['name'],
                $eml['email'],
                $eml['subject'],
                $eml['body'],
                $d->id()
            );

            $sms = Quote::genSMS($id, 'cancelled');

            SMS::send($sms['to'], $sms['sms']);

            // Send to admins

            $users = User::all();

            foreach ($users as $u) {
                if ($u->email_notify == '1') {
                    $message =
                        'Quote- ' .
                        $d->id .
                        ' has been cancelled. You can view this quote- ' .
                        U .
                        'client/q/' .
                        $d->id .
                        '/token_' .
                        $d->vtoken;

                    Email::sendEmail(
                        $config,
                        $_L,
                        $config['CompanyName'],
                        $u->username,
                        $config['CompanyName'] . ' Quote Cancelled',
                        $message
                    );
                }

                if ($u->sms_notify == '1') {
                    $sms = Quote::genSMS($id, 'cancelled_admin_notify');

                    SMS::send($u->phonenumber, $sms['sms']);
                }
            }

            r2(U . 'client/q/' . $id . '/token_' . $vtoken . '/');
        }

        break;

    case 'dl':
        require 'system/lib/mime.php';

        $req = route(2);

        $req_e = explode('_', $req);

        $id = $req_e[0];

        $token = $req_e[1];

        $doc = ORM::for_table('sys_documents')->find_one($id);

        if ($doc) {
            $db_token = $doc->file_dl_token;

            if ($db_token != $token) {
                i_close('Token does not match.');
            }

            $file_path = $doc->file_path;

            $file = 'storage/docs/' . $file_path;

            $ext = pathinfo($file_path, PATHINFO_EXTENSION);

            $file_name = $doc->title;

            $file_name = str_replace(' ', '_', $file_name);

            $file_name = strtolower($file_name);

            $dl_file_name = $file_name . '.' . $ext;

            $c_type = mime_content_type($file);

            if (file_exists($file)) {
                $basename = basename($file);

                // $mime = ($mime = getimagesize($file)) ? $mime['mime'] : $mime;
                $mime = mime_content_type($file);
                $size = filesize($file);
                $fp = fopen($file, "rb");
                if (!($mime && $size && $fp)) {
                    // Error.
                    return;
                }

                header("Content-type: " . $mime);
                header("Content-Length: " . $size);
                //  header("Content-Disposition: attachment; filename=" . $basename);
                header(
                    "Content-Disposition: attachment; filename=" . $dl_file_name
                );
                header('Content-Transfer-Encoding: binary');
                header(
                    'Cache-Control: must-revalidate, post-check=0, pre-check=0'
                );
                fpassthru($fp);
            }
        } else {
            i_close('Not Found');
        }

        break;

    case 'downloads':
        $ui->assign('selected_navigation', 'downloads');
        $ui->assign(
            '_title',
            $config['CompanyName'] . ' - ' . $_L['Downloads']
        );

        $c = Contacts::details();

        $ui->assign('user', $c);

        $ids = [];

        $file_ids = ORM::for_table('ib_doc_rel')
            ->where('rtype', 'contact')
            ->where('rid', $c->id)
            ->find_array();

        foreach ($file_ids as $f) {
            $ids[] = $f['did'];
        }

        $file_ids = ORM::for_table('sys_documents')
            ->select('id')
            ->where('is_global', '1')
            ->find_array();

        foreach ($file_ids as $f) {
            $ids[] = $f['id'];
        }

        if (!empty($ids)) {
            $ids = array_unique($ids);
            $d = ORM::for_table('sys_documents')
                ->where_in('id', $ids)
                ->find_many();
        } else {
            $d = [];
        }

        $ui->assign('d', $d);

        view('client_downloads');

        break;

    case 'orders':
        $ui->assign('selected_navigation', 'orders');
        $ui->assign('_title', $config['CompanyName'] . ' - ' . $_L['Orders']);

        $c = Contacts::details();

        $ui->assign('user', $c);

        $d = ORM::for_table('sys_orders')
            ->where('cid', $c->id)
            ->find_array();
        $ui->assign('d', $d);

        $ui->assign(
            'xjq',
            ' $(\'.amount\').autoNumeric(\'init\', {

    
    dGroup: ' .
                $config['thousand_separator_placement'] .
                ',
    aPad: ' .
                $config['currency_decimal_digits'] .
                ',
    pSign: \'' .
                $config['currency_symbol_position'] .
                '\',
    aDec: \'' .
                $config['dec_point'] .
                '\',
    aSep: \'' .
                $config['thousands_sep'] .
                '\',
    vMax: \'9999999999999999.00\',
                vMin: \'-9999999999999999.00\'

    });'
        );

        view('client_orders');

        break;

    case 'order_view':
        $ui->assign('selected_navigation', 'orders');
        $ui->assign('_title', $config['CompanyName'] . ' - ' . $_L['Orders']);

        $c = Contacts::details();

        $ui->assign('user', $c);

        $xjq =
            '

    $(\'.amount\').autoNumeric(\'init\', {

    aSign: \'' .
            $config['currency_code'] .
            ' \',
    dGroup: ' .
            $config['thousand_separator_placement'] .
            ',
    aPad: ' .
            $config['currency_decimal_digits'] .
            ',
    pSign: \'' .
            $config['currency_symbol_position'] .
            '\',
    aDec: \'' .
            $config['dec_point'] .
            '\',
    aSep: \'' .
            $config['thousands_sep'] .
            '\',
    vMax: \'999999999999.00\',
                vMin: \'-999999999999.00\'

    });

 ';

        $ui->assign('xjq', $xjq);

        $oid = route(2);
        $ordernum = route(3);

        $order = ORM::for_table('sys_orders')->find_one($oid);

        if ($order) {
            $db_ordernum = $order->ordernum;

            if ($ordernum != $db_ordernum) {
                i_close('Order number does not match.');
            }

            $ui->assign('order', $order);

            $orderItems = OrderItem::where('order_id', $order->id)->get();

            view('client_order_view', [
                'orderItems' => $orderItems,
            ]);
        }

        break;

    case 'autologin':
        $token = route(2);

        $token_length = strlen($token);

        if ($token_length < 20) {
            i_close('Invalid Token.');
        }

        $d = ORM::for_table('crm_accounts')
            ->where('autologin', $token)
            ->find_one();

        if ($d) {
            $auth_key = Misc::random_string(20) . md5(time());

            $d->token = $auth_key;

            $d->save();

            // Autologin successful

            _log($_L['Autologin Successful'], 'Client', $d->id);

            //

            setcookie(
                'cloudonex_client_token',
                $auth_key,
                time() + 86400 * 30,
                "/"
            ); // 86400 = 1 day
            $app->emit('client_auth_successful');

            r2(U . 'client/dashboard/');
        } else {
            i_close('Token Expired.');
        }

        break;

    case 'upload':
        // $c = Contacts::details();

        $token = route(2);
        $iid = route(3);

        $inv = Invoice::find($iid);

        if ($inv) {
            $c = Contact::find($inv->userid);

            if (!$c) {
                exit('Client Not Found');
            }

            if ($inv->vtoken != $token) {
                exit('Invoice Not Found');
            }

            $uploader = new Uploader();
            $uploader->setDir('storage/docs/');
            $uploader->sameName(false);
            $uploader->setExtensions(['zip', 'jpg', 'jpeg', 'png', 'gif']); //allowed extensions list//
            if ($uploader->uploadFile('file')) {
                //txtFile is the filebrowse element name //
                $uploaded = $uploader->getUploadName(); //get uploaded file name, renames on upload//

                $file = $uploaded;
                $msg = 'Uploaded Successfully';
                $success = 'Yes';
            } else {
                //upload failed
                $file = '';
                $msg = $uploader->getMessage();
                $success = 'No';
            }

            $a = [
                'success' => $success,
                'msg' => $msg,
                'file' => $file,
            ];

            _log(
                'Client: ' .
                    $c->account .
                    ' [ ' .
                    $c->email .
                    ' ] Uploaded a File-' .
                    $file,
                'Client',
                $c->id
            );

            header('Content-Type: application/json');

            echo json_encode($a);
        }

        break;

    case 'doc_payment_proof':
        $title = _post('title');
        $file_link = _post('file_link');
        $is_global = '0';
        $rid = _post('rid');
        $rtype = 'invoice';

        $did = Documents::assign($file_link, $title, $is_global, $rid, $rtype);

        if ($did) {
            echo $did;
        } else {
            ib_die($_L['All Fields are Required']);
        }

        break;

    case 'new-order':
        $ui->assign('selected_navigation', 'orders');
        $ui->assign('_title', $config['CompanyName'] . ' - ' . $_L['Orders']);

        $c = Contacts::details();

        $ui->assign('user', $c);

        $ui->assign('xheader', Asset::css(['css/ecommerce', 'modal']));
        $ui->assign('xfooter', Asset::js(['modal']));

        // Find all items

        $ui->assign('items', ORM::for_table('sys_items')->find_array());

        view('client_new_order');

        break;

    case 'view-item':
        $id = route(2);

        $item = ORM::for_table('sys_items')->find_one($id);

        if ($item) {
            $ui->assign('selected_navigation', 'orders');
            $ui->assign('_st', $item->name);

            $ui->assign('item', $item);
            $ui->assign('_title', $item->name);

            $c = Contacts::details();

            $ui->assign('user', $c);

            view('client_view_item');
        }

        break;

    case 'add_fund':
        if ($config['add_fund'] != '1') {
            i_close('This feature is disabled');
        }

        $user = Contacts::details();
        $ui->assign('user', $user);

        $amount = _post('amount');

        //  if(v::numeric()->between($config['add_fund_minimum_deposit'], $config['add_fund_maximum_deposit'])->validate($amount)){
        if (
            is_numeric($amount) &&
            $config['add_fund_minimum_deposit'] <= $amount &&
            $amount <= $config['add_fund_maximum_deposit']
        ) {
            $invoice = Invoice::forSingleItem($user->id, 'Credit', $amount, 1);

            if ($invoice) {
                r2(
                    U .
                        'client/iview/' .
                        $invoice['id'] .
                        '/token_' .
                        $invoice['vtoken']
                );
            }
        } else {
            _msglog(
                'e',
                'Amount shoule be between- ' .
                    $config['add_fund_minimum_deposit'] .
                    ' to ' .
                    $config['add_fund_maximum_deposit']
            );

            r2(U . 'client/dashboard/');
        }

        break;

    case 'pay_with_credit':
        if ($config['add_fund'] != '1') {
            i_close('This feature is disabled');
        }

        $id = $routes['2'];
        $d = ORM::for_table('sys_invoices')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);

            $invoice_total = $d->total;
            $user_balance = $a->balance;

            if ($user_balance == '0.00') {
                i_close('You do not have balance');
            }

            if ($d->status == 'Paid' || $d->status == 'Cancelled') {
                i_close('Can not pay for Invoice Status: ' . $d->status);
            }

            // create a transaction

            if ($invoice_total > $user_balance) {
                // Partially Paid

                $user_new_balance = '0.00';

                $paid_amount = $user_balance;

                $a->balance = $user_new_balance;

                $a->save();

                //                $d->credit = $user_balance;
                //                $d->status = 'Partially Paid';
                //                $d->save();
            } else {
                $user_new_balance = $user_balance - $invoice_total;

                $a->balance = $user_new_balance;

                $paid_amount = $invoice_total;

                $a->save();

                //                $invoice_total_new = $invoice_total-$user_balance;
                //
                //                $d->total = $invoice_total_new;
                //                $d->status = 'Partially Paid';
                //                $d->save();
            }

            // Add Transaction

            $msg = '';
            $account = 'Credit';
            $date = date('Y-m-d');
            $amount = $paid_amount;
            $amount = Finance::amount_fix($amount);
            $payerid = $a->id;
            $pmethod = 'Credit';
            $ref = 'Client Paid with Account Credit';

            $amount = str_replace($config['currency_code'], '', $amount);
            $amount = str_replace(',', '', $amount);

            $cat = _post('cats');
            $iid = $d->id;

            $description = 'Invoice: ' . $d->id . ' Payment from Credit';
            $msg = '';

            $i = $d;

            if ($msg == '') {
                //                //find the current balance for this account
                //                $a = ORM::for_table('sys_accounts')->where('account', $account)->find_one();
                //                $cbal = $a['balance'];
                //                $nbal = $cbal + $amount;
                //                $a->balance = $nbal;
                //                $a->save();

                $d = ORM::for_table('sys_transactions')->create();
                $d->account = $account;
                $d->type = 'Income';
                $d->payerid = $payerid;

                $d->amount = $amount;
                $d->category = $cat;
                $d->method = $pmethod;
                $d->ref = $ref;
                $d->tags = '';

                $d->description = $description;
                $d->date = $date;
                $d->dr = '0.00';
                $d->cr = $amount;
                $d->bal = '0.00';
                $d->iid = $iid;

                //others
                $d->payer = '';
                $d->payee = '';
                $d->payeeid = '0';
                $d->status = 'Cleared';
                $d->tax = '0.00';

                $d->aid = 0;
                $d->updated_at = date('Y-m-d H:i:s');
                //

                $d->save();
                $tid = $d->id();
                _log(
                    $_L['New Deposit'] .
                        ': ' .
                        $description .
                        ' [TrID: ' .
                        $tid .
                        ' | Amount: ' .
                        $amount .
                        ']',
                    'Client',
                    $a->id
                );
                // _msglog('s', 'Transaction Added Successfully');
                //now work with invoice

                if ($i) {
                    $pc = $i['credit'];
                    $it = $i['total'];
                    $dp = $it - $pc;
                    if ($dp == $amount or $dp < $amount) {
                        $i->status = 'Paid';
                    } else {
                        $i->status = 'Partially Paid';
                    }
                    $i->credit = $pc + $amount;
                    $i->save();
                }
                // echo $tid;
            } else {
                // echo '<div class="alert alert-danger fade in">' . $msg . '</div>';
            }

            r2(
                U . 'client/iview/' . $i->id . '/token_' . $i->vtoken,
                's',
                $_L['Payment Successful']
            );
        }

        break;

    case 'receipt':
        $transaction_id = route(2);

        $view_id = route(3);

        $transaction = Transaction::find($transaction_id);

        if ($transaction) {
            $tr_vid = $transaction->vid;

            if ($view_id != $tr_vid) {
                exit('Security Token Does not Match!');
            }

            $currency_symbol = $transaction->currency_symbol;

            $currency = Currency::where('iso_code', $currency_symbol)->first();

            if ($currency) {
                $currency_symbol = $currency->symbol;
            } else {
                $currency_symbol = $config['currency_code'];
            }

            $tr_url =
                U .
                'client/receipt/' .
                $transaction_id .
                '/' .
                $transaction->vid .
                '/render';
            $qr_url = U . 'client/qr/url/' . base64_encode($tr_url);

            $device = route(4);

            if ($device == 'render') {
                $tpl = 'client_receipt_mobile';
            } else {
                $tpl = 'client_receipt';
            }

            $contact = false;

            if ($transaction->payerid != 0 || $transaction->payerid != '') {
                $contact = Contact::find($transaction->payerid);
            }

            if ($transaction->payeeid != 0 || $transaction->payeeid != '') {
                $contact = Contact::find($transaction->payeeid);
            }

            view($tpl, [
                'transaction' => $transaction,
                'currency_symbol' => $currency_symbol,
                'qr_url' => $qr_url,
                'time_format' => $config['df'] . ' H:i:s',
                'contact' => $contact,
            ]);
        } else {
            echo 'Transaction Not Found!';
        }

        break;

    case 'form':
        $id = route(2);
        $embed = route(3, false);

        $lead_form = LeadForm::where('uuid', $id)->first();

        if ($lead_form) {
            if ($embed && $embed !== '') {
                $extend = 'canvas';
            } else {
                $extend = 'paper';
            }

            $form_data = \json_decode($lead_form->form_data);

            \view('client_lead_form', [
                'lead_form' => $lead_form,
                'form_data' => $form_data,
                'embed' => $embed,
                'extend' => $extend,
            ]);
        }

        break;

    case 'save-form':
        $data = $request->all();

        if (isset($data['form_id'])) {
            $lead_form = LeadForm::where('uuid', $data['form_id'])->first();

            if ($lead_form) {
                $lead = new Lead();

                $lead->first_name = $data['first_name'] ?? null;
                $lead->last_name = $data['last_name'] ?? null;
                $lead->email = $data['email'] ?? null;
                $lead->title = $data['title'] ?? null;
                $lead->company = $data['company'] ?? null;
                $lead->phone = $data['phone'] ?? null;
                $lead->address = $data['address'] ?? null;
                $lead->street = $data['street'] ?? null;
                $lead->city = $data['city'] ?? null;
                $lead->state = $data['state'] ?? null;
                $lead->zip = $data['zip'] ?? null;
                $lead->country = $data['country'] ?? null;
                $lead->company = $data['company'] ?? null;
                $lead->memo = $data['memo'] ?? null;
                $lead->form_id = $lead_form->id;

                $lead->save();

                $embed = $data['embed'] ?? false;

                $_SESSION['created_lead_id'] = $lead->id;

                if ($lead_form->webhook_url) {
                    $client = new \GuzzleHttp\Client();

                    $response = $client->request(
                        'POST',
                        $lead_form->webhook_url,
                        [
                            'form_params' => $data,
                        ]
                    );
                }

                if ($embed) {
                    jsonResponse([
                        'url' =>
                            'client/form_submitted/' .
                            $lead_form->uuid .
                            '/embed/',
                    ]);
                } else {
                    jsonResponse([
                        'url' => 'client/form_submitted/' . $lead_form->uuid,
                    ]);
                }
            }
        }

        break;

    case 'form_submitted':
        $id = route(2, false);
        $embed = route(3, false);

        if ($id) {
            $lead_form = LeadForm::where('uuid', $id)->first();

            $lead = false;

            if (isset($_SESSION['created_lead_id'])) {
                $lead = Lead::find($_SESSION['created_lead_id']);
            }

            $success_message_original = html_entity_decode(
                $lead_form->success_message
            );
            $smarty = new Smarty();
            $smarty->assign('lead', $lead);
            $success_message = $smarty->fetch(
                'eval:' . $success_message_original
            );

            if ($lead_form) {
                if ($embed && $embed !== '') {
                    $extend = 'canvas';
                } else {
                    $extend = 'paper';
                }
                \view('client_lead_form_submitted', [
                    'lead_form' => $lead_form,
                    'success_message' => $success_message,
                    'embed' => $embed,
                    'extend' => $extend,
                ]);
            }
        }

        break;

    case 'qr':
        $type = route(2);

        $data = route(3);

        $data = base64_decode($data);

        $qr = new BarcodeQR();

        if ($type == 'url') {
            $qr->url($data);
        }

        $qr->draw(100);

        break;

    case 'modal_view_item':
        $item_id = route(2);

        $item_id = str_replace('item_', '', $item_id);

        $item = Item::find($item_id);

        if ($item) {
            view('client_modal_view_item', [
                'item' => $item,
            ]);
        }

        break;

    case 'ajax_shopping_cart':
        view('client_ajax_shopping_cart', [
            'cart' => Cart::details(),
            'items' => Cart::items(),
        ]);

        break;

    case 'ajax_add_item':
        $item_id = route(2);
        $quantity = route(3);

        $added = Cart::addItem($item_id, $quantity);

        echo $item_id . ' ' . $quantity;

        break;

    case 'tickets':
        $req = route(2);

        $ui->assign('selected_navigation', 'support');
        $ui->assign('_title', $config['CompanyName']);

        switch ($req) {
            case 'new':
                $c = Contacts::details();

                $ui->assign('user', $c);

                $ui->assign(
                    'xheader',
                    Asset::css([
                        'dropzone/dropzone',
                        'sn/summernote',
                        'sn/summernote-bs3',
                        'modal',
                    ])
                );

                $ui->assign(
                    'xfooter',
                    Asset::js([
                        'modal',
                        'dropzone/dropzone',
                        'sn/summernote.min',
                    ])
                );

                $ui->assign('jsvar', 'var files = [];');

                $deps = ORM::for_table('sys_ticketdepartments')
                    ->order_by_asc('sorder')
                    ->find_array();

                $ui->assign('deps', $deps);
                view('client_tickets_new', []);

                break;

            case 'upload_file':
                $c = Contacts::details();
                $uploader = new Uploader();
                $uploader->setDir('storage/tickets/');
                $uploader->sameName(false);
                $uploader->setExtensions(['zip', 'jpg', 'jpeg', 'png', 'gif']); //allowed extensions list//
                if ($uploader->uploadFile('file')) {
                    //txtFile is the filebrowse element name //
                    $uploaded = $uploader->getUploadName(); //get uploaded file name, renames on upload//

                    $file = $uploaded;
                    $msg = 'Uploaded Successfully';
                    $success = 'Yes';
                } else {
                    //upload failed
                    $file = '';
                    $msg = $uploader->getMessage();
                    $success = 'No';
                }

                $a = [
                    'success' => $success,
                    'msg' => $msg,
                    'file' => $file,
                ];

                header('Content-Type: application/json');

                echo json_encode($a);

                break;

            case 'add_post':
                $c = Contacts::details();

                $tickets = new Tickets();

                $t = $tickets->create($c->id);

                header('Content-Type: application/json');

                echo json_encode($t);

                break;

            case 'view':
                $tid = route(3);

                $app->emit('client/tickets/view', [
                    'tid' => $tid,
                ]);

                $c = Contacts::details();
                $ui->assign('user', $c);

                $d = ORM::for_table('sys_tickets')
                    ->where('tid', $tid)
                    ->where('userid', $c->id)
                    ->find_one();

                if ($d) {
                    $ui->assign('d', $d);

                    // find all replies for this ticket

                    $replies = ORM::for_table('sys_ticketreplies')
                        ->where('tid', $d->id)
                        ->where('reply_type', 'Public')
                        ->find_array();
                    $ui->assign('replies', $replies);

                    $ui->display('tickets_view.tpl');
                } else {
                    echo 'Ticket not found';
                }

                break;

            case 'all':
                $c = Contacts::details();
                $ui->assign('user', $c);
                $ds = ORM::for_table('sys_tickets')
                    ->where('userid', $c->id)
                    ->order_by_desc('id')
                    ->find_array();
                $ui->assign('ds', $ds);

                $ui->assign(
                    'xjq',
                    '
        
        $( ".mmnt" ).each(function() {
                    //   alert($( this ).html());
                    var ut = $( this ).html();
                    $( this ).html(moment.unix(ut).fromNow());
                });
        
        '
                );

                view('client_tickets_all');

                break;

            case 'add_reply':
                $c = Contacts::details();

                $tickets = new Tickets();

                $t = $tickets->add_reply();

                header('Content-Type: application/json');

                echo json_encode($t);

                break;

            case 'create':
                $rc = '';

                if ($config['recaptcha'] == '1') {
                    $rc =
                        '<script src=\'https://www.google.com/recaptcha/api.js\'></script>';
                }

                $ui->assign(
                    'xheader',
                    '    <style type="text/css">
        body {

            background-color: #FAFAFA;
            overflow-x: visible;
        }
        .paper {
            margin: 50px auto;

            border: 2px solid #DDD;
            background-color: #FFF;
            position: relative;
            width: 600px;
        }

    </style>' .
                        $rc .
                        Asset::css([
                            'dropzone/dropzone',
                            'redactor/redactor',
                            'modal',
                        ])
                );

                $ui->assign(
                    'xfooter',
                    Asset::js([
                        'modal',
                        'dropzone/dropzone',
                        'redactor/redactor.min',
                    ]) . $PluginManager->js('tickets/js/public')
                );

                $ui->assign('_include', 'client_create');

                $ui->display('wrapper_content.tpl');

                break;

            case 'create_post':
                header('Content-Type: application/json');
                $msg = '';

                if (!isset($_SESSION['recaptcha_verified'])) {
                    $_SESSION['recaptcha_verified'] = false;
                }

                if ($config['recaptcha'] == 1) {
                    if (!$_SESSION['recaptcha_verified']) {
                        if (
                            Ib_Recaptcha::isValid(
                                $config['recaptcha_secretkey']
                            ) == false
                        ) {
                            $msg .=
                                $_L['Recaptcha Verification Failed'] . '<br>';
                        } else {
                            $_SESSION['recaptcha_verified'] = true;
                        }
                    }
                }

                $data = ib_posted_data();

                $email = $data['email'];

                $tickets = new Tickets();

                $t = $tickets->create();

                if ($t['success'] == 'Yes') {
                    _msglog(
                        's',
                        'Ticket - ' .
                            $t['tid'] .
                            ' has been created successfully. Your login access sent to your email- ' .
                            $t['email'] .
                            ' . Please check your Spam box too.'
                    );
                }

                echo json_encode($t);

                break;

            case 'notify':
                $ui->assign('_include', 'client_notify');

                $ui->display('wrapper_content.tpl');

                break;
        }

        break;

    case 'purchase_view':
        $today = date('Y-m-d H:i:s');

        $xfooter = Asset::js(['numeric']);

        $id = $routes['2'];
        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $items = ORM::for_table('sys_purchaseitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('items', $items);
            $trs_c = ORM::for_table('sys_transactions')
                ->where('purchase_id', $id)
                ->count();

            $trs = ORM::for_table('sys_transactions')
                ->where('purchase_id', $id)
                ->order_by_desc('id')
                ->find_many();
            $ui->assign('trs', $trs);
            $ui->assign('trs_c', $trs_c);
            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);
            $ui->assign('a', $a);
            $ui->assign('d', $d);

            $i_credit = $d['credit'];
            $i_due = '0.00';
            $i_total = $d['total'];
            if ($d['credit'] != '0.00') {
                $i_due = $i_total - $i_credit;
            } else {
                $i_due = $d['total'];
            }

            $ui->assign('i_due', $i_due);
            $pgs = ORM::for_table('sys_pg')
                ->where('status', 'Active')
                ->order_by_asc('sorder')
                ->find_many();
            $ui->assign('pgs', $pgs);
            $cf = ORM::for_table('crm_customfields')
                ->where('showinvoice', 'Yes')
                ->order_by_asc('id')
                ->find_many();
            $ui->assign('cf', $cf);

            $x_html = '';

            Event::trigger('view_invoice');

            $ui->assign('xfooter', $xfooter);

            $ui->assign(
                'xjq',
                ' $(\'.amount\').autoNumeric(\'init\', {

    aSign: \'' .
                    $config['currency_code'] .
                    ' \',
    dGroup: ' .
                    $config['thousand_separator_placement'] .
                    ',
    aPad: ' .
                    $config['currency_decimal_digits'] .
                    ',
    pSign: \'' .
                    $config['currency_symbol_position'] .
                    '\',
    aDec: \'' .
                    $config['dec_point'] .
                    '\',
    aSep: \'' .
                    $config['thousands_sep'] .
                    '\',
    vMax: \'9999999999999999.00\',
                vMin: \'-9999999999999999.00\'

    });'
            );

            $ui->assign('x_html', $x_html);

            $inv_files = Invoice::files($id);

            $inv_files_c = count($inv_files);

            $ui->assign('inv_files_c', $inv_files_c);

            $ui->assign('inv_files', $inv_files);

            //

            if (!isset($_SESSION['uid'])) {
                $ip = get_client_ip();
                // log invoice access log

                $country = $_L['Unknown'];
                $city = $_L['Unknown'];
                $lat = '';
                $lon = '';

                if (isset($_SERVER['HTTP_REFERER'])) {
                    $referer = $_SERVER['HTTP_REFERER'];
                } else {
                    $referer = '';
                }

                if (isset($_SERVER['HTTP_USER_AGENT'])) {
                    $browser = $_SERVER['HTTP_USER_AGENT'];
                } else {
                    $browser = '';
                }

                if ($config['maxmind_installed'] == 1) {
                    $l_data = Ip2Location::getDetails($ip);

                    $country = $l_data['country'];
                    $city = $l_data['city'];
                    $lat = $l_data['lat'];
                    $lon = $l_data['lon'];
                }

                $ial = ORM::for_table('ib_invoice_access_log')->create();
                $ial->iid = $id;
                $ial->ip = $ip;
                $ial->browser = $browser;
                $ial->referer = $referer;
                $ial->country = $country;
                $ial->city = $city;
                $ial->viewed_at = $today;
                $ial->customer = $d->account;
                $ial->save();
            }

            //

            if ($a->cid != '' || $a->cid != 0) {
                $company = Company::find($a->cid);
            } else {
                $company = false;
            }

            view('client_purchase_view', [
                'company' => $company,
            ]);
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'purchase_pdf':
        $id = $routes['2'];
        $token = $routes['3'];

        Purchase::pdf($id, 'inline', $token);

        break;

    case 'purchase_print':
        $id = $routes['2'];
        $d = ORM::for_table('sys_purchases')->find_one($id);

        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $items = ORM::for_table('sys_purchaseitems')
                ->where('invoiceid', $id)
                ->order_by_asc('id')
                ->find_many();

            $trs_c = ORM::for_table('sys_transactions')
                ->where('purchase_id', $id)
                ->count();

            $trs = ORM::for_table('sys_transactions')
                ->where('purchase_id', $id)
                ->order_by_desc('id')
                ->find_many();

            $a = ORM::for_table('crm_accounts')->find_one($d['userid']);

            $i_credit = $d['credit'];
            $i_due = '0.00';
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

            if ($a->cid != '' || $a->cid != 0) {
                $company = Company::find($a->cid);
            } else {
                $company = false;
            }

            require 'system/lib/invoices/purchase_print.php';
        } else {
            r2(U . 'customers/list', 'e', $_L['Account_Not_Found']);
        }

        break;

    case 'p_accept':
        $id = route(2);

        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $d->stage = 'Accepted';
            $d->save();

            r2(U . 'supplier/purchase_view/' . $id . '/token_' . $vtoken . '/');
        }

        break;

    case 'p_decline':
        $id = route(2);

        $d = ORM::for_table('sys_purchases')->find_one($id);
        if ($d) {
            $token = $routes['3'];
            $token = str_replace('token_', '', $token);
            $vtoken = $d['vtoken'];
            if ($token != $vtoken) {
                echo 'Sorry Token does not match!';
                exit();
            }

            $d->stage = 'Declined';
            $d->save();

            r2(U . 'supplier/purchase_view/' . $id . '/token_' . $vtoken . '/');
        }

        break;

    case 'uploads':
        $ui->assign('selected_navigation', 'downloads');
        $ui->assign('_title', $config['CompanyName'] . ' - ' . $_L['Uploads']);

        $c = Contacts::details();

        $files = Document::where('cid', $c->id)
            ->orderBy('id', 'desc')
            ->get();

        $upload_max_size = ini_get('upload_max_filesize');
        $post_max_size = ini_get('post_max_size');

        $ui->assign('upload_max_size', $upload_max_size);
        $ui->assign('post_max_size', $post_max_size);

        $ui->assign('xheader', Asset::css(['modal', 'dropzone/dropzone']));
        $ui->assign('xfooter', Asset::js(['modal', 'dropzone/dropzone']));

        view('client_uploads', [
            'user' => $c,
            'files' => $files,
        ]);

        break;

    case 'document_upload':
        $c = Contacts::details();

        if (APP_STAGE == 'Demo') {
            exit();
        }

        $uploader = new Uploader();
        $uploader->setDir('storage/docs/');
        $uploader->sameName(false);

        $uploader->setExtensions([
            'zip',
            'pdf',
            'jpg',
            'png',
            'jpeg',
            'gif',
            'psd',
        ]); //allowed extensions list//

        if ($uploader->uploadFile('file')) {
            //txtFile is the filebrowse element name //
            $uploaded = $uploader->getUploadName(); //get uploaded file name, renames on upload//

            $file = $uploaded;
            $msg = $_L['Uploaded Successfully'];
            $success = 'Yes';
        } else {
            //upload failed
            $file = '';
            $msg = $uploader->getMessage();
            $success = 'No';
        }

        $a = [
            'success' => $success,
            'msg' => $msg,
            'file' => $file,
        ];

        header('Content-Type: application/json');

        echo json_encode($a);

        break;

    case 'save_upload':
        $c = Contacts::details();

        $title = _post('title');
        $file_link = _post('file_link');

        if ($title == '' || $file_link == '') {
            ib_die($_L['All Fields are Required']);
        } else {
            $token = Misc::random_string(30);
            $ext = pathinfo($file_link, PATHINFO_EXTENSION);

            $document = new Document();

            $document->title = $title;
            $document->file_path = $file_link;
            $document->file_dl_token = $token;
            $document->file_mime_type = $ext;

            $document->is_global = 0;

            $document->cid = $c->id;

            $document->save();

            echo $document->id;
        }

        break;

    case 'save-invoice-signature':
        $invoice_id = _post('invoice_id');
        $view_token = _post('view_token');

        $invoice = Invoice::where('id', $invoice_id)
            ->where('vtoken', $view_token)
            ->first();

        if ($invoice) {
            $invoice->signature_data_base64 = $_POST['signData'];
            $invoice->save();
        }

        break;

    case 'payment-stripe':
        $invoice_id = _post('invoice_id');
        $view_token = _post('view_token');
        $invoice = Invoice::where('id', $invoice_id)
            ->where('vtoken', $view_token)
            ->first();

        $payment_gateway = PaymentGateway::where(
            'processor',
            'stripe'
        )->first();

        if ($invoice && $payment_gateway) {
            // Get client

            $contact = Contact::find($invoice->userid);

            $invoice_due_amount = getInvoiceDueAmount($invoice);

            \Stripe\Stripe::setApiKey($payment_gateway->c1);

            $amount = round($invoice_due_amount * 100);
            $amount = (int) $amount;

            $token = $_POST['stripeToken'];
            $charge = \Stripe\Charge::create([
                'amount' => $amount,
                'currency' => $payment_gateway->c2,
                'description' => getInvoiceNumber($invoice),
                'source' => $token,
                'capture' => true,
            ]);

            if (isset($charge->status) && $charge->status == 'succeeded') {
                $invoice->status = 'Paid';
                $invoice->save();
            }

            r2(getInvoicePreviewUrl($invoice), 's', $_L['Payment Successful']);
        }

        break;

    case 'projects':
        $user = Contacts::details();

        $projects = Project::where('contact_id', $user->id)
            ->select([
                'id',
                'name',
                'status',
                'summary',
                'start_date',
                'due_date',
            ])
            ->get();

        view('client_projects', [
            'user' => $user,
            'projects' => $projects,
        ]);

        break;

    case 'project-view':
        $user = Contacts::details();

        $projects = Project::where('contact_id', $user->id)
            ->select([
                'id',
                'name',
                'status',
                'summary',
                'start_date',
                'due_date',
            ])
            ->get();

        view('client_project_view', [
            'user' => $user,
            'projects' => $projects,
        ]);

        break;

    case 'save-shipping-address':
        $user = Contacts::details();

        $validator = new Validator();
        $data = $request->all();
        $validation = $validator->validate($data, [
            //
            'address' => 'required',
            'city' => 'required',
            'zip' => 'required',
            'state' => 'required',
            'country' => 'required',
        ]);

        if ($validation->fails()) {
            responseWithError($_L['All Fields are Required']);
        } else {
            $shipping_address = false;

            if (isset($data['form_id'])) {
                $shipping_address_id = (int) $data['id'];
                $shipping_address = ShippingAddress::find($shipping_address_id);
            }

            if (!$shipping_address) {
                $shipping_address = new ShippingAddress();
            }

            $shipping_address->address_line_1 = $data['address'];
            $shipping_address->city = $data['city'];
            $shipping_address->state = $data['state'];
            $shipping_address->zip = $data['zip'];
            $shipping_address->country = $data['country'];
            $shipping_address->contact_id = $user->id;

            $shipping_address->save();

            //			jsonResponse([
            //				'url' => 'leads/form-builder/'.$shipping_address->id,
            //			]);
        }

        break;

    default:
        echo 'action not defined';
}
