<?php
if (!defined('APP_RUN')) {
    exit('No direct access allowed');
}
_auth();
$ui->assign('selected_navigation', 'ps');
$ui->assign(
    '_title',
    $_L['Products n Services'] . '- ' . $config['CompanyName']
);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);

if (!has_access($user->roleid, 'products_n_services', 'view')) {
    permissionDenied();
}

switch ($action) {
    case 'modal-list':
        if (!has_access($user->roleid, 'products_n_services', 'view')) {
            permissionDenied();
        }

        $products_and_services = HostingPlan::all();

        $format_currency_override = [];

        if (isset($config['decimal_places_products_and_services'])) {
            $format_currency_override['precision'] =
                $config['decimal_places_products_and_services'];
        }

        $format_currency_override['prefix'] = '';
        $format_currency_override['suffix'] = '';

        \view('hostbilling/admin/ps_modal_list', [
            'products_and_services' => $products_and_services,
            'format_currency_override' => $format_currency_override,
        ]);

        break;

    case 'p-new':
        if (!has_access($user->roleid, 'products_n_services', 'create')) {
            permissionDenied();
        }

        $units = ORM::for_table('sys_units')
            ->order_by_asc('sorder')
            ->find_array();
        $ui->assign('units', $units);

        $ui->assign('type', 'Product');

        $max = ORM::for_table('sys_items')->max('id');
        $nxt = $max + 1;
        $ui->assign('nxt', $nxt);

        view('add-ps');

        break;

    case 's-new':
        if (!has_access($user->roleid, 'products_n_services', 'create')) {
            permissionDenied();
        }

        $ui->assign('type', 'Service');

        $max = ORM::for_table('sys_items')->max('id');
        $nxt = $max + 1;
        $ui->assign('nxt', $nxt);
        view('add-ps');

        break;

    case 'add-post':
        if (is_demo()) {
            exit('Disabled in demo.');
        }

        if (!has_access($user->roleid, 'products_n_services', 'edit')) {
            permissionDenied();
        }

        $msg = '';

        $data = $request->all();

        $name = _post('name');
        $sales_price = _post('sales_price', '0.00');
        $sales_price = Finance::amount_fix($sales_price);
        $item_number = _post('item_number');
        $description = _post('description');
        $type = _post('type');

        // other variables

        // check item number already exist

        if ($item_number != '') {
            $check = ORM::for_table('sys_items')
                ->where('item_number', $item_number)
                ->find_one();
            if ($check) {
                $msg .= 'Item number already exist <br>';
            }
        }

        $inventory = _post('inventory');

        if (!is_numeric($inventory)) {
            $inventory = '0';
        }

        $unit = _post('unit');

        if ($name == '') {
            $msg .= 'Item Name is required <br>';
        }

        $tax_code = _post('tax_code');
        $sales_price = Finance::amount_fix($sales_price);

        if (!is_numeric($sales_price)) {
            $sales_price = '0.00';
        }

        $cost_price = _post('cost_price', '0.00');

        $cost_price = Finance::amount_fix($cost_price);

        if (!is_numeric($cost_price)) {
            $cost_price = '0.00';
        }

        if ($msg == '') {
            $d = ORM::for_table('sys_items')->create();
            $d->name = $name;
            $d->sales_price = $sales_price;
            $d->item_number = $item_number;
            $d->description = $description;
            $d->type = $type;
            $d->unit = $unit;
            $d->inventory = $inventory;
            $d->e = '';

            $d->image = _post('file_link');
            $d->cost_price = $cost_price;

            $d->tax_code = $tax_code;

            if (isset($data['sku'])) {
                $d->sku = $data['sku'];
            }

            if (isset($data['width'])) {
                $d->width = createFromCurrency(
                    $data['width'],
                    $config['home_currency']
                );
            }

            if (isset($data['length'])) {
                $d->length = createFromCurrency(
                    $data['length'],
                    $config['home_currency']
                );
            }

            if (isset($data['height'])) {
                $d->height = createFromCurrency(
                    $data['height'],
                    $config['home_currency']
                );
            }

            if (isset($data['weight'])) {
                $d->weight = createFromCurrency(
                    $data['weight'],
                    $config['home_currency']
                );
            }

            $d->save();

            _msglog('s', $_L['Item Added Successfully']);

            echo $d->id();
        } else {
            echo $msg;
        }
        break;

    case 'p-list':
        if (!has_access($user->roleid, 'products_n_services', 'view')) {
            permissionDenied();
        }

        $paginator = Paginator::bootstrap('sys_items', 'type', 'Product');
        $d = ORM::for_table('sys_items')
            ->where('type', 'Product')
            ->offset($paginator['startpoint'])
            ->limit($paginator['limit'])
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('d', $d);
        $ui->assign('type', 'Product');
        $ui->assign('paginator', $paginator);

        view('ps-list');
        break;

    case 's-list':
        $paginator = Paginator::bootstrap('sys_items', 'type', 'Service');
        $d = ORM::for_table('sys_items')
            ->where('type', 'Service')
            ->offset($paginator['startpoint'])
            ->limit($paginator['limit'])
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('d', $d);
        $ui->assign('type', 'Service');
        $ui->assign('paginator', $paginator);

        view('ps-list');

        break;

    case 'products':
    case 'services':
        $items = Item::select([
            'id',
            'name',
            'item_number',
            'sales_price',
            'cost_price',
            'available',
            'image',
            'category_id',
        ]);

        if ($action === 'products') {
            $items = $items->where('type', 'Product');
        } else {
            $items = $items->where('type', 'Service');
        }

        $items = $items->get();

        $format_currency_override = [];

        if (isset($config['decimal_places_products_and_services'])) {
            $format_currency_override['precision'] =
                $config['decimal_places_products_and_services'];
        }

        \view('products_and_services', [
            'action' => $action,
            'items' => $items,
            'format_currency_override' => $format_currency_override,
            'can_edit' => has_access(
                $user->roleid,
                'products_n_services',
                'edit'
            ),
            'can_delete' => has_access(
                $user->roleid,
                'products_n_services',
                'delete'
            ),
        ]);

        break;

    case 'edit-post':
        if (is_demo()) {
            exit('Disabled in demo.');
        }

        if (!has_access($user->roleid, 'products_n_services', 'edit')) {
            permissionDenied();
        }

        $msg = '';

        $data = $request->all();

        $id = _post('id');

        $name = _post('name');
        $sales_price = _post('sales_price', '0.00');
        $sales_price = Finance::amount_fix($sales_price);
        $item_number = _post('item_number');
        $description = _post('description');
        $type = _post('type');

        // other variables

        $inventory = _post('inventory');

        $inventory = Finance::amount_fix($inventory);

        if (!is_numeric($inventory)) {
            $inventory = '0';
        }

        $unit = _post('unit');

        $msg = '';

        if ($name == '') {
            $msg .= 'Item Name is required <br>';
        }

        $sales_price = Finance::amount_fix($sales_price);

        if (!is_numeric($sales_price)) {
            $sales_price = '0.00';
        }

        $cost_price = _post('cost_price', '0.00');

        $cost_price = Finance::amount_fix($cost_price);

        if (!is_numeric($cost_price)) {
            $cost_price = '0.00';
        }

        if ($msg == '') {
            $d = ORM::for_table('sys_items')->find_one($id);
            if ($d) {
                if ($item_number != '' && $item_number != $d->item_number) {
                    $check = ORM::for_table('sys_items')
                        ->where('item_number', $item_number)
                        ->find_one();
                    if ($check) {
                        i_close('Item Number already exist.');
                    }
                }

                $d->name = $name;
                $d->item_number = $item_number;
                $d->sales_price = $sales_price;
                $d->description = $description;
                $d->unit = $unit;
                $d->inventory = $inventory;

                // other variables

                $d->image = _post('file_link');
                $d->cost_price = $cost_price;

                if (isset($data['sku'])) {
                    $d->sku = $data['sku'];
                }

                if (isset($data['width'])) {
                    $d->width = createFromCurrency(
                        $data['width'],
                        $config['home_currency']
                    );
                }

                if (isset($data['length'])) {
                    $d->length = createFromCurrency(
                        $data['length'],
                        $config['home_currency']
                    );
                }

                if (isset($data['height'])) {
                    $d->height = createFromCurrency(
                        $data['height'],
                        $config['home_currency']
                    );
                }

                if (isset($data['weight'])) {
                    $d->weight = createFromCurrency(
                        $data['weight'],
                        $config['home_currency']
                    );
                }

                $d->save();
                echo $d->id();
            } else {
                echo 'Not Found';
            }
        } else {
            echo $msg;
        }

        break;
    case 'delete':
        if (is_demo()) {
            exit('Disabled in demo.');
        }

        if (!has_access($user->roleid, 'products_n_services', 'delete')) {
            permissionDenied();
        }

        $id = $routes['2'];
        if (APP_STAGE == 'Demo') {
            r2(
                U . 'accounts/list',
                'e',
                'Sorry! Deleting Account is disabled in the demo mode.'
            );
        }
        $d = ORM::for_table('sys_accounts')->find_one($id);
        if ($d) {
            $d->delete();
            r2(U . 'accounts/list', 's', $_L['account_delete_successful']);
        }

        break;

    case 'edit-form':
        if (!has_access($user->roleid, 'products_n_services', 'edit')) {
            exit();
        }

        $id = $routes['2'];
        $d = ORM::for_table('sys_items')->find_one($id);

        if ($d) {
            $price = number_format(
                $d->sales_price,
                2,
                $config['dec_point'],
                $config['thousands_sep']
            );
            $has_img = '';
            if ($d->image != '') {
                $has_img =
                    '<hr>
<img src="' .
                    APP_URL .
                    '/storage/items/' .
                    $d->image .
                    '" class="img-fluid">
';
            }

            \view('ps_edit', [
                'has_img' => $has_img,
                'item' => $d,
            ]);
        } else {
            echo 'not found';
        }

        break;

    case 'json_get':
        if (!has_access($user->roleid, 'products_n_services', 'view')) {
            permissionDenied();
        }

        header('Content-Type: application/json');

        $pid = route(2);

        $d = ORM::for_table('sys_items')->find_one($pid);

        if ($d) {
            $i = [];
            $i['sales_price'] = $d->sales_price;

            echo json_encode($i);
        }

        break;

    case 'cats':
        break;

    case 'upload':
        if (!has_access($user->roleid, 'products_n_services', 'create')) {
            permissionDenied();
        }

        if (APP_STAGE == 'Demo') {
            exit();
        }

        $uploader = new Uploader();
        $uploader->setDir('storage/items/');
        $uploader->sameName(false);
        $uploader->setExtensions(['jpg', 'jpeg', 'png', 'gif']); //allowed extensions list//
        if ($uploader->uploadFile('file')) {
            $uploaded = $uploader->getUploadName(); //get uploaded file name, renames on upload//

            $file = $uploaded;
            $msg = $_L['Uploaded Successfully'];
            $success = 'Yes';

            // create thumb

            $image = new Img();

            // indicate a source image (a GIF, PNG or JPEG file)
            $image->source_path = 'storage/items/' . $file;

            // indicate a target image
            // note that there's no extra property to set in order to specify the target
            // image's type -simply by writing '.jpg' as extension will instruct the script
            // to create a 'jpg' file
            $image->target_path = 'storage/items/thumb' . $file;

            // since in this example we're going to have a jpeg file, let's set the output
            // image's quality
            $image->jpeg_quality = 100;

            // some additional properties that can be set
            // read about them in the documentation
            $image->preserve_aspect_ratio = true;
            $image->enlarge_smaller_images = true;
            $image->preserve_time = true;

            $image->resize(100, 100, ZEBRA_IMAGE_CROP_CENTER);
            $image->target_path = 'storage/items/thumb_400' . $file;

            $image->resize(400, 400, ZEBRA_IMAGE_CROP_CENTER);
        } else {
            //upload failed
            $file = '';
            $msg = $uploader->getMessage();
            $success = 'No';
        }

        $a = [
            'success' => $success,
            'msg' => $msg,
            'file' => $file,
        ];

        header('Content-Type: application/json');

        echo json_encode($a);

        break;

    default:
        echo 'action not defined';
}
