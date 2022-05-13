{extends file="$layouts_admin"}

{block name="content"}



<div class="card">
    <div class="card-body">
        <div class="row">
            <div class="col-6">
                <h3>{$_L['Servers']}</h3>
            </div>
            <div class="col-6 text-right">
                <a class="btn btn-primary" href="{$base_url}hostbilling/choose-server-type/">{$_L['New Server']}</a>
            </div>
        </div>

        <div class="hr-line-dashed"></div>
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>{$_L['Type']}</th>
                <th>{$_L['Name']}</th>
                <th>{$_L['Manage']}</th>
            </tr>
            </thead>
            <tbody>
            {foreach $servers as $server}
                <tr>
                    <td>
                        <a href="{$base_url}hostbilling/server/{$server->id}/">{$server->type}</a>
                    </td>
                    <td>
                        <a href="{$base_url}hostbilling/server/{$server->id}/">{$server->name}</a>
                    </td>
                    <td>
                        {if $server->type === 'cpanel'}
                            <a href="{$base_url}hostbilling/server-list-accounts/{$server->id}/" class="btn btn-primary">{$_L['List Accounts']}</a>
                            {else}
                            {if !empty($buttons_for_server_type[$server->type])}
                                {foreach $buttons_for_server_type[$server->type] as $button}
                                    <a

                                            {if !empty($button['external_link'])}
                                                href="{$button['external_link']}"
                                                {elseif !empty($button['link'])}
                                                href="{$base_url}{$button['link']}/{$server->id}/"
                                            {/if}

                                            {if !empty($button['target'])}
                                                target="{$button['target']}"
                                            {/if}


                                             class="btn btn-primary">{$button['name']}</a>
                                {/foreach}
                            {/if}
                        {/if}

                        <a href="{$base_url}hostbilling/server/{$server->id}/" class="btn btn-primary">{$_L['Edit']}</a>
                        <a href="javascript:;" class="btn btn-danger" onclick="confirmThenGoToUrl(event,'hostbilling/delete-server/{$server->id}')">
                            {$_L['Delete']}
                        </a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>

{/block}

{block name=script}

    <script>

    </script>


{/block}
