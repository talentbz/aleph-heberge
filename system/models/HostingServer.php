<?php
use Illuminate\Database\Eloquent\Model;

class HostingServer extends Model
{
    protected static $hosting_server_provider_relation_type = 'hostbilling_hosting_server_provider';

    public static function getSupportedServerTypes()
    {
        return [
            'cpanel' => [
                'name' => 'cPanel',
            ],
            'plesk' => [
                'name' => 'Plesk',
            ],
            'directadmin' => [
                'name' => 'DirectAdmin',
            ],
            'runcloud' => [
                'name' => 'RunCloud',
            ],
            'vestacp' => [
                'name' => 'VestaCP',
            ],
            'cyberpanel' => [
                'name' => 'CyberPanel',
            ],
            'hestiacp' => [
                'name' => 'Hestia',
            ],
        ];
    }

    public static function availableServertypes()
    {
        $data = [];

        $prefs = SharedPreference::where(
            'relation_type',
            self::$hosting_server_provider_relation_type
        )->get();

        foreach ($prefs as $pref) {
            $value = json_decode($pref->value);
            if (!empty($value->name)) {
                $data[$pref->key] = [
                    'name' => $value->name,
                ];
            }
        }

        $data['cpanel'] = [
            'name' => 'cPanel',
        ];

        $data['directadmin'] = [
            'name' => 'DirectAdmin',
        ];

        return $data;
    }

    public static function addNewProvider($key, $data)
    {
        $pref = new SharedPreference();
        $pref->relation_type = self::$hosting_server_provider_relation_type;
        $pref->relation_id = 0;
        $pref->key = $key;
        $pref->value = json_encode($data);
        $pref->save();
        return $pref;
    }

    public static function removeProvider($key)
    {
        $pref = SharedPreference::where(
            'relation_type',
            self::$hosting_server_provider_relation_type
        )
            ->where('key', $key)
            ->first();

        if ($pref) {
            $pref->delete();
        }
    }
}
