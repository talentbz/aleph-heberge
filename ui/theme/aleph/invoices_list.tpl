{extends file="$layouts_admin"}
{block name="head"}
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />
    <style>
        {if empty($config['admin_dark_theme'])}
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }
        .bg-success{
            color:#23a52d;
        }
        .bg-info{
            color:#2F92B5!important;
        }
        {/if}


    </style>

{/block}

{block name="content"}

    <div class="subheader">
        <h1 class="subheader-title">
            <i class='subheader-icon fal fa-window'></i> {$_L['Sales']}

        </h1>
    </div>

    <div class="row">
        <div class="col-md-3">
            <div class="dashboard-stat2" style="background: linear-gradient(87deg,#2dce89 0,#2dcecc 100%)!important;border-radius: .375rem; min-height: 1px;
    padding: 1.5rem;
    flex: 1 1 auto">
                <div class="number">
                    <h3 class="h2 font-weight-bold mb-0 text-white">
                        <span>{formatCurrency($invoice_paid_amount,$config['home_currency'])}</span>
                    </h3>
                    <small class="h5  mb-0 text-white">{$_L['Paid']}</small>
                </div>

                <div class="progress-info">


                    <div class="progress">
                                            <span style="width: {$p['Paid']['percentage']}%;" class="progress-bar bg-info">

                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="text-nowrap text-white font-weight-600"> {$p['Paid']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-stat2" style="background: linear-gradient(87deg,#f5365c 0,#f56036 100%)!important;    border-radius: .375rem;min-height: 1px;
    padding: 1.5rem;
    flex: 1 1 auto">
                <div class="number">
                    <h3 class="h2 font-weight-bold mb-0 text-white">
                        <span>{formatCurrency($invoice_un_paid_amount,$config['home_currency'])}</span>
                    </h3>
                    <small class="h5 mb-0 text-white">{$_L['Unpaid']}</small>
                </div>
                <div class="progress-info">
                    <div class="progress">
                                            <span style="width: {$p['Unpaid']['percentage']}%;" class="progress-bar  bg-success">
                                                <span class="sr-only">{$p['Unpaid']['percentage']}%</span>
                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="text-nowrap text-white font-weight-600"> {$p['Unpaid']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-stat2 " style="background: linear-gradient(87deg,#5e72e4 0,#825ee4 100%)!important;    border-radius: .375rem; rgba(0,0,0,.05); min-height: 1px;
    padding: 1.5rem;
    flex: 1 1 auto">
                <div class="number">
                    <h3 class="h2 font-weight-bold mb-0 text-white">
                        <span>{formatCurrency($invoice_partially_paid_amount,$config['home_currency'])}</span>
                    </h3>
                    <small class="h5 mb-0 text-white"">{$_L['Partially Paid']}</small>
                </div>
                <div class="progress-info">
                    <div class="progress">
                                            <span style="width: {$p['Partially Paid']['percentage']}%;" class="progress-bar  bg-success">
                                                <span class="sr-only">{$p['Partially Paid']['percentage']}%</span>
                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="text-nowrap text-white font-weight-600"> {$p['Partially Paid']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-stat2 " style="background: linear-gradient(87deg,#172b4d 0,#1a174d 100%)!important;   border-radius: .375rem;min-height: 1px;
    padding: 1.5rem;
    flex: 1 1 auto">
                <div class="number">
                    <h3 class="h2 font-weight-bold mb-0 text-white">
                        <span class="amount" data-a-sign="{$config['currency_code']} ">{formatCurrency($invoice_cancelled_amount,$config['home_currency'])}</span>
                    </h3>
                    <small class="h5  mb-0 text-white">{$_L['Cancelled']}</small>
                </div>
                <div class="progress-info">
                    <div class="progress">
                                            <span style="width: {$p['Cancelled']['percentage']}%;" class="progress-bar bg-success">
                                                <span class="sr-only">{$p['Cancelled']['percentage']}%</span>
                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="text-nowrap text-white font-weight-600"> {$p['Cancelled']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">

            <div class="panel">

                <div class="panel-hdr">




                    <h2>{$_L['Invoices']}</h2>


                    <div class="panel-toolbar">

                        <div class="btn-group">
                            <a href="{$_url}invoices/add/" class="btn btn-primary  btn-sm"> {$_L['Add Invoice']}</a>
                            <a href="{$_url}reports/invoices/" class="btn btn-warning btn-sm"> {$_L['View Reports']}</a>
                        </div>

                    </div>
                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <ul class="nav nav-tabs nav-tabs-clean mb-3" role="tablist">
                            <li class="nav-item"><a class="nav-link {if $tab == 'unpaid'}active{/if}" href="{$base_url}invoices/list/">{$_L['Unpaid']}</a></li>
                            <li class="nav-item"><a class="nav-link {if $tab == 'partially_paid'}active{/if}" href="{$base_url}invoices/list/0/partially_paid/">{$_L['Partially Paid']}</a></li>
                            <li class="nav-item"><a class="nav-link  {if $tab == 'paid'}active{/if}" href="{$base_url}invoices/list/0/paid/">{$_L['Paid']}</a></li>
                            <li class="nav-item"><a class="nav-link {if $tab == 'cancelled'}active{/if}" href="{$base_url}invoices/list/0/cancelled/">{$_L['Cancelled']}</a></li>
                            <li class="nav-item"><a class="nav-link {if $tab == 'all'}active{/if}" href="{$base_url}invoices/list/0/all/">{$_L['All']}</a></li>
                        </ul>

                        <div class="table-responsive">

                            <table id="clx_datatable" class="table table-striped w-100 sys_table footable">
                                <thead style="background: #f0f2ff">
                                <tr>
                                    <th>#</th>
                                    <th>{$_L['Account']}</th>
                                    <th>{$_L['Amount']}</th>
                                    <th>{$_L['Invoice Date']}</th>
                                    <th>{$_L['Due Date']}</th>
                                    <th>
                                        {$_L['Status']}
                                    </th>
                                    <th>{$_L['Type']}</th>
                                    <th class="text-right" width="140px;">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $d as $ds}
                                    <tr>
                                        <td data-value="{$ds['id']}" data-order="{$ds@iteration}"><a href="{$_url}invoices/view/{$ds['id']}/">{$ds['invoicenum']}{if $ds['cn'] neq ''} {$ds['cn']} {else} {$ds['id']} {/if}</a> </td>
                                        <td>
                                            {if isset($contacts[$ds['userid']])}
                                                <a href="{$_url}invoices/view/{$ds['id']}/">
                                                    <strong>
                                                        {$ds['account']}
                                                        {if $contacts[$ds['userid']]->company != ''}
                                                            <br>  {$contacts[$ds['userid']]->company}
                                                        {/if}
                                                    </strong>


                                                </a>
                                            {/if}
                                        </td>
                                        <td>{formatCurrency($ds['total'],$ds['currency_iso_code'])}</td>
                                        <td data-value="{strtotime($ds['date'])}">{date( $config['df'], strtotime($ds['date']))}</td>
                                        <td data-value="{strtotime($ds['duedate'])}">{date( $config['df'], strtotime($ds['duedate']))}</td>
                                        <td>

                                            {if $ds['status'] eq 'Unpaid'}
                                                <span class="badge badge-dot"><i class="bg-danger"></i>{ib_lan_get_line($ds['status'])}</span>
                                            {elseif $ds['status'] eq 'Paid'}
                                                <span class="badge badge-dot"><i class="bg-success"></i>{ib_lan_get_line($ds['status'])}</span>
                                            {elseif $ds['status'] eq 'Partially Paid'}
                                                <span class="badge badge-dot"><i class="bg-info"></i>{ib_lan_get_line($ds['status'])}</span>
                                            {elseif $ds['status'] eq 'Cancelled'}
                                                <span class="badge- badge-dot"><i class="bg-warning"></i>{ib_lan_get_line($ds['status'])}</span>
                                            {else}
                                                {ib_lan_get_line($ds['status'])}
                                            {/if}



                                        </td>
                                        <td>
                                            {if $ds['r'] eq '0'}
                                                <span class="badge badge-dot"><i class="bg-success"></i> {$_L['Onetime']}</span>
                                            {else}
                                                <span class="badge badge-dot"><i class="bg-warning"></i> {$_L['Recurring']}</span>
                                            {/if}
                                        </td>
                                        <td class="text-right">


                                            <div class="btn-group">
                                                <a href="{$_url}invoices/view/{$ds['id']}/" class="btn btn-primary btn-icon" data-toggle="tooltip" data-placement="top" title="{$_L['View']}"><i class="fal fa-file-alt"></i></a>

                                                <a href="{$_url}invoices/clone/{$ds['id']}/" class="btn btn-success btn-icon" data-toggle="tooltip" data-placement="top" title="{$_L['Clone']}"><i class="fal fa-copy"></i></a>


                                                <a href="{$_url}invoices/edit/{$ds['id']}/" class="btn btn-info btn-icon" data-toggle="tooltip" data-placement="top" title="{$_L['Edit']}"><i class="fal fa-file-edit"></i></a>

                                                {if $ds['r'] neq '0'}

                                                    <a href="{$_url}invoices/stop_recurring/{$ds['id']}/" class="btn btn-info btn-icon" data-toggle="tooltip" data-placement="top" title="{$_L['Stop Recurring']}"><i class="fal fa-stop"></i></a>

                                                {/if}

                                                <a href="#" class="btn btn-danger btn-icon cdelete" id="iid{$ds['id']}" data-toggle="tooltip" data-placement="top" title="{$_L['Delete']}"><i class="fal fa-trash-alt"></i></a>
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
{/block}

{block name="script"}

    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>

    <script>
        $(function () {

            var $modal = $('#cloudonex_body');

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
                            className: 'btn-warning btn-sm mr-1'
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


            $modal.on('click', '.cdelete', function(e){

                e.preventDefault();
                var id = this.id;
                bootbox.confirm("Are You Sure?", function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/invoice/" + id;
                    }
                });


            });





        });
    </script>
{/block}
