{extends file="$layouts_client"}

{block name="content"}

    <h2 class="mb-3">
        {$_L['Catalog']}
    </h2>
    <div class="row">
        <div class="col-md-9">
            <section>

                <div>
                    <div class="ib-ecom--catalog">
                        <div class="row">

                            {foreach $items as $item}

                                <div class="col-md-4">
                                    <div class="panel" >
                                        <div class="panel-container">
                                            <div class="panel-content">
                                                <div class="ib-ecom--catalog--item">
                                                    <div class="ib-ecom--catalog- mb-3" >

                                                        <a id="item_{$item['id']}" class="view-item" href="{$_url}client/view-item/{$item['id']}">

                                                            {if $item['image'] neq ''}
                                                                <img src="{$app_url}storage/items/thumb_400{$item['image']}" class="card-img-top img-fluid rounded-0">
                                                            {else}
                                                                <img src="{$app_url}ui/lib/img/item_placeholder.png">
                                                            {/if}


                                                        </a>

                                                    </div>
                                                    <div class="ib-ecom--catalog--item--title">
                                                        <a href="{$_url}client/view-item/{$item['id']}">{$item['name']}</a>
                                                        <div class="ib-ecom--catalog--item--price mb-3">
                                                            {ib_money_format($item['sales_price'],$config)}
                                                            {*<div class="ib-ecom--catalog--item--price--old">*}
                                                            {*$754.00*}
                                                            {*</div>*}
                                                        </div>
                                                        <div class="text-center mb-2">
                                                            <a href="{$_url}client/view-item/{$item['id']}" class="btn btn-sm btn-primary">See Details</a>
                                                        </div>

                                                    </div>

                                                    {*<div class="ib-ecom--catalog--item--descr">*}
                                                    {*<div class="ib-ecom--catalog--item--descr--sizes">*}
                                                    {*<span data-toggle="tooltip" data-placement="right" title="" data-original-title="Size S">S</span>*}
                                                    {*<span data-toggle="tooltip" data-placement="right" title="" data-original-title="Size M">M</span>*}
                                                    {*<span data-toggle="tooltip" data-placement="right" title="" data-original-title="Size XL">XL</span>*}
                                                    {*</div>*}
                                                    {*Including Lenses*}
                                                    {*</div>*}
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            {/foreach}

                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="col-md-3" id="load_shopping_cart">



        </div>
    </div>
{/block}

{block name="script"}
    <script>
        $(function () {

            var $modal = $('#ajax-modal');

            var $load_shopping_cart = $("#load_shopping_cart");

            function loadShoppingCart() {

                $load_shopping_cart.html(block_msg);

                $.get( base_url + "client/ajax_shopping_cart", function( data ) {
                    $load_shopping_cart.html(data);
                });
            }

            loadShoppingCart();

            $('.view-item').click(function (e) {
                e.preventDefault();

                var item_id = this.id;

                $('body').modalmanager('loading');

                $modal.load( base_url + 'client/modal_view_item/' +  item_id, '', function(){
                    $modal.modal();



                });

            });


            $modal.on('click', '.add_to_cart', function(e) {

                e.preventDefault();



                var form_item_id = $('#form_item_id').val();
                var form_item_qty = $('#form_item_quantity').val();

                $.get( base_url + "client/ajax_add_item/"+form_item_id+'/'+form_item_qty, function( data ) {
                   // alert(data);
                    loadShoppingCart();
                });

                $modal.modal('toggle');


            });




        })
    </script>
{/block}
