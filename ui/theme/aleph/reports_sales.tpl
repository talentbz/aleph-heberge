{extends file="$layouts_admin"}

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

            <div class="panel" id="calendar_wrap">
                <div class="panel-hdr">
                    <h2>{$_L['Calendar']} [ {$_L['Invoice']} ] </h2>
                </div>

                {*<div class="panel-container">
                    <div class="panel-content">
                        <div id="calendar"></div>
                    </div>


                    *}{*<div id="sale_chart" style="min-height: 548px;"></div>*}{*



                </div>*}

            </div>

        </div>

        <div class="col-md-12">

            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Sales']} </h2>
                </div>

                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table  table-striped dataTable" id="sales_items">
                                <thead style="background: #f0f2ff">
                                <tr>
                                    <th class="h6">{$_L['Item']}</th>
                                    <th class="h6">{$_L['Qty']}</th>
                                    <th class="h6">{$_L['Amount']}</th>
                                    <th class="h6">{$_L['Total']}</th>
                                    <th class="h6">{$_L['Date']}</th>
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $invoice_items as $item}
                                    <tr>
                                        <td class="h6">{$item['description']}</td>
                                        <td class="h6">{$item['qty']}</td>
                                        <td class="h6">{$item['amount']}</td>
                                        <td class="h6">{$item['total']}</td>
                                        <td class="h6 text-info">{$item['duedate']}</td>
                                    </tr>
                                {/foreach}

                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>{$_L['Item']}</th>
                                    <th>{$_L['Qty']}</th>
                                    <th>{$_L['Amount']}</th>
                                    <th>{$_L['Total']}</th>
                                    <th>{$_L['Date']}</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>

                    </div>




                </div>

            </div>

        </div>




    </div>
{/block}

{block name=script}




    <script>
        {literal}

        var $calendar_wrap = $("#calendar_wrap");

        function view_event(id) {


        }

        var ib_calendar_options = {
            customButtons: {},
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay,viewFullCalendar'
            },
            loading: function(isLoading, view) {
                if (isLoading) {
                    $calendar_wrap.block({ message: block_msg });
                } else {
                    $calendar_wrap.unblock();
                    $('[data-toggle="tooltip"]').tooltip();
                }
            },
            editable: true,
            eventLimit: 3,
            lang: ib_lang,
            isRTL: ib_rtl,
            eventSources: [{
                url: base_url + 'reports/sales_invoice_calendar',
                type: 'GET',
                error: function() {
                    bootbox.alert("Unable to load data.");
                }
            } ],
            eventRender: function(event, element) {
                element.attr('title', event._tooltip);
                element.attr('onclick', event.onclick);
                element.attr('data-toggle', 'tooltip');
                if (!event.url) {
                    element.click(function() {
                        view_event(event.eventid);
                    });
                }
            },
            eventStartEditable: false,

            firstDay: 0,
        };




        $('#calendar').fullCalendar(ib_calendar_options);

        {/literal}
    </script>
{/block}