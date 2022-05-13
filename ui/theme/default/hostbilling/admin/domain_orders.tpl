{extends file="$layouts_admin"}

{block name="content"}

    <div class="subheader">
        <h1 class="subheader-title">
            <i class='subheader-icon fal fa-window'></i> {$_L['Domain Orders']}

        </h1>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel">


                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">

                            <table id="clx_datatable" class="table table-striped w-100 sys_table">
                                <thead style="background: #f0f2ff">
                                <tr>
                                    <th>{$_L['Order']}</th>
                                    <th>{$_L['Customer']}</th>
                                    <th>{$_L['Invoice']}</th>
                                    <th>{$_L['Date']}</th>
                                    <th>
                                        Domain
                                    </th>
                                    <th>{$_L['Status']}</th>

                                </tr>
                                </thead>
                                <tbody>

                                {foreach  $domain_orders as $order}
                                    <tr>
                                        <td data-value="{$order->id}" data-order="{$order@iteration}">
                                            <a href="{$base_url}hostbilling/domain-order/{$order->id}/">{$order->tracking_id}</a>
                                        </td>
                                        <td>
                                            {if isset($contacts[$order->contact_id])}
                                                <a href="{$base_url}contacts/view/{$order->contact_id}/summary/">{$contacts[$order->contact_id]->account}</a>
                                            {/if}
                                        </td>
                                        <td>
                                            {if isset($invoices[$order->invoice_id])}
                                                <a href="{$base_url}invoices/view/{$order->invoice_id}/">
                                                    {$invoices[$order->invoice_id]->invoicenum}{$invoices[$order->invoice_id]->cn}
                                                </a>
                                            {/if}
                                        </td>
                                        <td data-value="{strtotime($order->created_at)}">
                                            {date( $config['df'], strtotime($order->created_at))}
                                        </td>
                                        <td>
                                            {$order->domain}
                                        </td>
                                        <td>
                                            {if $order->status === 'Approved'}
                                                <span class="badge badge-success">Approved</span>
                                            {elseif $order->status === 'Fraud'}
                                                <span class="badge badge-danger">Fraud</span>
                                            {elseif $order->status === 'Pending'}
                                                <span class="badge badge-primary">Pending</span>
                                            {elseif $order->status === 'Cancelled'}
                                                <span class="badge badge-secondary">Cancelled</span>
                                            {elseif $order->status === 'Expired'}
                                                <span class="badge badge-secondary">Expired</span>
                                            {else}
                                                <span class="badge badge-secondary">{$order->status}</span>
                                            {/if}


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

{block name=script}

    <script>
        $(function () {
            $('#clx_datatable').dataTable(
                {
                    responsive: true,
                    lengthChange: false
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
