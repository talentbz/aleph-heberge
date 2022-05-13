<?php
class Filesystem extends \Illuminate\Filesystem\Filesystem
{
    public static function manager($container)
    {
        return new \Illuminate\Filesystem\FilesystemManager($container);
    }
}
