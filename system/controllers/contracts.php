<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

authenticate_admin();

$action = route(1);
switch ($request_method) {
    case 'GET':
        switch ($action) {
            case '':
            case 'list':
                \view('contracts_list', [
                    'selected_navigation' => 'contracts',
                ]);

                break;
            case 'add':
                \view('contract', [
                    'selected_navigation' => 'contracts',
                ]);
                break;
            case 'summary':
                \view('contracts_summary', [
                    'selected_navigation' => 'contracts',
                ]);
                break;
        }
}
