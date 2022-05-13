<?php
use Illuminate\Database\Eloquent\Model;

class DomainOrder extends Model
{
    public static function saveActivationData($data, $send_email = false)
    {
        $order = self::find($data['order_id']);
        if ($order) {
            $order->activation_subject = $data['activation_subject'];
            $order->activation_message = $data['activation_message'];
            $order->save();
        }
    }
}
