{extends file="$layouts_admin"}



{block name="content"}



    <div class="row">
        <div class="col">
            <h2>{$d->subject}</h2>
        </div>
        <div class="col text-right">
            <a href="{$_url}tickets/admin/list/" class="btn btn-primary btn-sm" style="margin-bottom: 15px;"><i
                        class="fal fa-long-arrow-left"></i> {$_L['Back to the List']}</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">



            <div class="card border" id="t_options">

                <div class="card-header">
                    <ul class="nav nav-tabs card-header-tabs" role="tablist">
                        <li class="nav-item active" role="presentation"><a data-toggle="tab" class="nav-link active" href="#details"><i class="fal fa-th"></i> {$_L['Details']}</a></li>
                        <li class="nav-item" role="presentation"><a class="nav-link" data-toggle="tab" href="#tasks"><i class="fal fa-tasks"></i> {$_L['Tasks']}</a></li>

                    </ul>
                </div>




                <div class="card-body">




                    <div class="tab-content">
                        <div id="details" class="tab-pane fade show active ib-tab-box">


                            <div class="row mt-3">
                                <div class="col">
                                    <div> {$_L['Priority']}:
                                        {if $d->urgency == 'Medium' || $d->urgency == 'High'}
                                            <span class="badge badge-outline text-uppercase badge-outline-danger">{ib_lan_get_line($d->urgency)}</span>
                                        {else}
                                            <span class="badge badge-outline text-uppercase badge-outline-success">{ib_lan_get_line($d->urgency)}</span>
                                        {/if}
                                    </div>
                                </div>
                                <div class="col">
                                    <div> {$_L['Status']}: <span id="inline_status">{$d->status}</span></div>
                                </div>
                            </div>




                            <hr>
                            <p><strong>{$_L['Ticket']}:</strong> {$d->tid}</p>
                            <p><strong>{$_L['Customer']}:</strong> <a href="{$_url}contacts/view/{$d->userid}">{$d->account}</a></p>



                            <hr>




                            <a class="btn btn-primary" href="#" id="add_reply">{$_L['Add Reply']}</a>

                            {if $can_edit_sales}
                                {if $invoice}
                                    <a class="btn btn-success" href="{$_url}invoices/view/{$invoice->id}" id="add_reply">{$_L['View Invoice']}</a>
                                {else}
                                    <a class="btn btn-success" id="convertToInvoice" href="javascript:;">{$_L['Create Invoice']}</a>
                                {/if}
                            {/if}


                            <a class="cdelete btn btn-danger" href="#" id="t{$d->id}"><i class="fal fa-trash-alt"></i> </a>

                            <hr>

                            <div class="form-group">
                                <label for="editable_department">{$_L['Department']}</label>
                                <select class="form-control" id="editable_department" name="editable_department" size="1">
                                    <option value="None">None</option>
                                    {foreach $departments as $dep}
                                        <option value="{$dep['id']}" {if $department eq $dep['dname']} selected{/if}>{$dep['dname']}</option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="form-group">
                                <label>{$_L['Assigned to']}</label>
                                <select class="form-control" id="editable_assigned_to" name="editable_assigned_to" size="1">
                                    <option value="None">{$_L['None']}</option>
                                    {foreach $ads as $ad}
                                        <option value="{$ad['id']}" {if $d->aid eq $ad['id']} selected{/if}>{$ad['fullname']}</option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="editable_status">{$_L['Status']}</label>
                                <select class="form-control" id="editable_status" name="editable_status" size="1">
                                    <option value="Open" {if $d->status eq 'Open'} selected{/if}>{$_L['Open']}</option>
                                    <option value="On Hold" {if $d->status eq 'On Hold'} selected{/if}>{$_L['On Hold']}</option>
                                    <option value="Escalated" {if $d->status eq 'Escalated'} selected{/if}>{$_L['Escalated']}</option>
                                    <option value="Closed" {if $d->status eq 'Closed'} selected{/if}>{$_L['Closed']}</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="editable_cc">{$_L['Email']}</label>
                                <input class="form-control" type="text" id="editable_email" name="editable_email" value="{$d->email}">
                            </div>

                            <div class="form-group">
                                <label for="editable_cc">{$_L['Cc']}</label>
                                <input class="form-control" type="text" id="editable_cc" name="editable_cc" value="{$d->cc}">
                            </div>

                            <div class="form-group">
                                <label for="editable_bcc">{$_L['Bcc']}</label>
                                <input class="form-control" type="text" id="editable_bcc" name="editable_bcc" value="{$d->bcc}">
                            </div>

                            <div class="form-group">
                                <label for="editable_phone">{$_L['Phone']}</label>
                                <input class="form-control" type="text" id="editable_phone" name="editable_phone" value="{if $c}{$c->phone}{/if}">
                            </div>





                            <input type="hidden" name="tid" id="tid" value="{$d->id}">



                            <form>

                                <hr>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">{$_L['Note']}</label>
                                    <textarea class="form-control" name="notes" id="notes" rows="3">{$d->notes}</textarea>
                                </div>

                                <button type="submit" id="btn_save_note" class="btn btn-primary">{$_L['Save']}</button>

                            </form>


                            <hr>

                            <h4>{$_L['Previous Conversations']}</h4>


                            {if count($o_tickets) > 1}

                                <table class="table table-hover">

                                    <tbody>

                                    {foreach $o_tickets as $o_ticket}

                                        {if $o_ticket['id'] == $d->id}
                                            {continue}
                                        {/if}

                                        <tr>
                                            <td>
                                                <em>{date( $config['df'], strtotime($o_ticket['created_at']))}</em>
                                                <br>
                                                <p><a href="{$_url}tickets/admin/view/{$o_ticket['id']}">{$o_ticket['subject']}</a></p>
                                                <span class="label label-default inline-block"> {$_L['Status']}: {$d->status} </span>

                                            </td>
                                        </tr>


                                    {/foreach}

                                    </tbody>
                                </table>

                            {else}

                               <span class="mt-3">{$_L['No Data Available']}</span>

                            {/if}

                        </div>


                        <div id="tasks" class="tab-pane fade ib-tab-box">


                            <form id="ib_add_group" class="form-horizontal push-10-t push-10" method="post">

                                <div class="form-group">
                                    <label for="task_subject">{$_L['Task']}</label>
                                    <input class="form-control" type="text" id="task_subject" name="task_subject">
                                </div>



                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <button class="btn btn-primary" id="btn_add_task" type="submit">{$_L['Save']}</button>
                                        <div id="tasks_tools"  style="display: none;">
                                            <hr>

                                            <div class="btn-group">
                                                <button type="button" class="btn btn-success no-shadow" id="btn_mark_tasks_completed" data-toggle="tooltip" data-placement="top" title="{$_L['Mark as Completed']}"><i class="fal fa-check"></i></button>
                                                <button type="button" class="btn btn-primary no-shadow" id="btn_mark_tasks_not_started" data-toggle="tooltip" data-placement="top" title="{$_L['Mark as Not Started']}"><i class="fal fa-clock"></i></button>
                                                <button type="button" class="btn btn-danger no-shadow" id="btn_delete_tasks" data-toggle="tooltip" data-placement="top" title="{$_L['Delete']}"><i class="fal fa-trash-alt"></i></button>
                                            </div>


                                            <hr>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <div id="tasks_list">

                            </div>


                        </div>

                    </div>





                </div>

            </div>

        </div>
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-12" id="create_ticket">


                    <!-- The time line -->
                    <ul class="timeline">
                        <!-- timeline time label -->
                        <li class="time-label">
                  <span>
                    {date( $config['df'], strtotime($d->created_at))}
                  </span>
                        </li>
                        <!-- /.timeline-label -->
                        <!-- timeline item -->
                        <li>



                            {if $d->admin neq '0'}
                                {if $user['img'] eq 'gravatar'}
                                    <img src="http://www.gravatar.com/avatar/{($user['email'])|md5}?s=30"
                                         class="img-time-line" alt="{$user['fullname']}">
                                {elseif $user['img'] eq ''}
                                    <img class="img-time-line" src="{$app_url}ui/lib/img/default-user-avatar.png" alt="">
                                {else}
                                    <img src="{{APP_URL}}/{$user['img']}" class="img-time-line" alt="{$user['account']}">
                                {/if}

                            {elseif ($c)}

                                {if $c->img eq 'gravatar'}
                                    <img src="http://www.gravatar.com/avatar/{($user['email'])|md5}?s=30"
                                         class="img-time-line" alt="{$user['fullname']}">
                                {elseif $c->img eq ''}
                                    <img class="img-time-line" src="{$app_url}ui/lib/img/default-user-avatar.png" alt="">
                                {else}
                                    <img src="{$c->img}" class="img-time-line" alt="{$user['account']}">
                                {/if}

                            {else}



                            {/if}


                            <div class="timeline-item">



                                <h3 class="timeline-header"><a href="javascript:void(0)">{$d->account}</a></h3>

                                <div class="timeline-body">
                                    {$d->message}
                                    <hr>

                                    <a href="#" class="btn btn-warning t_edit" data-toggle="tooltip"
                                       data-placement="top" title="" data-original-title="{$_L['Edit']}" id="et{$d->id}"><i
                                                class="fal fa-pencil"></i> </a>
                                </div>

                                {if ($d->attachments) neq ''}
                                    <div class="timeline-footer">
                                        {Tickets::gen_link_attachments($d->attachments)}
                                    </div>
                                {/if}


                            </div>
                        </li>

                        {foreach $replies as $reply}
                            <li class="time-label">
                  <span>
                    {date( $config['df'], strtotime($reply['created_at']))}
                  </span>
                            </li>
                            <li>


                                {if $reply['admin'] neq '0'}
                                    <img src="{getAdminImage($reply['admin'],30)}" class="img-time-line">
                                {elseif ($c)}

                                    {if $c->img eq ''}
                                        <img class="img-time-line" src="{$app_url}ui/lib/img/default-user-avatar.png"
                                             alt="">
                                    {else}
                                        <img src="{{APP_URL}}/{$c->img}" class="img-time-line" alt="{$user['account']}">
                                    {/if}

                                {else}



                                {/if}

                                <div class="timeline-item">


                                    <h3 class="timeline-header"><a href="javascript:void(0)">{$reply['replied_by']}</a></h3>

                                    <div class="timeline-body" {if $reply['reply_type'] eq 'internal'} style="background: #FFF6D9;" {/if}>
                                        {$reply['message']}

                                        <hr>

                                        <a href="#" class="btn btn-warning reply_edit"
                                           data-toggle="tooltip" data-placement="top" title=""
                                           data-original-title="{$_L['Edit']}" id="er{$reply['id']}"><i
                                                    class="fal fa-pencil"></i> </a> &nbsp;
                                        <a href="#" class="btn btn-danger reply_delete"
                                           data-toggle="tooltip" data-placement="top" title=""
                                           data-original-title="{$_L['Delete']}" id="dr{$reply['id']}"><i
                                                    class="fal fa-trash-alt"></i> </a> &nbsp;

                                        {if $reply['reply_type'] eq 'internal'} <a href="#" class="btn btn-primary no-shadow reply_make_public"
                                                                                   data-toggle="tooltip" data-placement="top" title=""
                                                                                   data-original-title="{$_L['Public']}" id="rp{$reply['id']}"><i
                                                    class="fal fa-globe"></i> </a> {/if}

                                    </div>

                                    {if ($reply['attachments']) neq ''}
                                        <div class="timeline-footer">
                                            {Tickets::gen_link_attachments($reply['attachments'])}
                                        </div>
                                    {/if}


                                </div>
                            </li>
                        {/foreach}

                        <!-- END timeline item -->
                        <!-- timeline item -->
                        <li class="time-label">
                  <span class="bg-green" id="section_add_reply">
                   {__('Add Reply')}
                  </span>
                        </li>
                        <li>
                            {if $user['img'] eq ''}
                                <img class="img-time-line" src="{$app_url}ui/lib/img/default-user-avatar.png" alt="">
                            {else}
                                <img src="{$user['img']}" class="img-time-line" alt="{$user['account']}">
                            {/if}

                            <div class="timeline-item">


                                <div class="timeline-body">
                                    <form class="form-horizontal push-10-t push-10" method="post">

                                        <ul class="nav nav-pills mb-3"  role="tablist">
                                            <li class="nav-item"><a id="reply_public" class="nav-link active" href="#">{$_L['Customer']}</a></li>
                                            <li class="nav-item"><a id="reply_internal" class="nav-link" href="#">{$_L['Internal']}</a></li>
                                        </ul>

                                        <div class="form-group">
                                            <div class="col-xs-12">

                                            <textarea id="content" class="form-control sysedit"
                                                      name="content"></textarea>
                                                <div class="help-block">
                                                    <a data-toggle="modal" href="#modal_add_item"><i
                                                                class="fal fa-paperclip"></i> {$_L['Attach File']}</a>
                                                    | <a data-toggle="modal" href="#modal_predefined_replies"><i
                                                                class="fal fa-align-left"></i> {$_L['Predefined Reply']}</a>
                                                </div>
                                            </div>
                                        </div>




                                        <div class="form-group">
                                            <div class="col-xs-12">

                                                <input type="hidden" name="attachments" id="attachments" value="">
                                                <input type="hidden" name="f_tid" id="f_tid" value="{$d->id}">
                                                <input type="hidden" name="cid" id="cid" value="{$d->userid}">

                                                <button class="btn btn-primary" id="ib_form_submit" type="submit"><i
                                                            class="fal fa-send push-5-r"></i> Submit
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </li>

                        <li>
                            <i class="fal fa-life-ring bg-gray"></i>
                        </li>
                    </ul>
                </div>
                <!-- /.col -->
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal_add_item" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                        {$_L['Attach File']}
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" class="dropzone" id="upload_container">

                        <div class="dz-message">
                            <h3> <i class="fal fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Click to Upload']}</span>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$_L['Close']}</button>
                </div>
            </div>
        </div>
    </div>







    <div id="modal_predefined_replies" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{$_L['Predefined Replies']}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered table-hover sys_table" id="clx_datatable">
                        <thead>
                        <tr>
                            <th>{$_L['Name']}</th>
                        </tr>
                        </thead>
                        <tbody>

                        {foreach $predefined_replies as $predefined_replie}
                            <tr>
                                <td><a href="javascript:;" onclick="setPreDefinedContent(event,'{$predefined_replie->id}');">{$predefined_replie->title}</a> </td>
                            </tr>
                        {/foreach}

                        </tbody>

                        <tfoot>
                        <tr>
                            <td>
                                <ul class="pagination">
                                </ul>
                            </td>
                        </tr>
                        </tfoot>

                    </table>
                </div>
            </div>
        </div>

    </div>

