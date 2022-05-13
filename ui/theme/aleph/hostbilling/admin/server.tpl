{extends file="$layouts_admin"}

{block name="content"}

    <div class="mx-auto" style="width: 100%; max-width: 800px;">
        <div class="card">
            <div class="card-body">
                {if !$server}
                    {if isset($available_server_types[$selected_type])}
                        <h3>New Server ({$available_server_types[$selected_type]['name']})</h3>
                    {/if}

                    {else}

                    <h3>{$server->name}</h3>

                {/if}

                <div class="hr-line-dashed"></div>
                <form method="post" id="form_main">
                    <div class="mb-3">
                        <label>{$_L['Name']}</label>
                        <input class="form-control" name="name"
                        {if $server}
                            value="{$server->name}"
                        {/if}
                        >
                    </div>

                    {if $selected_type === 'cpanel'}

                        <div class="mb-3">
                            <label>{$_L['Host']}</label>
                            <input class="form-control" name="host"
                                    {if $server}
                                        value="{$server->host}"
                                    {/if}
                            >
                        </div>

                        <div class="mb-3">
                            <label>{$_L['Username']}</label>
                            <input class="form-control" name="username"
                                    {if $server}
                                        value="{$server->username}"
                                    {/if}
                            >
                        </div>

                        <div class="mb-3">
                            <label>{$_L['API Token']}</label>
                            <input class="form-control" name="api_key"
                                    {if $server}
                                        value="{$server->api_key}"
                                    {/if}
                            >
                        </div>

                    {elseif $selected_type === 'directadmin'}

                        <div class="mb-3">
                            <label>{$_L['Host']}</label>
                            <input class="form-control" name="host"
                                    {if $server}
                                        value="{$server->host}"
                                    {/if}
                            >
                        </div>

                        <div class="mb-3">
                            <label>{$_L['Username']}</label>
                            <input class="form-control" name="username"
                                    {if $server}
                                        value="{$server->username}"
                                    {/if}
                            >
                        </div>

                        <div class="mb-3">
                            <label>{$_L['Password']}</label>
                            <input class="form-control" name="password"
                                    {if $server}
                                        value="{$server->password}"
                                    {/if}
                            >
                        </div>


                        {else}


                        {if !empty($input_require_for_this_server_type['host'])}

                            <div class="mb-3">
                                <label>{if !empty($input_require_for_this_server_type['host']['label'])} {$input_require_for_this_server_type['host']['label']} {else} Host{/if}</label>
                                <input class="form-control" name="host"
                                        {if $server}
                                            value="{$server->host}"
                                        {/if}
                                >
                            </div>

                        {/if}

                        {if !empty($input_require_for_this_server_type['port'])}

                            <div class="mb-3">
                                <label>{if !empty($input_require_for_this_server_type['port']['label'])} {$input_require_for_this_server_type['port']['label']} {else} {{__('Port')}}{/if}</label>
                                <input class="form-control" name="port"
                                        {if $server}
                                            value="{$server->port}"
                                        {/if}
                                >
                            </div>

                        {/if}

                        {if !empty($input_require_for_this_server_type['username'])}

                            <div class="mb-3">
                                <label>{if !empty($input_require_for_this_server_type['username']['label'])} {$input_require_for_this_server_type['username']['label']} {else} Username{/if}</label>
                                <input class="form-control" name="username"
                                        {if $server}
                                            value="{$server->username}"
                                        {/if}
                                >
                            </div>

                        {/if}

                        {if !empty($input_require_for_this_server_type['password'])}

                            <div class="mb-3">
                                <label>{if !empty($input_require_for_this_server_type['password']['label'])} {$input_require_for_this_server_type['password']['label']} {else} Password{/if}</label>
                                <input class="form-control" name="password"
                                        {if $server}
                                            value="{$server->password}"
                                        {/if}
                                >
                            </div>

                        {/if}


                        {if !empty($input_require_for_this_server_type['api_key'])}

                            <div class="mb-3">
                                <label>{if !empty($input_require_for_this_server_type['api_key']['label'])} {$input_require_for_this_server_type['api_key']['label']} {else} API Key{/if}</label>
                                <input class="form-control" name="api_key"
                                        {if $server}
                                            value="{$server->api_key}"
                                        {/if}
                                >
                            </div>

                        {/if}

                        {if !empty($input_require_for_this_server_type['api_secret'])}

                            <div class="mb-3">
                                <label>{if !empty($input_require_for_this_server_type['api_secret']['label'])} {$input_require_for_this_server_type['api_secret']['label']} {else} API Key{/if}</label>
                                <input class="form-control" name="api_secret"
                                        {if $server}
                                            value="{$server->api_secret}"
                                        {/if}
                                >
                            </div>

                        {/if}

                    {/if}


                    <div class="mb-3">
                        {if $server}
                            <input type="hidden" name="id" value="{$server->id}">
                            <input type="hidden" name="type" value="{$server->type}">
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
                axios.post(base_url + 'hostbilling/server',$form_main.serialize()).then(function (response) {
                    $btn_submit.prop('disabled',false);

                    window.location = base_url + 'hostbilling/servers/'

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
