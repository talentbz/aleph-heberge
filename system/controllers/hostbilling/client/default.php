<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}

require 'system/controllers/hostbilling/client/init.php';

\view(get_theme_file('home'), [
    'type' => 'client_auth',
    'admin' => User::admin(),
]);
