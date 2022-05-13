<?php
use Illuminate\Database\Eloquent\Model;

class TaskSchedule extends Model
{
    public static function daily($settings, $language)
    {
        Invoice::generateRecurringInvoices($settings, $language);
    }
}
