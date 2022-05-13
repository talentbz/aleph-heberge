{extends file="$layouts_admin"}

{block name="head"}


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
            color: #2CCE89!important;
        }
        {/if}
    </style>
{/block}

{block name="content"}


    <div class="row">
        <div class="col-md-3">
            <div class="dashboard-stat2 ">
                <div class="display">
                    <div class="number">
                        <h3 class="font-green-meadow">
                            <span class="amount" data-a-sign="{$config['currency_code']} ">{$invoice_paid_amount}</span>
                        </h3>
                        <small>{$_L['Paid']}</small>
                    </div>
                    <div class="icon">
                        <i class="fal fa-calendar-check-o"></i>
                    </div>
                </div>
                <div class="progress-info">
                    <div class="progress">
                                            <span style="width: {$p['Paid']['percentage']}%;" class="progress-bar progress-bar-primary bg-green-meadow">
                                                <span class="sr-only">{$p['Paid']['percentage']}%</span>
                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="progress-status-title"> {$_L['Percentage']} </div>
                        <div class="progress-status-number"> {$p['Paid']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-stat2 ">
                <div class="display">
                    <div class="number">
                        <h3 class="font-red">
                            <span class="amount" data-a-sign="{$config['currency_code']} ">{$invoice_un_paid_amount}</span>
                        </h3>
                        <small>{$_L['Unpaid']}</small>
                    </div>
                    <div class="icon">
                        <i class="fal fa-calendar-check-o"></i>
                    </div>
                </div>
                <div class="progress-info">
                    <div class="progress">
                                            <span style="width: {$p['Unpaid']['percentage']}%;" class="progress-bar progress-bar-primary bg-red">
                                                <span class="sr-only">{$p['Unpaid']['percentage']}%</span>
                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="progress-status-title"> {$_L['Percentage']} </div>
                        <div class="progress-status-number"> {$p['Unpaid']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-stat2 ">
                <div class="display">
                    <div class="number">
                        <h3 class="font-blue">
                            <span class="amount" data-a-sign="{$config['currency_code']} ">{$invoice_partially_paid_amount}</span>
                        </h3>
                        <small>{$_L['Partially Paid']}</small>
                    </div>
                    <div class="icon">
                        <i class="fal fa-calendar-check-o"></i>
                    </div>
                </div>
                <div class="progress-info">
                    <div class="progress">
                                            <span style="width: {$p['Partially Paid']['percentage']}%;" class="progress-bar progress-bar-primary green-sharp">
                                                <span class="sr-only">{$p['Partially Paid']['percentage']}%</span>
                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="progress-status-title"> {$_L['Percentage']} </div>
                        <div class="progress-status-number"> {$p['Partially Paid']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-stat2 ">
                <div class="display">
                    <div class="number">
                        <h3 class="font-blue-hoki">
                            <span class="amount" data-a-sign="{$config['currency_code']} ">{$invoice_cancelled_amount}</span>
                        </h3>
                        <small>{$_L['Cancelled']}</small>
                    </div>
                    <div class="icon">
                        <i class="fal fa-calendar-check-o"></i>
                    </div>
                </div>
                <div class="progress-info">
                    <div class="progress">
                                            <span style="width: {$p['Cancelled']['percentage']}%;" class="progress-bar progress-bar-primary bg-blue-hoki">
                                                <span class="sr-only">{$p['Cancelled']['percentage']}%</span>
                                            </span>
                    </div>
                    <div class="progress-status">
                        <div class="progress-status-title"> {$_L['Percentage']} </div>
                        <div class="progress-status-number"> {$p['Cancelled']['percentage']}% </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">

                    <h2>{$_L['Purchase Orders']}</h2>


                    <div class="panel-toolbar">
                        <div class="btn-group">
                            <a href="{$_url}purchases/add/" class="btn btn-sm btn-primary"> {$_L['New Purchase Order']}</a>
                            <a href="{$_url}reports/purchases/" class="btn btn-sm btn-primary"> {$_L['View Reports']}</a>
                        </div>
                    </div>
                </div>

                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table table-striped" id="clx_datatable">
                                <thead style="background: #f0f2ff">
                                <tr>
                                    <th class="h6">#</th>
                                    <th class="h6">{$_L['Account']}</th>
                                    <th class="h6">{$_L['Amount']}</th>
                                    <th class="h6">{$_L['Issued at']}</th>
                                    <th class="h6">
                                        {$_L['Status']}
                                    </th>
                                    <th class="h6">{$_L['Type']}</th>
                                    <th class="text-right" width="120px;">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $d as $ds}
                                    <tr>
                                        <td data-value="{$ds['id']}"><a class="h6" href="{$_url}purchases/view/{$ds['id']}/">{$ds['invoicenum']}{if $ds['cn'] neq ''} {$ds['cn']} {else} {$ds['id']} {/if}</a> </td>
                                        <td ><a class="h6 text-info"href="{$_url}purchases/view/{$ds['id']}/">{$ds['account']}</a> </td>
                                        <td>{formatCurrency($ds['total'],$ds['currency_iso_code'])}</td>
{*                                        <td class="amount" data-a-sign="{if $ds['currency_symbol'] eq ''} {$config['currency_code']} {else} {$ds['currency_symbol']}{/if} ">{$ds['total']}</td>*}
                                        <td data-value="{strtotime($ds['date'])}">{date( $config['df'], strtotime($ds['date']))}</td>
                                        {*<td data-value="{strtotime($ds['duedate'])}">{date( $config['df'], strtotime($ds['duedate']))}</td>*}
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
                                                <span class="badge badge-success"><i class="fal fa-dot-circle-o"></i> {$_L['Onetime']}</span>
                                            {else}
                                                <span class="label label-info"><i class="fal fa-repeat"></i> {$_L['Recurring']}</span>
                                            {/if}
                                        </td>
                                        <td class="text-right">


                                            <div class="btn-group">
                                                <a href="{$_url}purchases/view/{$ds['id']}/" class="btn btn-primary btn-sm" data-toggle="tooltip" data-placement="top" title="{$_L['View']}"><i class="fal fa-file"></i></a>
                                                <a href="{$_url}purchases/clone/{$ds['id']}/" class="btn btn-success btn-sm" data-toggle="tooltip" data-placement="top" title="{$_L['Clone']}"><i class="fal fa-clone"></i></a>
                                                <a href="{$_url}purchases/edit/{$ds['id']}/" class="btn btn-info btn-sm" data-toggle="tooltip" data-placement="top" title="{$_L['Edit']}"><i class="fal fa-pencil"></i></a>
                                                <a href="#" class="btn btn-danger btn-sm cdelete" id="iid{$ds['id']}" data-toggle="tooltip" data-placement="top" title="{$_L['Delete']}"><i class="fal fa-trash-alt"></i></a>
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
    <script>

        $(function () {

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

            $clx_body = $('#cloudonex_body');

            $clx_body.on('click', '.cdelete', function(e){

                e.preventDefault();
                var id = this.id;
                bootbox.confirm("{$_L['are_you_sure']}", function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/purchase/" + id;
                    }
                });

            });





        });



    </script>
{/block}
