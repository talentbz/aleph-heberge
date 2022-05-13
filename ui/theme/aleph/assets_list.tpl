{extends file="$layouts_admin"}
{block name="head"}

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />
    <style>
        {if empty($config['admin_dark_theme'])}
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #F7F9FC;
        }
        {/if}

    </style>
{/block}

{block name="content"}


    <div class="row">
        <div class="col-lg-3">
            <div class="card border m-lg-0 mb-3">
                <div class="card-body">
                    <h2 class="card-title">{$_L['Assets']}</h2>
                    <div class="hr-line-dashed"></div>
                    <a href="{$_url}assets/asset" class="btn btn-primary btn-block add_asset">{$_L['Add an asset']}</a>


                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><a href="{$_url}assets/list"><i class="fal fa-folder"></i> {$_L['All categories']}</a></li>
                    {foreach $categories as $category}
                        <li class="list-group-item"><a href="{$_url}assets/list/{$category->id}"><i class="fal fa-folder"></i> {$category->name}</a></li>
                    {/foreach}
                </ul>
                <div class="card-body mb-3">
                    {if $selected_category}
                        <a href="javascript:;" id="btnNewCategory" class="btn btn-primary">{$_L['New category']}</a>
                        <a href="javascript:;" onclick="confirmThenGoToUrl(event,'delete/asset-category/{$category->id}');" class="btn btn-danger">{$_L['Delete']}</a>
                    {else}
                        <a href="javascript:;" id="btnNewCategory" class="btn btn-primary btn-block">{$_L['New category']}</a>
                    {/if}
                </div>
            </div>




        </div>
        <div class="col-lg-9">

            <div class="panel mb-3">
                <div class="panel-container">
                    <div class="panel-content">

                        <h3>{$_L['Total']}: <span class="amount">{$assets_value}</span></h3>

                        <div class="hr-line-dashed"></div>

                        <div class="table-responsive">
                            <table class="table table-striped" id="clx_datatable">
                                <thead style="background: #f0f2ff">
                                <tr>
                                    <th>{$_L['Name']}</th>
                                    <th>{$_L['Date purchased']}</th>
                                    <th>{$_L['Supported until']}</th>
                                    <th>{$_L['Price']}</th>
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $assets as $asset}
                                    <tr>
                                        <td  data-value="{$asset->id}"><a href="{$_url}assets/asset/{$asset->id}"><strong>{$asset->name}</strong></a> </td>
                                        <td>{date( $config['df'], strtotime($asset->date_purchased))}</td>
                                        <td>{date( $config['df'], strtotime($asset->supported_until))}</td>
                                        <td class="amount">{$asset->price}</td>

                                    </tr>
                                {/foreach}

                                </tbody>



                            </table>
                        </div>



                    </div>
                </div>
            </div>

        </div>
    </div>



{/block}

{block name=script}
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>


    <script>


        $(function() {

            $('#clx_datatable').dataTable(
                {
                    responsive: true,
                    lengthChange: false,
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
                        "<'row mb-3'<'col-sm-12 col-md-6 d-flex align-items-center justify-content-start'f><'col-sm-12 col-md-6 d-flex align-items-center justify-content-end'lB>>" +
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

            $('.has-tooltip').tooltip();

            $('.amount').autoNumeric('init', {

                aSign: '{$config['currency_code']} ',
                dGroup: {$config['thousand_separator_placement']},
                aPad: {$config['currency_decimal_digits']},
                pSign: '{$config['currency_symbol_position']}',
                aDec: '{$config['dec_point']}',
                aSep: '{$config['thousands_sep']}',
                vMax: '9999999999999999.00',
                vMin: '-9999999999999999.00'

            });

            $('#btnNewCategory').click(function (e) {
                e.preventDefault();


                bootbox.prompt({
                    title: "{$_L['Category Name']}",
                    buttons: {
                        'cancel': {
                            label: '{$_L['Cancel']}'
                        },
                        'confirm': {
                            label: '{$_L['OK']}'
                        }
                    },
                    callback: function(result) {
                        if (result === null) {

                        } else {
                            $.post( "{$_url}assets/category-post", { category: result } ).done(function() {
                                location.reload();
                            });
                        }
                    }
                });


            });


        });



    </script>


{/block}
