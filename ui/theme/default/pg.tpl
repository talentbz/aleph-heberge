{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Payment Gateways']}</h2>
                    <div class="panel-toolbar">
                        <a href="{$_url}reorder/pg/" class="btn btn-primary mb-md"><i class="fal fa-arrows"></i> {$_L['Reorder Payment Gateways']}</a>

                    </div>

                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <table class="table table-bordered table-hover sys_table">
                            <thead>
                            <tr>

                                <th>{$_L['Logo']}</th>
                                <th>{$_L['Gateway Name']}</th>
                                <th>{$_L['Setting Name']}</th>
                                <th>{$_L['Value']}</th>
                                <th>{$_L['Status']}</th>
                                <th class="text-right">{$_L['Manage']}</th>
                            </tr>
                            </thead>
                            <tbody>

                            {foreach $d as $ds}
                                <tr>

                                    <td>
                                        <a href="{$_url}settings/pg-conf/{$ds['id']}/">
                                            {if $ds['logo'] neq ''}
                                                <img src="{$app_url}{$ds['logo']}">
                                            {else}
                                                <img src="{$app_url}ui/lib/img/pg/{$ds['processor']}.png">
                                            {/if}

                                        </a>
                                    </td>
                                    <td><a href="{$_url}settings/pg-conf/{$ds['id']}/">{$ds['name']}</a> </td>
                                    <td>{$ds['settings']}</td>
                                    <td>{$ds['value']}</td>

                                    <td>
                                        {if $ds['status'] eq 'Inactive'}
                                            <h4><span class="badge badge-danger">{$_L['Inactive']}</span></h4>
                                        {else}
                                            <h4><span class="badge badge-success">{$_L['Active']}</span></h4>
                                        {/if}

                                    </td>

                                    <td class="text-right">

                                        <a href="{$_url}settings/pg-conf/{$ds['id']}/" class="btn btn-success"> {$_L['Edit']}</a>

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
{/block}
