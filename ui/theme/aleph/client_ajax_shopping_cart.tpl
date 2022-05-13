

<div class="panel">
    <div>

        <div class="panel-hdr">
            <h2>{$_L['Shopping Cart']}</h2>
        </div>
        {if $cart && $cart->item_count > 0}

            <div>



                        {foreach $items as $item}
                            <div class="panel-container">
                                <div class="panel-content">
                                    <div>
                                        <div class="top-cart-item-image mb-2">
                                            <a href="#"><img src="{Cart::getItemImage($item['id'])}" alt="Blue Shoulder Bag" class="img-fluid"></a>
                                        </div>
                                        <div class="top-cart-item-desc">
                                            <a href="#" class="t400"><span class="txt_cart_item_name">{strTrunc($item['name'])}</span></a>

                                            <span class="top-cart-item-price">{ib_money_format($item['price'],$config)} [Total: {ib_money_format($item['price']*$item['qty'],$config)}]</span>
                                            <span class="top-cart-item-quantity">x {$item['qty']}</span>
                                        </div>
                                    </div>



                                </div>
                            </div>





                        {/foreach}




            </div>
            <div class="panel-container">
                <div class="panel-content">
                    <div class="top-cart-action clearfix" style="padding-bottom: 0;">

                        <span class="top-checkout-price t600 h3 text-right pull-right" style="color: #333;">{$_L['Total']}: {ib_money_format($cart->total,$config)}</span>





                    </div>
                </div>
            </div>






            <hr>
            <div class="panel-container">
                <div class="panel-content">
                    <a class="btn btn-danger text-right" href="{$_url}cart/clear">Clear</a>
                    <a class="btn btn-primary text-right pull-right" href="{$_url}cart/checkout">Checkout</a>

                    {else}

                    <p class="text-center" style="margin-top: 20px;">{$_L['Your Cart is empty']}</p>

                    <hr>

                    {/if}
                </div>
            </div>



    </div>
</div>


