{extends file="$layouts_admin"}
{block name="head"}

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />
    <style>
        {if empty($config['admin_dark_theme'])}
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;

        }
        .h2, h2 {
            font-size: 1.25rem;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: inherit;
            font-weight: 600;
            line-height: 1.5;
            margin-bottom: .5rem;
            color: #32325d;
        }


        .text-info{
            color: #6772E5!important;
        }
        .text-success{
            color: #2CCE89!important;}

        .text-danger{
            color: #F6365B!important;
        }
        .text-warning{
            color: #FB6340!important;
        }
        .text-primary{
            color: #10CDEF!important;
        }
        {/if}
    </style>
{/block}
{block name="content"}

    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Payments']}</h2>

                </div>

                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">

                            <table class="table table-striped" id="clx_datatable">
                                <thead style="background: #f0f2ff">
                                <tr>
                                    <th>{$_L['Invoice']}#</th>
                                    <th>{$_L['Date']}</th>
                                    <th>{$_L['Account']}</th>


                                    <th class="text-right">{$_L['Amount']}</th>

                                    <th>{$_L['Transaction ID']}</th>

                                    <th class="text-right">{$_L['Cr']}</th>
                                    <th>{$_L['Manage']}</th>
                                </tr>

                                </thead>

                                {foreach $d as $ds}
                                    <tr class="{if $ds['cr'] eq '0.00'}warning {else}info{/if}">
                                        <td>{$ds['iid']}</td>
                                        <td>{date( $config['df'], strtotime($ds['date']))}</td>
                                        <td class="h6">{$ds['account']}</td>
                                        <td class="text-right amount text-info">{$ds['amount']}</td>
                                        <td>{$ds['description']}</td>
                                        <td class="text-right amount">{$ds['cr']}</td>
                                        <td><a href="{$_url}transactions/manage/{$ds['id']}">{$_L['Manage']}</a></td>
                                    </tr>
                                {/foreach}


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
