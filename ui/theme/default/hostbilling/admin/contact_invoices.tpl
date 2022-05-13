{extends file="hostbilling/admin/contact_base.tpl"}


{block name="inner_content"}


    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>{$_L['Invoice']}</th>
            <th>{$_L['Customer']}</th>
            <th>{$_L['Status']}</th>
            <th>{$_L['Created']}</th>
        </tr>
        </thead>
        <tbody>

        {foreach $invoices as $recent_invoice}

            <tr>
                <td>
                    <a href="{$base_url}invoices/view/7/{$recent_invoice->id}">
                        {cloudonex_get_invoice_number($recent_invoice)}
                    </a>
                </td>
                <td>
                    <a href="{$base_url}contacts/view/{$recent_invoice->userid}/summary/">
                        {$recent_invoice->account}
                    </a>
                </td>
                <td>
                    {cloudonex_get_invoice_status_with_badge($recent_invoice->status)}
                </td>
                <td>
                    {date( $config['df'], strtotime($recent_invoice->created_at))}
                </td>
            </tr>

        {/foreach}


        </tbody>
    </table>


{/block}
