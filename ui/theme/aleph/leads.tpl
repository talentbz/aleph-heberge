{extends file="$layouts_admin"}

{block name="content"}


    <div class="subheader">
        <h1 class="subheader-title">
            <i class='subheader-icon fal fa-user-alt'></i> {$_L['Leads']} <span class='fw-300'></span>
        </h1>
        <div class="subheader-block d-lg-flex align-items-center">
            <a href="#" class="btn btn-primary add_item waves-effect waves-light" id="add_item"><i class="fal fa-plus"></i> {$_L['New Lead']}</a>
        </div>

    </div>

    <div class="row">


        <div class="col-md-12">
            <div class="panel">
                <div class="panel-container show">
                    <div class="panel-content">


                        <div class="row">
                            <div class="col-md-3 col-sm-6">

                                <form>

                                    <div class="form-group">
                                        <label for="filter_first_name">{$_L['First Name']}</label>
                                        <input type="text" id="filter_first_name" name="filter_first_name" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_middle_name">{$_L['Middle Name']}</label>
                                        <input type="text" id="filter_middle_name" name="filter_middle_name" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_last_name">{$_L['Last Name']}</label>
                                        <input type="text" id="filter_last_name" name="filter_last_name" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_email">{$_L['Email']}</label>
                                        <input type="email" id="filter_email" name="filter_email" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_salutation">{$_L['Salutation']}</label>
                                        <input type="text" id="filter_salutation" name="filter_salutation" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_company">{$_L['Company']}</label>
                                        <input type="text" id="filter_company" name="filter_company" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_phone">{$_L['Phone']}</label>
                                        <input type="text" id="filter_phone" name="filter_phone" class="form-control">
                                    </div>

                                    <div class="form-group">
                                        <label for="filter_status">{$_L['Status']}</label>
                                        <input type="text" id="filter_status" name="filter_status" class="form-control">
                                    </div>








                                    <button type="submit" id="ib_filter" class="btn btn-primary">{$_L['Filter']}</button>

                                    <br>
                                </form>


                            </div>
                            <div class="col-md-9 col-sm-6 ib_right_panel">


                                <div class="table-responsive" id="ib_data_panel">


                                    <table class="table table-bordered table-hover display" id="ib_dt">
                                        <thead>
                                        <tr class="heading">
                                            <th>{$_L['ID']}</th>
                                            <th>{$_L['Name']}</th>
                                            <th>{$_L['Title']}</th>
                                            <th>{$_L['Company']}</th>

                                            <th>{$_L['Phone']}</th>

                                            <th>{$_L['Email']}</th>
                                            <th>{$_L['Status']}</th>
                                            <th>{$_L['Owner']}</th>

                                            <th>{$_L['Manage']}</th>
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


            var $modal = $('#cloudonex_body');

            $('[data-toggle="tooltip"]').tooltip();

            var ib_dt = $('#ib_dt').DataTable( {

                "serverSide": true,
                "ajax": {
                    "url": base_url + "leads/json_list/",
                    "type": "POST",
                    "data": function ( d ) {

                        d.first_name = $('#filter_first_name').val();
                        d.last_name = $('#filter_last_name').val();
                        d.middle_name = $('#filter_middle_name').val();
                        d.email = $('#filter_email').val();
                        d.salutation = $('#filter_salutation').val();
                        d.company = $('#filter_company').val();
                        d.phone = $('#filter_phone').val();
                        d.status = $('#filter_status').val();


                    }
                },
                "pageLength": 10,
                responsive: true,

                lengthMenu: [
                    [ 10, 25, 50, -1 ],
                    [ '10 rows', '25 rows', '50 rows', 'Show all' ]
                ],
                "columnDefs": [
                    { "orderable": false, "targets": 8 }
                ],
                "order": [[ 0, 'desc' ]],
                "scrollX": true,
                "initComplete": function () {
                    $ib_data_panel.unblock();
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

            $('.add_item').on('click', function(e){

                e.preventDefault();

                $.fancybox.open({
                    src  :  base_url + 'leads/modal_lead/new/',
                    touch: false,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {

                        }
                    },
                });

            });





            $modal.on('click', '.modal_submit', function(e){

                e.preventDefault();


                $.post( _url + "leads/post/", $("#ib_modal_form").serialize())
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            // $ib_data_panel.block({ message:block_msg });
                            //
                            // ib_dt.ajax.reload(
                            //     function () {
                            //         $ib_data_panel.unblock();
                            //     }
                            // );
                            location.reload();

                        }

                        else {

                            toastr.error(data);
                        }

                    });

            });


            $modal.on('click', '.act_convert_to_customer', function(e){

                e.preventDefault();


                $.post( base_url + "leads/convert_to_customer/", { lid: $("#v_lid").val() })
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            window.location = base_url + 'contacts/view/' + data;

                        }

                        else {

                            toastr.error(data);
                        }

                    });

            });

            $modal.on('click', '.act_memo_update', function(e){

                e.preventDefault();


                $.post( base_url + "leads/update_memo/", { lid: $("#v_lid").val(), memo:$("#v_memo").val() })
                    .done(function( data ) {

                        toastr.success(data);

                    });

            });





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

                        $.get( base_url + "delete/lead/"+lid, function( data ) {
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

            $ib_data_panel.on('click', '.cedit', function(e){
                e.preventDefault();
                var lid = this.id;

                $.fancybox.open({
                    src  :  base_url + 'leads/modal_lead/edit/'+lid,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {

                        }
                    },
                });



            });

            $ib_data_panel.on('click', '.cview', function(e){

                e.preventDefault();
                var lid = this.id;

                $.fancybox.open({
                    src  :  base_url + 'leads/modal_lead/view/'+lid,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {

                        }
                    },
                });


            });





        });
    </script>
{/block}
