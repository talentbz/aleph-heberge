<a href="{$_url}quotes/new/1/{$cid}/" class="btn btn-primary waves-effect waves-light">{$_L['Create New Quote']}</a>

<hr>
<div class="table-responsive">
    <table class="table table-striped sys_table">
        <thead style="background: #f0f2ff">
        <tr>
            <th>#</th>
            <th width="30%">{$_L['Subject']}</th>
            <th>{$_L['Amount']}</th>
            <th>{$_L['Date Created']}</th>
            <th>{$_L['Expiry Date']}</th>
            <th>{$_L['Stage']}</th>

            <th class="text-right">{$_L['Manage']}</th>
        </tr>
        </thead>
        <tbody>

        {foreach $i as $ds}
            <tr>
                <td><a href="{$_url}quotes/view/{$ds['id']}/">{$ds['id']}</a> </td>
                <td><a class="text-info h6" href="{$_url}quotes/view/{$ds['id']}/">{$ds['subject']}</a> </td>
                <td class="amount">{$ds['total']}</td>
                <td>{date( $config['df'], strtotime($ds['datecreated']))}</td>
                <td>{date( $config['df'], strtotime($ds['validuntil']))}</td>
                <td>
                    {if $ds['stage'] eq 'Dead'}
                        <span class="label label-default">{$_L['Dead']}</span>
                    {elseif $ds['stage'] eq 'Lost'}
                        <span class="label label-danger">{$_L['Lost']}</span>
                    {elseif $ds['stage'] eq 'Accepted'}
                        <span class="label label-success">{$_L['Accepted']}</span>
                    {elseif $ds['stage'] eq 'Draft'}
                        <span class="label label-info">{$_L['Draft']}</span>
                    {elseif $ds['stage'] eq 'Delivered'}
                        <span class="label label-info">{$_L['Delivered']}</span>
                    {else}
                        <span class="label label-info">{$ds['stage']}</span>
                    {/if}

                </td>

                <td class="text-right">
                    <div class="btn-group">
                        <a href="{$_url}quotes/view/{$ds['id']}/" class="btn btn-primary btn-sm">{$_L['View']}</a>
                        <a href="{$_url}quotes/edit/{$ds['id']}/" class="btn btn-info btn-sm"> {$_L['Edit']}</a>

                    </div>


                </td>
            </tr>
        {/foreach}

        </tbody>
    </table>
</div>


