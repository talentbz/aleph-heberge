<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/
_auth();
$ui->assign('selected_navigation', 'settings');
$ui->assign('_title', $_L['Accounts'] . '- ' . $config['CompanyName']);
$action = $routes['1'];
$user = User::_info();
$ui->assign('user', $user);
switch ($action) {
    case 'list':
        $d = ORM::for_table('sys_tax')
            ->order_by_desc('id')
            ->find_many();
        $ui->assign('d', $d);

        Event::trigger('tax/list/');

        view('list-tax');

        break;

    case 'modal-form':
        echo '
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h3>Modal header</h3>
</div>
<div class="modal-body">

<form class="form-horizontal" role="form" id="add_form" method="post">
  <div class="form-group">
    <label for="name" class="col-sm-2 control-label">Name</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="name" id="name">
    </div>
  </div>
  <div class="form-group">
    <label for="rate" class="col-sm-2 control-label">Rate (%)</label>
    <div class="col-sm-2">
      <input type="text" class="form-control" name="rate" id="rate">
    </div>
  </div>
</form>

</div>
<div class="modal-footer">

	<button type="button" data-dismiss="modal" class="btn">Close</button>
	<button id="save" class="btn btn-primary">Save</button>
</div>';

        break;

    case 'edit-form':
        $id = $routes['2'];
        $d = ORM::for_table('sys_tax')->find_one($id);
        if ($d) {
            echo '
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h3>Modal header</h3>
</div>
<div class="modal-body">

<form class="form-horizontal" role="form" id="edit_form" method="post">
  <div class="form-group">
    <label for="name" class="col-sm-2 control-label">Name</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" value="' .
                $d['name'] .
                '" name="name" id="name">
    </div>
  </div>
  <div class="form-group">
    <label for="rate" class="col-sm-2 control-label">Rate (%)</label>
    <div class="col-sm-2">
      <input type="text" class="form-control" name="rate" value="' .
                $d['rate'] .
                '" id="rate">
      <input type="hidden" name="id" value="' .
                $d['id'] .
                '">
    </div>
  </div>
</form>

</div>
<div class="modal-footer">

	<button type="button" data-dismiss="modal" class="btn">Close</button>
	<button id="update" class="btn btn-primary">Update</button>
</div>';
        } else {
            echo 'not found';
        }

        break;

    case 'add-post':
        $msg = '';
        $rate = _post('rate');
        $name = _post('name');
        if ($name == '') {
            $msg .= 'Name is Required <br>';
        }
        if (!is_numeric($rate)) {
            $msg .= 'Invalid Tax Rate <br>';
        }

        if ($msg == '') {
            $d = ORM::for_table('sys_tax')->create();
            $d->name = $name;
            $d->rate = $rate;
            $d->save();
            echo $d->id();
        } else {
            echo $msg;
        }

        break;

    case 'edit-post':
        $msg = '';
        $id = _post('id');
        $rate = _post('rate');
        $name = _post('name');
        if ($name == '') {
            $msg .= 'Name is Required <br>';
        }
        if (!is_numeric($rate)) {
            $msg .= 'Invalid Tax Rate <br>';
        } else {
        }

        if ($msg == '') {
            $d = ORM::for_table('sys_tax')->find_one($id);
            if ($d) {
                $d->name = $name;
                $d->rate = $rate;
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
        $id = $routes['2'];
        $id = str_replace('t', '', $id);
        $d = ORM::for_table('sys_tax')->find_one($id);
        if ($d) {
            $d->delete();
        }
        r2(U . 'tax/list/');
        break;

    case 'rate':
        $tid = _post('tid');
        $d = ORM::for_table('sys_tax')->find_one($tid);
        if ($d) {
            echo $d['rate'];
        } else {
            echo '0.00';
        }
        break;

    default:
        echo 'action not defined';
}
