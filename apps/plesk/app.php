<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

authenticate_admin();

$action = route(2);

switch ($action) {
    case 'clients':
        $id = route(3, false);
        if ($id) {
            $server = HostingServer::find($id);
            if ($server && $server->type === 'plesk') {
                $host = $server->host;
                $username = $server->username;
                $password = $server->password;

                try {
                    $response = (new Http())
                        ->withOptions([
                            'verify' => false,
                        ])
                        ->withBasicAuth($username, $password)
                        ->get('https://' . $host . ':8443/api/v2/clients');
                } catch (\Exception $exception) {
                    abort(500, $exception->getMessage());
                }

                $clients = $response->json();

                \view('app_wrapper', [
                    'include' => 'clients', # This is the template file without extension inside views folder
                    'server' => $server,
                    'clients' => $clients,
                ]);
            }
        }
        break;

    case 'sync-accounts':
        $id = (int) _post('id');

        if ($id) {
            $server = HostingServer::find($id);

            if ($server) {
                $accounts = [];
                $errors = false;

                try {
                    $response = (new Http())
                        ->withOptions([
                            'verify' => false,
                        ])
                        ->withBasicAuth($server->username, $server->password)
                        ->get(
                            'https://' . $server->host . ':8443/api/v2/clients'
                        );
                } catch (\Exception $exception) {
                    abort(500, $exception->getMessage());
                }

                $accounts = $response->json();

                foreach ($accounts as $account) {
                    $name = $account['name'];
                    $username = $account['login'];
                    $email = $account['email'];

                    $contact = Contact::where('email', $email)->first();

                    if (!$contact) {
                        $contact = new Contact();
                        $contact->account = $name;
                        $contact->email = $email;
                        $contact->save();
                    }
                }
                jsonResponse([
                    'success' => true,
                ]);
            }
        }

        break;

    default:
        abort(404);
        break;
}
