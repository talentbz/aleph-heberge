{extends file="$layouts_admin"}

{block name="content"}

    {block name="head"}

    {/block}


    <div class="row">



        <div class="col-md-12">



            <div class="panel">

                <div class="panel-hdr">
                    <h2>{if $action eq 'products'} {$_L['Products']} {else} {$_L['Services']} {/if}</h2>

                    <div class="panel-toolbar">

                        <div class="btn-group">
                            <a href="{$_url}ps/p-new" class="btn btn-primary"><i class="fal fa-plus"></i> {$_L['Add Product']}</a>
                            <a href="{$_url}ps/s-new" class="btn btn-success"><i class="fal fa-plus"></i> {$_L['Add Service']}</a>
                        </div>

                    </div>
                </div>

                <div class="panel-container show">

                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table table-striped w-100" id="clx_datatable">
                                <thead style="background:#f0f2ff" >
                                <tr>
                                    <th class="bold">{$_L['Item Number']}</th>
                                    <th class="bold">{$_L['Image']}</th>
                                    <th class="bold">{$_L['Name']}</th>
                                    <th class="bold">{$_L['Sales Price']}</th>
                                    <th class="bold">{$_L['Cost Price']}</th>
                                    <th class="text-center bold">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>


                                {foreach $items as $item}
                                    <tr>
                                        <td>
                                            {$item->item_number}
                                        </td>
                                        <td>
                                            {if $item->image}
                                                <img alt="{$item->name}" class="img-fluid" src="{APP_URL}/storage/items/thumb{$item->image}">
                                                {else}
                                                <img alt="{$item->name}" class="img-fluid" src="{APP_URL}/ui/lib/img/item_placeholder.png">
                                            {/if}
                                        </td>
                                        <td>
                                            {$item->name}
                                        </td>
                                        <td>
                                            {formatCurrency($item->sales_price,$config['home_currency'],$format_currency_override)}
                                        </td>
                                        <td>

                                            {formatCurrency($item->cost_price,$config['home_currency'],$format_currency_override)}

                                        </td>
                                        <td>

                                            <div class="btn-group float-right">

                                                {if $can_edit}
                                                    <a href="javascript:;" id="edit_item_{$item->id}" class="btn edit_item btn-primary btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['Edit']}" data-placement="top"><i class="fal fa-pencil"></i> </a>
                                                {/if}

                                                {if $action eq 'products'}
                                                    <a target="_blank" href="{$_url}inventory/barcode/{$item->id}" class="btn btn-dark btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['Barcode']}" data-placement="top"><i class="fal fa-barcode"></i> </a>
                                                {/if}

                                                {if $can_delete}

                                                    <a href="javascript:;" onclick="confirmThenGoToUrl(event,'delete/ps/{$item->id}')"  class="btn btn-danger btn-icon waves-effect waves-themed has-tooltip" data-title="{$_L['Delete']}" data-placement="top"><i class="fal fa-trash-alt"></i> </a>

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

    <script>

        $(function () {
            var $modal = $('#cloudonex_body');
            $('#clx_datatable').dataTable(
                {
                    responsive: true,
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

            $modal.on('click', '.edit_item', function(e){
                e.preventDefault();
                var vid = this.id;
                var id = vid.replace("edit_item_", "");
                id = id.replace("t", "");


                $.fancybox.open({
                    src  :  base_url + 'ps/edit-form/' + id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('.amount').autoNumeric('init', {

                                aSign: '{$config['currency_code']}',
                                dGroup: {$config['thousand_separator_placement']},
                                aPad: {$config['currency_decimal_digits']},
                                pSign: '{$config['currency_symbol_position']}',
                                aDec: '{$config['dec_point']}',
                                aSep: '{$config['thousands_sep']}',
                                vMax: '9999999999999999.00',
                                vMin: '-9999999999999999.00',

                                {if isset($config['decimal_places_products_and_services'])}
                                mDec: {$config['decimal_places_products_and_services']},
                                {/if}

                            });

                            $('#description').redactor(
                                {
                                    minHeight: 200 // pixels
                                }
                            );

                            //  new Clipboard('.ib_btn_copy');

                            var $file_link = $("#file_link");
                            var ib_submit = $("#update");

                            var ib_file = new Dropzone("#upload_container",
                                {
                                    url: base_url + "ps/upload/",
                                    maxFiles: 1
                                }
                            );


                            ib_file.on("sending", function() {

                                ib_submit.prop('disabled', true);

                            });

                            ib_file.on("success", function(file,response) {

                                ib_submit.prop('disabled', false);

                                upload_resp = response;

                                if(upload_resp.success == 'Yes'){

                                    toastr.success(upload_resp.msg);
                                    // $file_link.val(upload_resp.file);
                                    $('#file_link_image').val(upload_resp.file);


                                }
                                else{
                                    toastr.error(upload_resp.msg);
                                }


                            });

                        },
                        touch: false,
                        autoFocus: false,
                    },
                });
            });

            $modal.on('click', '#update', function(event){
                event.preventDefault();
                $.post(base_url + 'ps/edit-post/', $('#edit_form').serialize(), function(data){
                    if ($.isNumeric(data)) {

                        location.reload();
                    }
                    else {

                        toastr.error(data);

                    }

                });

            });
        });

    </script>
{/block}
