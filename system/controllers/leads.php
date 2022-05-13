<?php
/*
|--------------------------------------------------------------------------
| Controller
|--------------------------------------------------------------------------
|
*/
_auth();
$ui->assign('selected_navigation', 'leads');
$ui->assign('_title', $_L['Leads'] . '- ' . $config['CompanyName']);
$action = route(1, 'list');
$user = User::_info();
$ui->assign('user', $user);
Event::trigger('leads');
switch ($action) {
    case 'list':
        $ui->assign('salutations', db_find_array('crm_salutations'));
        $ui->assign('sources', db_find_array('crm_lead_sources'));
        $ui->assign('industries', db_find_array('crm_industries'));
        $ui->assign('ls', db_find_array('crm_lead_status'));
        $ui->assign(
            'companies',
            db_find_array('sys_companies', ['id', 'company_name'])
        );

        view('leads');
        break;

    case 'modal_lead':
        $act = route(2);
        $ui->assign('act', $act);
        $ui->assign('salutations', db_find_array('crm_salutations'));
        $ui->assign('sources', db_find_array('crm_lead_sources'));
        $ui->assign('industries', db_find_array('crm_industries'));
        $ui->assign('ls', db_find_array('crm_lead_status'));
        $ui->assign(
            'companies',
            db_find_array('sys_companies', ['id', 'company_name'])
        );
        $val = [];
        if ($act == 'view') {
            $id = route(3);
            $id = str_replace('vid', '', $id);
            $id = str_replace('xid', '', $id);
            $lead = ORM::for_table('crm_leads')->find_one($id);
            if ($lead) {
                $ui->assign('lead', $lead);
            }
        } elseif ($act == 'edit') {
            $lid = route(3);
            $lid = str_replace('eid', '', $lid);
            $lead = db_find_one('crm_leads', $lid);
            if ($lead) {
                $val['status'] = $lead->status;
                $val['salutation'] = $lead->salutation;
                $val['first_name'] = $lead->first_name;
                $val['middle_name'] = $lead->middle_name;
                $val['last_name'] = $lead->last_name;
                $val['suffix'] = $lead->suffix;
                $val['title'] = $lead->title;
                $val['company'] = $lead->company;
                $val['website'] = $lead->website;
                $val['industry'] = $lead->industry;
                $val['employees'] = $lead->employees;
                $val['email'] = $lead->email;
                $val['phone'] = $lead->phone;
                $val['source'] = $lead->source;
                $val['address'] = $lead->address;
                $val['street'] = $lead->street;
                $val['city'] = $lead->city;
                $val['state'] = $lead->state;
                $val['zip'] = $lead->zip;
                $val['country'] = $lead->country;
                $val['public'] = $lead->public;

                $val['ratings'] = $lead->ratings;
                $val['street'] = $lead->street;
                $val['country'] = $lead->country;
                $val['assigned'] = $lead->assigned;
                $val['lid'] = $lead->id;
            }
        } else {
            $val['status'] = '';
            $val['salutation'] = '';
            $val['first_name'] = '';
            $val['middle_name'] = '';
            $val['last_name'] = '';
            $val['suffix'] = '';
            $val['title'] = '';
            $val['company'] = '';
            $val['website'] = '';
            $val['industry'] = '';
            $val['employees'] = '';
            $val['email'] = '';
            $val['phone'] = '';
            $val['source'] = '';
            $val['address'] = '';
            $val['street'] = '';
            $val['city'] = '';
            $val['state'] = '';
            $val['zip'] = '';
            $val['country'] = '';
            $val['public'] = '';
            $val['ratings'] = '';
            $val['street'] = '';
            $val['country'] = '';
            $val['assigned'] = '';
            $val['lid'] = '';
        }

        $ui->assign('val', $val);
        view('modal_lead');
        break;

    case 'post':
        $act = _post('act');
        $data = ib_posted_data();
        $data['oid'] = $user->id;

        if ($act == 'view') {
        } elseif ($act == 'edit') {
            echo Leads::update($data['lid'], $data);
        } else {
            echo Leads::create($data);
        }

        break;

    case 'json_list':
        $data = request()->all();
        $columns = [];
        $columns[] = 'id';
        $columns[] = 'name';
        $columns[] = 'title';
        $columns[] = 'company';
        $columns[] = 'phone';
        $columns[] = 'email';
        $columns[] = 'status';
        $columns[] = 'owner';
        $columns[] = 'manage';
        $order_by = $data['order'];
        $o_c_id = $order_by[0]['column'];
        $o_type = $order_by[0]['dir'];
        $a_order_by = $columns[$o_c_id];
        $d = ORM::for_table('crm_leads');
        $d->select('id');
        $d->select('salutation');
        $d->select('first_name');
        $d->select('middle_name');
        $d->select('last_name');
        $d->select('title');
        $d->select('company');
        $d->select('company_id');
        $d->select('email');
        $d->select('phone');
        $d->select('o');
        $d->select('status');
        $d->select('oid');
        $first_name = _post('first_name');
        if ($first_name != '') {
            $d->where_like('first_name', "%$first_name%");
        }

        $last_name = _post('last_name');
        if ($last_name != '') {
            $d->where_like('last_name', "%$last_name%");
        }

        $middle_name = _post('middle_name');
        if ($middle_name != '') {
            $d->where_like('middle_name', "%$middle_name%");
        }

        $email = _post('email');
        if ($email != '') {
            $d->where_like('email', "%$email%");
        }

        $salutation = _post('salutation');
        if ($salutation != '') {
            $d->where_like('salutation', "%$salutation%");
        }

        $company = _post('company');
        if ($company != '') {
            $d->where_like('company', "%$company%");
        }

        $phone = _post('phone');
        if ($phone != '') {
            $d->where_like('phone', "%$phone%");
        }

        $status = _post('status');
        if ($status != '') {
            $d->where('status', "%$status%");
        }

        $x = $d->find_array();
        $iTotalRecords = $d->count();
        $iDisplayLength = intval($_REQUEST['length']);
        $iDisplayLength =
            $iDisplayLength < 0 ? $iTotalRecords : $iDisplayLength;
        $iDisplayStart = intval($_REQUEST['start']);
        $sEcho = intval($_REQUEST['draw']);
        $records = [];
        $records["data"] = [];
        $end = $iDisplayStart + $iDisplayLength;
        $end = $end > $iTotalRecords ? $iTotalRecords : $end;
        if ($o_type == 'desc') {
            $d->order_by_desc($a_order_by);
        } else {
            $d->order_by_asc($a_order_by);
        }

        if (!has_access($user->roleid, 'leads', 'all_data')) {
            $d->where('aid', $user->id);
        }

        $d->limit($end);
        $d->offset($iDisplayStart);
        $x = $d->find_array();
        $i = $iDisplayStart;
        foreach ($x as $xs) {
            $records["data"][] = [
                $xs['id'],
                '<a href="#" class="cview" id="xid' .
                $xs['id'] .
                '">' .
                $xs['salutation'] .
                ' ' .
                $xs['first_name'] .
                ' ' .
                $xs['middle_name'] .
                ' ' .
                $xs['last_name'] .
                '</a>',
                $xs['title'],
                $xs['company'],
                $xs['phone'],
                $xs['email'],
                $xs['status'],
                $xs['o'],
                '
                <div class="btn-group">
                <a href="#" class="btn btn-primary btn-xs cview" id="vid' .
                $xs['id'] .
                '"><i class="fal fa-search"></i> </a>
                <a href="#" class="btn btn-warning btn-xs cedit" id="eid' .
                $xs['id'] .
                '"><i class="fal fa-pencil"></i> </a>
                <a href="#" class="btn btn-danger btn-xs cdelete" id="did' .
                $xs['id'] .
                '"><i class="fal fa-trash-alt"></i> </a>
</div>
                ',
            ];
        }

        $records["draw"] = $sEcho;
        $records["recordsTotal"] = $iTotalRecords;
        $records["recordsFiltered"] = $iTotalRecords;
        api_response($records);
        break;

    case 'convert_to_customer':
        $lid = _post('lid');
        echo Leads::convertToCustomer($lid);
        break;

    case 'update_memo':
        $data = request()->all();
        $lid = _post('lid');
        $memo = $data['memo'];
        echo Leads::updateMemo($lid, $memo);
        break;

    case 'web-to-lead':
        $lead_forms = LeadForm::select(['id', 'uuid', 'name', 'created_at'])
            ->orderBy('id', 'desc')
            ->get();

        $lead_form_ids = $lead_forms
            ->keyBy('id')
            ->keys()
            ->all();

        $leads = Lead::whereIn('form_id', $lead_form_ids)
            ->select(['id', 'form_id'])
            ->get();

        $leads_count = [];

        foreach ($leads as $lead) {
            if (isset($leads_count[$lead->form_id])) {
                ++$leads_count[$lead->form_id];
                continue;
            }
            $leads_count[$lead->form_id] = 1;
        }

        view('leads_web_to_lead', [
            'lead_forms' => $lead_forms,
            'leads_count' => $leads_count,
        ]);

        break;

    case 'form':
        $selected_form = false;

        $id = route(2);
        if ($id) {
            $selected_form = LeadForm::find($id);
        }

        $lead_sources = LeadSource::get();

        view('lead_form', [
            'lead_sources' => $lead_sources,
            'selected_form' => $selected_form,
        ]);

        break;

    case 'form-embed':
        $id = route(2);
        if ($id) {
            $lead_form = LeadForm::find($id);

            if ($lead_form) {
                $embed_code =
                    '<iframe width="100%" height="800"
                  src="' .
                    U .
                    'client/form/' .
                    $lead_form->uuid .
                    '/embed/" 
                  frameborder="0" 
                  allowfullscreen>
                  
</iframe>';
                $embed_code = htmlentities($embed_code);
                view('leads_form_embed', [
                    'lead_form' => $lead_form,
                    'embed_code' => $embed_code,
                ]);
            }
        }

        break;

    case 'save-form':
        $validator = new Validator();
        $data = $request->all();
        $validation = $validator->validate($data, [
            'name' => 'required',
            'submit_button_name' => 'required',
            'success_message' => 'required',
            'source_id' => 'required',
            'admin_id' => 'required',
        ]);

        $lead_form = false;

        if ($validation->fails()) {
            responseWithError($_L['All Fields are Required']);
        } else {
            if (isset($data['form_id'])) {
                $lead_form_id = (int) $data['form_id'];
                $lead_form = LeadForm::find($lead_form_id);
            }

            if (!$lead_form) {
                $lead_form = new LeadForm();
                $lead_form->uuid = (string) sp_uuid();
            }

            $lead_form->name = $data['name'];
            $lead_form->submit_button_name = $data['submit_button_name'];
            $lead_form->success_message = $data['success_message'];
            $lead_form->lead_source_id = $data['source_id'];
            $lead_form->admin_id = $data['admin_id'];
            $lead_form->save();

            jsonResponse([
                'url' => 'leads/form-builder/' . $lead_form->id,
            ]);
        }

        break;

    case 'form-builder':
        $id = route(2);

        if ($id) {
            $lead_form = LeadForm::find($id);

            if ($lead_form) {
                \view('lead_form_data', [
                    'lead_form' => $lead_form,
                ]);
            }
        }

        break;

    case 'save-form-data':
        $id = _post('id');

        if ($id) {
            $lead_form = LeadForm::find($id);

            $data = request()->all();

            if ($lead_form && !empty($data['form_data'])) {
                $lead_form->form_data = $data['form_data'];
                $lead_form->save();
            }
        }

        break;

    case 'delete-web-to-lead-form':
        $id = route(2);
        $id = str_replace('delete_', '', $id);

        if ($id) {
            $lead_form = LeadForm::find($id);
            $lead_form->delete();
        }

        r2(U . 'leads/web-to-lead/', 's', $_L['delete_successful']);

        break;

    case 's':
        is_dev();
        $t = new Schema('crm_leads');
        $t->drop();
        $t->add('secret', 'varchar', 100);
        $t->add('status', 'varchar', 200);
        $t->add('o', 'varchar', 200);
        $t->add('oid', 'int', 11, '0');
        $t->add('salutation', 'varchar', 200);
        $t->add('first_name', 'varchar', 200);
        $t->add('middle_name', 'varchar', 200);
        $t->add('last_name', 'varchar', 200);
        $t->add('suffix', 'varchar', 200);
        $t->add('title', 'varchar', 200);
        $t->add('company', 'varchar', 200);
        $t->add('company_id', 'int', 11, '0');
        $t->add('website', 'varchar', 200);
        $t->add('industry', 'varchar', 200);
        $t->add('employees', 'varchar', 200);
        $t->add('email', 'varchar', 200);
        $t->add('phone', 'varchar', 50);
        $t->add('color', 'varchar', 20);
        $t->add('source', 'varchar', 200);
        $t->add('added_from', 'varchar', 200);
        $t->add('mobile', 'varchar', 200);
        $t->add('address', 'varchar', 200);
        $t->add('street', 'varchar', 200);
        $t->add('city', 'varchar', 200);
        $t->add('state', 'varchar', 200);
        $t->add('zip', 'varchar', 50);
        $t->add('country', 'varchar', 50);
        $t->add('created_by', 'varchar', 200);
        $t->add('created_at', 'datetime');
        $t->add('updated_at', 'datetime');
        $t->add('updated_by', 'varchar', 200);
        $t->add('viewed_at', 'datetime');
        $t->add('cid', 'int', 11, '0');
        $t->add('aid', 'int', 11, '0');
        $t->add('iid', 'int', 11, '0');
        $t->add('rid', 'int', 11, '0');
        $t->add('sorder', 'int', 11, '0');
        $t->add('assigned', 'int', 11, '0');
        $t->add('last_contact', 'datetime');
        $t->add('last_contact_by', 'varchar', 200);
        $t->add('date_converted', 'datetime');
        $t->add('public', 'int', 1, '0');
        $t->add('ratings', 'varchar', '50');
        $t->add('flag', 'int', 1, '0');
        $t->add('lost', 'int', 1, '0');
        $t->add('junk', 'int', 1, '0');
        $t->add('trash', 'int', 1, '0');
        $t->add('archived', 'int', 1, '0');
        $t->add('memo');
        $t->save();
        $t = new Schema('crm_lead_sources');
        $t->drop();
        $t->add('sname', 'varchar', '200');
        $t->add('is_active', 'int', '1', '1');
        $t->add('is_default', 'int', '1', '1');
        $t->add('sorder', 'int', '11', '0');
        $t->add_primary_data('(`sname`) VALUES 
        (\'Advertisement\'),
         (\'Customer Event\'),
         (\'Employee Referral\'),
         (\'Google AdWords\'),
         (\'Other\'),
         (\'Partner\'),
         (\'Purchased List\'),
         (\'Trade Show\'),
         (\'Webinar\'),
         (\'Website\'),
         (\'Facebook\')
         ');
        $t->save();
        $t = new Schema('crm_industries');
        $t->drop();
        $t->add('industry', 'varchar', '200');
        $t->add('is_active', 'int', '1', '1');
        $t->add('is_default', 'int', '1', '0');
        $t->add('sorder', 'int', '11', '0');
        $t->add_primary_data('(`industry`) VALUES 
        (\'Agriculture\'),
         (\'Apparel\'),
         (\'Banking\'),
         (\'Biotechnology\'),
         (\'Chemicals\'),
         (\'Communications\'),
         (\'Construction\'),
         (\'Consulting\'),
         (\'Education\'),
         (\'Electronics\'),
         (\'Energy\'),
         (\'Engineering\'),
         (\'Entertainment\'),
         (\'Environmental\'),
         (\'Finance\'),
         (\'Food & Beverage\'),
         (\'Government\'),
         (\'Healthcare\'),
         (\'Hospitality\'),
         (\'Insurance\'),
         (\'Machinery\'),
         (\'Manufacturing\'),
         (\'Media\'),
         (\'Not For Profit\'),
         (\'Other\'),
         (\'Recreation\'),
         (\'Retail\'),
         (\'Shipping\'),
         (\'Technology\'),
         (\'Telecommunications\'),
         (\'Transportation\'),
         (\'Utilities\')
         ');
        $t->save();
        $t = new Schema('crm_lead_status');
        $t->drop();
        $t->add('sname', 'varchar', '200');
        $t->add('is_active', 'int', '1', '1');
        $t->add('is_default', 'int', '1', '0');
        $t->add('is_converted', 'int', '1', '0');
        $t->add('sorder', 'int', '11', '0');
        $t->add_primary_data('(`sname`,`is_default`) VALUES 
        (\'Unqualified\',\'0\'),
         (\'New\',\'1\'),
         (\'Working\',\'0\'),
         (\'Nurturing\',\'0\'),
         (\'Qualified\',\'0\')
         ');
        $t->save();
        $t = new Schema('crm_salutations');
        $t->drop();
        $t->add('sname', 'varchar', '200');
        $t->add('is_active', 'int', '1', '1');
        $t->add('is_default', 'int', '1', '0');
        $t->add('sorder', 'int', '11', '0');
        $t->add_primary_data('(`sname`) VALUES 
        (\'Mr.\'),
         (\'Ms.\'),
         (\'Mrs.\'),
         (\'Dr.\'),
         (\'Prof.\')
         ');
        $t->save();
        break;

    default:
        echo 'action not defined';
}
