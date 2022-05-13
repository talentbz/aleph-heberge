<?php
class Ed
{
    public static function encrypt($pure_string, $encryption_key = '')
    {
        return base64_encode($pure_string);
    }

    public static function decrypt($encrypted_string, $encryption_key = '')
    {
        return base64_decode($encrypted_string);
    }
}
