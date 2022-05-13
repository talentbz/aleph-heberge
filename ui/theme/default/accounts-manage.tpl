{extends file="$layouts_admin"}


{block name="head"}


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
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Manage_Accounts']}</h2>
                    <div class="panel-toolbar">
                        <a href="{$base_url}accounts/add/" class="btn btn-primary">{$_L['New Account']}</a>
                    </div>
                </div>

                <div class="panel-container">
                    <div class="panel-content">



                        <table class="table table-striped table-bordered" id="clx_datatable">

                            <thead>
                            <tr>
                                <th>{$_L['Account']}</th>
                                <th>{$_L['Balance']}</th>
                                <th>{$_L['Manage']}</th>
                            </tr>
                            </thead>


                            <tbody>
                            {foreach $balances['banks'] as $bank}



                                <tr>
                                    <td>
                                        <h4>{$bank->account}</h4>
                                    </td>
                                    <td>
                                        {if (isset($balances['balances'][$bank->id]))}



                                            <strong>{$_L['Equity']} ({$_L['Initial balance']}): {formatCurrency($balances['total_equity_bank'][$bank->id],$balances['home_currency']->iso_code)}</strong> <br>
                                            <strong>{$_L['Total in']}: {formatCurrency($balances['total_in_bank'][$bank->id],$balances['home_currency']->iso_code)} </strong>  <br>
                                            <strong>{$_L['Total out']}: {formatCurrency($balances['total_out_bank'][$bank->id],$balances['home_currency']->iso_code)} </strong>  <br>

                                            <hr>

                                            <strong> {$_L['Balance']} ({$_L['in home currency']}) : {formatCurrency($balances['balances'][$bank->id],$balances['home_currency']->iso_code)}</strong>

                                        {/if}
                                    </td>
                                    <td>


                                        <div class="btn-group">
                                            <a href="{$_url}accounts/add-equity/{$bank->id}" class="btn btn-sm btn-primary"><i class="fal fa-plus"></i> {$_L['Record initial balance']}</a>

                                            <a href="{$_url}accounts/edit/{$bank->id}" class="btn btn-sm btn-warning"><i class="fal fa-pencil"></i> {$_L['Edit']}</a>

                                            {if {$bank->ib_url} neq ''}
                                                <a href="{$bank->ib_url}" target="_blank" class="btn btn-sm btn-primary"><i class="fal fa-globe"></i></a>
                                            {/if}

                                            <a href="{$_url}accounts/delete/{$bank->id}" id="did{$bank->id}" class="cdelete btn btn-danger btn-sm"><i class="fal fa-trash"></i> {$_L['Delete']}</a>
                                        </div>


                                    </td>
                                </tr>

                            {/foreach}
                            </tbody>




                        </table>

                        <div class="hr-line-dashed"></div>

                        <h3>{$_L['Net Worth']} - {formatCurrency($balances['net_worth'],$balances['home_currency']->iso_code)}</h3>

                    </div>
                </div>

            </div>



        </div>



    </div>


    <input type="hidden" id="_lan_are_you_sure" value="{$_L['are_you_sure']}">


{/block}


{block name="script"}

    <script>
        $(function () {
            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                var lan_msg = $("#_lan_are_you_sure").val();
                bootbox.confirm(lan_msg, function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "accounts/delete/" + id + '/';
                    }
                });
            });

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

        })
    </script>


{/block}
