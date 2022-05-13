<?php
use Illuminate\Database\Eloquent\Model;

class Contact extends Model
{
    protected $table = 'crm_accounts';

    /**
     * @return array
     */
    public static function asArray()
    {
        return Contact::all()
            ->keyBy('id')
            ->toArray();
    }

    public static function hasLoginToken()
    {
        if (isset($_COOKIE['cloudonex_client_token'])) {
            return true;
        } elseif (isset($_SESSION['cloudonex_client_token'])) {
            return true;
        }

        return false;
    }

    /**
     * @return bool
     */
    public static function isLoggedIn()
    {
        if (isset($_COOKIE['cloudonex_client_token'])) {
            $cloudonex_client_token = $_COOKIE['cloudonex_client_token'];
        } elseif (isset($_SESSION['cloudonex_client_token'])) {
            $cloudonex_client_token = $_SESSION['cloudonex_client_token'];
        } else {
            return false;
        }

        return self::where('token', $cloudonex_client_token)->first();
    }

    /**
     * @return mixed
     */
    public static function getAllContacts()
    {
        return Contact::select(['id', 'account', 'email', 'phone', 'company'])
            ->orderBy('id', 'desc')
            ->get();
    }
}
