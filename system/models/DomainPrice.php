<?php
use Illuminate\Database\Eloquent\Model;

class DomainPrice extends Model
{
    public static function savePrice($data)
    {
        $domain_price = new DomainPrice();
        $domain_price->extension = $data['extension'];
        $domain_price->register = $data['register'];
        $domain_price->transfer = $data['transfer'];
        $domain_price->renew = $data['renew'];
        $domain_price->save();
    }
}
