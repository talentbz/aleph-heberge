{extends file="$layouts_admin"}

{block name="content"}

    {block name="head"}

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />

        <style>
            {if empty($config['admin_dark_theme'])}
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

            {/if}

        </style>
    {/block}


    <div class="row">



        <div class="col-md-12">



            <div class="panel">

                <div class="panel-hdr">
                    <h2>{$_L['Companies']}</h2>

                    <div class="panel-toolbar">
                        <a href="#" class="btn btn-primary add_company waves-effect waves-light" id="add_company">{$_L['New Company']}</a>

                    </div>
                </div>

                <div class="panel-container show">

                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table table-striped w-100" id="clx_datatable">
                                <thead
                                        {if empty($config['admin_dark_theme'])}
                                            style="background:#f0f2ff"
                                            {/if}
                                         >
                                <tr>
                                    <th class="bold">{$_L['Logo']}</th>
                                    <th class="bold">{$_L['Company Name']}</th>
                                    <th class="bold">{$_L['Email']}</th>
                                    <th class="bold">{$_L['Phone']}</th>
                                    <th class="text-center bold">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>


                                {foreach $companies as $company}
                                    <tr data-id="{$company['id']}">
                                        <td>

                                            {if $company['logo_url'] neq ''}
                                                <img style="max-height: 40px;" src="{$app_url}storage/companies/{$company->logo_url}">
                                            {else}
                                                <span class="clx-avatar">{$company['company_name'][0]}</span>
                                            {/if}

                                        </td>
                                        <td>
                                            <a class="cview" id="ae{$company['id']}" href="#">
                                                <strong>
                                                    {$company['company_name']}
                                                    {if $company['code'] != ''}
                                                        <br>
                                                        {$company['code']}
                                                    {/if}
                                                </strong>

                                            </a>
                                        </td>
                                        <td><a href="#" class="send_email text-info h6">{$company['email']}</a> </td>
                                        <td class="h6">{$company['phone']}</td>
                                        <td class="text-right">
                                            <div class="btn-group">

                                                <a href="{$_url}" id="ae{$company['id']}" class="btn btn-primary btn-icon cview" data-toggle="tooltip" title="{$_L['View']}"><i class="fal fa-building"></i> </a>

                                                <a href="{$_url}" id="be{$company['id']}" class="btn btn-warning btn-icon cedit" data-toggle="tooltip" title="{$_L['Edit']}"><i class="fal fa-pencil"></i> </a>


                                                <a href="#" class="btn btn-danger btn-icon cdelete" id="c{$company['id']}" data-toggle="tooltip" title="{$_L['Delete']}"><i class="fal fa-trash-alt"></i> </a>
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



    </div>

    <div class="md-fab-wrapper">
        <a class="md-fab md-fab-primary waves-effect waves-light add_company" href="#">
            <i class="fal fa-plus"></i>
        </a>
    </div>


{/block}


