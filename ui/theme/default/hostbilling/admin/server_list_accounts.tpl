{extends file="$layouts_admin"}

{block name="content"}

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col">
                            <h3>{$_L['List Accounts']}</h3>
                        </div>
                        <div class="col text-right">
                            {if $server->type == 'cpanel'}
                                <button id="btn_sync_accounts" class="btn btn-primary">{$_L['Sync Accounts']}</button>
                            {/if}
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    {if $errors}
                        {foreach $errors as $key=>$value}
                            <div class="alert alert-danger">
                                {$value}
                            </div>
                        {/foreach}
                        {else}

                        {if count($accounts) > 0}
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>{$_L['Domain']}</th>
                                    <th>{$_L['Plan']}</th>
                                    <th>{$_L['Email']}</th>
                                    <th>{$_L['Disk Used']}</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $accounts as $account}
                                    <tr>
                                        <td>
                                            {if !empty($account['domain'])}
                                                <strong>{$account['domain']}</strong>
                                            {/if}
                                        </td>
                                        <td>
                                            {if !empty($account['plan'])}
                                                {$account['plan']}
                                            {/if}
                                        </td>
                                        <td>
                                            {if !empty($account['email'])}
                                                {$account['email']}
                                            {/if}
                                        </td>
                                        <td>
                                            {if !empty($account['diskused'])}
                                                {$account['diskused']}
                                            {/if}
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                            {else}
                            <p>No data available.</p>
                        {/if}


                    {/if}
                </div>
            </div>
        </div>
    </div>

{/block}

{block name=script}

    <script>

        $(function () {

            let $btn_sync_accounts = $('#btn_sync_accounts');
            $btn_sync_accounts.on('click',function (event) {
                event.preventDefault();

                $btn_sync_accounts.prop('disabled',true);

                $.post(base_url + 'hostbilling/sync-accounts/', {
                    id: {$server->id}
            })
                .done(function (data) {
                    $btn_sync_accounts.prop('disabled',false);
                    window.location = base_url + 'hostbilling/orders/';
                }).fail(function(data) {
                $btn_sync_accounts.prop('disabled',false);
                let errors = $.parseJSON(data.responseText);
                $.each(errors, function(key, value) {
                    toastr.error(value);
                });
            });

        });

        });


    </script>


{/block}
