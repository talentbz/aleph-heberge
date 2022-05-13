{extends file="hostbilling/layouts/client.tpl"}



{block name="content"}



    <div class="container">

        <div class="bg-white shadow p-4">

            <h1>{$_L['Checkout']}</h1>

            <div class="hr-line-dashed"></div>

            {if count($items) || !empty($shopping_cart_items['domains'])}


                <table class="table table-bordered">
                    {foreach $items as $item}
                        <tr>
                            <td>
                                <h3>{$item->name}</h3>

                                <div class="hr-line-dashed"></div>

                                <div class="mb-3">
                                    <label>{__('Billing Cycle')}</label>
                                    <select class="custom-select mt-2 select_payment_term" data-id="{$item->id}" >
                                        {foreach get_available_item_pricing_terms($item) as $key => $value}
                                            <option value="{$key}"
                                                    {if isset($shopping_cart_items['hosting'][$item->id]['term']) && ($shopping_cart_items['hosting'][$item->id]['term'] === $key)}
                                                        selected
                                                    {/if}
                                            >{$value['name']} {formatCurrency($value['price'],$config['home_currency'])}</option>
                                        {/foreach}
                                    </select>
                                </div>


                                {if $item->require_domain_name}

                                    <div class="mb-3">
                                        <label>{__('Enter Your Domain')}</label>
                                        <input class="form-control hosting_set_domain_name" name="domain_name" data-id="{$item->id}"
                                                {if isset($shopping_cart_items['hosting'][$item->id]['domain_name'])}
                                                    value="{$shopping_cart_items['hosting'][$item->id]['domain_name']}"
                                                {/if}
                                        >
                                        <p>
                                            <a href="{$base_url}client/domain-register/">{__('Register a new domain?')}</a>
                                        </p>
                                    </div>

                                {/if}



                            </td>
                            <td class="text-right">
                                <p>
                                    <strong>{formatCurrency($shopping_cart_items['hosting'][$item->id]['price'],$config['home_currency'])}</strong>
                                </p>
                                <a href="{$base_url}client/remove-shopping-cart-item/{$item->id}" class="btn mt-3 btn-danger btn-icon waves-effect waves-themed"><i class="fal fa-trash-alt"></i> </a>
                            </td>
                        </tr>
                    {/foreach}

                    {if !empty($shopping_cart_items['domains'])}

                        {foreach $shopping_cart_items['domains'] as $key => $value}

                            <tr>
                                <td>
                                    <h5>{$value['name']}</h5>

                                    {if $value['term'] == 1}
                                        1 {__('year')}
                                        {else}
                                        {$value['term']} {__('years')}
                                    {/if}

                                </td>
                                <td class="text-right">
                                    <p>
                                        <strong>{formatCurrency($value['price'],$config['home_currency'])}</strong>
                                    </p>
                                    <a href="{$base_url}client/remove-shopping-cart-domain/{$key}" class="btn mt-3 btn-danger btn-icon waves-effect waves-themed"><i class="fal fa-trash-alt"></i> </a>
                                </td>
                            </tr>

                        {/foreach}

                    {/if}


                    <tr>
                        <td class="text-right">
                            <h4>{__('Total')}:</h4>
                        </td>
                        <td class="text-right" style="width: 150px;">
                            <h4>{formatCurrency($shopping_cart->total,$config['home_currency'])}</h4>
                        </td>
                    </tr>

                </table>


                {if $user}
                    <a class="btn btn-primary" href="{$base_url}client/checkout-commit">{__('Pay Now')}</a>

                    {else}


                        <a href="{$base_url}client/login/">
                            <h5 class="text-info">{__('I already have an account')}</h5>
                        </a>

                    <a href="{$base_url}client/register/">
                        <h5 class="text-info">{__('Or create an account')}</h5>
                    </a>

                {/if}


                <div class="hr-line-dashed"></div>
                <a class="btn btn-success" href="{$base_url}client/">{__('Continue Shopping')}</a>
                <a class="btn btn-danger" href="{$base_url}client/delete-shopping-cart">{__('Empty Shopping Cart')}</a>



            {else}

                {__('No items in the shopping cart.')}

                <div class="hr-line-dashed"></div>

                <a class="btn btn-success" href="{$base_url}client/">{__('Go to Homepage')}</a>

            {/if}




        </div>

    </div>







{/block}

{block name=script}

    <script>

        $(function () {

            $('.select_payment_term').on('change',function () {
                let that = $(this);
                window.location = base_url + 'client/shopping-cart-update-term/' + that.data('id') + '/' + that.val();
            });

            $('.hosting_set_domain_name').on('keyup paste',function () {
                let that = $(this);
                $.post( base_url + 'client/set-domain-for-hosting', {
                    id: that.data('id'),
                    domain: that.val(),
                });

            });

        });

    </script>


{/block}
