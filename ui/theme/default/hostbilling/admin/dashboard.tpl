{extends file="$layouts_admin"}


{block name="head"}

    <style>

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }

        .h2, h2 {
            font-size: 1.25rem;
        }

        .text-info{
            color: #6772E5!important;
        }
        .text-success{
            color: #2CCE89!important;
        }

        .icon-shape {
            padding: 12px;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        .icon {
            width: 3rem;
            height: 3rem;
        }
        .text-white {
            color: #fff !important;
        }
        .text-white {
            color: #fff !important;
        }
        .shadow {
            box-shadow: 0 0 2rem 0 rgba(136, 152, 170, 0.15) !important;
        }
        .rounded-circle, .avatar.rounded-circle img {
            border-radius: 50% !important;
        }
        .bg-gradient-red {
            background: linear-gradient(
                    87deg
                    , #f5365c 0, #f56036 100%) !important;
        }

        .bg-gradient-success {
            background: linear-gradient(
                    87deg
                    , #2dce89 0, #2dcecc 100%) !important;
        }
        .bg-gradient-info {
            background: linear-gradient(
                    87deg
                    , #11cdef 0, #1171ef 100%) !important;
        }

        .bg-gradient-blue {
            background: linear-gradient(90deg, rgba(10,6,68,1) 0%, rgba(7,13,46,1) 0%, rgba(41,20,110,1) 44%, rgba(35,10,112,1) 50%, rgba(69,28,144,1) 100%, rgba(215,246,247,1) 100%); !important;

        }
        .bg-gradient-pink {
            background: linear-gradient(90deg, rgba(10,6,68,1) 0%, rgba(204,147,5,1) 0%, rgba(189,123,10,1) 100%, rgba(237,227,200,1) 100%, rgba(240,133,219,1) 100%, rgba(215,246,247,1) 100%);

        }

    </style>
{/block}


{block name="content"}


    <div class="row mt-3">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xl-6">
            <div class="row mb-3">
                <div class="col-lg-6 col-md-12 col-sm-12 col-xl-6 mb-3">
                    <div class="card" style="background: #FAE292;">
                        <div class="card-body text-center statistics-info">
                            <div class="icon icon-shape bg-gradient-pink text-white rounded-circle shadow">

                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-cart"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                            </div>
                            <h6 class="mt-4 mb-1">{$_L['Total value of Active Orders']}</h6>
                            <h2 class="mb-2 number-font">{formatCurrency($total_active_order_amount,$config['home_currency'])}</h2>

                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-12 col-sm-12 col-xl-6">
                    <div class="card" style="background: #E7FFBD;">
                        <div class="card-body text-center statistics-info">
                            <div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow">

                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-clock"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                            </div>
                            <h6 class="mt-4 mb-1">{$_L['Total Paid Invoice Amount']}</h6>
                            <h2 class="mb-2 number-font">{formatCurrency($total_paid_invoice_amount,$config['home_currency'])}</h2>

                        </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-12 col-sm-12 col-xl-6 mt-3">
                    <div class="card" style="background: #ffe1e2;">
                        <div class="card-body text-center statistics-info">
                            <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">

                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-up-circle"><circle cx="12" cy="12" r="10"></circle><polyline points="16 12 12 8 8 12"></polyline><line x1="12" y1="16" x2="12" y2="8"></line></svg>
                            </div>
                            <h6 class="mt-4 mb-1">{$_L['Total Orders']}</h6>
                            <h2 class="mb-2  number-font">{$total_orders}</h2>


                        </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-12 col-sm-12 col-xl-6 mt-3">
                    <div class="card" style="background: #DBD9FC;">
                        <div class="card-body text-center statistics-info">
                            <div class="icon icon-shape bg-gradient-blue text-white rounded-circle shadow">

                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            </div>
                            <h6 class="mt-4 mb-1">{$_L['Total Customers']}</h6>
                            <h2 class="mb-2  number-font">{$total_customers}</h2>
                        </div>
                    </div>
                </div>



            </div>
        </div>
        <div class="col-sm-12 col-md-12 col-lg-12 col-xl-6">
            <div class="card" style="background: #c2d5ff;">

                <div class="p-3">
                    <h3 class="mb-0">
                        {$_L['Orders']}
                    </h3>
                    <h5 class="mt-2">{$_L['Total last 7 days']} {formatCurrency($total_last_7_days,$config['home_currency'])}</h5>
                </div>

                <div id="orders_chart" class="mb-3"></div>

            </div>
        </div><!-- COL END -->
    </div>



    <div class="row mt-3">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Recent Tickets']}</h3>
                    <div class="hr-line-dashed"></div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>{$_L['Ticket']}</th>
                            <th>{$_L['Subject']}</th>
                            <th>{$_L['Customer']}</th>
                            <th>{$_L['Status']}</th>
                            <th>{$_L['Last Update']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $recent_tickets as $recent_ticket}
                            <tr>
                                <td>
                                    <a href="{$base_url}tickets/admin/view/{$recent_ticket->id}" class="font-weight-bold">
                                        {$recent_ticket->tid}
                                    </a>
                                </td>
                                <td>
                                    <a href="{$base_url}tickets/admin/view/{$recent_ticket->id}" class="font-weight-bold">
                                        {$recent_ticket->subject|escape}
                                    </a>
                                </td>
                                <td>
                                    <a href="{$base_url}contacts/view/{$recent_ticket->userid}/summary/">
                                        {$recent_ticket->account|escape}
                                    </a>
                                </td>
                                <td>
                                    {cloudonex_get_ticket_status_with_badge($recent_ticket->status|escape)}
                                </td>
                                <td>
                                    {date( $config['df'], strtotime($recent_ticket->updated_at))}
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Recent Orders']}</h3>
                    <div class="hr-line-dashed"></div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>Order</th>
                            <th>Domain</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $recent_orders as $recent_order}

                            <tr>
                                <td>
                                    <a href="{$base_url}hostbilling/order/{$recent_order->id}/" class="font-weight-bold">
                                        {$recent_order->tracking_id|escape}
                                    </a>
                                </td>
                                <td>
                                    {{$recent_order->domain|escape}}
                                </td>
                                <td>
                                    {date( $config['df'], strtotime($recent_order->created_at))}
                                </td>
                                <td>
                                    {formatCurrency($recent_order->total,$config['home_currency'])}
                                </td>
                                <td>
                                    {cloudonex_get_order_status_with_badge($recent_order->status)}
                                </td>
                            </tr>


                        {/foreach}

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <div class="row mt-3">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Recent Invoices']}</h3>
                    <div class="hr-line-dashed"></div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>{$_L['Invoice']}</th>
                            <th>{$_L['Customer']}</th>
                            <th>{$_L['Status']}</th>
                            <th>{$_L['Created']}</th>
                        </tr>
                        </thead>
                        <tbody>

                        {foreach $recent_invoices as $recent_invoice}

                            <tr>
                                <td>
                                    <a href="{$base_url}invoices/view/{$recent_invoice->id}/">
                                        {cloudonex_get_invoice_number($recent_invoice)}
                                    </a>
                                </td>
                                <td>
                                    <a href="{$base_url}contacts/view/{$recent_invoice->userid}/summary/">
                                        {$recent_invoice->account}
                                    </a>
                                </td>
                                <td>
                                    {cloudonex_get_invoice_status_with_badge($recent_invoice->status)}
                                </td>
                                <td>
                                    {date( $config['df'], strtotime($recent_invoice->date))}
                                </td>
                            </tr>

                        {/foreach}


                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Recent Clients']}</h3>
                    <div class="hr-line-dashed"></div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>
                                {$_L['Name']}
                            </th>
                            <th>
                                {$_L['Email']}
                            </th>
                            <th>
                                {$_L['Created']}
                            </th>
                        </tr>
                        </thead>
                        <tbody>

                        {foreach $recent_customers as $recent_customer}

                            <tr>
                                <td>
                                    <a href="{$base_url}contacts/view/{$recent_customer->id}">
                                        {$recent_customer->account}
                                    </a>
                                </td>
                                <td>
                                    {$recent_customer->email}
                                </td>


                                <td>
                                    {date( $config['df'], strtotime($recent_customer->created_at))}
                                </td>
                            </tr>

                        {/foreach}

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>




{/block}

{block name=script}

    <script>

        $(function () {
            let orders_chart_options = {
                chart: {
                    type: 'area',
                    height: 265,
                    sparkline: {
                        enabled: true
                    },
                },
                dataLabels: {
                    enabled: false
                },
                stroke: {
                    curve: 'smooth',
                    width: 2,
                },
                series: [{
                    name: 'sales',
                    data: [
                        {foreach $orders_for_chart as $key => $value}
                        {$value},
                        {/foreach}
                    ]
                }],
                xaxis: {
                    categories: [
                        {foreach $orders_for_chart as $key => $value }
                        '{$key}',
                        {/foreach}
                    ],
                    low: 0,
                    offsetX: 0,
                    offsetY: 0,
                    show: false,
                    labels: {
                        low: 0,
                        offsetX: 0,
                        show: false,
                    },
                    axisBorder: {
                        low: 0,
                        offsetX: 0,
                        show: false,
                    },
                    markers: {
                        strokeWidth: 3,
                        colors: "#ffffff",
                        strokeColors: [ '#7366ff' , '#f73164' ],
                        hover: {
                            size: 6,
                        }
                    },
                },
                yaxis: {
                    low: 0,
                    offsetX: 0,
                    offsetY: 0,
                    show: false,
                    labels: {
                        low: 0,
                        offsetX: 0,
                        show: false,
                    },
                    axisBorder: {
                        low: 0,
                        offsetX: 0,
                        show: false,
                    },
                },
                grid: {
                    show: false,
                    padding: {
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 35
                    }
                },
                colors: [ '#7366ff' , '#f73164' ],
                fill: {
                    type:"gradient",
                    gradient: {
                        type: "vertical",
                        shadeIntensity: 1,
                        inverseColors: !1,
                        opacityFrom: .40,
                        opacityTo: .05,
                        stops: [45, 100]
                    }
                },
                legend: {
                    show: false,
                },
                tooltip: {
                    x: {
                        format: 'MM'
                    },
                },
            };

            let chart = new ApexCharts(document.querySelector("#orders_chart"), orders_chart_options);
            chart.render();
        });

    </script>


{/block}
