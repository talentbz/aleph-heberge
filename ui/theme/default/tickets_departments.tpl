{extends file="$layouts_admin"}

{block name="head"}


    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }

        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600;
            line-height: 1.5;
            margin-bottom: .5rem;
            color: #32325d;
        }
        .text-info{
            color: #6772E5!important;
        }
        .text-success{
            color: #2CCE89!important;}

        .text-danger{
            color: #F6365B!important;
        }
        .text-warning{
            color: #FB6340!important;
        }
        .text-primary{
            color: #10CDEF!important;
        }
    </style>
{/block}

{block name="content"}

    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Support Ticket Departments']}</h2>

                    <div class="panel-toolbar">
                        <div class="btn-group">
                            <a data-toggle="modal" href="#modal_add_item" class="btn btn-success mb-md"><i class="fal fa-plus"></i> {$_L['Add New Department']}</a>

                            <a href="{$_url}tickets/admin/departments_reorder/" class="btn btn-primary mb-md"><i class="fal fa-arrows"></i> {$_L['Reorder']}</a>
                        </div>
                    </div>

                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <table class="table table-striped sys_table">
                            <thead style="background: #f0f2ff">
                            <tr>

                                <th class="h6">{$_L['Department Name']}</th>

                                <th class="h6">{$_L['Email']}</th>
                                <th class="h6">{$_L['Status']}</th>
                                <th class="text-right h6">{$_L['Manage']}</th>
                            </tr>
                            </thead>
                            <tbody>

                            {foreach $ds as $d}
                                <tr>

                                    <td class="h6">{$d['dname']}</td>

                                    <td class="h6 text-info">{$d['email']}</td>

                                    <td>
                                        {if $d['hidden'] eq 'Yes'}
                                            <span class="badge badge-danger">{$_L['Inactive']}</span>
                                        {else}
                                            <span class="badge badge-success">{$_L['Active']}</span>
                                        {/if}

                                    </td>

                                    <td class="text-right">

                                        <div class="btn-group">
                                            <a href="#" class="btn btn-info btn-sm item_edit" id="e{$d['id']}">{$_L['Edit']}</a>
                                            <a href="#" class="btn btn-danger btn-sm cdelete" onclick="confirmThenGoToUrl(event,'tickets/admin/delete_department/{$d['id']}')"></i> {$_L['Delete']}</a>
                                        </div>

                                    </td>
                                </tr>
                            {/foreach}

                            </tbody>
                        </table>

                    </div>
                </div>


            </div>



        </div>



    </div>


    <div class="modal fade" id="modal_add_item" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{$_L['Add New Department']}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="ib_modal_form">


                        <div class="form-group">
                            <label for="department_name">{$_L['Name']}</label>
                            <input type="text" name="department_name" class="form-control" id="department_name">
                        </div>



                        <div class="form-group">
                            <label for="email">{$_L['Email']}</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>

                        <div class="form-group">
                            <label for="host">{$_L['Host']}</label>
                            <input type="text" class="form-control" id="host" name="host">
                        </div>

                        <div class="form-group">
                            <label for="password">{$_L['Password']}</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>

                        <div class="form-group">
                            <label for="port">IMAP Port</label>
                            <input type="text" class="form-control" id="port" name="port">
                        </div>



                        <div class="form-group">
                            <label for="encryption">Encryption</label>
                            <label class="radio-inline">
                                <input type="radio" name="encryption" value="tls"> TLS
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="encryption" value="ssl"> SSL
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="encryption" value=""> No Encryption
                            </label>
                        </div>



                        <hr>

                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" id="hidden" name="hidden" value="1"> Hide from client?
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" id="delete_after_import" name="delete_after_import" value="1"> Delete mail after import?
                                </label>
                            </div>
                        </div>



                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$_L['Close']}</button>
                    <button type="button" id="btn_modal_action" class="btn btn-primary">{$_L['Save']}</button>
                </div>
            </div>
        </div>
    </div>




{/block}

{block name="script"}

<script>
    $(function() {

        var _url = base_url;

        $btn_modal_action = $("#btn_modal_action");

        $modal_add_item = $("#modal_add_item");

        $btn_modal_action.on('click', function(e) {
            e.preventDefault();
            $modal_add_item.block({ message: block_msg });
            $.post( _url + "tickets/admin/departments_post/", $("#ib_modal_form").serialize())
                .done(function( data ) {

                    if ($.isNumeric(data)) {

                        location.reload();

                    }

                    else {
                        $modal_add_item.unblock();
                        toastr.error(data);
                    }

                });

        });










        var $modal = $('#cloudonex_body');

        $('.item_edit').on('click', function(e){
            e.preventDefault();
            var id = this.id;
            $.fancybox.open({
                src  : base_url + 'tickets/admin/edit_department/'+ id + '/',
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




        $modal.on('click', '.test_imap', function(e){
            e.preventDefault();
            $.post( base_url + "tickets/admin/imap_test/", $("#edit_form").serialize())
                .done(function( data ) {

                    if ($.isNumeric(data)) {
                        $.fancybox.close()
                        toastr.success("Connected Successfully");

                    }

                    else {
                        $.fancybox.close()
                        toastr.error(data);
                    }

                });


        });


        $modal.on('click', '.edit_submit', function(e){
            e.preventDefault();

            $.post( _url + "tickets/admin/departments_edit/", $("#edit_form").serialize())
                .done(function( data ) {

                    if ($.isNumeric(data)) {

                        location.reload();

                    }

                    else {
                        $.fancybox.close();
                        toastr.error(data);
                    }

                });


        });

    });
</script>

{/block}
