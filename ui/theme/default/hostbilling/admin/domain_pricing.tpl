{extends file="$layouts_admin"}

{block name="content"}

    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Add Extension/TLD']}</h3>
                    <form id="form_save_domain_price">
                        <div class="mb-3">
                            <label>{$_L['Extension']}</label>
                            <input class="form-control" name="extension"
                                   {if $selected_domain_price}
                                       value="{$selected_domain_price->extension}"
                                   {/if}
                            >
                            <span>e.g. (.com)</span>
                        </div>

                        <div class="mb-3">
                            <label>{$_L['Registration Price']}</label>
                            <input class="form-control" name="register"
                                    {if $selected_domain_price}
                                        value="{numberFormatUsingCurrency($selected_domain_price->register,$config['home_currency'])}"
                                    {/if}
                            >
                        </div>
                        <div class="mb-3">
                            <label>{$_L['Transfer Price']}</label>
                            <input class="form-control" name="transfer"
                                    {if $selected_domain_price}
                                        value="{numberFormatUsingCurrency($selected_domain_price->transfer,$config['home_currency'])}"
                                    {/if}
                            >
                        </div>
                        <div class="mb-3">
                            <label>{$_L['Renewal Price']}</label>
                            <input class="form-control" name="renew"
                                    {if $selected_domain_price}
                                        value="{numberFormatUsingCurrency($selected_domain_price->renew,$config['home_currency'])}"
                                    {/if}
                            >
                        </div>
                        <div class="mb-3">
                            <label>{$_L['Registration Provider']}</label>
                            <select class="form-control" name="registration_provider_id">
                                <option value="">--</option>
                                {foreach $domain_registration_providers as $domain_registration_provider}
                                    <option value="{$domain_registration_provider->id}"
                                            {if $selected_domain_price}
                                                {if $selected_domain_price->registration_provider_id === $domain_registration_provider->id}
                                                    selected
                                                {/if}
                                            {/if}
                                    >{$domain_registration_provider->name}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="mb-3">

                            {if $selected_domain_price}
                                <input type="hidden" name="id" value="{$selected_domain_price->id}">
                            {/if}

                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped table-bordered" id="clx_datatable">

                        <thead>
                        <tr>
                            <th>{$_L['Extension']}</th>
                            <th>{$_L['Registration Price']}</th>
                            <th>{$_L['Transfer Price']}</th>
                            <th>{$_L['Renewal Price']}</th>
                            <th>{$_L['Manage']}</th>
                        </tr>
                        </thead>


                        <tbody>
                        {foreach $domain_prices as $domain_price}



                            <tr>
                                <td>
                                    <h4>{$domain_price->extension}</h4>
                                </td>
                                <td>
                                    {formatCurrency($domain_price->register,$config['home_currency'])}
                                </td>
                                <td>
                                    {formatCurrency($domain_price->transfer,$config['home_currency'])}
                                </td>
                                <td>
                                    {formatCurrency($domain_price->renew,$config['home_currency'])}

                                </td>
                                <td>
                                    <a href="{$base_url}hostbilling/domain-pricing/{$domain_price->id}" class="btn btn-primary">{$_L['Edit']}</a>
                                    <a href="javascript:;" onclick="confirmThenGoToUrl(event,'hostbilling/delete-domain-pricing/{$domain_price->id}')" class="btn btn-danger">{$_L['Delete']}</a>
                                </td>
                            </tr>

                        {/foreach}
                        </tbody>




                    </table>
                </div>
            </div>
        </div>
    </div>


{/block}

{block name=script}

    <script>

        $(function () {

            $('#clx_datatable').dataTable(
                {
                    responsive: true,
                    "language": {
                        "emptyTable": "{$_L['No items to display']}",
                        "info":      "{$_L['Showing _START_ to _END_ of _TOTAL_ entries']}",
                        "infoEmpty":      "{$_L['Showing 0 to 0 of 0 entries']}",
                        buttons: {
                            pageLength: '{$_L['Show all']}'
                        },
                        searchPlaceholder: "{__('Search')}"
                    },
                }
            );

            $('#whois_server').select2();

            let $form_save_domain_price = $('#form_save_domain_price');

            $form_save_domain_price.on('submit',function (event) {
                event.preventDefault();

                axios.post(base_url + 'hostbilling/domain-pricing',$form_save_domain_price.serialize()).then(function (response) {

                    location.reload();

                }).catch(function (error) {

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });



            });


        });

    </script>


{/block}