{block name="script"}
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>


    <script>

        $(function() {


            $('#clx_datatable').dataTable(
                {
                    responsive: true,
                    lengthChange: false,
                    dom:
                    /*	--- Layout Structure
                        --- Options
                        l	-	length changing input control
                        f	-	filtering input
                        t	-	The table!
                        i	-	Table information summary
                        p	-	pagination control
                        r	-	processing display element
                        B	-	buttons
                        R	-	ColReorder
                        S	-	Select

                        --- Markup
                        < and >				- div element
                        <"class" and >		- div with a class
                        <"#id" and >		- div with an ID
                        <"#id.class" and >	- div with an ID and a class

                        --- Further reading
                        https://datatables.net/reference/option/dom
                        --------------------------------------
                     */
                        "<'row mb-3'<'col-sm-12 col-md-6 d-flex align-items-center justify-content-start'f><'col-sm-12 col-md-6 d-flex align-items-center justify-content-end'lB>>" +
                        "<'row'<'col-sm-12'tr>>" +
                        "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
                    buttons: [
                        /*{
                        	extend:    'colvis',
                        	text:      'Column Visibility',
                        	titleAttr: 'Col visibility',
                        	className: 'mr-sm-3'
                        },*/
                        {
                            extend: 'pdfHtml5',
                            text: 'PDF',
                            titleAttr: 'Generate PDF',
                            className: 'btn-danger btn-sm mr-1'
                        },
                        {
                            extend: 'excelHtml5',
                            text: 'Excel',
                            titleAttr: 'Generate Excel',
                            className: 'btn-success btn-sm mr-1'
                        },
                        {
                            extend: 'csvHtml5',
                            text: 'CSV',
                            titleAttr: 'Generate CSV',
                            className: 'btn-primary btn-sm mr-1'
                        },
                        {
                            extend: 'copyHtml5',
                            text: 'Copy',
                            titleAttr: 'Copy to clipboard',
                            className: 'btn-dark btn-sm mr-1'
                        },
                        {
                            extend: 'print',
                            text: 'Print',
                            titleAttr: 'Print Table',
                            className: 'btn-secondary btn-sm'
                        }
                    ],
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
            $('.has-tooltip').tooltip();




            var tab = 'summary';


            function updateDiv(action,base_url,cid,cb){

                var $ibox_form = $('#ibox_form');
                $ibox_form.block({ message: block_msg });

                // if (window.history.replaceState) {
                //     window.history.replaceState( {} , '',  _url + 'contacts/view/'+ cid +'/' + action + '/' );
                // }


                $('.list-group a.active').removeClass('active');
                $("#"+action).addClass("active");



                $.post(base_url +  "contacts/company_" +action + '/', {
                    cid: cid

                })
                    .done(function (data) {

                        $("#application_ajaxrender").html(data);
                        $ibox_form.unblock();

                        cb();


                        $('.amount').autoNumeric('init');

                    });

            }

            var cb  =  function cb(){



                switch(tab) {
                    case "memo":


                        // $('#v_memo').redactor(
                        //     {
                        //         minHeight: 200 // pixels
                        //     }
                        // );

                        break;





                    default:

                    //cb = function cb (){
                    //    //  return;
                    //};

                }




            };



            var _url = $("#_url").val();




            var $modal = $('#cloudonex_body');

            $('[data-toggle="tooltip"]').tooltip();

            $('.add_company').on('click', function(e){

                e.preventDefault();

                $.fancybox.open({
                    src  :  base_url + 'contacts/modal_add_company',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $("#ajax-modal .country").select2();
                        }
                    },
                });

            });



            // function sendEmail(email,loader) {
            //
            //
            //
            //     $modal.load( base_url + 'handler/email/' + email + '/', '', function(){
            //
            //         $modal.modal();
            //
            //         if(loader){
            //             $('body').modalmanager('loading');
            //         }
            //
            //         ib_editor('#email_content',300,false);
            //
            //     });
            //
            // }


            $modal.on('click', '.modal_submit', function(e){

                e.preventDefault();

                $.post( _url + "contacts/add_company_post/", $("#ib_modal_form").serialize())
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {
                            toastr.error(data);
                        }

                    });

            });

            $modal.on('click', '.cedit', function(e){

                e.preventDefault();
                var id = this.id;

                $.fancybox.open({
                    src  :  base_url + 'contacts/modal_add_company/' + id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $("#ajax-modal .country").select2();
                        }
                    },
                });


            });

            $modal.on('click', '.cdelete', function(e){

                e.preventDefault();
                var id = this.id;
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/company/" + id + '/';
                    }
                });


            });


            $modal.on('click', '.cview', function(e){

                e.preventDefault();
                var id = this.id;

                $.fancybox.open({
                    src  :  base_url + 'contacts/modal_view_company/'+id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            updateDiv('summary',base_url,id,cb);
                        }
                    },
                });

            });




            $modal.on('click', '.act_memo_update', function(e){

                e.preventDefault();


                $.post( base_url + "contacts/company_update_notes/", { id: $('#base_cid').val(), memo:$("#v_memo").val() })
                    .done(function( data ) {

                        toastr.success(data);

                    });

            });







            $modal.on('click', '.li_memo', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'memo';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.li_customers', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'customers';

                updateDiv(tab,base_url,cid,cb);

            });

            $modal.on('click', '.li_summary', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'summary';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.li_summary', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'summary';

                updateDiv(tab,base_url,cid,cb);

            });

            $modal.on('click', '.li_invoices', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'invoices';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.li_quotes', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'quotes';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.li_orders', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'orders';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.li_files', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'files';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.li_transactions', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'transactions';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.li_tickets', function(e){

                var cid = $('#base_cid').val();

                e.preventDefault();

                tab = 'tickets';

                updateDiv(tab,base_url,cid,cb);

            });


            $modal.on('click', '.send_email', function(e){
                e.preventDefault();
                sendEmail($(this).html(),true);

            });

            $("#ib_data_table").on('click', '.send_email', function(e){
                e.preventDefault();
                sendEmail($(this).html(),false);
            });


            $modal.on('click', '#btn_send_email', function(e){

                e.preventDefault();
                $modal.modal('loading');
                $.post( base_url + "handler/send_email_post/", {
                    to: $('#toemail').val(),
                    subject: $('#subject').val(),
                    message: tinyMCE.activeEditor.getContent()

                })
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {
                            $modal.modal('loading');
                            toastr.error(data);
                        }

                    });

            });








        });

    </script>
{/block}