{/block}

{block name="script"}



    <script>

        Dropzone.autoDiscover = false;
        $(function() {

            var tid = {$d->id};

            $( ".mmnt" ).each(function() {
                var ut = $( this ).html();
                $( this ).html(moment.unix(ut).fromNow());
            });

            var _url = $("#_url").val();

            var $ib_form_submit = $("#ib_form_submit");

            var $create_ticket = $("#create_ticket");

            $('#clx_datatable').dataTable(
                {
                    "language": {
                        "emptyTable": "{$_L['No items to display']}",
                        "info":      "{$_L['Showing _START_ to _END_ of _TOTAL_ entries']}",
                        "infoEmpty":      "{$_L['Showing 0 to 0 of 0 entries']}",
                        buttons: {
                            pageLength: '{$_L['Show all']}'
                        },
                        searchPlaceholder: "{__('Search')}"
                    },
                }
            );



            $('#content').redactor(
                {
                    minHeight: 200,
                }
            );

            var $modal = $('#cloudonex_body');

            var reply_type = 'public';


            var upload_resp;


            var ib_file = new Dropzone("#upload_container",
                {
                    url: _url + "tickets/client/upload_file/",
                    maxFiles: 10,
                    acceptedFiles: "image/jpeg,image/png,image/gif"
                }
            );

            ib_file.on("sending", function() {

                $ib_form_submit.prop('disabled', true);

            });


            // Ticket convert to invoice

            $('#convertToInvoice').on('click',function (e) {
                e.preventDefault();

                bootbox.confirm('Are you sure?', function (yes) {
                    if(yes)
                        {
                            window.location = '{$_url}invoices/create-from-ticket/{$d->id}';
                        }
                });

            });


            ib_file.on("success", function(file,response) {

                $ib_form_submit.prop('disabled', false);

                upload_resp = response;

                if(upload_resp.success == 'Yes'){

                    toastr.success(upload_resp.msg);
                    // $file_link.val(upload_resp.file);
                    // files.push(upload_resp.file);
                    //
                    // console.log(files);

                    $('#attachments').val(function(i,val) {
                        return val + (!val ? '' : ',') + upload_resp.file;
                    });


                }
                else{
                    toastr.error(upload_resp.msg);
                }







            });



            $ib_form_submit.on('click', function(e) {
                e.preventDefault();
                $create_ticket.block({ message: block_msg });
                $.post( _url + "tickets/admin/add_reply/", {  message: $('#content').val(), reply_type: reply_type, attachments: $("#attachments").val(), f_tid: $("#f_tid").val()} )
                    .done(function( data ) {

                        if(data.success == "Yes"){
                            location.reload();
                        }

                        else {
                            $create_ticket.unblock();
                            toastr.error(data.msg);
                        }

                    });


            });


            $("#add_reply").on('click', function(e) {
                e.preventDefault();

                $('html, body').animate({
                    scrollTop: $("#section_add_reply").offset().top - 60
                }, 500);



            });

            $('#notes').redactor(
                {
                    minHeight: 150, // pixels
                    plugins: ['fontcolor']
                }
            );

            $("#btn_save_note").on('click', function(e) {
                e.preventDefault();

                $('#t_options').block({ message: null });

                $.post(base_url + 'tickets/admin/save_note', {
                    tid: $('#tid').val(),

                    notes: $('#notes').val()

                })
                    .done(function () {
                        toastr.success(_L['Saved Successfully']);
                        $('#t_options').unblock();

                    });

            });

            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        window.location.href = base_url + "tickets/admin/delete/" + id;
                    }
                });
            });


            $(".t_edit").click(function (e) {
                e.preventDefault();
                var id = this.id;


                $.fancybox.open({
                    src  : base_url + 'tickets/admin/edit_modal/'+id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#edit_content').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                    }
                });

            });


            $(".reply_edit").click(function (e) {
                e.preventDefault();
                var id = this.id;

                $.fancybox.open({
                    src  : base_url + 'tickets/admin/edit_modal/'+id+'/reply',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#edit_content').redactor();
                        },
                        touch: false,
                        autoFocus: false,
                    }
                });


            });



            $('[data-toggle="tooltip"]').tooltip();

            // $modal.on('hidden.bs.modal', function () {
            //     location.reload();
            // });

            $modal.on('click', '.update_ticket_message', function(e){

                e.preventDefault();


                $.post( _url + "tickets/admin/edit_modal_post/", {
                    tid: $('#edit_tid').val(),
                    type: $('#edit_type').val(),
                    message:  $('#edit_content').val(),

                })
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {

                            toastr.error(data);
                        }

                    });

            });


            $(".reply_delete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        window.location.href = base_url + "tickets/admin/delete_reply/" + id;
                    }
                });
            });






            $("#editable_cc").on("blur",function(e){
                $.post(base_url + 'tickets/admin/update_cc',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });


            $("#editable_bcc").on("blur",function(e){
                $.post(base_url + 'tickets/admin/update_bcc',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });


            $("#editable_email").on("blur",function(e){
                $.post(base_url + 'tickets/admin/update_email',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });


            $("#editable_phone").on("blur",function(e){
                $.post(base_url + 'tickets/admin/update_phone',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });


            $("#editable_hour").on("blur",function(e){
                $.post(base_url + 'tickets/admin/update_hour',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });

            $("#editable_minute").on("blur",function(e){
                $.post(base_url + 'tickets/admin/update_minute',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });


            $("#editable_department").on("change",function(e){
                $.post(base_url + 'tickets/admin/update_department',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });


            $('#editable_assigned_to').select2({

            })
                .on("change", function (e) {

                    $.post(base_url + 'tickets/admin/update_assigned_to',{
                        id: {$d->id}, value: $("#editable_assigned_to option:selected").val()
                    },function (data) {
                        if ($.isNumeric(data)) {

                            toastr.success('{$_L['Saved Successfully']}');

                        }

                        else {

                            toastr.error(data);
                        }
                    })
                });


            // $("#editable_assigned_to").on("change",function(e){
            //
            // });

            $("#editable_status").on("change",function(e){
                $.post(base_url + 'tickets/admin/update_status',{ id: tid, value: $(this).val()},function (data) {
                    if ($.isNumeric(data)) {

                        toastr.success('{$_L['Saved Successfully']}');

                        $("#inline_status").html($("#editable_status option:selected").text());

                    }

                    else {

                        toastr.error(data);
                    }
                })
            });





            var $reply_public = $("#reply_public");
            var $reply_internal = $("#reply_internal");


            $reply_public.click(function (e) {
                e.preventDefault();
                $(this).addClass('active');
                $reply_internal.removeClass('active');
                reply_type = 'public';
                $('#content').closest('.redactor-box').find('.redactor-editor').css({
                    backgroundColor: '#FFFFFF'
                });
            });


            $reply_internal.click(function (e) {
                e.preventDefault();
                $(this).addClass('active');
                $reply_public.removeClass('active');
                reply_type = 'internal';
                $('#content').closest('.redactor-box').find('.redactor-editor').css({
                    backgroundColor: '#FFF6D9'
                });
            });


            $(".reply_make_public").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        window.location.href = base_url + "tickets/admin/reply_make_public/" + id;
                    }
                });
            });

            function loadTasks() {

                $("#tasks_list").html(block_msg);

                $.get( base_url + "tickets/admin/tasks_list/{$ticket->id}", function( data ) {

                    $("#tasks_list").html(data);



                    $('.task-checkbox').on('change', function (event) {


                        var i_check_id = $(this)[0].id;

                        if($(this)[0].checked){

                            $.get(base_url + 'tickets/admin/set_task_completed/'+i_check_id,function () {
                                loadTasks();
                            });

                        }
                        else{

                            $.get(base_url + 'tickets/admin/set_task_not_started/'+i_check_id,function () {
                                loadTasks();
                            });

                        }

                    });

                });
            }


            loadTasks();


            $("#btn_add_task").click(function (e) {
                e.preventDefault();


                if($("#task_subject").val() == ''){

                    $("#task_subject").focus();

                }

                else {

                    $("#btn_add_task").prop('disabled', true);

                    $.post( base_url + "tasks/post/", { title: $("#task_subject").val(), rel_type: 'Ticket', tid: '{$ticket->id}', rel_id: '{$ticket->id}', cid: {$ticket->userid}, priority: '{$ticket->urgency}' })
                        .done(function( data ) {

                            $("#btn_add_task").prop('disabled', false);

                            if ($.isNumeric(data)) {

                                $("#task_subject").val('');

                                loadTasks();

                            }
                            else{
                                toastr.error(data);
                            }

                        });

                }
            });

            var task_id;

            function has_selected_task_items() {
                if($('.selected').length > 0){

                    $("#tasks_tools").show(200);

                }
                else{
                    $("#tasks_tools").hide(200);
                }
            }

            $("#tasks_list").on('click', '.task_item', function () {

                task_id = this.id;



                if($("#" + task_id).hasClass('selected')){
                    $("#" + task_id).removeClass('selected');
                }
                else{
                    $("#" + task_id).addClass('selected');
                }

                has_selected_task_items();


                // alert(task_id);


            });

            $("#btn_mark_tasks_completed").on('click',function (e) {
                e.preventDefault();
                var arrayOfIds = $.map($(".selected"), function(n, i){
                    return n.id;
                });

                $("#btn_mark_tasks_completed").prop('disabled', true);

                $.post( base_url + "tickets/admin/do_task/", { action: 'completed', ids: arrayOfIds })
                    .done(function( data ) {

                        $("#btn_mark_tasks_completed").prop('disabled', false);

                        loadTasks();

                        $("#tasks_tools").hide(200);

                    });

            });


            $("#btn_mark_tasks_not_started").on('click',function (e) {
                e.preventDefault();
                var arrayOfIds = $.map($(".selected"), function(n, i){
                    return n.id;
                });

                $("#btn_mark_tasks_completed").prop('disabled', true);

                $.post( base_url + "tickets/admin/do_task/", { action: 'not_started', ids: arrayOfIds })
                    .done(function( data ) {

                        $("#btn_mark_tasks_completed").prop('disabled', false);

                        loadTasks();

                        $("#tasks_tools").hide(200);

                    });

            });


            $("#btn_delete_tasks").on('click',function (e) {
                e.preventDefault();

                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        var arrayOfIds = $.map($(".selected"), function(n, i){
                            return n.id;
                        });

                        $("#btn_delete_tasks").prop('disabled', true);

                        $.post( base_url + "tickets/admin/do_task/", { action: 'delete', ids: arrayOfIds })
                            .done(function( data ) {

                                $("#btn_delete_tasks").prop('disabled', false);

                                loadTasks();

                                $("#tasks_tools").hide(200);

                            });
                    }
                });



            });





        });

        function setPreDefinedContent(event,predefined_reply_id) {

            $('#modal_predefined_replies').modal('hide');

            $.get( "{$_url}tickets/admin/get-predefined-reply/" + predefined_reply_id, function( data ) {

                $('#content').redactor('code.set', data);

            });


        }

    </script>
{/block}
