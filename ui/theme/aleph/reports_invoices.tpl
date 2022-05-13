{extends file="$layouts_admin"}

{block name="head"}

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />


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

            <div class="card border" id="t_options">

                <div class="card-header">
                    <ul class="nav nav-tabs card-header-tabs">
                        <li class="nav-item active"><a class="nav-link active" href="{$_url}reports/invoices"><i class="fal fa-th"></i> {$_L['Invoices']}</a></li>
                        <li class="nav-item"><a class="nav-link" href="{$_url}reports/invoices_summary"><i class="fal fa-chart-bar"></i> {$_L['Summary']}</a></li>
                    </ul>
                </div>




                <div class="card-body">




                    <div class="tab-content">
                        <div id="details" class="tab-pane fade show active ib-tab-box">

                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <form>
                                        <div class="form-row">
                                            <div class="col-md-4"><input style="min-width: 250px;" type="text" name="reportrange" class="form-control" id="reportrange"></div>
                                            <div class="col-md-4">
                                                <select id="cid" name="cid" class="form-control">
                                                    <option value="">{$_L['All']}</option>
                                                    {foreach $c as $cs}
                                                        <option value="{$cs['id']}"
                                                                {if $p_cid eq ($cs['id'])}selected="selected" {/if}>{$cs['account']} {if $cs['email'] neq ''}- {$cs['email']}{/if}</option>
                                                    {/foreach}

                                                </select>
                                            </div>
                                            <div class="col-md-4">
                                                <button class="btn btn-primary" id="ib_filter" type="submit">{$_L['Filter']}</button>
                                            </div>
                                        </div>


                                        {*<button class="btn btn-primary" type="submit">{$_L['PDF']}</button>*}
                                    </form>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="table-responsive" id="ib_data_panel">


                                        <table class="table table-striped table-hover display" id="ib_dt">
                                            <thead>
                                            <tr class="heading">
                                                <th>{$_L['Invoice']}</th>
                                                <th>{$_L['Customer']}</th>
                                                <th class="text-right">{$_L['Total']}</th>
                                                <th class="text-left text-success">{$_L['Paid']}</th>
                                                <th class="text-left text-danger">{$_L['Due']}</th>


                                                <th>{$_L['Date']}</th>

                                                <th>{$_L['Manage']}</th>
                                            </tr>
                                            </thead>



                                            <tfoot>
                                            <tr>
                                                <th colspan="2" style="text-align:right">{$_L['Total']}:</th>
                                                <th></th>
                                                <th></th>
                                                <th></th>

                                                <th colspan="2"></th>
                                            </tr>
                                            </tfoot>

                                        </table>
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


    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>

    <script>


        $(function () {

            var start = moment().subtract(29, 'days');
            var end = moment();

            var $ib_data_panel = $("#ib_data_panel");

            $ib_data_panel.block({ message:block_msg });

            function cb(start, end) {
                $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            }

            var $reportrange = $("#reportrange");

            $reportrange.daterangepicker({
                startDate: start,
                endDate: end,
                ranges: {
                    '{__('Today')}': [moment(), moment()],
                    '{__('Yesterday')}': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    '{__('Last 7 Days')}': [moment().subtract(6, 'days'), moment()],
                    '{__('Last 30 Days')}': [moment().subtract(29, 'days'), moment()],
                    '{__('This Month')}': [moment().startOf('month'), moment().endOf('month')],
                    '{__('Last Month')}': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                locale: {
                    format: 'YYYY/MM/DD'
                }
            }, cb);

            cb(start, end);

            var $cid = $('#cid');



            $cid.select2({
            });

            var ib_dt = $('#ib_dt').DataTable( {

                "language": {
                    "emptyTable": "{$_L['No items to display']}",
                    "info":      "{$_L['Showing _START_ to _END_ of _TOTAL_ entries']}",
                    "infoEmpty":      "{$_L['Showing 0 to 0 of 0 entries']}",
                    buttons: {
                        pageLength: '{$_L['Show all']}'
                    },
                    searchPlaceholder: "{__('Search')}"
                },
                "serverSide": true,
                dom:
                /*	--- Layout Structure
                    --- Options
                    l	-	length changing input control
                    f	-	filtering input
                    t	-	The table!
                    i	-	Table information summary
                    p	-	pagination control
                    r	-	processing display element
                    B	-	buttons
                    R	-	ColReorder
                    S	-	Select

                    --- Markup
                    < and >				- div element
                    <"class" and >		- div with a class
                    <"#id" and >		- div with an ID
                    <"#id.class" and >	- div with an ID and a class

                    --- Further reading
                    https://datatables.net/reference/option/dom
                    --------------------------------------
                 */
                    "<'row mb-3'<'col-sm-12 col-md-6 d-flex align-items-center justify-content-start'l><'col-sm-12 col-md-6 d-flex align-items-center justify-content-end'B>>" +
                    "<'row'<'col-sm-12'tr>>" +
                    "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
                buttons: [
                    /*{
                        extend:    'colvis',
                        text:      'Column Visibility',
                        titleAttr: 'Col visibility',
                        className: 'mr-sm-3'
                    },*/
                    {
                        extend: 'pdfHtml5',
                        text: 'PDF',
                        titleAttr: 'Generate PDF',
                        className: 'btn-danger btn-sm mr-1'
                    },
                    {
                        extend: 'excelHtml5',
                        text: 'Excel',
                        titleAttr: 'Generate Excel',
                        className: 'btn-success btn-sm mr-1'
                    },
                    {
                        extend: 'csvHtml5',
                        text: 'CSV',
                        titleAttr: 'Generate CSV',
                        className: 'btn-primary btn-sm mr-1'
                    },
                    {
                        extend: 'copyHtml5',
                        text: 'Copy',
                        titleAttr: 'Copy to clipboard',
                        className: 'btn-dark btn-sm mr-1'
                    },
                    {
                        extend: 'print',
                        text: 'Print',
                        titleAttr: 'Print Table',
                        className: 'btn-secondary btn-sm'
                    }
                ],
                "ajax": {
                    "url": base_url + "reports/json_invoices/",
                    "type": "POST",
                    "data": function ( d ) {


                        d.reportrange = $reportrange.val();
                        d.cid = $cid.val();


                    }
                },
                "pageLength": 10,
                "responsive": true,
                lengthMenu: [
                    [ 10, 25, 50, -1 ],
                    [ '10 {$_L['rows']}', '25 {$_L['rows']}', '50 {$_L['rows']}', '{$_L['Show all']}' ]
                ],
                "columnDefs": [
                    { "orderable": false, "targets": 6 },
                    { "orderable": false, "targets": 4 },
                ],
                "order": [[ 0, 'desc' ]],
                "scrollX": false,
                "initComplete": function () {
                    $ib_data_panel.unblock();
                },
                "footerCallback": function ( row, data, start, end, display ) {
                    var api = this.api(), data;

                    // Remove the formatting to get integer data for summation
                    var intVal = function ( i ) {
                        return typeof i === 'string' ?
                            i.replace(/[\$,]/g, '')*1 :
                            typeof i === 'number' ?
                                i : 0;
                    };

                    // Total over all pages
                    total = api
                        .column( 2 )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );

                    // Total over this page
                    pageTotal = api
                        .column( 2, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );

                    pageTotal_2 = api
                        .column( 3, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );

                    pageTotal_3 = api
                        .column( 4, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );

                    // Update footer
                    $( api.column( 2 ).footer() ).html(
                        // '$'+pageTotal +' ( $'+ total +' total)'
                        pageTotal
                    );
                    $( api.column( 3 ).footer() ).html(
                        // '$'+pageTotal +' ( $'+ total +' total)'
                        pageTotal_2
                    );

                    $( api.column( 4 ).footer() ).html(
                        // '$'+pageTotal +' ( $'+ total +' total)'
                        pageTotal_3
                    );
                }
            } );

            var $ib_filter = $("#ib_filter");



            $ib_filter.on('click', function(e) {
                e.preventDefault();

                $ib_data_panel.block({ message:block_msg });

                ib_dt.ajax.reload(
                    function () {
                        $ib_data_panel.unblock();
                    }
                );


            });

        });

    </script>
{/block}
