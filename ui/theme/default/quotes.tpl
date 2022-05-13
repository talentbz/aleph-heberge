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
    <div class="panel">
        <div class="panel-hdr">
            <h2>{$_L['Total']} : {$total_quote}</h2>
        </div>

        <div class="panel-container">
            <div class="panel-content">
                <div class="table-responsive">
                    <table class="table table-striped w-100" id="clx_datatable">
                        <thead style="background: #f0f2ff">
                        <tr>
                            <th>#</th>
                            <th>{$_L['Account']}</th>
                            <th width="30%">{$_L['Subject']}</th>
                            <th>{$_L['Amount']}</th>
                            <th>{$_L['Date Created']}</th>
                            <th>{$_L['Expiry Date']}</th>
                            <th>{$_L['Stage']}</th>

                            <th class="text-right">{$_L['Manage']}</th>
                        </tr>
                        </thead>
                        <tbody>

                        {foreach $d as $ds}
                            <tr>
                                <td data-value="{$ds['id']}" data-order="{$ds@iteration}"><a href="{$_url}quotes/view/{$ds['id']}/">{$ds['invoicenum']}{if $ds['cn'] neq ''} {$ds['cn']} {else} {$ds['id']} {/if}</a> </td>
                                <td><a href="{$_url}contacts/view/{$ds['userid']}/">{$ds['account']}</a> </td>
                                <td><a href="{$_url}quotes/view/{$ds['id']}/"><strong>{$ds['subject']}</strong></a> </td>
                                <td class="amount">{$ds['total']}</td>
                                <td>{date( $config['df'], strtotime($ds['datecreated']))}</td>
                                <td>{date( $config['df'], strtotime($ds['validuntil']))}</td>
                                <td>
                                    {if $ds['stage'] eq 'Dead'}
                                        <span class="badge badge-danger">{$_L['Dead']}</span>
                                    {elseif $ds['stage'] eq 'Lost'}
                                        <span class="badge badge-warning">{$_L['Lost']}</span>
                                    {elseif $ds['stage'] eq 'Accepted'}
                                        <span class="badge badge-success">{$_L['Accepted']}</span>
                                    {elseif $ds['stage'] eq 'Draft'}
                                        <span class="badge badge-primary">{$_L['Draft']}</span>
                                    {elseif $ds['stage'] eq 'Delivered'}
                                        <span class="label label-info">{$_L['Delivered']}</span>
                                    {else}
                                        <span class="label label-info">{$ds['stage']}</span>
                                    {/if}

                                </td>

                                <td class="text-right">
                                    <div class="btn-group">
                                        <a href="{$_url}quotes/view/{$ds['id']}/" class="btn btn-primary btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['View']}" data-placement="top"><i class="fal fa-file"></i> </a>
                                        <a href="{$_url}quotes/edit/{$ds['id']}/" class="btn btn-warning btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['Edit']}" data-placement="top"><i class="fal fa-pencil"></i> </a>
                                        <a href="#" id="iid{$ds['id']}" class="btn btn-danger btn-icon waves-effect waves-themed has-tooltip cdelete" data-title="{$_L['Delete']}" data-placement="top"><i class="fal fa-trash"></i> </a>




                                    </div>

                                </td>
                            </tr>
                        {/foreach}

                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="8">
                                <ul class="pagination">
                                </ul>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>



                {$paginator['contents']}
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
            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                bootbox.confirm("Are You Sure?", function(result) {
                    if(result){
                        window.location.href = base_url + "delete/quote/" + id;
                    }
                });
            });

            $('.has-tooltip').tooltip();

        });
    </script>
{/block}
