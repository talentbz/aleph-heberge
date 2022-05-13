{extends file="$layouts_client"}

{block name="head"}


    <style>
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
            color: #2CCE89!important;
        }
    </style>
{/block}

{block name="content"}

    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Total']} : {count($d)} </h2>

                </div>
                <div class="panel-container">
                    <div class="table-responsive">

                        <table class="table table-striped sys_table">
                            <th class="h6">{$_L['Date']}</th>
                            <th class="h6">{$_L['Account']}</th>


                            <th class="h6">{$_L['Amount']}</th>

                            <th>{$_L['Description']}</th>

                            {foreach $d as $ds}
                                <tr class="{if $ds['cr'] eq '0.00'}warning {else}info{/if}">
                                    <td class="h6">{date( $config['df'], strtotime($ds['date']))}</td>
                                    <td class="h6">{$ds['account']}</td>
                                    {*<td>{$ds['type']}</td>*}
                                    {* From v 2.4 Sadia Sharmin *}



                                    <td class="h6">{$ds['amount']}</td>
                                    <td class="h6 text-info">{$ds['description']}</td>

                                    {*<td class="text-right"><span {if $ds['bal'] < 0}class="text-red"{/if}>{$config['currency_code']} {number_format($ds['bal'],2,$config['dec_point'],$config['thousands_sep'])}</span></td>*}
                                    {*<td><a href="{$_url}transactions/manage/{$ds['id']}">{$_L['Manage']}</a></td>*}
                                </tr>
                            {/foreach}



                        </table>

                    </div>
                </div>

            </div>

        </div>

        <!-- Widget-1 end-->

        <!-- Widget-2 end-->
    </div>

{/block}