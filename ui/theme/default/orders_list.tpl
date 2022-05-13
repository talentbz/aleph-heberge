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



        <div class="col-md-12">



            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Order']}</h2>
                    <div class="panel-toolbar">
                        <a href="{$_url}orders/add/" class="btn btn-primary"><i class="fal fa-plus"></i> {$_L['Add New Order']}</a>
                    </div>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <form class="form-horizontal" method="post" action="{$_url}customers/list/">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <div class="table-responsive">
                                        <table id="clx_datatable" class="table-striped w-100 table sys_table footable">
                                            <thead style="background: #f0f2ff">
                                            <tr>
                                                <th>#</th>
                                                <th>{$_L['Order']} #</th>
                                                <th>{$_L['Date']}</th>
                                                <th>{$_L['Customer']}</th>
                                                <th>{$_L['Total']}</th>
                                                <th>{$_L['Status']}</th>
                                                <th class="text-right" data-sort-ignore="true">{$_L['Manage']}</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            {foreach $d as $ds}

                                                <tr>

                                                    <td><a href="{$_url}orders/view/{$ds['id']}/">{$ds['id']}</a> </td>
                                                    <td>

                                                        <a  href="{$_url}orders/view/{$ds['id']}/"><strong>{$ds['ordernum']}</strong></a>

                                                    </td>

                                                    <td>
                                                        {date( $config['df'], strtotime({$ds['date_added']}))}
                                                    </td>
                                                    <td><a href="{$_url}contacts/view/{$ds['cid']}/"><strong>{$ds['cname']}</strong></a> </td>

                                                    <td class="amount">
                                                        {formatCurrency($ds['amount'],$ds['currency_iso_code'])}


                                                    </td>
                                                    <td>
                                                        {if $ds['status'] eq 'Active'}
                                                            <span class="badge badge-success">{ib_lan_get_line($_L[$ds['status']])}</span>
                                                        {else}
                                                            <span class="badge badge-danger">{ib_lan_get_line($_L[$ds['status']])}</span>
                                                        {/if}
                                                    </td>
                                                    <td class="text-right">
                                                        <div class="btn-group">
                                                            <a href="{$_url}orders/view/{$ds['id']}/" class="btn btn-primary btn-sm"><i class="fal fa-search"></i> </a>

                                                            <a href="#" class="btn btn-danger btn-sm cdelete" id="uid{$ds['id']}"><i class="fal fa-trash-alt"></i> </a>
                                                        </div>

                                                    </td>
                                                </tr>

                                            {/foreach}

                                            </tbody>



                                        </table>
                                    </div>

                                </div>

                            </div>
                        </form>
                    </div>





                </div>
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

            $(".cdelete").click(function (e) {
                e.preventDefault();
                var oid = this.id;
                bootbox.confirm('{$_L['are_you_sure']}', function(result) {
                    if(result){
                        window.location.href = base_url + "delete/order/" + oid + '/';
                    }
                });
            });

        })
    </script>
{/block}
