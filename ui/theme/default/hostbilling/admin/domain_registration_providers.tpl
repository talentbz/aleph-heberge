{extends file="$layouts_admin"}

{block name="content"}

    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-6">
                    <h3>{$_L['Domain Registration Providers']}</h3>
                </div>
                <div class="col-6 text-right">
                    <a class="btn btn-primary" href="{$base_url}hostbilling/choose-domain-registration-provider/">Add New Provider</a>
                </div>
            </div>

            <div class="hr-line-dashed"></div>
            <table class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th>{$_L['Type']}</th>
                    <th>{$_L['Name']}</th>
                    <th>{$_L['Manage']}</th>
                </tr>
                </thead>
                <tbody>
                {foreach $domain_registration_providers as $domain_registration_provider}
                    <tr>
                        <td>
                            <a href="{$base_url}hostbilling/choose-domain-registration-provider/{$domain_registration_provider->id}/">{$domain_registration_provider->type}</a>
                        </td>
                        <td>
                            <a href="{$base_url}hostbilling/choose-domain-registration-provider/{$domain_registration_provider->id}/">{$domain_registration_provider->name}</a>
                        </td>
                        <td>
                            <a href="javascript:;" class="btn btn-danger" onclick="confirmThenGoToUrl(event,'hostbilling/delete-domain-registration-provider/{$domain_registration_provider->id}')">
                                Delete
                            </a>
                            <a href="{$base_url}hostbilling/domain-registration-provider/{$domain_registration_provider->id}/" class="btn btn-primary">{$_L['Edit']}</a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>

{/block}

{block name=script}

    <script>

    </script>


{/block}
