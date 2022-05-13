{extends file="$layouts_admin"}

{block name="content"}

    <div class="mx-auto" style="width: 100%; max-width: 800px;">
        <div class="card">
            <div class="card-body">
                {if !$domain_registration_provider}
                    {if isset($available_domain_registration_providers[$selected_type])}
                        <h3>New Domain Registration Provider ({$available_domain_registration_providers[$selected_type]['name']})</h3>
                    {/if}

                    {else}

                    <h3>{$domain_registration_provider->name}</h3>

                {/if}

                <div class="hr-line-dashed"></div>
                <form method="post" id="form_main">


                    <div class="mb-3">
                        <label>{$_L['Name']}</label>
                        <input class="form-control" name="name"
                        {if !$domain_registration_provider}
                            {if isset($available_domain_registration_providers[$selected_type])}
                                value="{$available_domain_registration_providers[$selected_type]['name']}"
                            {/if}

                            {else}

                            value="{$domain_registration_provider->name}"

                        {/if}
                        >
                    </div>

                    {if $selected_type === 'resellerclub' || $selected_type === 'resell_biz'}

                        <div class="mb-3">
                            <label>{$_L['Reseller ID']}</label>
                            <input class="form-control" name="username"
                            {if $domain_registration_provider}
                                value="{$domain_registration_provider->username}"
                            {/if}
                            >
                        </div>

                        <div class="mb-3">
                            <label>{$_L['API Key']}</label>
                            <input class="form-control" name="api_key"
                                    {if $domain_registration_provider}
                                        value="{$domain_registration_provider->api_key}"
                                    {/if}
                            >
                        </div>

                        {elseif $selected_type === 'name_com'}

                    {elseif $selected_type === 'godadday'}


                    {/if}

                    <div class="mb-3">
                        {if $domain_registration_provider}
                            <input type="hidden" name="id" value="{$domain_registration_provider->id}">
                            <input type="hidden" name="type" value="{$domain_registration_provider->type}">
                            <input type="hidden" name="id" value="{$domain_registration_provider->id}">
                        {else}
                            <input type="hidden" name="type" value="{$selected_type}">
                        {/if}
                        <button class="btn btn-primary" id="btn_submit" type="submit">{$_L['Save']}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

{/block}

{block name=script}

    <script>

        $(function () {

            let $form_main = $('#form_main');
            let $btn_submit = $('#btn_submit');

            $form_main.on('submit',function (event) {
                event.preventDefault();
                $btn_submit.prop('disabled',true);
                axios.post(base_url + 'hostbilling/domain_registration_provider/',$form_main.serialize()).then(function (response) {
                    $btn_submit.prop('disabled',false);

                    window.location = base_url + 'hostbilling/domain-registration-providers/'

                }).catch(function (error) {

                    $btn_submit.prop('disabled',false);

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });
            });

        });

    </script>


{/block}
