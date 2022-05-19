{extends file="hostbilling/layouts/new_base/base.tpl"}

{block name="new_content"}
    <!-- <style>
          .clx-navigation-type-top .page-sidebar .primary-nav .nav-menu > li > ul li:hover > a {
            color: #6969FF;
        }
        .header-icon:not(.btn)[data-toggle=dropdown][data-toggle=dropdown]:after {
            background: #4c8ec4;
        }

        .card{
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 24px 0 rgb(34 41 47 / 10%);
        }
        .clx-list-with-padding li{
            position: relative;
            padding: 8px 0 8px 25px;
            font-size: 16px;
        }


        .clx-pricing-table .pt-head:after {
            content: "";
            position: absolute;
            top: -50px;
            left: -20px;
            right: -10px;
            bottom: 0;
            background: #4C3FB9;
            z-index: -1;
            transform: rotate(
                    -7deg
            );
        }
        .z-index-1 {
            z-index: 1;
        }

        .clx-pricing-table.featured .pt-head:after {
            background: #15db95;
        }

        label{
            font-weight: bold;
        }

        .nav-menu li a>svg {
            margin-right: .75rem;
        }

        .nav-menu li.active>a {
            -webkit-box-shadow: none;
            box-shadow: none;
        }

        .table.invoice-items{
            border: 1px solid #dee2e6;
        }

        .table.invoice-items td, .table.invoice-items th {
            border: 1px solid #dee2e6;
        }
    </style> -->

    <!-- <div class="container">


        {if $group && $group->header_content}
            <div class="my-3">
                {$group->header_content}
            </div>
        {/if}

        <div class="row align-items-center">

            {foreach $items as $item}
                <div class="col-sm-6 col-lg-4 my-3 pricing_block">
                    <div class="shadow-hover shadow-lg bg-white hover-top clx-pricing-table overflow-hidden {if $item->featured}featured{/if} ">
                        <div class="pt-head position-relative z-index-1 p-4">
                            <h6 class="mb-2 text-white">{$item->name}</h6>

                            {if $item->one_time_fee && $item->one_time_fee > 0}
                                <h5 class="m-0 h1 text-white selected_price">{formatCurrency(($item->one_time_fee),$config['home_currency'])}</h5>
                                <p class="text-white selected_term">{$_L['One Time']}</p>

                            {elseif $item->price_monthly && $item->price_monthly > 0}
                                <h5 class="m-0 h1 text-white selected_price">{formatCurrency(($item->price_monthly),$config['home_currency'])}</h5>
                                <p class="text-white selected_term">{$_L['Monthly']}</p>

                            {elseif $item->price_yearly && $item->price_yearly > 0}
                                <h5 class="m-0 h1 text-white selected_price">{formatCurrency(($item->price_yearly),$config['home_currency'])}</h5>
                                <p class="text-white selected_term">{$_L['Yearly']}</p>

                            {elseif $item->price_quarterly && $item->price_quarterly > 0}
                                <h5 class="m-0 h1 text-white selected_price">{formatCurrency(($item->price_quarterly),$config['home_currency'])}</h5>
                                <p class="text-white selected_term">{$_L['Quarterly']}</p>

                            {elseif $item->price_half_yearly && $item->price_half_yearly > 0}
                                <h5 class="m-0 h1 text-white selected_price">{formatCurrency(($item->price_half_yearly),$config['home_currency'])}</h5>
                                <p class="text-white selected_term"> {$_L['Half Yearly']}</p>

                            {elseif $item->two_years && $item->two_years > 0}
                                <h5 class="m-0 h1 text-white selected_price">{formatCurrency(($item->two_years),$config['home_currency'])}</h5>
                                <p class="text-white selected_term">{$_L['Two Years']}</p>

                            {elseif $item->price_three_years && $item->price_three_years > 0}
                                <h5 class="m-0 h1 text-white selected_price">{formatCurrency(($item->price_three_years),$config['home_currency'])}</h5>
                                <p class="text-white selected_term">{$_L['Three Years']}</p>
                            {/if}

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


                        </div>
                        <div class="p-4">


                            {if $item->features && count(json_decode($item->features))}
                                <ul class="list-unstyled clx-list-with-padding">
                                    {foreach json_decode($item->features) as $feature_line}
                                        <li><i class="fal fa-check mr-2"></i> {$feature_line}</li>
                                    {/foreach}
                                </ul>
                            {/if}
                        </div>
                        <div class="hr-line-dashed m-0"></div>
                        <div class="p-4">
                            <a href="{$base_url}client/buy-now/{$item->slug}" class="btn btn-primary btn_buy_now">{$_L['Buy Now']}</a>
                            <a href="{$base_url}client/item/{$item->slug}" class="btn btn-secondary">{$_L['Learn More']}</a>
                        </div>
                    </div>
                </div>
            {/foreach}



        </div>

    </div> -->

    <section class="third-banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="banner-info">
                        <div class="banner-info-inner d-flex">
                        <img src="img/iconeVPS SSD.png" alt="">
                        <h1>VPS SSD</h1>
                        </div>
                        <div class="banner-info-text">
                        <p>Un contrôle total et un prix selon votre budget et évolutif. <br> L’essentiel pour démarrer <br>
                            Serveurs en
                            France. <br> Support en France.</p>
                        </div>
                        <div class="banner-info-list">
                        <ul>
                            <li><a href="#">• Trafic illimité </a></li>
                            <li><a href="#">• Cœurs CPU, RAM, Disque 100% dédiés </a></li>
                            <li><a href="#">• ans engagement, prêt à l’emploi</a></li>
                            <li><a href="#">• Distribution a la demande.</a></li>
                        </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="banner-img-4">
                        <img src="img/image VPS SSD.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="pricing">
        <div class="container">
        <div class="row">
            <div class="col-lg-4">
            <div class="pricing-table">
                <div class="pricing-btn">
                <button style="background-color: #78C8ED;">MENSUEL</button>
                <button style="background-color: #833D8F;">ANNUEL</button>
                </div>
                <div class="first-card">
                <h3 class="card-heading">VPS M SSD</h3>
                <div class="card-pricing">
                    <h1>19,00<span style="font-size: 43px; font-weight: 600;">€</span> <span>/ mois</span></h1>
                </div>
                <ul class="card-list">
                    <li>• 4 cœur Intel a 2.6Giga hertz </li>
                    <li>• 8 Giga de RAM </li>
                    <li>• 300 Giga d’espace disque SSD </li>
                    <li>•Trafic illimité </li>

                </ul>
                <button class="card-botton">JE RESERVE</button>
                </div>
            </div>
            </div>
            <div class="col-lg-4">

            <div class="pricing-table">
                <div class="pricing-btn">
                <button style="background-color: #78C8ED;">MENSUEL</button>
                <button style="background-color: #833D8F;">ANNUEL</button>
                </div>
                <div class="first-card">
                <h3 class="card-heading">VPS L 100% SSD</h3>
                <div class="card-pricing">
                    <h1>40,00<span style="font-size: 43px; font-weight: 600;">€</span> <span>/ mois</span></h1>
                </div>
                <ul class="card-list">
                    <ul class="card-list">
                    <li>• 8 coeurs Intel </li>
                    <li> • 16 Giga de RAM </li>
                    <li>• 800 Giga d’espace disque SSD </li>
                    <li>• • Trafic illimité </li>

                    </ul>
                </ul>
                <button class="card-botton">JE RESERVE</button>
                </div>

            </div>
            </div>
            <div class="col-lg-4">
            <div class="pricing-table">
                <div class="pricing-btn">
                <button style="background-color: #78C8ED;">MENSUEL</button>
                <button style="background-color: #833D8F;">ANNUEL</button>
                </div>
                <div class="first-card">
                <h3 class="card-heading">VPS XL 100% SSD</h3>
                <div class="card-pricing">
                    <h1>60,00<span style="font-size: 43px; font-weight: 600;">€</span> <span>/ mois</span></h1>
                </div>
                <ul class="card-list">
                    <li>• Equipée de 10 cœur Intel </li>
                    <li> • 40 Giga de RAM </li>
                    <li>• 800 Giga d’espace disque SSD </li>
                    <li>• • Trafic illimité </li>

                </ul>
                <button class="card-botton">JE RESERVE</button>
                </div>

            </div>
            </div>
        </div>
        </div>
    </section>


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
        });

    </script>


{/block}
