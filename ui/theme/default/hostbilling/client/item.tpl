{extends file="hostbilling/layouts/new_base/base.tpl"}



{block name="new_content"}



    <div class="mx-auto" style="width: 100%; max-width: 800px;">
        <div class="bg-white shadow p-4 pricing_block">
            <div class="pb-2">
                <h1 class="m-0">{$item->name}</h1>
                
                <h5 class="m-0 h1 selected_price"><label id="total_price"></label> {$config['home_currency']}</h5>
                <p class="selected_term">{$_L['Monthly']}</p>

                {if count(get_available_item_pricing_terms($item)) > 1}

                    <select class="custom-select my-2 select_payment_term" data-id="{$item->id}" data-slug="{$item->slug}" >
                        {foreach get_available_item_pricing_terms($item) as $key => $value}
                            <option data-price="{formatCurrency($value['price'],$config['home_currency'])}" data-term="{$key}" value="{$key}"
                                    {if isset($shopping_cart_items['hosting'][$item->id]['term']) && ($shopping_cart_items['hosting'][$item->id]['term'] === $key)}
                                        selected
                                    {/if}
                            >{$value['name']} {formatCurrency($value['price'],$config['home_currency'])}</option>
                        {/foreach}
                    </select>

                {/if}
                
              {if ($item->options && $item->options->linux && count($item->options->linux) > 0)}
                <h1>OS</h1>
                <select class="custom-select my-2 select-option" data-id="{$item->id}" data-slug="{$item->slug}">
                    <option data-price="0" data-term="linux" value="0" selected>Select OS option</option>
                    {foreach $item->options->linux as $key => $value}
                        <option data-price="{formatCurrency($value->price,$config['home_currency'])}" data-term="{$key}" value="{$value->price}"
                                {if isset($shopping_cart_items['hosting'][$item->id]['term']) && ($shopping_cart_items['hosting'][$item->id]['term'] === $key)}
                                    selected
                                {/if}
                        >{$value->name} {formatCurrency($value->price,$config['home_currency'])}</option>
                    {/foreach}
                </select>

                {/if}

                {if ($item->options && $item->options->dashboard && count($item->options->dashboard) > 0)}
                <h1>Panneau d'administration</h1>

                    <select class="custom-select my-2 select-option" data-id="{$item->id}" data-slug="{$item->slug}">
                        <option data-price="0" data-term="dashboard" value="0" selected>Select dashboard option</option>
                        {foreach $item->options->dashboard as $key => $value}
                            <option data-price="{formatCurrency($value->price,$config['home_currency'])}" data-term="{$key}" value="{$value->price}"
                                    {if isset($shopping_cart_items['hosting'][$item->id]['term']) && ($shopping_cart_items['hosting'][$item->id]['term'] === $key)}
                                        selected
                                    {/if}
                            >{$value->name} {formatCurrency($value->price,$config['home_currency'])}</option>
                        {/foreach}
                    </select>

                {/if}

                {if ($item->options && $item->options->data_center && count($item->options->data_center) > 0)}
                    <h1>Data Center</h1>
                    <select class="custom-select my-2 select-option" data-id="{$item->id}" data-slug="{$item->slug}">
                        <option data-price="0" data-term="data_center" value="0" selected>Select data center option</option>
                        {foreach $item->options->data_center as $key => $value}
                            <option data-price="{formatCurrency($value->price,$config['home_currency'])}" data-term="{$key}" value="{$value->price}"
                                    {if isset($shopping_cart_items['hosting'][$item->id]['term']) && ($shopping_cart_items['hosting'][$item->id]['term'] === $key)}
                                        selected
                                    {/if}
                            >{$value->name} {formatCurrency($value->price,$config['home_currency'])}</option>
                        {/foreach}
                    </select>

                {/if}

                
                {if ($item->options && $item->options->managed_server && count($item->options->managed_server) > 0)}
                    <h1>Serveur managé</h1>
                    <select class="custom-select my-2 select-option" data-id="{$item->id}" data-slug="{$item->slug}">
                        <option data-price="0" data-term="managed_server" value="0" selected>Select managed server option</option>
                        {foreach $item->options->managed_server as $key => $value}
                            <option data-price="{formatCurrency($value->price,$config['home_currency'])}" data-term="{$key}" value="{$value->price}"
                                    {if isset($shopping_cart_items['hosting'][$item->id]['term']) && ($shopping_cart_items['hosting'][$item->id]['term'] === $key)}
                                        selected
                                    {/if}
                            >{$value->name} {formatCurrency($value->price,$config['home_currency'])}</option>
                        {/foreach}
                    </select>

                {/if}

            </div>

            {if $item->features && count(json_decode($item->features))}
                <ul class="list-unstyled clx-list-with-padding">
                    {foreach json_decode($item->features) as $feature_line}
                        <li class="pl-1"><i class="fal fa-check mr-2"></i> {$feature_line}</li>
                    {/foreach}
                </ul>
            {/if}
            <a href="{$base_url}client/buy-now/{$item->slug}" class="btn btn-primary btn_buy_now">{$_L['Buy Now']}</a>
            <div class="hr-line-dashed"></div>
            {$item->description}
        </div>
    </div>

{/block}

{block name=script}

    <script>

        $(function () {

            $('.select_payment_term').on('change',function () {
                let that = $(this);

                that.closest('.pricing_block').find('.selected_price').html(that.find(':selected').data('price'));
                that.closest('.pricing_block').find('.selected_term').html(that.find(':selected').data('term'));

                that.closest('.pricing_block').find('.btn_buy_now').attr('href',base_url + 'client/buy-now/' + that.data('slug') + '/' + that.find(':selected').data('term'));

            });
            var price = {$item->price_monthly};

            // one time fee.
            var one_time_fee = {$item->one_time_fee};
            if(price == 0){
                if(one_time_fee !=0){
                    price = one_time_fee;
                }
            };
            
            var total = parseInt(price);
            $("#total_price").text(total);

            $('.select-option').on('change',function () {
                total = price;
                var selectedOptions = $('.select-option option:selected')
                .toArray().map(item => item.value);
                console.warn(selectedOptions);
                selectedOptions.forEach((option) => {
                    total += parseInt(option);
                });
                $("#total_price").text(total);
            });
            
        });

    </script>


{/block}
