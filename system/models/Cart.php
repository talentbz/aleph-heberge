<?php
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    protected $table = 'sys_cart';

    public static function addItem($item_id, $qty = 1)
    {
        $cart_create = false;

        $item = Item::find($item_id);


        if ($item) {
            $cid = '0';
            $cloudonex_client_token = false;

            $ip = get_client_ip();

            $today = date('Y-m-d H:i:s');

            if (isset($_COOKIE['cloudonex_client_token'])) {
                $cloudonex_client_token = $_COOKIE['cloudonex_client_token'];
            } elseif (isset($_SESSION['cloudonex_client_token'])) {
                $cloudonex_client_token = $_SESSION['cloudonex_client_token'];
            } else {
                $cid = '0';
            }

            if ($cloudonex_client_token) {
                $d = Contact::where('token', $cloudonex_client_token)->first();

                if ($d) {
                    $cid = $d->id;
                }
            }

            if (isset($_COOKIE['ib_cart_secret'])) {
                $secret = $_COOKIE['ib_cart_secret'];

                $cart = self::where('secret', $secret)->first();

                if ($cart) {
                    $cart_create = false;

                    setcookie(
                        'ib_cart_secret',
                        $secret,
                        time() + 86400 * 30,
                        "/"
                    );
                    $current_items = $cart->items;
                    $current_items_d = json_decode($current_items, true);

                    $e_found = false;

                    $items = [];

                    $i = 0;

                    $item_added = false;

                    $total = 0.0;

                    foreach ($current_items_d as $e_i) {
                        $e_qty = $e_i['qty'];

                        $items[$i]['id'] = $e_i['id'];

                        $items[$i]['name'] = $e_i['name'];
                        $items[$i]['price'] = $e_i['price'];

                        if ($e_i['id'] == $item_id) {
                            $items[$i]['qty'] = $e_qty + $qty;

                            $item_added = true;
                        } else {
                            $items[$i]['qty'] = $e_qty;
                        }

                        $total += $items[$i]['price'] * $items[$i]['qty'];

                        $i++;
                    }

                    if (!$item_added) {
                        $items[$i]['id'] = $item_id;
                        $items[$i]['name'] = $item->name;
                        $items[$i]['price'] = $item->sales_price;
                        $items[$i]['qty'] = $qty;
                        $total += $item->sales_price * $qty;
                    }

                    $items_json = json_encode($items);

                    $cart->items = $items_json;
                    $cart->total = $total;

                    $cart->ip = $ip;
                    $cart->cid = $cid;

                    $cart->updated_at = $today;

                    $cart->item_count = $cart->item_count + $qty;

                    $cart->save();

                    return $secret;
                }

                $cart_create = true;
            }

            $cart_create = true;

            if ($cart_create) {
                $secret = Misc::random_string(20) . md5(time());

                $cart = new self();

                $items = [];

                $items[0]['id'] = $item_id;
                $items[0]['name'] = $item->name;
                $items[0]['price'] = $item->sales_price;
                $items[0]['qty'] = $qty;

                $items_json = json_encode($items);

                $cart->items = $items_json;

                $cart->total = $item->sales_price * $qty;

                setcookie('ib_cart_secret', $secret, time() + 86400 * 30, "/");

                $cart->secret = $secret;

                $cart->item_count = $qty;

                $cart->ip = $ip;

                $cart->created_at = $today;
                $cart->updated_at = $today;

                $cart->cid = $cid;

                $cart->save();

                return $secret;
            }

            return false;
        }

        return false;
    }

    public static function removeItem($item_id, $qty = 1)
    {
        if (isset($_COOKIE['ib_cart_secret'])) {
            $secret = $_COOKIE['ib_cart_secret'];

            $cart = self::where('secret', $secret)->first();

            if ($cart) {
                $today = date('Y-m-d H:i:s');

                $current_items = $cart->items;
                $current_items_d = json_decode($current_items, true);

                $items = [];

                $i = 0;

                $total = 0.0;
                foreach ($current_items_d as $e_i) {
                    $e_qty = $e_i['qty'];

                    if ($e_i['id'] == $item_id) {
                        $qty_check = $e_qty - $qty;

                        if ($qty_check != 0) {
                            $items[$i]['id'] = $e_i['id'];

                            $items[$i]['name'] = $e_i['name'];
                            $items[$i]['price'] = $e_i['price'];

                            $items[$i]['qty'] = $qty_check;
                        }
                    } else {
                        $items[$i]['id'] = $e_i['id'];

                        $items[$i]['name'] = $e_i['name'];
                        $items[$i]['price'] = $e_i['price'];

                        $items[$i]['qty'] = $e_qty;
                    }

                    $total += $items[$i]['price'] * $items[$i]['qty'];

                    $i++;
                }

                $items_json = json_encode($items);

                $cart->items = $items_json;
                $cart->total = $total;

                $cart->updated_at = $today;

                $cart->item_count = $cart->item_count - $qty;

                $cart->save();

                return $secret;
            }

            return false;
        }

        return false;
    }

    public static function deleteItem($item_id)
    {
        if (isset($_COOKIE['ib_cart_secret'])) {
            $secret = $_COOKIE['ib_cart_secret'];

            $cart = self::where('secret', $secret)->first();

            if ($cart) {
                $today = date('Y-m-d H:i:s');

                $current_items = $cart->items;
                $current_items_d = json_decode($current_items, true);

                $items = [];

                $i = 0;

                $total = 0.0;

                $decrease_qty = 0;

                foreach ($current_items_d as $e_i) {
                    if ($e_i['id'] != $item_id) {
                        $e_qty = $e_i['qty'];
                        $items[$i]['id'] = $e_i['id'];
                        $items[$i]['name'] = $e_i['name'];
                        $items[$i]['price'] = $e_i['price'];
                        $items[$i]['qty'] = $e_qty;
                        $total += $items[$i]['price'] * $items[$i]['qty'];
                        $i++;
                    } else {
                        $decrease_qty = $e_i['qty'];
                    }
                }

                $items_json = json_encode($items);

                $cart->items = $items_json;
                $cart->total = $total;

                $cart->updated_at = $today;

                $cart->item_count = $cart->item_count - $decrease_qty;

                $cart->save();

                return $secret;
            }

            return false;
        }

        return false;
    }

    public static function getItemImage($item_id)
    {
        $item = Item::find($item_id);

        $img = APP_URL . '/ui/lib/img/item_placeholder.png"';
        if ($item) {
            if ($item->image != '') {
                $img = APP_URL . '/storage/items/thumb' . $item->image . '"';
            }
        }

        return $img;
    }

    public static function items()
    {
        $items = [];

        if (isset($_COOKIE['ib_cart_secret'])) {
            $secret = $_COOKIE['ib_cart_secret'];

            // check cart exist

            $cart = self::where('secret', $secret)->first();

            if ($cart) {
                $current_items = $cart->items;
                $items = json_decode($current_items, true);
            }
        }

        return $items;
    }

    public static function hasItem()
    {
        if (isset($_COOKIE['ib_cart_secret'])) {
            $secret = $_COOKIE['ib_cart_secret'];

            $cart = self::where('secret', $secret)->first();

            if ($cart) {
                $current_items = $cart->items;
                $current_items_d = json_decode($current_items, true);

                $count = count($current_items_d);

                if ($count > 0) {
                    return true;
                }
            }
        }

        return false;
    }

    public static function details()
    {
        if (isset($_COOKIE['ib_cart_secret'])) {
            $secret = $_COOKIE['ib_cart_secret'];

            $cart = self::where('secret', $secret)->first();

            if ($cart) {
                return $cart;
            }
        }

        return false;
    }

    public static function clearItems()
    {
        if (isset($_COOKIE['ib_cart_secret'])) {
            $secret = $_COOKIE['ib_cart_secret'];

            $cart = self::where('secret', $secret)->first();

            if ($cart) {
                $cart->delete();

                return true;
            }
        }

        return false;
    }
}
