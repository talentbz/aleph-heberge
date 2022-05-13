{extends file="$layouts_admin"}

{block name="content"}

    <div class="row">
        <div class="col">

            {if $hosting_plan}
               <h3>{__('Edit')}</h3>
                {else}
                {if $type === 'service'}
                    <h3>{$_L['Add Service']}</h3>
                {else}
                    <h3>{$_L['Add Hosting Plan']}</h3>
                {/if}
            {/if}

        </div>
        <div class="col text-right">
            <a
                    {if $type === 'service'}
                        href="{$base_url}hostbilling/services"
                    {else}
                        href="{$base_url}hostbilling/hosting-plans"
                    {/if}
                    class="btn btn-sm btn-danger mb-3">{$_L['Back to the List']}</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8">


            <div class="card">
                <div class="card-body">

                    <form id="form_save_service">

                        <div class="mb-3">
                            <label>{$_L['Name']}</label>
                            <input class="form-control" name="name" {if $hosting_plan}value="{$hosting_plan->name}" {/if} >
                        </div>

                        <div class="mb-3">
                            <label>{$_L['Group']}</label>
                            <select class="custom-select" name="group_id">
                                <option value="">--</option>
                                {foreach $groups as $group}
                                    <option value="{$group->id}"
                                            {if $hosting_plan}
                                                {if $hosting_plan->group_id === $group->id}
                                                    selected
                                                {/if}
                                            {/if}
                                    >{$group->name}</option>
                                {/foreach}
                            </select>
                        </div>



                        {if $type === 'hosting'}

                            <h4>{$_L['Pricing']}</h4>
                            <p>{$_L['Keep blank to disable any of the terms.']}</p>

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label>{$_L['Monthly']}</label>
                                        <input class="form-control" name="price_monthly"
                                               {if $hosting_plan && $hosting_plan->price_monthly > 0}value="{numberFormatUsingCurrency($hosting_plan->price_monthly,$config['home_currency'])}" {/if}
                                        >
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label>{$_L['Quarterly']}</label>
                                        <input class="form-control" name="price_quarterly"
                                               {if $hosting_plan && $hosting_plan->price_quarterly > 0}value="{numberFormatUsingCurrency($hosting_plan->price_quarterly,$config['home_currency'])}" {/if}
                                        >
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label>{$_L['Half Yearly']}</label>
                                        <input class="form-control" name="price_half_yearly"
                                               {if $hosting_plan && $hosting_plan->price_half_yearly > 0}value="{numberFormatUsingCurrency($hosting_plan->price_half_yearly,$config['home_currency'])}" {/if}
                                        >
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label>{$_L['Yearly']}</label>
                                        <input class="form-control" name="price_yearly"
                                               {if $hosting_plan && $hosting_plan->price_yearly > 0}value="{numberFormatUsingCurrency($hosting_plan->price_yearly,$config['home_currency'])}" {/if}
                                        >
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label>{$_L['Two years']}</label>
                                        <input class="form-control" name="price_two_years"
                                               {if $hosting_plan && $hosting_plan->price_two_years > 0}value="{numberFormatUsingCurrency($hosting_plan->price_two_years,$config['home_currency'])}" {/if}
                                        >
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label>{$_L['Three years']}</label>
                                        <input class="form-control" name="price_three_years"
                                               {if $hosting_plan && $hosting_plan->price_three_years > 0}value="{numberFormatUsingCurrency($hosting_plan->price_three_years,$config['home_currency'])}" {/if}
                                        >
                                    </div>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
							
							
							


                        {else}

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label>{$_L['Service Fee']}</label>
                                        <input class="form-control" name="one_time_fee"
                                               {if $hosting_plan && $hosting_plan->one_time_fee > 0}value="{numberFormatUsingCurrency($hosting_plan->one_time_fee,$config['home_currency'])}" {/if}
                                        >
                                    </div>
                                </div>
                            </div>



                        {/if}



                        <div class="hr-line-dashed"></div>

                        <div class="mb-3">
                            <label>{$_L['Description']}</label>
                            <textarea class="form-control" name="description" id="description">{if $hosting_plan && $hosting_plan->description}{$hosting_plan->description}{/if}</textarea>
                        </div>

                        {if $type === 'hosting'}

                            <div class="mb-3">
                                <div class="custom-control custom-switch">
                                    <input type="checkbox" class="custom-control-input" name="allow_free_domain" value="1" id="allow_free_domain"
                                            {if $hosting_plan && $hosting_plan->allow_free_domain}
                                                checked
                                            {/if}
                                    >
                                    <label class="custom-control-label" for="allow_free_domain">{$_L['Allow Free Domain?']}</label>
                                </div>
                            </div>

                        {/if}


                        <div class="mb-3">
                            <div class="custom-control custom-switch">
                                <input type="checkbox" class="custom-control-input" name="require_domain_name" value="1" id="require_domain_name"
                                        {if $hosting_plan && $hosting_plan->require_domain_name}
                                            checked
                                        {/if}
                                >
                                <label class="custom-control-label" for="require_domain_name">{$_L['Require Domain Name?']}</label>
                            </div>
                        </div>


                        <div class="mb-3">
                            <div class="custom-control custom-switch">
                                <input type="checkbox" class="custom-control-input" name="plan_is_featured" value="1" id="plan_is_featured"
                                        {if $hosting_plan && $hosting_plan->is_featured}
                                            checked
                                        {/if}
                                >
                                <label class="custom-control-label" for="plan_is_featured">{$_L['Featured?']}</label>
                            </div>
                        </div>



                        {if $type === 'hosting'}

                            <div class="hr-line-dashed"></div>

                            <h4>{$_L['Automation']}</h4>

                            <div class="mb-3">
                                <label>{$_L['Server/Hosting Provider']}</label>
                                <select class="custom-select" name="hosting_provider_id">
                                    <option value="">--</option>
                                    {foreach $servers as $server}
                                        <option value="{$server->id}"
                                                {if $hosting_plan}
                                                    {if $hosting_plan->hosting_provider_id === $server->id}
                                                        selected
                                                    {/if}
                                                {/if}
                                        >{$server->name}</option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="mb-3">
                                <label>{$_L['Plan API Name']}</label>
                                <input class="form-control" name="api_name"
                                       {if $hosting_plan}value="{$hosting_plan->api_name}" {/if}
                                >
                                <span class="help-block">{$_L['Enter the automation package/plan name.']}</span>
                            </div>

                        {/if}


                        <div class="hr-line-dashed"></div>
                        <h4>{$_L['Features']}</h4>

                        <div id="div_features">

                            {if $hosting_plan && $hosting_plan->features}

                                {foreach json_decode($hosting_plan->features) as $feature_line}
                                    <div class="mb-3">
                                        <input class="form-control" name="features[]" value="{$feature_line}">
                                    </div>
                                {/foreach}

                            {else}

                                <div class="mb-3">
                                    <input class="form-control" name="features[]">
                                </div>

                            {/if}


                        </div>

                        <div class="my-3">
                            <button id="btn_add_features" type="button" class="btn btn-success btn-icon waves-effect waves-themed"><i class="fal fa-plus"></i> </button>
                        </div>

                        <div class="hr-line-dashed"></div>


                        <div class="mb-3">

                            {if $hosting_plan}
                                <input type="hidden" name="id" value="{$hosting_plan->id}">
                            {/if}

                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-4">

            {if $hosting_plan}
                <div class="card">
                    <div class="card-body">
                        <div class="mb-3">
                            <label for="input_item_details">{__('Item Details')}:</label>
                            <input type="text" class="form-control mb-3" id="input_item_details" onClick="this.setSelectionRange(0, this.value.length)" value="{$base_url}client/item/{$hosting_plan->slug}">
                        </div>
                        <div class="mb-3">
                            <label for="input_cart_link">{__('Link to the Cart')}:</label>
                            <input type="text" class="form-control mb-3" id="input_cart_link" onClick="this.setSelectionRange(0, this.value.length)" value="{$base_url}client/buy-now/{$hosting_plan->slug}">
                        </div>
                    </div>
                </div>
            {/if}

        </div>
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

            $('#description').redactor(
                {
                    minHeight: 200 // pixels
                }
            );

            let $form_save_service = $('#form_save_service');

            $form_save_service.on('submit',function (event) {
                event.preventDefault();

                axios.post(base_url + 'hostbilling/{$type}',$form_save_service.serialize()).then(function (response) {
                    window.location = base_url + 'hostbilling/{$type}/' + response.data.id;
                }).catch(function (error) {

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });



            });


        });

    </script>


{/block}
