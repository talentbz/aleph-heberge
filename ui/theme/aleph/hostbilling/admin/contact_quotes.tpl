{extends file="hostbilling/admin/contact_base.tpl"}


{block name="inner_content"}


    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>{$_L['Quote']}</th>
            <th>{$_L['Customer']}</th>
            <th>{$_L['Status']}</th>
            <th>{$_L['Created']}</th>
        </tr>
        </thead>
        <tbody>

        {foreach $quotes as $recent_quote}

            <tr>
                <td>
                    <a href="{$base_url}invoices/view/7/{$recent_quote->id}">
                        {cloudonex_get_invoice_number($recent_quote)}
                    </a>
                </td>
                <td>
                    <a href="{$base_url}contacts/view/{$recent_quote->userid}/summary/">
                        {$recent_quote->account}
                    </a>
                </td>
                <td>
                    {cloudonex_get_invoice_status_with_badge($recent_quote->status)}
                </td>
                <td>
                    {date( $config['df'], strtotime($recent_quote->created_at))}
                </td>
            </tr>

        {/foreach}


        </tbody>
    </table>


{/block}
