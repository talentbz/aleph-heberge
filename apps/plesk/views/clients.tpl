{block name="content"}
    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col">
                    <h3>Clients</h3>
                </div>
                <div class="col text-right">
                    <button id="btn_sync_accounts" class="btn btn-primary">Sync Accounts</button>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            <table class="table table-hover" id="clx_datatable">
                <thead>
                <tr>
                    <th>Domain</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Created</th>
                </tr>
                </thead>
                <tbody>

                {foreach $clients as $client}
                    <tr>
                        <td>
                            {if !empty($client['name'])}
                                {$client['name']}
                            {/if}
                        </td>
                        <td>
                            {if !empty($client['login'])}
                                {$client['login']}
                            {/if}
                        </td>
                        <td>
                            {if !empty($client['email'])}
                                {$client['email']}
                            {/if}
                        </td>
                        <td>
                            {if !empty($client['created'])}
                                {date($config['df'],strtotime($client['created']))}
                            {/if}
                        </td>
                    </tr>
                {/foreach}


                </tbody>
            </table>
        </div>
    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            $('#clx_datatable').dataTable(
                {
                    responsive: true,
                }
            );

            let $btn_sync_accounts = $('#btn_sync_accounts');
            $btn_sync_accounts.on('click',function (event) {
                event.preventDefault();

                $btn_sync_accounts.prop('disabled',true);

                $.post(base_url + 'plesk/app/sync-accounts/', {
                    id: {$server->id}
                })
                    .done(function (data) {
                        $btn_sync_accounts.prop('disabled',false);
                        window.location = base_url + 'contacts/list/';
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
