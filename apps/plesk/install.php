<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}
HostingServer::addNewProvider('plesk', [
    'name' => 'plesk',
]);