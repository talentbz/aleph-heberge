<?php
use GuzzleHttp\Client;

$action = route(1, 'panel');

$api_url = 'https://www.cloudonex.com/api';
$file_id = '';

switch ($action) {
    case 'save-purchase-key':
        $user = User::_info();

        $data = $request->all();

        if (isset($data['purchase_key'])) {
            $client = new Client();

            $response = $client->request(
                'POST',
                $api_url . '/verify-license-key/',
                [
                    'form_params' => [
                        'app_url' => APP_URL,
                        'license_key' => $data['purchase_key'],
                    ],
                ]
            );

            $data = \json_decode((string) $response->getBody());

            if (isset($data->success)) {
                if ($data->success) {
                    update_option('purchase_key', $data->license_key);

                    jsonResponse([
                        'valid' => true,
                    ]);
                } else {
                    $message = '';

                    if (isset($data->errors)) {
                        foreach ($data->errors as $key => $value) {
                            foreach ($value as $error) {
                                $message .= $error . ' <br>';
                            }
                        }
                    }

                    jsonResponse([
                        'valid' => false,
                        'message' => $message,
                    ]);
                }
            } else {
                jsonResponse([
                    'valid' => false,
                    'message' => 'Unable to verify!',
                ]);
            }
        } else {
            jsonResponse([
                'valid' => false,
                'message' => 'Purchase key can not be empty.',
            ]);
        }

        break;

    case 'check-for-update':
        $user = User::_info();

        $client = new Client();

        $response = $client->request('POST', $api_url . '/version-check/', [
            'form_params' => [
                'license_key' => $config['purchase_key'],
                'file_id' => $file_id,
            ],
        ]);

        $data = \json_decode((string) $response->getBody());

        if (isset($data->build) && $config['build'] < $data->build) {
            $status =
                'Your installed build is ' .
                $config['build'] .
                ', the latest build is ' .
                $data->build .
                PHP_EOL .
                'Update available.';
            jsonResponse([
                'status' => $status,
                'continue' => true,
            ]);
        }

        jsonResponse([
            'status' => 'You are using latest version',
            'continue' => false,
        ]);

        break;

    case 'get-download-url':
        $user = User::_info();

        $client = new Client();

        $response = $client->request(
            'POST',
            $api_url . '/download-file-using-license-key/',
            [
                'form_params' => [
                    'license_key' => $config['purchase_key'],
                    'file_id' => $file_id,
                ],
            ]
        );

        $data = \json_decode((string) $response->getBody());

        if (isset($data->success) && $data->success) {
            $status = 'Received download link from the server.';

            $download_url = $data->download_url;

            updateOption('sp_update_signed_url', $download_url, true);

            if (APP_STAGE === 'Demo') {
                $download_url = '---- Hidden in Demo ----';
            }

            jsonResponse([
                'status' => $status,
                'download_url' => $data->download_url,
                'continue' => true,
            ]);
        } elseif (!empty($data->message)) {
            jsonResponse([
                'status' => $data->message,
                'continue' => false,
            ]);
        }

        break;

    case 'download-latest-version':
        $user = User::_info();
        if (!empty($config['sp_update_signed_url'])) {
            $client = new Client();

            $file_name = sp_uuid() . '.zip';

            updateOption('sp_update_file_name', $file_name, true);

            try {
                $client->request('GET', $config['sp_update_signed_url'], [
                    'sink' => './' . $file_name,
                ]);

                jsonResponse([
                    'status' => 'File downloaded to your server.',
                    'continue' => true,
                ]);
            } catch (\Exception $e) {
                jsonResponse([
                    'status' => $e->getMessage(),
                    'continue' => false,
                ]);
            }
        }

        break;

    case 'unzip-downloaded-file':
        $user = User::_info();
        $failed_message =
            'You can still update by just unzipping the file. Go to file manager using your website control panel and you will see a file- ' .
            $config['sp_update_file_name'] .
            ', Just unzip this file and update will be completed.';

        if (!extension_loaded('zip')) {
            jsonResponse([
                'status' =>
                    'PHP zip extension is not available in your server. ' .
                    $failed_message,
                'continue' => false,
            ]);
        }

        if (!empty($config['sp_update_file_name'])) {
            if (APP_STAGE === 'Live' || APP_STAGE === 'Demo') {
                $file = $config['sp_update_file_name'];

                $path = pathinfo(realpath($file), PATHINFO_DIRNAME);

                $zip = new \ZipArchive();
                $res = $zip->open($file);
                if ($res === true) {
                    // extract it to the path we determined above
                    $zip->extractTo($path);
                    $zip->close();

                    jsonResponse([
                        'status' => 'Unzip completed.',
                        'continue' => true,
                    ]);
                } else {
                    jsonResponse([
                        'status' =>
                            'Automatic unzip failed. ' . $failed_message,
                        'continue' => false,
                    ]);
                }
            } else {
                jsonResponse([
                    'status' =>
                        'This option is not available in Demo or Dev mode.',
                    'continue' => false,
                ]);
            }
        }

        break;

    case 'finalize-update':
        $message = Update::singleCommand();

        updateOption('build', $file_build);

        $message .= '---------------------------' . PHP_EOL;

        removeOption('sp_update_signed_url');
        removeOption('sp_update_file_name');

        jsonResponse([
            'status' => $message,
        ]);

        break;

    case 'schema':
        $_SESSION['was_redirected'] = true;
        $message = Update::singleCommand();

        updateOption('build', $file_build);

        $message .= '---------------------------' . PHP_EOL;

        $message .= 'Redirecting, please wait...';

        $script =
            '<script>
    $(function() {
        var delay = 10000;
        var $serverResponse = $("#serverResponse");
        var interval = setInterval(function(){
   $serverResponse.append(\'.\');
}, 500);
        
        setTimeout(function(){ window.location = \'' .
            U .
            'dashboard\'; }, delay);
    });
</script>';

        HtmlCanvas::createTerminal($message, $script);

        break;

    case 'map_with_account':
        is_dev();

        $accounts = Account::all()
            ->keyBy('account')
            ->all();

        $transactions = Transaction::all();

        foreach ($transactions as $transaction) {
            $transaction->account_id = $accounts[$transaction->account]->id;
            $transaction->save();
        }

        break;

    case 'map_with_categories':
        is_dev();

        $categories = TransactionCategory::all()
            ->keyBy('name')
            ->all();

        $transactions = Transaction::all();

        foreach ($transactions as $transaction) {
            if (
                $transaction->category != '' &&
                isset($categories[$transaction->category])
            ) {
                $transaction->cat_id = $categories[$transaction->category]->id;
                $transaction->save();
            }
        }

        break;
}
