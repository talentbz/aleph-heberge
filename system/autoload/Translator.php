<?php
class Translator extends \Illuminate\Translation\Translator
{
    public static function init($language)
    {
        $loader = new \Illuminate\Translation\FileLoader(
            new Filesystem(),
            'system/i18n/framework'
        );
        return new Translator($loader, $language);
    }
}
