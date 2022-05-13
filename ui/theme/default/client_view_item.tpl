{extends file="$layouts_client"}

{block name="content"}
    <section >
        <div class="panel">
            <div class="panel-container">
                <div class="panel-content">
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="cui-ecommerce--catalog--item">
                                <div class="cui-ecommerce--catalog--item--img">
                                    <div class="cui-ecommerce--catalog--item--like cui-ecommerce--catalog--item--like__selected">
                                        <i class="icmn-heart3 cui-ecommerce--catalog--item--like--liked"><!-- --></i>
                                        <i class="icmn-heart4 cui-ecommerce--catalog--item--like--unliked"><!-- --></i>
                                    </div>
                                    <div class="panel">
                                        <div class="panel-container">
                                            <div class="panel-content">
                                                <a href="javascript: void(0);">
                                                    {if $item->image neq ''}
                                                        <img src="{$app_url}storage/items/{$item->image}" class="img-fluid">
                                                    {else}
                                                        <img src="{$_url}ui/lib/img/item_placeholder.png">
                                                    {/if}
                                                </a>
                                            </div>
                                        </div>

                                    </div>



                                </div>
                            </div>

                        </div>
                        <div class="col-lg-7">

                            <p class="h1">
                                {$item->name}
                            </p>

                          <p class="h4">
                              {ib_money_format($item->sales_price,$config)}
                          </p>


                            <hr>
                            <div class="cui-ecommerce--product--descr">
                                {$item->description}
                            </div>
                            <hr>
                            <a class="btn btn-primary" href="{$_url}cart/add/{$item->id}">
                                <i class="fal fa-shopping-cart"></i>
                                {$_L['Buy Now']}
                            </a>



                        </div>
                    </div>
                </div>

            </div>

        </div>
    </section>
{/block}
