{extends file="$layouts_admin"}

{block name="head"}


    <style>
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }
    </style>
{/block}

{block name="content"}
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Records']} {$paginator['found']}
                        . {$_L['Page']} {$paginator['page']} {$_L['of']} {$paginator['lastpage']}. </h2>
                    <div class="panel-toolbar">
                        <a href="javascript:;" class="btn btn-primary pull-right" onclick="confirmThenGoToUrl(event,'util/clear_logs')" id="clear_logs"><i
                                    class="fal fa-list"></i> {$_L['Clear Old Data']}</a>
                    </div>



                </div>
                <div class="panel-container" id="application_ajaxrender">
                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table  table-striped sys_table datat" id="clx_datatable">
                                <thead style="background: #f0f2ff">
                                <tr>
                                    <th>{$_L['ID']}</th>
                                    <th>{$_L['Date']}</th>
                                    <th>{$_L['Type']}</th>
                                    <th>{$_L['Description']}</th>
                                    <th>{$_L['UID']}</th>
                                    <th>{$_L['IP']}</th>

                                </tr>
                                </thead>
                                <tbody>

                                {foreach $d as $ds}
                                    <tr>
                                        <td>{$ds['id']}</td>
                                        <td>{date( $config['df'], strtotime($ds['date']))}</td>
                                        <td>{$ds['type']}</td>
                                        <td>{$ds['description']}</td>
                                        <td>{$ds['userid']}</td>
                                        <td>{$ds['ip']}</td>
                                    </tr>
                                {/foreach}

                                </tbody>
                            </table>
                        </div>


                    </div>






                </div>


            </div>
        </div>
    </div>
{/block}

{block name="script"}


    <script>
        $(function() {

            $('#clx_datatable').dataTable(
                {
                    responsive: true,
                    lengthChange: false,
                    "language": {
                        "emptyTable": "{$_L['No items to display']}",
                        "info":      "{$_L['Showing _START_ to _END_ of _TOTAL_ entries']}",
                        "infoEmpty":      "{$_L['Showing 0 to 0 of 0 entries']}",
                        buttons: {
                            pageLength: '{$_L['Show all']}'
                        },
                        searchPlaceholder: "{__('Search')}"
                    },

                }
            );

            $('.has-tooltip').tooltip();
        });
    </script>
{/block}
