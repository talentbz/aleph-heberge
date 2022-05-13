{extends file="$layouts_admin"}
{block name="head"}


    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }
    </style>
{/block}



{block name="content"}
    <div class="panel">
        <div class="panel-hdr">
            <h2>{$_L['Total Database Size']}: {$dbsize}  MB </h2>
            <div class="panel-toolbar">
                <a href="{$_url}util/dbbackup/" class="btn btn-primary"><i class="fal fa-download"></i> {$_L['Download Database Backup']}</a>
            </div>
        </div>
        <div class="panel-container">
            <div class="panel-content">
                <div class="table-responsive ">
                    <table class="table table-hover table-striped  sys_table">
                        <thead style="background: #f0f2ff">
                        <tr>
                            <th width="50%">{$_L['Table Name']}</th>
                            <th>{$_L['Rows']}</th>
                            <th>{$_L['Size']}</th>

                        </tr>
                        </thead>
                        <tbody>

                        {foreach $tables as $tbl}
                            <tr>
                                <td>{$tbl['name']}</td>
                                <td>{$tbl['rows']}</td>
                                <td>{$tbl['size']} Kb</td>

                            </tr>
                        {/foreach}

                        </tbody>
                    </table>
                </div>

            </div>



        </div>
    </div>
{/block}
