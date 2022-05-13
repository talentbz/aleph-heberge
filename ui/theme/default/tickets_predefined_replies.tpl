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
                    <h2>Predefined Replies</h2>
                    <div class="panel-toolbar">
                        <div class="btn-group">
                            <a data-toggle="modal" href="#modal_add_item" class="btn btn-success mb-md"><i class="fal fa-plus"></i> {$_L['Add Predefined Reply']}</a>

                            <a href="{$_url}tickets/admin/predefined_replies_reorder/" class="btn btn-primary mb-md"><i class="fal fa-arrows"></i> {$_L['Reorder Predefined Replies']}</a>
                        </div>
                    </div>
                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <table class="table table-striped " id="clx_datatable">
                            <thead style="background: #f0f2ff">
                            <tr>

                                <th>Title</th>
                                <th class="text-right">{$_L['Manage']}</th>
                            </tr>
                            </thead>
                            <tbody>

                            {foreach $replies as $reply}

                                <tr>

                                    <td>{$reply['title']}</td>


                                    <td class="text-right">
                                        <div class="btn-group">
                                            <a href="{$_url}tickets/admin/predefined_reply_edit/{$reply['id']}" class="btn btn-info btn-sm item_edit"> {$_L['Edit']}</a>
                                            <a href="#" class="btn btn-danger btn-sm cdelete" id="d{$reply['id']}">{$_L['Delete']}</a>

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
                    <div class="row">



                        <div class="col-md-12">

                            <form id="ib_modal_form">
                                <div class="form-group">
                                    <label for="title">{$_L['Title']}</label>
                                    <input type="text" name="title" class="form-control" id="title">
                                </div>


                                <div class="form-group">
                                    <label for="message">{$_L['Message']}</label>
                                    <textarea id="message" name="message" class="form-control" rows="5"></textarea>
                                </div>



                            </form>
                        </div>




                    </div>
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

            $('#clx_datatable').dataTable(
                {
                    responsive: true,
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

            var _url = base_url;

            var $modal_add_item = $("#modal_add_item");

            var $message = $("#message");

            $modal_add_item.on('shown.bs.modal', function() {
                $message.redactor({
                    minHeight: 200,
                    paragraphize: false,
                    replaceDivs: false,
                    linebreaks: true
                });
            });

            var $btn_modal_action = $("#btn_modal_action");


            $btn_modal_action.on('click', function(e) {
                e.preventDefault();

                $modal_add_item.block({ message: block_msg });
                $.post( _url + "tickets/admin/predefined_replies_post/", $("#ib_modal_form").serialize())
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


            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm('Are you sure?', function(result) {
                    if(result){

                        window.location.href = _url + "tickets/admin/predefined_replies_delete/" + id + "/";
                    }
                });
            });



        });
    </script>
{/block}
