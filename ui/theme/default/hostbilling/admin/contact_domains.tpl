{extends file="hostbilling/admin/contact_base.tpl"}


{block name="inner_content"}


    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>{$_L['Tracking ID']}</th>
            <th>{$_L['Domain']}</th>
            <th>{$_L['Next Due Date']}</th>
            <th>{$_L['Amount']}</th>
            <th>{$_L['Status']}</th>
        </tr>
        </thead>
        <tbody>

        {foreach $domains as $recent_domain}

            <tr>
                <td>
                    <a href="{$base_url}hostbilling/domain-order/{$recent_domain->id}">
                        {$recent_domain->tracking_id}
                    </a>
                </td>
                <td>
                    {$recent_domain->domain}
                </td>

                <td>

                    {date( $config['df'], strtotime($recent_domain->created_at))}
                </td>
                <td>
                    {$recent_domain->amount}
                </td>
                <td>
                    {cloudonex_get_invoice_status_with_badge($recent_domain->status)}
                </td>

            </tr>

        {/foreach}


        </tbody>
    </table>


{/block}
