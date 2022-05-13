{extends file="hostbilling/admin/contact_base.tpl"}


{block name="inner_content"}


    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>{$_L['Order']}</th>
            <th>{$_L['Date']}</th>
            <th>{$_L['Total']}</th>
            <th>{$_L['Status']}</th>


        </tr>
        </thead>
        <tbody>

        {foreach $orders as $recent_order}

            <tr>
                <td>
                    <a href="{$base_url}hostbilling/order/{$recent_order->id}">
                        {$recent_order->tracking_id}
                    </a>
                </td>
                <td>
                    {date( $config['df'], strtotime($recent_order->created_at))}
                </td>
                <td>
                    {$recent_order->total}
                </td>
                <td>
                    {cloudonex_get_invoice_status_with_badge($recent_order->status)}
                </td>
            </tr>

        {/foreach}


        </tbody>
    </table>


{/block}
