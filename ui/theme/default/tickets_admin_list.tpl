{extends file="$layouts_admin"}

{block name="content"}

    <div class="subheader">
        <h1 class="subheader-title">
            <i class='subheader-icon fal fa-life-ring'></i> {$_L['Tickets']} <span class='fw-300'></span>
        </h1>
        <div class="subheader-block d-lg-flex align-items-center">
            <a href="{$_url}tickets/admin/create/" class="btn btn-primary"><i class="fal fa-plus"></i> {$_L['Open Ticket']}</a>
        </div>

    </div>

    <div class="row">


        <div class="col-md-12">
            <div class="panel">
                <div class="panel-container">
                    <div class="panel-content">



                        <div class="row">

                            <div class="col-md-3 col-sm-6">

                                <form>

                                    <div class="form-group">
                                        <label for="filter_account">{$_L['Customer']}</label>
                                        <input type="text" id="filter_account" name="filter_account" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_status">{$_L['Status']}</label>
                                        <select class="form-control" id="filter_status" name="filter_status" size="1">
                                            <option value="">All</option>
                                            <option value="Open">Open</option>
                                            <option value="On Hold">On Hold</option>
                                            <option value="Escalated">Escalated</option>
                                            <option value="Closed">Closed</option>

                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_status">{$_L['Staff']}</label>
                                        <select class="form-control" id="filter_by_staff" name="filter_by_staff">
                                            <option value="">--</option>

                                            {foreach $staffs as $staff}
                                                <option value="{$staff->id}">{$staff->fullname}</option>
                                            {/foreach}

                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_company">{$_L['Company']}</label>
                                        <input type="text" id="filter_company" name="filter_company" class="form-control">
                                    </div>





                                    <div class="form-group">
                                        <label for="filter_email">{$_L['Email']}</label>
                                        <input type="email" id="filter_email" name="filter_email" class="form-control">
                                    </div>


                                    <div class="form-group">
                                        <label for="filter_subject">{$_L['Subject']}</label>
                                        <input type="text" id="filter_subject" name="filter_subject" class="form-control">
                                    </div>






                                    <button type="submit" id="ib_filter" class="btn btn-primary">{$_L['Filter']}</button>

                                    <br>
                                </form>


                            </div>
                            <div class="col-md-9 col-sm-6 ib_right_panel">

                                <div id="ib_act_hidden" style="display: none;">

                                    <a href="#" id="set_status" class="btn btn-primary"><i class="fal fa-tags"></i> Set Status</a>

                                    <a href="#" id="delete_multiple_customers" class="btn btn-danger"><i class="fal fa-trash"></i> {$_L['Delete']}</a>

                                    <hr>
                                </div>

                                <div class="table-responsive" id="ib_data_panel">


                                    <table class="table table-bordered display" id="ib_dt" width="100%">
                                        <thead>
                                        <tr class="heading">
                                            <th width="100px;">#</th>
                                            <th width="60px;">{$_L['Image']}</th>
                                            <th>{$_L['Subject']}</th>
                                            <th>{$_L['Customer']}</th>
                                            <th>{$_L['Company']}</th>
                                            <th>{$_L['Assigned To']}</th>
                                            <th class="text-right" style="width: 80px;">{$_L['Status']}</th>
                                        </tr>
                                        </thead>




                                    </table>
                                </div>

                            </div>
                        </div>



                    </div>
                </div>
            </div>
        </div>

    </div>



{/block}

{block name="script"}
    <script>

        $(function() {

            var _url = $("#_url").val();

            var $ib_data_panel = $("#ib_data_panel");

            $ib_data_panel.block({ message:block_msg });

            var selected = [];
            var ib_act_hidden = $("#ib_act_hidden");
            function ib_btn_trigger() {
                if(selected.length > 0){
                    ib_act_hidden.show(200);
                }
                else{
                    ib_act_hidden.hide(200);
                }
            }

            $('#filter_by_staff').select2({

                }
            ).on('change',function () {



            });


            $('[data-toggle="tooltip"]').tooltip();

            var ib_dt = $('#ib_dt').DataTable( {

                "serverSide": true,
                "ajax": {
                    "url": base_url + "tickets/admin/json_list/",
                    "type": "POST",
                    "data": function ( d ) {

                        d.account = $('#filter_account').val();
                        d.email = $('#filter_email').val();
                        d.company = $('#filter_company').val();
                        d.status = $('#filter_status').val();
                        d.subject = $('#filter_subject').val();
                        d.staff = $('#filter_by_staff').val();

                    }
                },
                "pageLength": 20,

                responsive: true,
                fixedHeader: {
                    headerOffset: 50
                },
                "columnDefs": [
                    {
                        "render": function ( data, type, row ) {
                            return '<a href="' + base_url +'tickets/admin/view/'+ row[7] +'">'+ data +'</a>';
                        },
                        "targets": 2
                    },
                    {
                        "render": function ( data, type, row ) {
                            return '<a href="' + base_url +'contacts/view/'+ row[8] +'">'+ data +'</a>';
                        },
                        "targets": 3
                    },

                    { "orderable": false, "targets": 6 },
                    { "orderable": false, "targets": 1 },
                    { className: "text-center", "targets": [ 1 ] }
                ],
                "order": [[ 0, 'asc' ]],
                "scrollX": true,
                "initComplete": function () {
                    $ib_data_panel.unblock();
                },
                select: {
                    info: false
                },
                "language": {
                    "emptyTable": "{$_L['No items to display']}",
                    "info":      "{$_L['Showing _START_ to _END_ of _TOTAL_ entries']}",
                    "infoEmpty":      "{$_L['Showing 0 to 0 of 0 entries']}",
                    buttons: {
                        pageLength: '{$_L['Show all']}'
                    },
                    searchPlaceholder: "{__('Search')}"
                },
            } );

            var $ib_filter = $("#ib_filter");


            $ib_filter.on('click', function(e) {
                e.preventDefault();

                $ib_data_panel.block({ message:block_msg });

                ib_dt.ajax.reload(
                    function () {
                        $ib_data_panel.unblock();
                    }
                );


            });




            $ib_data_panel.on('click', '.cdelete', function(e){
                e.preventDefault();
                var lid = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){

                        $.get( base_url + "tickets/admin/delete/"+lid, function( data ) {
                            $ib_data_panel.block({ message:block_msg });

                            ib_dt.ajax.reload(
                                function () {
                                    $ib_data_panel.unblock();
                                }
                            );
                        });


                    }
                });

            });



            // $("#assign_to_group").click(function(e){
            //     e.preventDefault();
            //
            // });

            // $('#set_status').webuiPopover({
            //     type:'async',
            //     placement:'top',
            //
            //     cache: false,
            //     width:'240',
            //     url: base_url + 'tickets/admin/available_status/'
            // });

            $('body').on('change', '#bulk_status', function(e){

                $('.webui-popover').block({ message: block_msg});

                $.post( base_url + "tickets/admin/set_status/", { status: $('#bulk_status').val(), ids: selected })
                    .done(function( data ) {

                        $('.webui-popover').unblock();
                        $ib_data_panel.block({ message:block_msg });
                        ib_dt.ajax.reload(
                            function () {
                                $ib_data_panel.unblock();
                            }
                        );

                        toastr.success(data);


                    });



            });

            $("#delete_multiple_customers").click(function(e){
                e.preventDefault();
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        $.redirect(base_url + "tickets/admin/delete_multiple/",{ type: "tickets", ids: selected});
                    }
                });

            });




        });
    </script>
{/block}

