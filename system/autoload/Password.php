<?php
class Password
{
    public static function _crypt($password)
    {
        return password_hash($password, PASSWORD_DEFAULT);
    }

    public static function _verify($user_input, $hashed_password)
    {
        return crypt($user_input, $hashed_password) == $hashed_password;
    }

    public static function _gen()
    {
        $pass = substr(
            str_shuffle(
                str_repeat(
                    'ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@#!123456789',
                    8
                )
            ),
            0,
            8
        );
        return $pass;
    }
}
