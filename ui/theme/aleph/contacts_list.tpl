{extends file="$layouts_admin"}

{block name="head"}

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css" />
    <style>

        {if !empty($config['admin_dark_theme'])}

        {else}
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
                    {if $type == 'supplier'}
                        <h2>{$_L['List Suppliers']}</h2>
                    {else}
                        <h2>{$_L['List Customers']}</h2>
                    {/if}

                    <div class="panel-toolbar">
                        <div class="btn-group">

                            {if $type == 'supplier'}
                                <a href="{$_url}contacts/add/supplier" class="btn btn-sm btn-success"> {$_L['Add Supplier']}</a>
                                {else}
                                <a href="{$_url}contacts/add/" class="btn btn-sm btn-success"> {$_L['Add Customer']}</a>
                            {/if}
                            <a href="{$_url}contacts/import_csv/" class="btn btn-sm btn-warning"> {$_L['Import']}</a>
                        </div>



                    </div>
                </div>


                <div class="panel-container show">


                    <div class="panel-content">
                        <div class="table-responsive" id="ib_data_panel">


                            <table class="table table-striped w-100"  id="clx_datatable">
                                <thead
                                        {if empty($config['admin_dark_theme'])}
                                            style="background: #f0f2ff"

                                        {/if}
                                >
                                <tr class="heading">
                                    <th>{$_L['Image']}</th>
                                    <th>{$_L['Name']}</th>

                                    {if $show_company_column}

                                        <th>{$_L['Company Name']}</th>

                                    {/if}

                                    {if $show_group_column}

                                        <th>{$_L['Group']}</th>

                                    {/if}


                                    <th>{$_L['Email']}</th>
                                    <th>{$_L['Phone']}</th>
                                    <th class="text-right" style="width: 80px;">{$_L['Manage']}</th>
                                </tr>


                                </thead>


                                <tbody>
                                {foreach $contacts as $contact}
                                    <tr>
{*                                        <td>*}
{*                                            {$contact->id}*}
{*                                            {$contact@iteration}*}
{*                                        </td>*}
                                        <td data-order="{$contact@iteration}">
                                           <a href="{$_url}contacts/view/{$contact->id}">{sp_get_contact_image($contact)}</a>
                                        </td>
                                        <td>
                                            <a class="h6" href="{$_url}contacts/view/{$contact->id}">
                                                <strong>
                                                    {$contact->account}
                                                </strong>

                                                {if $contact->code}
                                                    <br>
                                                    {$contact->code}
                                                {/if}

                                            </a>
                                        </td>

                                        {if $show_company_column}

                                            <td class="text-info h6">
                                                {$contact->company}
                                            </td>

                                        {/if}

                                        {if $show_group_column}

                                            <td class="text-info h6">
                                                {$contact->gname}
                                            </td>

                                        {/if}

                                        <td class="text-info h6">
                                            {$contact->email}
                                        </td>
                                        <td class="h6">
                                            {$contact->phone}
                                        </td>
                                        <td>
                                            <div class="btn-group float-right">
                                                <a href="{$_url}contacts/view/{$contact->id}" class="btn btn-primary btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['View']}" data-placement="top"><i class="fal fa-user-alt"></i> </a>

                                                {if $has_edit_permission}
                                                    <a href="{$_url}contacts/view/{$contact->id}/edit/" class="btn btn-info btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['Edit']}" data-placement="top"><i class="fal fa-pencil"></i> </a>
                                                {/if}

                                                {if $has_delete_permission}
                                                    <a href="#" onclick="confirmThenGoToUrl(event,'contacts/delete/{$contact->id}')"  class="btn btn-danger btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['Delete']}" data-placement="top"><i class="fal fa-trash-alt"></i> </a>
                                                {/if}

                                            </div>
                                        </td>
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

{block name="script"}

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
        });
    </script>
{/block}
