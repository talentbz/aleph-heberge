<?php

$ui->assign('selected_navigation', 'support');
$ui->assign('_title', 'Tickets' . ' - ' . $config['CompanyName']);
$user = User::_info();
$ui->assign('user', $user);

$action = route(2);

if (!has_access($user->roleid, 'support', 'view')) {
    permissionDenied();
}

$data = request()->all();

switch ($action) {
    case 'departments':
        $app->emit('tickets/admin/departments');

        $ds = ORM::for_table('sys_ticketdepartments')
            ->order_by_asc('sorder')
            ->find_array();

        $ui->assign('ds', $ds);

        view('tickets_departments');

        break;

    case 'departments_post':
        $msg = '';

        $dname = _post('department_name');
        $email = _post('email');

        if ($dname == '') {
            $msg .= 'Department Name is Required';
        }

        if ($email != '' && filter_var($email, FILTER_VALIDATE_EMAIL) != true) {
            $msg .= 'Invalid Email Address';
        }

        if ($msg == '') {
            $d = ORM::for_table('sys_ticketdepartments')->create();
            $d->dname = $dname;
            $d->email = $email;
            $d->hidden = _post('hidden', '0');
            $d->host = _post('host');
            $d->port = _post('port');
            $d->username = $email;
            $d->password = _post('password');
            $d->encryption = _post('encryption', 'no');
            $d->delete_after_import = _post('delete_after_import', '0');
            $d->sorder = 1;
            $d->save();

            _msglog('s', 'Department Added Successfully');

            echo $d->id();
        } else {
            echo $msg;
        }

        break;

    case 'delete_department':
        $id = route(3);

        $id = str_replace('d', '', $id);

        $d = ORM::for_table('sys_ticketdepartments')->find_one($id);

        if ($d) {
            $d->delete();

            r2(U . 'tickets/admin/departments/', 's', 'Deleted Successfully');
        }

        break;

    case 'edit_department':
        $id = route(3);

        $id = str_replace('e', '', $id);

        $d = ORM::for_table('sys_ticketdepartments')->find_one($id);

        if ($d) {
            echo '<form id="edit_form">
    <div class="modal-body">
        <div class="form-group">
                            <label for="department_name">Department Name</label>
                            <input type="text" name="department_name" class="form-control" id="department_name" value="' .
                $d->dname .
                '">
                        </div>



                        <div class="form-group">
                            <label for="email">Default Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="' .
                $d->email .
                '">
                        </div>

                        <div class="form-group">
                            <label for="host">IMAP Host</label>
                            <input type="text" class="form-control" id="host" name="host" value="' .
                $d->host .
                '">
                        </div>

                        <div class="form-group">
                            <label for="port">IMAP Port</label>
                            <input type="text" class="form-control" id="port" name="port" value="' .
                $d->port .
                '">
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" value="' .
                $d->password .
                '">
                        </div>

                        <div class="form-group">
                            <label for="encryption">Encryption</label>
                            <label class="radio-inline">
                                <input type="radio" name="encryption" value="tls" ' .
                ($d->encryption == 'tls' ? 'checked' : "") .
                '> TLS
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="encryption" value="ssl" ' .
                ($d->encryption == 'ssl' ? 'checked' : "") .
                '> SSL
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="encryption" value="no" ' .
                ($d->encryption == '' ? 'checked' : "") .
                '> No Encryption
                            </label>
                        </div>

                        <hr>

                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"  name="hidden" id="hidden" value="1" ' .
                ($d->hidden == '1' ? 'checked' : "") .
                '> Hide from client?
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="delete_after_import" id="delete_after_import" value="1" ' .
                ($d->delete_after_import == '1' ? 'checked' : "") .
                '> Delete mail after import?
                                </label>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <button class="btn btn-primary test_imap">Test IMAP Connection</button>
    </div>
    <div class="modal-footer">
    <input type="hidden" name="edit_dep" id="edit_dep" value="' .
                $d->id .
                '">
        <button type="button" data-dismiss="modal" class="btn btn-danger">Close</button>
        <button type="button" id="btn_modal_edit_action" class="btn btn-primary edit_submit">Save</button>

    </div></form>';
        }

        break;

    case 'departments_edit':
        $msg = '';

        $edit_dep = _post('edit_dep');

        $d = ORM::for_table('sys_ticketdepartments')->find_one($edit_dep);

        if ($d) {
            $dname = _post('department_name');
            $email = _post('email');

            if ($dname == '') {
                $msg .= 'Department Name is Required';
            }

            if (
                $email != '' &&
                filter_var($email, FILTER_VALIDATE_EMAIL) != true
            ) {
                $msg .= 'Invalid Email Address';
            }

            if ($msg == '') {
                $d->dname = $dname;

                $d->email = $email;
                $d->hidden = _post('hidden', '0');
                $d->host = _post('host');
                $d->port = _post('port');
                $d->username = $email;
                $d->password = _post('password');
                $d->encryption = _post('encryption', 'no');
                $d->delete_after_import = _post('delete_after_import', '0');
                $d->save();

                _msglog('s', 'Department Edited Successfully');

                echo $edit_dep;
            } else {
                echo $msg;
            }
        } else {
            echo $edit_dep . 'dd';
        }

        break;

    case 'departments_reorder':
        $d = ORM::for_table('sys_ticketdepartments')
            ->order_by_asc('sorder')
            ->find_array();
        $ui->assign('ritem', 'Support Ticket Departments');
        $ui->assign('d', $d);
        $ui->assign('display_name', 'dname');
        $ui->display('reorder.tpl', [
            'action' => 'sys_ticketdepartments',
        ]);

        break;

    case 'predefined_replies':
        $ui->assign('xheader', Asset::css(['modal', 'redactor/redactor']));

        $ui->assign('xfooter', Asset::js(['modal', 'redactor/redactor.min']));

        $ui->assign(
            'replies',
            db_find_array('sys_canned_responses', ['id', 'title'], 'asc:sorder')
        );

        view('tickets_predefined_replies');

        break;

    case 'predefined_replies_post':
        $data = sp_purify_data($request->all());

        $ret = Tickets::addPredefinedReply($data);

        if ($ret['success'] == 'Yes') {
            echo $ret['id'];
        } else {
            echo $ret['msg'];
        }

        break;

    case 'predefined_replies_reorder':
        $d = ORM::for_table('sys_canned_responses')
            ->order_by_asc('sorder')
            ->find_array();
        $ui->assign('ritem', 'Predefined Replies');
        $ui->assign('d', $d);

        $ui->assign('display_name', 'title');
        $ui->display('reorder.tpl', [
            'action' => 'sys_canned_responses',
        ]);

        break;

    case 'predefined_replies_delete':
        $id = route(3);

        $id = str_replace('d', '', $id);

        Tickets::deletePredefinedReply($id);

        r2(
            U . 'tickets/admin/predefined_replies/',
            's',
            'Deleted Successfully'
        );

        break;

    case 'predefined_reply_edit':
        $id = route(3);

        $reply = TicketPredefinedReply::find($id);

        if ($reply) {
            view('predefined_reply_edit', [
                'reply' => $reply,
            ]);
        }

        break;

    case 'predefined_reply_edit_post':
        $id = _post('id');

        $reply = TicketPredefinedReply::find($id);

        $title = _post('title');

        $message = $data['message'];

        if ($reply) {
            if ($title == '' || $message == '') {
                r2(
                    U . 'tickets/admin/predefined_reply_edit/' . $id,
                    'e',
                    $_L['All Fields are Required']
                );
            }

            $reply->title = $title;
            $reply->message = $message;
            $reply->save();
            r2(
                U . 'tickets/admin/predefined_reply_edit/' . $id,
                's',
                $_L['Data Updated']
            );
        }

        break;

    case 'create':
        $app->emit('tickets/admin/create');

        if (isset($routes['3']) and $routes['3'] != '') {
            $p_cid = $routes['3'];
            $p_d = ORM::for_table('crm_accounts')->find_one($p_cid);
            if ($p_d) {
                $ui->assign('p_cid', $p_cid);
            }
        } else {
            $ui->assign('p_cid', '');
        }

        $customers = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id')
            ->find_array();
        $ui->assign('customers', $customers);

        $ui->assign(
            'xheader',
            Asset::css(['s2/css/select2.min', 'dropzone/dropzone', 'modal'])
        );

        $deps = ORM::for_table('sys_ticketdepartments')
            ->order_by_asc('sorder')
            ->find_array();

        $ui->assign('deps', $deps);

        view('tickets_admin_create', []);
        break;

    case 'upload_file':
        $uploader = new Uploader();
        $uploader->setDir('storage/tickets/');
        $uploader->sameName(false);
        $uploader->setExtensions(['zip', 'jpg', 'jpeg', 'png', 'gif']); //allowed extensions list//
        if ($uploader->uploadFile('file')) {
            $uploaded = $uploader->getUploadName(); //get uploaded file name, renames on upload//

            $file = $uploaded;
            $msg = 'Uploaded Successfully';
            $success = 'Yes';
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

    case 'add_post':
        header('Content-Type: application/json');
        $cid = _post('cid');

        if ($cid == '') {
            echo json_encode([
                "success" => "No",
                "msg" => 'Please Select Customer',
            ]);

            exit();
        }

        $tickets = new Tickets();

        $t = $tickets->create($cid, $user->id);

        echo json_encode($t);

        break;

    case 'view':
        $id = route(3);

        $app->emit('tickets/admin/view', [
            'tid' => $id,
        ]);

        if (has_access($user->roleid, 'sales', 'edit')) {
            $can_edit_sales = true;
        } else {
            $can_edit_sales = false;
        }

        $d = ORM::for_table('sys_tickets')->find_one($id);

        if ($d) {
            if ($d->ttotal == '') {
                $timeSpent = 0;

                $hh = '00';
                $mm = '00';
            } else {
                $timeSpent = strtotime($d->ttotal) - strtotime('TODAY');
                $timeSpent = (int) $timeSpent;

                $hhmmss = $d->ttotal;
                $hhmmss_split = explode(':', $hhmmss);
                $hh = $hhmmss_split[0];
                $mm = $hhmmss_split[1];
            }

            $ui->assign('d', $d);

            $c = ORM::for_table('crm_accounts')->find_one($d->userid);

            $ui->assign('c', $c);

            if ($d->admin != '0') {
                $a = db_find_one('sys_users', $d->admin);
            } else {
                $a = false;
            }

            $ui->assign('a', $a);

            $replies = ORM::for_table('sys_ticketreplies')
                ->where('tid', $d->id)
                ->find_array();
            $ui->assign('replies', $replies);

            $departments = ORM::for_table('sys_ticketdepartments')
                ->select('id')
                ->select('dname')
                ->find_array();

            $ui->assign('departments', $departments);

            $deps = [];
            $d_x = 0;
            foreach ($departments as $dep) {
                $deps[$d_x]['value'] = $dep['id'];
                $deps[$d_x]['text'] = $dep['dname'];
                $d_x++;
            }

            $jed = json_encode($deps);

            $ads = ORM::for_table('sys_users')
                ->select('id')
                ->select('fullname')
                ->find_array();

            $ui->assign('ads', $ads);

            $aas = [];
            $a_x = 0;
            foreach ($ads as $ad) {
                $aas[$a_x]['value'] = $ad['id'];
                $aas[$a_x]['text'] = $ad['fullname'];
                $a_x++;
            }

            $jaa = json_encode($aas);

            $dd = ORM::for_table('sys_ticketdepartments')
                ->select('dname')
                ->find_one($d->did);

            if ($dd) {
                $department = $dd->dname;
            } else {
                $department = '';
            }

            $ui->assign('department', $department);

            $o_tickets = ORM::for_table('sys_tickets')
                ->where('email', $d->email)
                ->select('status')
                ->select('subject')
                ->select('urgency')
                ->select('created_at')
                ->select('id')
                ->find_array();
            $ui->assign('o_tickets', $o_tickets);

            $invoice = Invoice::where('ticket_id', $d->id)->first();

            $predefined_replies = TicketPredefinedReply::orderBy(
                'sorder',
                'asc'
            )
                ->select(['id', 'title'])
                ->get();

            view('tickets_admin_view', [
                'invoice' => $invoice,
                'ticket' => $d,
                'timeSpent' => $timeSpent,
                'can_edit_sales' => $can_edit_sales,
                'predefined_replies' => $predefined_replies,
                'hh' => $hh,
                'mm' => $mm,
            ]);
        } else {
            echo 'Ticket not found';
        }

        break;

    case 'imap_test':
        $host = _post('host');
        $port = _post('port');
        $username = _post('email');
        $password = _post('password');
        $enc = _post('encryption');

        $imap = imap_open(
            '{' . $host . ':' . $port . '/imap/' . $enc . '}INBOX',
            $username,
            $password
        );

        if ($imap) {
            echo 1;
        } else {
            echo imap_last_error();
        }

        break;

    case 'list':
        $staffs = User::all();

        view('tickets_admin_list', [
            'staffs' => $staffs,
        ]);

        break;

    case 'add_reply':
        $tickets = new Tickets();

        $t = $tickets->add_reply($user->id);

        header('Content-Type: application/json');

        echo json_encode($t);

        break;

    case 'save_note':
        $tid = _post('tid');

        $notes = $data['notes'];

        $ticket = db_find_one('sys_tickets', $tid);

        if ($ticket) {
            $ticket->notes = $notes;
            $ticket->save();
        }

        break;

    case 'delete':
        $tid = route(3);
        $tid = str_replace('t', '', $tid);

        $ticket = db_find_one('sys_tickets', $tid);

        if ($ticket) {
            $ticket->delete();
        }

        $replies = ORM::for_table('sys_ticketreplies')
            ->where('tid', $tid)
            ->find_many();

        foreach ($replies as $reply) {
            $reply->delete();
        }

        $tasks = Task::where('tid', $tid)->get();

        foreach ($tasks as $task) {
            $task->delete();
        }

        r2(U . 'tickets/admin/list/', 's', $_L['delete_successful']);

        break;

    case 'view_modal':
        view('tickets_admin_view_modal');

        break;

    case 'edit_modal':
        $tid = route(3);
        $tid = str_replace('et', '', $tid);
        $tid = str_replace('er', '', $tid);

        $type = route(4);

        if ($type == 'reply') {
            $ui->assign('type', 'reply');

            $ticket = db_find_one('sys_ticketreplies', $tid);
        } else {
            $ui->assign('type', 'ticket');

            $ticket = db_find_one('sys_tickets', $tid);
        }

        if ($ticket) {
            $ui->assign('ticket', $ticket);

            view('tickets_admin_edit_modal');
        }

        break;

    case 'edit_modal_post':
        $tid = _post('tid');

        $type = _post('type');

        $message = $data['message'];

        if ($type == 'reply') {
            $ticket = db_find_one('sys_ticketreplies', $tid);
        } else {
            $ticket = db_find_one('sys_tickets', $tid);
        }

        if ($ticket) {
            $ticket->message = $message;
            $ticket->save();

            echo '1';
        } else {
            echo 'Ticket Not Found';
        }

        break;

    case 'delete_reply':
        $tid = route(3);
        $tid = str_replace('dr', '', $tid);

        $ticket = db_find_one('sys_ticketreplies', $tid);

        if ($ticket) {
            $t = $ticket->tid;

            $ticket->delete();
            r2(U . 'tickets/admin/view/' . $t, 's', $_L['delete_successful']);
        }

        break;

    case 'json_list':
        $columns = [];

        $columns[] = 'tid';
        $columns[] = 'img';
        $columns[] = 'subject';
        $columns[] = 'account';
        $columns[] = 'account';
        $columns[] = 'admin';

        $order_by = $data['order'];

        $o_c_id = $order_by[0]['column'];
        $o_type = $order_by[0]['dir'];

        $a_order_by = $columns[$o_c_id];

        $staffs = User::all()
            ->keyBy('id')
            ->all();

        $account = _post('account');

        $tickets = Ticket::select([
            'id',
            'tid',
            'userid',
            'account',
            'subject',
            'status',
            'aid',
        ]);

        if ($user->roleid) {
            $assigned_departments = Relation::where('type', 'staff_departments')
                ->where('source_id', $user->id)
                ->get()
                ->keyBy('target_id')
                ->keys();

            $tickets = $tickets->whereIn('did', $assigned_departments);
        }

        if ($account != '') {
            $tickets = $tickets->where('account', 'like', "%$account%");
        }

        $email = _post('email');

        if ($email != '') {
            $tickets = $tickets->where('email', 'like', "%$email%");
        }

        $subject = _post('subject');

        if ($subject != '') {
            $tickets = $tickets->where('subject', 'like', "%$subject%");
        }

        $company = _post('company');

        if ($company != '') {
            $contacts_under_companies = Contact::where(
                'company',
                'like',
                '%' . $company . '%'
            )->get();

            $contact_ids = [];
            $contact_ids[] = 0;

            foreach ($contacts_under_companies as $contacts_under_company) {
                $contact_ids[] = $contacts_under_company->id;
            }

            $tickets = $tickets->whereIn('userid', $contact_ids);
        }

        $status = _post('status');

        if ($status != '') {
            $tickets = $tickets->where('status', 'like', "%$status%");
        }

        $staff = _post('staff');
        if ($staff != '') {
            $tickets = $tickets->where('aid', $staff);
        }

        $x = $tickets->get()->toArray();

        $iTotalRecords = $tickets->count();

        $iDisplayLength = (int) $_REQUEST['length'];
        $iDisplayLength =
            $iDisplayLength < 0 ? $iTotalRecords : $iDisplayLength;
        $iDisplayStart = (int) $_REQUEST['start'];
        $sEcho = (int) $_REQUEST['draw'];

        $records = [];
        $records["data"] = [];

        $end = $iDisplayStart + $iDisplayLength;
        $end = $end > $iTotalRecords ? $iTotalRecords : $end;

        if ($o_type == 'desc') {
            $tickets = $tickets->orderBy($a_order_by, 'desc');
        } else {
            $tickets = $tickets->orderBy($a_order_by);
        }

        $tickets = $tickets->limit($iDisplayLength);
        $tickets = $tickets->offset($iDisplayStart);
        $x = $tickets->get()->toArray();

        $i = $iDisplayStart;

        $colors = Colors::colorNames();

        $contacts = Contact::select(['id', 'account', 'company'])
            ->get()
            ->keyBy('id')
            ->toArray();

        $i = 0;

        foreach ($x as $xs) {
            $i++;

            $full_name = $xs['account'];

            $css_bg = $colors[array_rand($colors)];

            $full_name_e = explode(' ', $full_name);

            $first_name = $full_name_e[0];

            $first_name_letter = $first_name[0] ?? '';

            if (isset($full_name_e[1])) {
                $last_name = $full_name_e[1];
                $last_name_letter = $last_name[0];
            } else {
                $last_name_letter = '';
            }

            $img =
                '<span class="clx-avatar ib_bg_' .
                $css_bg .
                '">' .
                $first_name_letter .
                $last_name_letter .
                '</span>';

            $staff_name = '';

            if (isset($staffs[$xs['aid']])) {
                $staff_name = $staffs[$xs['aid']]->fullname;
            }

            $account = mb_convert_encoding($xs['account'], 'UTF-8', 'UTF-8');

            $company = '';

            if (
                isset($contacts[$xs['userid']]) &&
                $contacts[$xs['userid']]['company'] != ''
            ) {
                $company .= mb_convert_encoding(
                    $contacts[$xs['userid']]['company'],
                    'UTF-8',
                    'UTF-8'
                );
            }

            $records["data"][] = [
                0 => $i,
                1 =>
                    '<a href="' .
                    U .
                    'contacts/view/' .
                    $xs['userid'] .
                    '">' .
                    $img .
                    '</a>',
                2 =>
                    mb_convert_encoding($xs['subject'], 'UTF-8', 'UTF-8') .
                    ' <br>' .
                    $xs['tid'],
                3 => $account,
                4 => $company,
                5 => mb_convert_encoding($staff_name, 'UTF-8', 'UTF-8'),
                6 =>
                    '
                <span class="label label-default inline-block"> ' .
                    $xs['status'] .
                    ' </span>
                ',
                7 => $xs['id'],
                8 => $xs['userid'],

                "DT_RowId" => 'row_' . $xs['id'],
            ];
        }

        $records["draw"] = $sEcho;
        $records["recordsTotal"] = $iTotalRecords;
        $records["recordsFiltered"] = $iTotalRecords;

        header("Content-type: application/json; charset=utf-8");
        echo json_encode($records);

        break;

    case 'update_cc':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        if ($value != '' && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            i_close($_L['Invalid Email']);
        }

        if ($d) {
            $d->cc = $value;
            $d->save();
        }

        echo '1';

        break;

    case 'update_hour':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        if (!is_numeric($value)) {
            exit('Invalid data');
        }

        if ($d) {
            $hh = '00';
            $mm = '00';
            $ss = '00';

            if ($d->ttotal != '') {
                $hhmmss = $d->ttotal;
                $hhmmss_split = explode(':', $hhmmss);
                $hh = $hhmmss_split[0];
                $mm = $hhmmss_split[1];
                $ss = $hhmmss_split[2];
            }

            $new_hh = $value;

            $new_total = $new_hh . ':' . $mm . ':' . $ss;

            $d->ttotal = $new_total;

            $d->save();
        }

        echo '1';

        break;

    case 'update_minute':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        if (!is_numeric($value)) {
            exit('Invalid data');
        }

        if ($d) {
            $hh = '00';
            $mm = '00';
            $ss = '00';

            if ($d->ttotal != '') {
                $hhmmss = $d->ttotal;
                $hhmmss_split = explode(':', $hhmmss);
                $hh = $hhmmss_split[0];
                $mm = $hhmmss_split[1];
                $ss = $hhmmss_split[2];
            }

            $new_mm = $value;

            $new_total = $hh . ':' . $new_mm . ':' . $ss;

            $d->ttotal = $new_total;

            $d->save();
        }

        echo '1';

        break;

    case 'update_bcc':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        if ($value != '' && !filter_var($value, FILTER_VALIDATE_EMAIL)) {
            i_close($_L['Invalid Email']);
        }

        if ($d) {
            $d->bcc = $value;
            $d->save();
        }

        echo '1';

        break;

    case 'update_status':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        if ($d) {
            $d->status = $value;
            $d->save();

            _log(
                'Ticket - <a href="' .
                    U .
                    'tickets/admin/view/' .
                    $d->id .
                    '">' .
                    $d->tid .
                    '</a> updated By- ' .
                    $user->fullname .
                    ' Value: ' .
                    $value,
                'Ticket',
                $user->id
            );

            // check related tasks

            $tasks = Task::where('tid', $id)->get();

            foreach ($tasks as $task) {
                $task->status = 'Completed';
                $task->save();
            }
        }

        echo '1';

        break;

    case 'update_department':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        if ($d) {
            $d->did = $value;
            $d->save();
        }

        echo '1';

        break;

    case 'update_assigned_to':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        // Find the user

        $staff = User::find($value);

        if ($staff) {
            Email::sendEmail(
                $config,
                $_L,
                '',
                $staff->username,
                'Ticket assigned: ' . $d->tid,
                'View Ticket- ' . U . 'tickets/admin/view/' . $d->id
            );

            if (
                isset($config['tickets_assigned_sms_notification']) &&
                $config['tickets_assigned_sms_notification'] == 1 &&
                $staff->phonenumber != ''
            ) {
                require 'system/lib/misc/smsdriver.php';

                $tpl = SMSTemplate::where(
                    'tpl',
                    'Ticket Assigned: Admin Notification'
                )->first();

                if ($tpl) {
                    $message = new Template($tpl->sms);
                    $message->set('ticket_id', $d->tid);
                    $message_o = $message->output();
                    spSendSMS($staff->phonenumber, $message_o);
                }
            }
        }

        if ($d) {
            $d->aid = $value;
            $d->save();

            _log(
                'Ticket assigned By- ' .
                    $user->fullname .
                    ' Assigned To: ' .
                    $staff->fullname,
                'Ticket',
                $user->id
            );

            jsonResponse([
                'id' => $d->id,
                'fullname' => $staff->fullname,
                'success' => true,
            ]);
        }

        break;

    case 'update_email':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        $value = _post('value');

        if ($d && filter_var($value, FILTER_VALIDATE_EMAIL)) {
            $d->email = $value;
            $d->save();
            echo '1';
        } else {
            echo 'Invalid Email';
        }

        break;

    case 'reply_make_public':
        $id = route(3);
        $id = str_replace('rp', '', $id);

        $d = db_find_one('sys_ticketreplies', $id);

        if ($d) {
            $d->reply_type = 'public';
            $d->save();

            Tickets::sendReplyNotification($d->tid, $d->message);

            r2(
                U . 'tickets/admin/view/' . $d->tid,
                's',
                'Updated Successfully'
            );
        }

        break;

    case 'tasks_list':
        $tid = route(3);

        $tasks = ORM::for_table('sys_tasks')
            ->where('rel_type', 'Ticket')
            ->where('rel_id', $tid)
            ->select('title')
            ->select('id')
            ->select('status')
            ->order_by_desc('id')
            ->find_array();

        $li = '';

        foreach ($tasks as $task) {
            $li .=
                '<li class="task_item' .
                ($task['status'] == 'Completed' ? ' completed' : '') .
                '" id="t_tasks_' .
                $task['id'] .
                '">
                                <input class="custom-checkbox task-checkbox" id="s_tasks_' .
                $task['id'] .
                '" type="checkbox" value="" name="" ' .
                ($task['status'] == 'Completed' ? ' checked' : '') .
                ' class="i-checks"/>
                                <span class="m-l-xs">' .
                $task['title'] .
                '</span>
                                
                            </li>';
        }

        if ($li == '') {
        } else {
            echo '<ul class="todo-list my-3">
                            
                            ' .
                $li .
                '
                            
                        </ul>';
        }

        break;

    case 'do_task':
        $ids = $data['ids'];
        $do = _post('action');

        if ($do == 'completed') {
            foreach ($ids as $id) {
                $id = str_replace('t_tasks_', '', $id);
                $d = ORM::for_table('sys_tasks')->find_one($id);
                if ($d) {
                    $d->status = 'Completed';
                    $d->save();
                }
            }
        } elseif ($do == 'not_started') {
            foreach ($ids as $id) {
                $id = str_replace('t_tasks_', '', $id);
                $d = ORM::for_table('sys_tasks')->find_one($id);
                if ($d) {
                    $d->status = 'Not Started';
                    $d->save();
                }
            }
        } elseif ($do == 'delete') {
            foreach ($ids as $id) {
                $id = str_replace('t_tasks_', '', $id);
                $d = ORM::for_table('sys_tasks')->find_one($id);
                if ($d) {
                    $d->delete();
                }
            }
        } else {
        }

        echo 'ok';

        break;

    case 'set_task_completed':
        $id = route(3);
        $id = str_replace('s_tasks_', '', $id);
        $d = ORM::for_table('sys_tasks')->find_one($id);
        if ($d) {
            $d->status = 'Completed';
            $d->save();
            echo 'ok';
        }

        break;

    case 'set_task_not_started':
        $id = route(3);
        $id = str_replace('s_tasks_', '', $id);
        $d = ORM::for_table('sys_tasks')->find_one($id);
        if ($d) {
            $d->status = 'Not Started';
            $d->save();
            echo 'ok';
        }

        break;

    case 'update_phone':
        $id = _post('id');

        $d = db_find_one('sys_tickets', $id);

        if ($d) {
            $customer = db_find_one('crm_accounts', $d->userid);

            if ($customer) {
                $customer->phone = _post('value');
                $customer->save();
            }
        }

        echo '1';

        break;

    case 'available_status':
        echo '<div class="form-group">
                                <label for="bulk_status">Status</label>
                                <select class="form-control" id="bulk_status" name="bulk_status" size="1">
                                  
                                    <option value="Open">Open</option>
                                    <option value="On Hold">On Hold</option>
                                    <option value="Escalated">Escalated</option>
                                    <option value="Closed">Closed</option>

                                </select>
                            </div>';

        break;

    case 'set_status':
        $ids_raw = $data['ids'];

        $status = _post('status');

        foreach ($ids_raw as $id_single) {
            $id = str_replace('row_', '', $id_single);
            $t = ORM::for_table('sys_tickets')
                ->select('id')
                ->find_one($id);
            if ($t) {
                $t->status = $status;
                $t->save();
            }
        }

        echo $_L['Data Updated'];

        break;

    case 'settings':
        view('tickets_admin_edit_modal');

        break;

    case 'delete_multiple':
        if (!isset($data['ids'])) {
            exit();
        }

        $ids_raw = $data['ids'];

        $ids = [];

        foreach ($ids_raw as $id_single) {
            $id = str_replace('row_', '', $id_single);
            $ids[] = $id;
        }

        $tickets = ORM::for_table('sys_tickets')
            ->where_id_in($ids)
            ->delete_many();

        foreach ($ids as $id) {
            $tasks = Task::where('tid', $id)->get();

            foreach ($tasks as $task) {
                $task->delete();
            }
        }

        r2(U . 'tickets/admin/list/', 's', $_L['Deleted Successfully']);

        break;

    case 'log_time':
        $ticket_id = _post('ticket_id');

        $ticket = Ticket::find($ticket_id);

        if ($ticket) {
            $ticket->ttotal = _post('total_time');
            $ticket->save();
        }

        break;

    case 'get-predefined-reply':
        $id = route(3);

        $reply = TicketPredefinedReply::find($id);

        if ($reply) {
            echo $reply->message;
        }

        break;
}
