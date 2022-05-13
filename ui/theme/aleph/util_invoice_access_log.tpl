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
                    {*<a href="#" class="btn btn-primary btn-sm pull-right" id="clear_logs"><i class="fal fa-list"></i> {$_L['Clear Old Data']}</a>*}



                </div>
                <div class="panel-container" id="application_ajaxrender">
                    <div class="panel-content">
                        <div class="table-responsive">

                            <table class="table table-bordered sys_table" id="clx_datatable">
                                <thead style="background: #f0f2ff">
                                <tr>

                                    <th>{$_L['Date']}</th>
                                    <th>{$_L['Customer']}</th>
                                    <th>{$_L['Invoice']}</th>
                                    <th>{$_L['IP']}</th>
                                    <th>{$_L['Country']}</th>
                                    <th>{$_L['City']}</th>
                                    <th>{$_L['Browser']}</th>

                                </tr>
                                </thead>
                                <tbody>
                                {foreach $d as $ds}
                                    <tr>

                                        <td>{date( $config['df']|cat:' H:i:s', strtotime($ds['viewed_at']))}</td>
                                        <td><a href="{$_url}contacts/view/{$ds['cid']}">{$ds['customer']}</a> </td>
                                        <td><a href="{$_url}invoices/view/{$ds['iid']}">{$ds['iid']}</a> </td>
                                        <td>{$ds['ip']}</td>
                                        <td>{$ds['country']}</td>
                                        <td>{$ds['city']}</td>
                                        <td>{$ds['browser']}</td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>

                        </div>

                    </div>




                    {$paginator['contents']}

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
