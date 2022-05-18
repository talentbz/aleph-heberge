{extends file="hostbilling/layouts/new_base/base.tpl"}




{block name="new_content"}



    <div class="container">

        <div class="bg-white shadow p-4">

            <h1>{$_L['Checkout']}</h1>

            <div class="hr-line-dashed"></div>

            {if count($items) || !empty($shopping_cart_items['domains'])}


                <table class="table table-bordered">
                    {foreach $items as $item}
                        <tr>
                            <td class="item_selected" id={$item->id}>
                                <h3>{$item->name}</h3>

                                <div class="hr-line-dashed"></div>

                                <div class="mb-3">
                                    <label>{__('Billing Cycle')}</label>
                                    <select class="custom-select mt-2 select_payment_term" data-id="{$item->id}" id="term_{$item->id}" >
                                        {foreach get_available_item_pricing_terms($item) as $key => $value}
                                            <option value="{$value['price']}"
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

                                {if $item->linux && count($item->linux)}
                                    <div class="mb-3">
                                        <label>OS</label>
                                        <select class="custom-select mt-2 select_payment_term" data-id="os_{$item->id}" id="os_{$item->id}"  >
                                        
                                            <option data-price="0" data-term="linux" value="-1"
                                                {if !isset($shopping_cart_items['hosting'][$item->id]['options']['linux']) }
                                                selected
                                            {/if}>Select option</option>
     
                                            {foreach $item->linux as $key => $value}
                                                <option value="{$key}" name="linux[{$key}][price]"
                                                {if isset($shopping_cart_items['hosting'][$item->id]['options']['linux']) && ($shopping_cart_items['hosting'][$item->id]['options']['linux']['name'] === $value->name)}
                                                        selected
                                                    {/if}
                                                >{$value->name} {$value->price} {$config['home_currency']}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                {/if}

                                {if $item->dashboard && count($item->dashboard)}
                                    <div class="mb-3">
                                        <label>Panneau d'administration</label>
                                        <select class="custom-select mt-2 select_payment_term" data-id="dashboard_{$item->id}" id="dashboard_{$item->id}" >
                                            <option data-price="0" data-term="dashboard" value="-1"
                                                {if !isset($shopping_cart_items['hosting'][$item->id]['options']['dashboard']) }
                                                selected
                                            {/if}>Select option</option>
                                            {foreach $item->dashboard as $key => $value}
                                                <option value="{$key}" name="dashboard[{$key}][price]"
                                                {if isset($shopping_cart_items['hosting'][$item->id]['options']['dashboard']) && ($shopping_cart_items['hosting'][$item->id]['options']['dashboard']['name'] === $value->name)}
                                                        selected
                                                    {/if}
                                                >{$value->name} {$value->price} {$config['home_currency']}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                {/if}

                                {if $item->data_center && count($item->data_center)}
                                    <div class="mb-3">
                                        <label>Data center</label>
                                        <select class="custom-select mt-2 select_payment_term" data-id="data_center_{$item->id}" id="data_center_{$item->id}" >
                                            <option data-price="0" data-term="data_center" value="-1"
                                             {if !isset($shopping_cart_items['hosting'][$item->id]['options']['data_center']) }
                                                selected
                                            {/if}>Select option</option>
                                            {foreach $item->data_center as $key => $value}
                                                <option value="{$key}" name="data_center[{$key}][price]"
                                                {if isset($shopping_cart_items['hosting'][$item->id]['options']['data_center']) && ($shopping_cart_items['hosting'][$item->id]['options']['data_center']['name'] === $value->name)}
                                                        selected
                                                    {/if}
                                                >{$value->name} {$value->price} {$config['home_currency']}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                {/if}

                                {if $item->managed_server && count($item->managed_server)}
                                    <div class="mb-3">
                                        <label>Serveur managé</label>
                                        <select class="custom-select mt-2 select_payment_term" data-id="managed_server_{$item->id}" id="managed_server_{$item->id}" >
                                            <option data-price="0" data-term="managed_server" value="-1" 
                                            {if !isset($shopping_cart_items['hosting'][$item->id]['options']['managed_server']) }
                                                selected
                                            {/if}>Select option</option>
                                            
                                            {foreach $item->managed_server as $key => $value}
                                            
                                                <option value="{$key}" name="managed_server[{$key}][price]"
                                                {if isset($shopping_cart_items['hosting'][$item->id]['options']['managed_server']) && ($shopping_cart_items['hosting'][$item->id]['options']['managed_server']['name'] === $value->name)}
                                                        selected
                                                    {/if}
                                                >{$value->name} {$value->price} {$config['home_currency']}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                {/if}



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
            var selectedItem = '';
            
            $('.item_selected').on('click',function () {
                selectedItem = this.id;
            });
            console.warn("selectedItem",selectedItem);
            var price = {$shopping_cart_items['hosting'][$item->id]['price']};
            var total = parseInt(price);
            $('#item_price_' + selectedItem).text(total);
            $('.select_payment_term').on('change',function () {
                let that = $(this);
                
                window.location = base_url + 'client/shopping-cart-update-term/' + selectedItem + '/?total=' + total+'&OS='+$( '#os_'+ selectedItem +' option:selected' ).val()
                +'&dashboard='+$( '#dashboard_'+ selectedItem +' option:selected' ).val()+'&managed_server='+$( '#managed_server_'+ selectedItem +' option:selected' ).val()
                +'&data_center='+$( '#data_center_'+ selectedItem +' option:selected' ).val();
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
