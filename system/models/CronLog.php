<?php

use Illuminate\Database\Eloquent\Model;

class CronLog extends Model
{
    protected $table = 'sys_schedulelogs';
    public $timestamps = false;
}
