{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Records']} {$paginator['found']}
                        . {$_L['Page']} {$paginator['page']} {$_L['of']} {$paginator['lastpage']}. </h2>

                </div>
                <div class="panel-container" id="application_ajaxrender">
                    <div class="panel-content">
                        <table class="table table-bordered sys_table" id="sys_logs">
                            <thead>
                            <tr>
                                <th>{$_L['ID']}</th>
                                <th>{$_L['Date']}</th>
                                <th width="60%">{$_L['Message']}</th>

                            </tr>
                            </thead>
                            <tbody>
                            {foreach $d as $ds}
                                <tr>
                                    <td>{$ds['id']}</td>
                                    <td>{date( $config['df'], strtotime($ds['date']))}</td>
                                    <td>{nl2br($ds['logs'])}</td>

                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                        {$paginator['contents']}
                    </div>






                </div>


            </div>
        </div>
    </div>
{/block}
