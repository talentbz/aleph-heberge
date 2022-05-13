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
    <div class="panel panel-default">

        <div class="panel-body">

            <div class="table-responsive">

                <table class="table table-striped sys_table">
                    <thead style="background: #f0f2ff">
                    <tr>

                        <th class="h6">{$_L['Date']}</th>

                        {*<th>{$_L['Title']}</th>*}

                        <th class="h6 text-info">{$_L['Order']} #</th>


                        <th class="h6">{$_L['Amount']}</th>
                        <th class="h6">{$_L['Status']}</th>

                    </tr>
                    </thead>
                    <tbody>

                    {foreach $d as $ds}

                        <tr>

                            <td class="h6"> {date( $config['df'], strtotime({$ds['date_added']}))} </td>

                            {*<td>*}
                                {*<a href="{$_url}client/order_view/{$ds['id']}/{$ds['ordernum']}/">{$ds['stitle']}</a>*}


                            {*</td>*}

                            <td class="h6">

                                <a  class="text-info" href="{$_url}client/order_view/{$ds['id']}/{$ds['ordernum']}/">{$ds['ordernum']}</a>

                            </td>




                            <td class="amount h6" data-a-sign="{$config['currency_code']} ">{$ds['amount']}</td>

                            <td>
                                {if $ds['status'] eq 'Active'}
                                    <span class="badge badge-success">{ib_lan_get_line($_L[$ds['status']])}</span>
                                {else}
                                    <span class="badge badge-danger">{ib_lan_get_line($_L[$ds['status']])}</span>
                                {/if}
                            </td>
                        </tr>

                    {/foreach}

                    </tbody>



                </table>

            </div>




        </div>
    </div>
{/block}