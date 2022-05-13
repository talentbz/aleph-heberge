{extends file="$layouts_admin"}

{block name="content"}
    <div class="panel">
        <div class="panel-hdr">
            <h2>{$_L['SMS Templates']}</h2>
        </div>

        <div class="panel-container">
            <div class="panel-content">

                <table class="table table-condensed table-hover table-bordered" id="clx_datatable">
                    <thead>
                    <tr>


                        <th>{$_L['Name']}</th>
                        <th width="70%">{$_L['Message']}</th>
                        <th>{$_L['Manage']}</th>
                    </tr>
                    </thead>
                    <tbody>

                    {foreach $templates as $template}
                        <tr>

                            <td>{$template->tpl}</td>
                            <td>{$template->sms}</td>
                            <td> <a href="{$_url}sms/init/edit/{$template->id}" class="btn btn-sm btn-dark">{$_L['Edit']}</a> </td>
                        </tr>
                    {/foreach}

                    </tbody>
                </table>

            </div>
        </div>

    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            $('#clx_datatable').dataTable(
                {
                    responsive: true,
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
        });
    </script>
{/block}
