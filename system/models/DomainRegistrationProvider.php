<?php
use Illuminate\Database\Eloquent\Model;
class DomainRegistrationProvider extends Model
{
    protected static $domain_registration_provider_relation_type = 'hostbilling_domain_registration_provider';
    public static function availableProviders()
    {
        $data = [];

        $data['resellerclub'] = [
            'name' => 'Resellerclub',
        ];
        $data['resell_biz'] = [
            'name' => 'Resell.biz',
        ];

        $prefs = SharedPreference::where(
            'relation_type',
            self::$domain_registration_provider_relation_type
        )->get();

        foreach ($prefs as $pref) {
            $value = json_decode($pref->value);
            if (!empty($value->name)) {
                $data[$pref->key] = [
                    'name' => $value->name,
                ];
            }
        }

        return $data;
    }

    public static function addNewProvider($key, $data)
    {
        $pref = new SharedPreference();
        $pref->relation_type =
            self::$domain_registration_provider_relation_type;
        $pref->relation_id = 0;
        $pref->key = $key;
        $pref->value = json_encode($data);
        $pref->save();
        return $pref;
    }
}
