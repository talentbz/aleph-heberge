<?php

use Iodev\Whois\Factory;

class Whois extends Factory
{
    public static function createDefault()
    {
        return self::get()->createWhois();
    }
}
