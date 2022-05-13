{extends file="$layouts_admin"}

{block name="content"}


    <div class="row">
        <div class="col-md-12">

            <div class="card border" id="t_options">

                <div class="card-header">
                    <ul class="nav nav-tabs card-header-tabs">
                        <li class="nav-item"><a class="nav-link" href="{$_url}reports/invoices"><i class="fal fa-th"></i> {$_L['Invoices']}</a></li>
                        <li class="nav-item"><a class="nav-link active" href="{$_url}reports/invoices_summary"><i class="fal fa-chart-bar"></i> {$_L['Summary']}</a></li>
                    </ul>
                </div>




                <div class="card-body">




                    <div class="tab-content">
                        <div id="details" class="tab-pane fade show active ib-tab-box">


                            <h3>{$_L['Invoices']} - {$_L['Paid']} [ {$_L['Last 12 Months']} ]</h3>


                            <div class="row">
                                <div class="col-md-9">
                                    <div class="container_sales_chart" id="container_sales_chart" style="min-height: 450px;"></div>
                                </div>
                                <div class="col-md-3">

                                    <div class="p-3 bg-info-200 rounded overflow-hidden position-relative text-white mb-g">                           <div>
                                            <h5 class="display-4 d-block l-h-n m-0 fw-500">
                                                {$total_invoice}
                                                <small class="m-0 l-h-n">{$_L['Total Invoice']}</small>
                                            </h5>
                                            <i class="fal fa-list position-absolute pos-right pos-bottom opacity-15 mb-n1 mr-n4" style="font-size: 6rem;"></i>


                                        </div>
                                    </div>




                                    {if $all_data}

                                        <div class="p-3 bg-info-200 rounded overflow-hidden position-relative text-white mb-g">                           <div>
                                                <h5 class="display-4 d-block l-h-n m-0 fw-500">
                                                    {$total_invoice_items}
                                                    <small class="m-0 l-h-n">{$_L['Sales Count']}</small>
                                                </h5>
                                                <i class="fal fa-list position-absolute pos-right pos-bottom opacity-15 mb-n1 mr-n4" style="font-size: 6rem;"></i>


                                            </div>
                                        </div>


                                    {/if}

                                    <div class="p-3 bg-info-200 rounded overflow-hidden position-relative text-white mb-g">                           <div>
                                            <h5 class="display-4 d-block l-h-n m-0 fw-500">
                                                {$total_invoice_amount}
                                                <small class="m-0 l-h-n">{$_L['Total Amount']}</small>
                                            </h5>
                                            <i class="fal fa-list position-absolute pos-right pos-bottom opacity-15 mb-n1 mr-n4" style="font-size: 6rem;"></i>


                                        </div>
                                    </div>

                                </div>
                            </div>


                        </div>



                    </div>





                </div>

            </div>



        </div>
    </div>




{/block}


{block name="script"}



    <script>

        jQuery(document).ready(function() {

            var options = {
                series: [{
                    name: '{$_L['Amount']}',
                    data: [
                        {foreach $m['data'] as $d}
                        {$d},
                        {/foreach}
                    ],
                }],
                chart: {
                    height: 400,
                    type: 'bar',
                },
                plotOptions: {
                    bar: {
                        dataLabels: {
                            position: 'top', // top, center, bottom
                        },
                    }
                },
                dataLabels: {
                    offsetY: -20,
                    style: {
                        fontSize: '12px',
                        colors: ["#304758"]
                    }
                },

                xaxis: {
                    categories: [
                        {foreach $m['display'] as $m}
                        '{$m}',
                        {/foreach}
                    ],
                    position: 'top',
                    axisBorder: {
                        show: false
                    },
                    axisTicks: {
                        show: false
                    },
                    crosshairs: {
                        fill: {
                            type: 'gradient',
                            gradient: {
                                colorFrom: '#D8E3F0',
                                colorTo: '#BED1E6',
                                stops: [0, 100],
                                opacityFrom: 0.4,
                                opacityTo: 0.5,
                            }
                        }
                    },
                    tooltip: {
                        enabled: true,
                    }
                },
                yaxis: {
                    axisBorder: {
                        show: false
                    },
                    axisTicks: {
                        show: false,
                    },
                    labels: {
                        show: false,

                    }

                },
                title: {
                    text: '{$_L['Invoice']}',
                    floating: true,
                    offsetY: 330,
                    align: 'center',
                    style: {
                        color: '#444'
                    }
                }
            };

            var chart = new ApexCharts(document.querySelector("#container_sales_chart"), options);
            chart.render();


        });



    </script>
{/block}
