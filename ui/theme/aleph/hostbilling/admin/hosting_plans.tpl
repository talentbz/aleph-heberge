{extends file="$layouts_admin"}

{block name="content"}

    <div class="row">

        <div class="col-md-3">
            <a href="{$_url}hostbilling/{$type}">
                <div class="card mb-3">
                    <div class="card-body">
                        <div style="padding: 80px;">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus-circle" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10"/>
                                <path d="M12 8v8M8 12h8"/>
                            </svg>
                        </div>
                        {if $type === 'service'}
                            <h4 class="text-center">{$_L['Add New Service']}</h4>
                            {else}
                            <h4 class="text-center">{$_L['Add New Hosting Plan']}</h4>
                        {/if}
                    </div>
                </div>
            </a>
        </div>

        {foreach $hosting_plans as $hosting_plan}
            <div class="col-md-3">
                <div class="card mb-3">
                    <div class="card-body" style="min-height: 419px;">
                        <h2>{$hosting_plan->name}</h2>

                        <div class="hr-line-dashed"></div>

                        <div class="mb-3">
                            {foreach get_available_item_pricing_terms($hosting_plan) as $key => $value}
                                <p>{$value['name']}</p>
                                <h4>{formatCurrency($value['price'],$config['home_currency'])}</h4>
                                <div class="hr-line-dashed"></div>

                            {/foreach}


                        </div>



                        <a href="{$_url}hostbilling/{$type}/{$hosting_plan->id}" class="btn btn-primary">{$_L['Edit']}</a>
                        <a href="#" id="delete_{$hosting_plan->id}" class="btn btn-danger confirm_delete">{$_L['Delete']}</a>
                    </div>
                </div>
            </div>
        {/foreach}

    </div>


{/block}

{block name=script}

    <script>

        $(function () {


            $btn_add_features = $('#btn_add_features');
            $div_features = $('#div_features');

            $btn_add_features.on('click',function () {
                $div_features.append('<div class="mb-3">\
                    <input class="form-control" name="features[]">\
                    </div>');
            });

            let $form_save_domain_price = $('#form_save_domain_price');

            $form_save_domain_price.on('submit',function (event) {
                event.preventDefault();

                axios.post(base_url + 'hostbilling/save-domain-price',$form_save_domain_price.serialize()).then(function (response) {

                }).catch(function (error) {

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });



            });


            $(".confirm_delete").click(function (event) {
                event.preventDefault();
                let id = this.id;
                id = id.replace('delete_','');
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        window.location.href = base_url + "hostbilling/delete-hosting-plan/" + id;
                    }
                });
            });


        });

    </script>


{/block}
