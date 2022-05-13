<?php
class Validation extends Illuminate\Validation\Factory
{
    public static function init($language)
    {
        return new self(Translator::init($language), new Container());
    }
}
