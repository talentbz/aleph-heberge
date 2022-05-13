<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/
_auth();
$ui->assign('selected_navigation', 'tasks');
$ui->assign('_title', $_L['Tasks'] . '- ' . $config['CompanyName']);

$action = route(1, 'list');

$user = User::_info();
$ui->assign('user', $user);

Event::trigger('accounts');

switch ($action) {
    case 'list':
        $mdate = date('Y-m-d');
        $ui->assign('mdate', $mdate);

        $contacts = Contact::select(['id', 'account'])
            ->get()
            ->groupBy('id')
            ->all();
        $tickets = Ticket::select(['id', 'tid'])
            ->get()
            ->groupBy('id')
            ->all();
        $tasks_not_started = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Not Started')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_not_started = $tasks_not_started->where('aid', $user->id);
        }

        $tasks_not_started = $tasks_not_started->find_array();

        $ui->assign('tasks_not_started', $tasks_not_started);

        $tasks_in_progress = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'In Progress')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_in_progress = $tasks_in_progress->where('aid', $user->id);
        }

        $tasks_in_progress = $tasks_in_progress->find_array();

        $ui->assign('tasks_in_progress', $tasks_in_progress);

        $tasks_completed = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Completed')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_completed = $tasks_completed->where('aid', $user->id);
        }

        $tasks_completed = $tasks_completed->find_array();
        $ui->assign('tasks_completed', $tasks_completed);

        $tasks_deferred = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Deferred')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_deferred = $tasks_deferred->where('aid', $user->id);
        }

        $tasks_deferred = $tasks_deferred->find_array();

        $ui->assign('tasks_deferred', $tasks_deferred);

        $tasks_waiting = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Waiting')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_waiting = $tasks_waiting->where('aid', $user->id);
        }

        $tasks_waiting = $tasks_waiting->find_array();

        $ui->assign('tasks_waiting', $tasks_waiting);

        view('tasks', [
            'contacts' => $contacts,
            'tickets' => $tickets,
        ]);

        break;

    case 'create':
        $id = route(2, 0);
        $project_id = route(3, 0);

        $customers_all_data = has_access(
            $user->roleid,
            'customers',
            'all_data'
        );

        $c = ORM::for_table('crm_accounts')
            ->select('id')
            ->select('account')
            ->select('company')
            ->select('email')
            ->order_by_desc('id');

        if (!$customers_all_data) {
            $c->where('o', $user->id);
        }

        $c = $c->find_many();

        $edit = false;

        $relations = ['Customer', 'Invoice', 'Quote', 'Lead'];

        $app->emit('internalRelatedTo', [&$relations]);

        $mdate = date('Y-m-d');

        if (!$id) {
            $task = [];

            $task['id'] = '';
            $task['cid'] = '';
            $task['title'] = '';
            $task['description'] = '';
            $task['status'] = 'Not Started';
            $task['priority'] = '';
            $task['created_at'] = '';
            $task['created_by'] = '';
            $task['updated_at'] = '';
            $task['updated_by'] = '';
            $task['due_date'] = '';
            $task['is_public'] = '';
            $task['started'] = $mdate;
            $task['due_date'] = $mdate;
        } else {
            $id = str_replace('e_', '', $id);

            $task = ORM::for_table('sys_tasks')->find_one($id);

            if ($task) {
                $edit = true;
            }
        }

        $ui->assign('edit', $edit);
        $ui->assign('task', $task);
        $ui->assign('relations', $relations);
        $ui->assign('val', $task);

        view('modal_task_create', [
            'c' => $c,
            'project_id' => $project_id,
        ]);

        break;

    case 'post':
        $title = _post('title');

        $msg = '';

        if ($title == '') {
            $msg .= 'Title is required';
        }

        if ($msg == '') {
            $data = ib_posted_data();

            $data['aid'] = $user->id;
            $data['created_by'] = $user->fullname;

            $task = Tasks::create($data);

            if ($task) {
                echo $task;
            } else {
                echo 'An error occurred';
            }
        } else {
            echo $msg;
        }

        break;

    case 'set_status':
        $id = _post('task_id');
        $id = str_replace('item_', '', $id);

        $d = ORM::for_table('sys_tasks')->find_one($id);

        $target = _post('target');

        switch ($target) {
            case 'not_started':
                $status = 'Not Started';

                if ($d->tid) {
                    $ticket = Ticket::find($d->tid);

                    if ($ticket) {
                        $ticket->status = 'Open';
                        $ticket->save();
                    }
                }

                break;

            case 'in_progress':
                $status = 'In Progress';

                if ($d->tid) {
                    $ticket = Ticket::find($d->tid);

                    if ($ticket) {
                        $ticket->status = 'Open';
                        $ticket->save();
                    }
                }

                break;

            case 'completed':
                $status = 'Completed';

                $d->date_finished = date('Y-m-d');

                if ($d->tid) {
                    $ticket = Ticket::find($d->tid);

                    if ($ticket) {
                        $ticket->status = 'Closed';
                        $ticket->save();
                    }
                }

                break;

            case 'deferred':
                $status = 'Deferred';

                break;

            case 'waiting_on_someone':
                $status = 'Waiting';

                break;

            default:
                $status = 'Not Started';
        }

        if ($d) {
            $d->status = $status;

            $d->save();

            echo $d->id();
        }

        break;

    case 'view':
        $id = route(2);
        $id = str_replace('v_', '', $id);

        $d = ORM::for_table('sys_tasks')->find_one($id);

        if ($d) {
            $has_delete_permission = true;
            $has_edit_permission = true;
            if (!has_access($user->roleid, 'tasks', 'delete')) {
                $has_delete_permission = false;
            }

            if (!has_access($user->roleid, 'tasks', 'edit')) {
                $has_edit_permission = false;
            }

            $ui->assign('d', $d);

            $contact_id = $d->cid;
            $ticket_id = $d->tid;

            $contact = false;
            $ticket = false;

            if ($contact_id != '' || $contact_id != 0) {
                $contact = Contact::find($contact_id);
            }

            if ($ticket_id != '' || $ticket_id != 0) {
                $ticket = Ticket::find($ticket_id);
            }

            view('modal_task_view', [
                'contact' => $contact,
                'ticket' => $ticket,
                'has_delete_permission' => $has_delete_permission,
                'has_edit_permission' => $has_edit_permission,
            ]);
        }

        break;

    case 'ajax_tasks':
        $reportrange = _post('reportrange');

        if ($reportrange != '') {
            $reportrange = explode('-', $reportrange);
            $from_date = date('Y-m-d', strtotime(trim($reportrange[0])));
            $to_date = date('Y-m-d', strtotime(trim($reportrange[1])));
        }

        $mdate = date('Y-m-d');
        $ui->assign('mdate', $mdate);

        $contacts = Contact::select(['id', 'account'])
            ->get()
            ->groupBy('id')
            ->all();
        $tickets = Ticket::select(['id', 'tid'])
            ->get()
            ->groupBy('id')
            ->all();

        $tasks_not_started = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Not Started')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_not_started = $tasks_not_started->where('aid', $user->id);
        }

        $tasks_not_started = $tasks_not_started->find_array();

        $ui->assign('tasks_not_started', $tasks_not_started);

        $tasks_in_progress = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'In Progress')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_in_progress = $tasks_in_progress->where('aid', $user->id);
        }

        $tasks_in_progress = $tasks_in_progress->find_array();

        $ui->assign('tasks_in_progress', $tasks_in_progress);

        $tasks_completed = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Completed')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_completed = $tasks_completed->where('aid', $user->id);
        }

        $tasks_completed = $tasks_completed->find_array();
        $ui->assign('tasks_completed', $tasks_completed);

        $tasks_deferred = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Deferred')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_deferred = $tasks_deferred->where('aid', $user->id);
        }

        $tasks_deferred = $tasks_deferred->find_array();

        $ui->assign('tasks_deferred', $tasks_deferred);

        $tasks_waiting = ORM::for_table('sys_tasks')
            ->select('title')
            ->select('aid')
            ->select('cid')
            ->select('tid')
            ->select('priority')
            ->where('status', 'Waiting')
            ->select('id')
            ->select('created_at')
            ->select('due_date')
            ->select('created_by')
            ->order_by_desc('id');

        if (!has_access($user->roleid, 'tasks', 'all_data')) {
            $tasks_waiting = $tasks_waiting->where('aid', $user->id);
        }

        $tasks_waiting = $tasks_waiting->find_array();

        $ui->assign('tasks_waiting', $tasks_waiting);

        view('ajax.tasks', []);

        break;

    default:
        echo 'action not defined';
}
