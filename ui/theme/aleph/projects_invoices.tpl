{extends file="project_base.tpl"}

{block name="project_content"}
    <div class="row mb-3">
        <div class="col">
            <h2>{$_L['Invoices']}</h2>
        </div>

        <div class="col text-right">
            <a href="{$_url}invoices/add/1/0/0/{$project->id}" class="btn btn-primary">{$_L['New Invoice']}</a>
        </div>



    </div>


    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered table-hover" id="clx_datatable">
                <thead>
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

                {foreach $invoices as $invoice}
                    <tr>
                        <td  data-value="{$invoice->id}"><a href="{$_url}invoices/view/{$invoice->id}/">{$invoice->invoicenum}{if $invoice->cn neq ''} {$invoice->cn} {else} {$invoice->id} {/if}</a> </td>
                        <td>

                            {if isset($contacts[$invoice->userid])}
                                <a href="{$_url}invoices/view/{$invoice->id}/">
                                    {$invoice->account} <br>
                                    {$contacts[$invoice->userid]->company}
                                </a>
                            {/if}


                        </td>
                        <td>{formatCurrency($invoice->total,$invoice->currency_iso_code)}</td>
                        <td data-value="{strtotime($invoice->date)}">{date( $config['df'], strtotime($invoice->date))}</td>
                        <td data-value="{strtotime($invoice->duedate)}">{date( $config['df'], strtotime($invoice->duedate))}</td>
                        <td>

                            {if $invoice->status eq 'Unpaid'}
                                <span class="label label-danger">{ib_lan_get_line($invoice->status)}</span>
                            {elseif $invoice->status eq 'Paid'}
                                <span class="label label-success">{ib_lan_get_line($invoice->status)}</span>
                            {elseif $invoice->status eq 'Partially Paid'}
                                <span class="label label-info">{ib_lan_get_line($invoice->status)}</span>
                            {elseif $invoice->status eq 'Cancelled'}
                                <span class="label">{ib_lan_get_line($invoice->status)}</span>
                            {else}
                                {ib_lan_get_line($invoice->status)}
                            {/if}



                        </td>
                        <td>
                            {if $invoice->r eq '0'}
                                <span class="label label-default">{$_L['Onetime']}</span>
                            {else}
                                <span class="label label-default">{$_L['Recurring']}</span>
                            {/if}
                        </td>
                        <td class="text-right">

                            <a href="{$_url}invoices/view/{$invoice->id}/" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="top" title="{$_L['View']}"><i class="fal fa-file-alt"></i></a>



                            <a href="{$_url}invoices/edit/{$invoice->id}/" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="top" title="{$_L['Edit']}"><i class="fal fa-pencil"></i></a>



                        </td>
                    </tr>
                {/foreach}

                </tbody>



            </table>
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
        });
    </script>
{/block}
