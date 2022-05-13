<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/

_auth();
$ui->assign('selected_navigation', 'contacts');
$ui->assign('_title', $_L['Accounts'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);
switch ($action) {
    case 'ps':
        $can_edit = has_access($user->roleid, 'products_n_services', 'edit');
        $can_delete = has_access(
            $user->roleid,
            'products_n_services',
            'delete'
        );

        $type = _post('stype');
        $name = _post('txtsearch');
        $d = ORM::for_table('sys_items')
            ->where('type', $type)
            ->where_like('name', "%$name%")
            ->order_by_asc('name')
            ->find_array();
        if ($d) {
            echo '<table class="table table-hover">
        <tbody>
        
        <tr>
 
 <td>
 ' .
                $_L['Image'] .
                '
</td>

                <td class="project-title">
                    ' .
                $_L['Name'] .
                '
                </td>
                <td>

                  ' .
                $_L['Cost Price'] .
                '

                </td>
                <td>

                  ' .
                $_L['Sales Price'] .
                '

                </td>
                
                

                <td class="project-actions text-right">

                    ' .
                $_L['Manage'] .
                '
                </td>
            </tr>
        
        
        
        ';

            foreach ($d as $ds) {
                if ($ds['image'] == '') {
                    $img =
                        '<img src="' .
                        APP_URL .
                        '/ui/lib/img/item_placeholder.png">';
                } else {
                    $img =
                        '<img src="' .
                        APP_URL .
                        '/storage/items/thumb' .
                        $ds['image'] .
                        '">';
                }
                $price = ib_money_format($ds['sales_price'], $config);
                $cost_price = ib_money_format($ds['cost_price'], $config);

                $available = round($ds['inventory']);

                if ($available != 0) {
                    $txt_available =
                        '<hr> ' . $_L['Available'] . ': ' . $available;
                } else {
                    $txt_available = '';
                }

                $tax_code_line = '';

                if ($ds['tax_code'] != '') {
                    $tax_code_line =
                        '<br> <small>' .
                        $_L['Tax Code'] .
                        ': ' .
                        $ds['tax_code'] .
                        '</small>';
                }

                $edit_button = '';
                $delete_button = '';

                if ($can_edit) {
                    $edit_button =
                        '<a href="#" class="btn btn-primary cedit" id="e' .
                        $ds['id'] .
                        '"><i class="fal fa-pencil"></i> ' .
                        $_L['Edit'] .
                        ' </a>';
                }

                if ($can_delete) {
                    $delete_button =
                        '<a href="#" class="btn btn-danger cdelete" id="pid' .
                        $ds['id'] .
                        '"><i class="fal fa-trash-alt"></i> ' .
                        $_L['Delete'] .
                        ' </a>';
                }

                echo '


 <tr>
 
 <td>
 ' .
                    $img .
                    '
</td>

                <td class="project-title">
                    <a href="#" class="cedit"  id="t' .
                    $ds['id'] .
                    '">' .
                    $ds['name'] .
                    '</a>
                    <br>
                    <small>' .
                    $_L['Item Code'] .
                    ' ' .
                    $ds['item_number'] .
                    '</small> ' .
                    $tax_code_line .
                    '
                    
                    ' .
                    $txt_available .
                    '
                </td>
                
                <td>

                   ' .
                    $cost_price .
                    '

                </td>
                <td>

                   ' .
                    $price .
                    '

                </td>

                <td class="project-actions text-right">
                
                <div class="btn-group">
                ' .
                    $edit_button .
                    '
                    ' .
                    $delete_button .
                    '
                    <a href="' .
                    U .
                    'inventory/barcode/' .
                    $ds['id'] .
                    '" target="_blank" class="btn btn-dark"><i class="fal fa-barcode"></i> ' .
                    $_L['Barcode'] .
                    ' </a>
</div>

                    
                </td>
            </tr>';
            }

            echo '
        <tr>
 
 <td colspan="5">
&nbsp;
</td>

                
            </tr>
        </tbody>
    </table>';
        } else {
            echo '<h4>' . $_L['Nothing Found'] . '</h4>';
        }

        break;

    default:
        echo 'action not defined';
}
