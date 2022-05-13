{extends file="hostbilling/admin/contact_base.tpl"}


{block name="inner_content"}

    <a href="#" class="btn btn-primary mb-3">{$_L['Create New Ticket']}</a>

    {if count($tickets)}

        <table class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>{$_L['Ticket']}</th>
                <th>{$_L['Subject']}</th>
                <th>{$_L['Customer']}</th>
                <th>{$_L['Status']}</th>
                <th>{$_L['Last Update']}</th>
            </tr>
            </thead>
            <tbody>
            {foreach $tickets as $recent_ticket}
                <tr>
                    <td>
                        <a href="{$base_url}tickets/admin/view/{$recent_ticket->id}" class="font-weight-bold">
                            {$recent_ticket->tid}
                        </a>
                    </td>
                    <td>
                        <a href="{$base_url}tickets/admin/view/{$recent_ticket->id}" class="font-weight-bold">
                            {$recent_ticket->subject}
                        </a>
                    </td>
                    <td>
                        <a href="{$base_url}contacts/view/{$recent_ticket->userid}/summary/">
                            {$recent_ticket->account}
                        </a>
                    </td>
                    <td>
                        {cloudonex_get_ticket_status_with_badge($recent_ticket->status)}
                    </td>
                    <td>
                        {date( $config['df'], strtotime($recent_ticket->updated_at))}
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>

    {/if}


{/block}
