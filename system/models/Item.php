<?php
use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    protected $table = 'sys_items';

    public static function rebuildSalesData()
    {
        return true;
    }
}
