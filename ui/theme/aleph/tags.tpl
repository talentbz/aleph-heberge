{extends file="$layouts_admin"}

{block name="content"}
    <div class="panel">
        <div class="panel-hdr">
            <h2>{$_L['Manage Tags']} </h2>
        </div>
        <div class="panel-container">
            <div class="panel-content">

                    <table class="table table-bordered table-hover sys_table">
                        <thead>
                        <tr>

                            <th>{$_L['Tag']}</th>
                            <th>{$_L['Type']}</th>
                            <th>{$_L['Delete']}</th>

                        </tr>
                        </thead>
                        <tbody>

                        {if count($d) > 0}

                            {foreach $d as $ds}
                                <tr>

                                    <td>{$ds['text']}</td>
                                    <td>{$ds['type']}</td>
                                    <td>
                                        <a href="#" class="btn btn-danger btn-xs cdelete" id="iid{$ds['id']}"><i class="fal fa-trash"></i> {$_L['Delete']}</a>
                                    </td>
                                </tr>
                            {/foreach}

                        {else}

                            <tr>
                                <td colspan="3">
                                    {$_L['No Data Available']}
                                </td>
                            </tr>

                        {/if}



                        </tbody>
                    </table>



            </div>



        </div>
    </div>
{/block}
