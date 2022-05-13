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
    </style>
{/block}


{block name="content"}

    <div class="row">

        <div class="col-md-12">
            <div class="panel">

                <div class="panel-container">
                    <div class="panel-content">


                        <div class="row" id="d_ajax_summary">

                            <div class="col-md-4">



                                <table class="table table-striped">

                                    <tbody>
                                    <tr><td class="h5">{$_L['Paid']} </td> <td><span class="amount text-success h5">{formatCurrency($total_paid_amount,$config['home_currency'])}</span> </td></tr>
                                    <tr><td class="h5">{$_L['Unpaid']} </td> <td><span class="amount text-danger h5">{formatCurrency($total_unpaid_amount,$config['home_currency'])}</span> </td></tr>
                                    <tr><td class="h5">{$_L['Partially Paid']} </td> <td><span class="amount text-info h5">{formatCurrency($total_partially_paid_amount,$config['home_currency'])}</span> </td></tr>
                                    <tr><td class="h5">{$_L['Cancelled']} </td> <td><span class="amount text-warning h5">{formatCurrency($total_cancelled_amount,$config['home_currency'])}</span> </td></tr>
                                    <tr><td>&nbsp; </td> <td></td></tr>


                                    </tbody>
                                </table>

{*                                <h4>{$_L['Total Unpaid Amount']}: <span class="amount text-danger">{$total_unpaid_amount}</span></h4>*}

                                {if $config['add_fund']}
                                    <h4>{$_L['Balance']} <span class="amount text-success">{formatCurrency($user->balance,$config['home_currency'])}</span></h4>
                                    <h4>{$_L['Due']} <span class="amount text-warning">{formatCurrency($due_amount,$config['home_currency'])}</span></h4>
                                {/if}

                            </div>


                            <div class="col-md-8">


                                <div id="invoice_summary"></div>

                            </div>


                        </div>

                    </div>
                </div>


            </div>

        </div>


    </div>

    <div class="panel">
        <div class="panel-hdr">


            <h2>{$_L['Total']} : {$total_invoice}</h2>


        </div>
        <div class="panel-container">
            <div class="table-responsive">

                <table class="table table-striped sys_table">
                    <thead>
                    <tr>
                        <th>#</th>
                        {*<th>{$_L['Account']}</th>*}
                        <th>{$_L['Amount']}</th>
                        <th>{$_L['Invoice Date']}</th>
                        <th>{$_L['Due Date']}</th>
                        <th>
                            {$_L['Status']}
                        </th>
                        {*<th>{$_L['Type']}</th>*}
                        <th class="text-right" width="100px">{$_L['Manage']}</th>
                    </tr>
                    </thead>
                    <tbody>

                    {foreach $d as $ds}
                        <tr>
                            <td><a target="_blank"
                                   href="{$_url}client/iview/{$ds['id']}/token_{$ds['vtoken']}/">{$ds['invoicenum']}{if $ds['cn'] neq ''} {$ds['cn']} {else} {$ds['id']} {/if}</a>
                            </td>
                            {*<td>{$ds['account']} </td>*}
                            <td class="amount h6"
                                data-a-sign="{if $ds['currency_symbol'] eq ''} {$config['currency_code']} {else} {$ds['currency_symbol']}{/if} ">{$ds['total']}</td>
                            <td>{date( $config['df'], strtotime($ds['date']))}</td>
                            <td>{date( $config['df'], strtotime($ds['duedate']))}</td>
                            <td>

                                {if $ds['status'] eq 'Unpaid'}
                                    <span class="badge badge-danger">{ib_lan_get_line($ds['status'])}</span>
                                {elseif $ds['status'] eq 'Paid'}
                                    <span class="badge badge-success">{ib_lan_get_line($ds['status'])}</span>
                                {elseif $ds['status'] eq 'Partially Paid'}
                                    <span class="badge badge-info">{ib_lan_get_line($ds['status'])}</span>
                                {elseif $ds['status'] eq 'Cancelled'}
                                    <span class="label">{ib_lan_get_line($ds['status'])}</span>
                                {else}
                                    {ib_lan_get_line($ds['status'])}
                                {/if}


                            </td>
                            {*<td>*}
                            {*{if $ds['r'] eq '0'}*}
                            {*<span class="label label-success"><i class="fal fa-dot-circle-o"></i> {$_L['Onetime']}</span>*}
                            {*{else}*}
                            {*<span class="label label-success"><i class="fal fa-repeat"></i> {$_L['Recurring']}</span>*}
                            {*{/if}*}
                            {*</td>*}
                            <td class="text-center">
                                <div class="btn-group">
                                    <a target="_blank" href="{$_url}client/iview/{$ds['id']}/token_{$ds['vtoken']}/"
                                       class="btn btn-primary btn-xs"><i class="fal fa-check"></i> </a>
                                    <a href="{$_url}client/ipdf/{$ds['id']}/token_{$ds['vtoken']}/dl/"
                                       class="btn btn-warning btn-xs "><i class="fal fa-file"></i> </a>
                                    <a target="_blank" href="{$_url}iview/print/{$ds['id']}/token_{$ds['vtoken']}/"
                                       class="btn btn-danger btn-xs"><i class="fal fa-print"></i> </a>

                                </div>
                            </td>

                        </tr>
                        {foreachelse}
                        <tr>
                            <td colspan="8">
                                {$_L['No Data Available']}
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
            var options = {
                series: [{$total_paid_amount}, {$total_unpaid_amount}, {$total_partially_paid_amount}, {$total_cancelled_amount}],
                chart: {
                    height: 390,
                    type: 'radialBar',
                },
                plotOptions: {
                    radialBar: {
                        offsetY: 0,
                        startAngle: 0,
                        endAngle: 270,
                        hollow: {
                            margin: 5,
                            size: '30%',
                            background: 'transparent',
                            image: undefined,
                        },
                        dataLabels: {
                            name: {
                                show: false,
                            },
                            value: {
                                show: false,
                            }
                        }
                    }
                },
                colors: ['#2CCE89', '#F6365B', '#6772E5', '#FB6340'],
                labels: ['{$_L['Paid']}', '{$_L['Unpaid']}', '{$_L['Partially Paid']}', '{$_L['Cancelled']}'],
                legend: {
                    show: true,
                    floating: true,
                    fontSize: '14px',
                    position: 'left',
                    offsetX: 100,
                    offsetY: 15,
                    labels: {
                        useSeriesColors: true,
                    },
                    markers: {
                        size: 0
                    },
                    formatter: function(seriesName, opts) {
                        return seriesName + ":  " + opts.w.globals.series[opts.seriesIndex]
                    },
                    itemMargin: {
                        vertical: 3
                    }
                },
                responsive: [{
                    breakpoint: 480,
                    options: {
                        legend: {
                            show: false
                        }
                    }
                }]
            };

            var chart = new ApexCharts(document.querySelector("#invoice_summary"), options);
            chart.render();
        });
    </script>
{/block}
