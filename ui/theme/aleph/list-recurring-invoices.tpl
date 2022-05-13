{extends file="$layouts_admin"}

{block name="content"}
    <div class="panel">
        <div class="panel-hdr">
            <h2>{$_L['List Invoices']} </h2>
            <div class="panel-toolbar">
                <a href="{$_url}invoices/add/recurring/" class="btn btn-primary"><i class="fal fa-plus"></i> {$_L['Add Recurring Invoice']}</a>
            </div>
        </div>

        <div class="panel-container">
            <div class="panel-content">

                <table class="table table-bordered table-hover" id="clx_datatable">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>{$_L['Account']}</th>
                        <th>{$_L['Amount']}</th>
                        <th>{$_L['Invoice']} {$_L['Date']}</th>
                        <th>{$_L['Due']} {$_L['Date']}</th>
                        <th>{$_L['Next Invoice']}</th>
                        <th>{$_L['Status']}</th>
                        <th class="text-right">{$_L['Manage']}</th>
                    </tr>
                    </thead>
                    <tbody>

                    {foreach $d as $ds}
                        <tr>
                            <td><a href="{$_url}invoices/view/{$ds['id']}">{$ds['id']}</a></td>
                            <td><a href="{$_url}contacts/view/{$ds['userid']}">{$ds['account']}</a> </td>
                            <td>{$ds['total']}</td>
                            <td>{date( $config['df'], strtotime($ds['date']))}</td>
                            <td>{date( $config['df'], strtotime($ds['duedate']))}</td>
                            <td>{date( $config['df'], strtotime($ds['nd']))}</td>
                            <td> {if $ds['status'] eq 'Unpaid'}
                                    <span class="label label-danger">{$_L['Unpaid']}</span>
                                {elseif $ds['status'] eq 'Paid'}
                                    <span class="label label-success">{$_L['Paid']}</span>
                                {elseif $ds['status'] eq 'Cancelled'}
                                    <span class="label label-default">{$_L['Cancelled']}</span>
                                {else}
                                    <span class="label label-info">{$ds['status']}</span>
                                {/if}</td>
                            <td class="text-right">
                                <a href="{$_url}invoices/view/{$ds['id']}" class="btn btn-primary btn-xs"><i class="fal fa-check"></i> {$_L['View']}</a>
                                <a href="{$_url}invoices/edit/{$ds['id']}" class="btn btn-info btn-xs"><i class="fal fa-pencil"></i> {$_L['Edit']}</a>
                                <a href="#" class="btn btn-warning btn-xs cstop" id="sid{$ds['id']}"><i class="fal fa-stop"></i> {$_L['Stop Recurring']}</a>
                                <a href="#" class="btn btn-danger btn-xs cdelete" id="iid{$ds['id']}"><i class="fal fa-trash"></i> {$_L['Delete']}</a>
                            </td>
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

            $('.has-tooltip').tooltip();
            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm("Are you sure?", function(result) {
                if(result){
                    window.location.href = base_url + "delete/invoice/" + id;
                }
            });
        });

        $(".cstop").click(function (e) {
            e.preventDefault();
            var id = this.id;
            bootbox.confirm("Are you sure? This will prevent future invoice generation from this invoice.", function(result) {
                if(result){
                    window.location.href = base_url + "invoices/stop_recurring/" + id;
                }
            });
        });


        });
    </script>
{/block}
