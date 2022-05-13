{extends file="$layouts_client"}

{block name="content"}
    <div class="row">

        <div class="col-md-12">
            <div class="panel">
                <div class="panel-container">
                    <div class="panel-content">

                        {if $cart && $cart->item_count > 0}
                            <div class="table-responsive">
                                <table id="cart_summary" class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th width="120px;">{$_L['Product']}</th>
                                        <th>{$_L['Description']}</th>
                                        <th>{$_L['Unit price']}</th>
                                        <th width="100px;">{$_L['Quantity']}</th>
                                        <th>&nbsp;</th>
                                        <th class="text-right">{$_L['Total']}</th>
                                    </tr>
                                    </thead>

                                    <tbody>


                                    {foreach $items as $item}

                                        <tr>
                                            <td>
                                                <a href="{$_url}item/{$item['id']}">
                                                    <img class="img-responsive" src="{Cart::getItemImage($item['id'])}" alt="{$item['name']}" >
                                                </a>
                                            </td>
                                            <td>
                                                <a href="{$_url}item/{$item['id']}">{$item['name']}</a>
                                            </td>
                                            <td>
                                                {ib_money_format($item['price'],$config)}
                                            </td>

                                            <td class="cart_quantity">

                                                <input class="form-control" size="2" type="text" autocomplete="off"  value="{$item['qty']}" disabled>
                                                <div style="margin-top: 10px;">

                                                    <div class="btn-group">
                                                        <a class="btn btn-primary btn-xs" href="{$_url}cart/add/{$item['id']}"> <span><i class="fal fa-plus"></i></span> </a>
                                                        <a class="btn btn-danger btn-xs" href="{$_url}cart/remove/{$item['id']}"> <span><i class="fal fa-minus"></i></span> </a>
                                                    </div>

                                                </div>
                                            </td>
                                            <td class="cart_delete text-center" data-title="Delete">
                                                <div>
                                                    <a href="{$_url}cart/delete/{$item['id']}"><i class="icon-trash"></i></a>
                                                </div>
                                            </td>
                                            <td> {ib_money_format($item['price']*$item['qty'],$config)} </td>

                                        </tr>




                                    {/foreach}


                                    </tbody>

                                    <tfoot>


                                    <tr class="cart_total_price">
                                        <td rowspan="4" colspan="3" id="cart_voucher" class="cart_voucher">
                                        </td>
                                        <td colspan="2" class="text-right"><strong>{$_L['Total']}</strong></td>
                                        <td colspan="2"><strong>{ib_money_format($cart->total,$config)}</strong></td>
                                    </tr>
                                    </tfoot>

                                </table>
                            </div>

                            <div>

                                <div class="dropdown">
                                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        {$_L['Select Final Delivery Address']}
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        {foreach $shipping_addresses as $shipping_address}

                                            <a class="dropdown-item" href="#">{$shipping_address->address_line_1}</br>{$shipping_address->city},{$shipping_address->zip},{$shipping_address->state}
                                            </a>


                                        {/foreach}
                                    </div>



                                </div>




                            </div>

                        <div class="float-right">
                            <p class="cart_navigation clearfix">
                                <a href="{$_url}cart/checkout/" class="btn btn-primary pull-right" title="Proceed to checkout">
                                    <span><i class="fal fa-shopping-cart"></i> {$_L['Proceed to checkout']}</span>
                                </a>

                                {*<a href="" class="btn btn-default">*}
                                {*<i class="icon-chevron-left left"></i>Continue shopping*}
                                {*</a>*}
                            </p>

                            {else}

                            <p>{$_L['Your Cart is empty']}</p>

                            {/if}
                        </div>








                    </div>
                </div>
            </div>


        </div>

    </div>
{/block}
