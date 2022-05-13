{extends file="$layouts_admin"}

{block name="head"}

<style>
    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #F7F9FC;
    }

    .h2, h2 {
        font-size: 1.25rem;
    }
    .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
        font-family: inherit;
        font-weight: 600;
        line-height: 1.5;
        margin-bottom: .5rem;
        color: #32325d;
    }
    .text-info{
        color: #6772E5!important;
    }
    .text-success{
        color: #2CCE89!important;
    }

    .icon-shape {
        padding: 10px;
        text-align: center;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: .357rem!important;

        font-weight: 600
    }
    .icon {
        width: 2.5rem;
        height: 2.5rem;
        color:#7367F0 ;
    }
    .text-white {
        color: #fff !important;
    }
    .text-white {
        color: #fff !important;
    }
    .shadow {
        box-shadow: 0 0 2rem 0 rgba(136, 152, 170, 0.15) !important;
    }
    .rounded-circle, .avatar.rounded-circle img {
        border-radius: .357rem!important;
    }
    .bg-gradient-red {
        background: linear-gradient(
                87deg
                , #f5365c 0, #f56036 100%) !important;
    }

    .bg-gradient-success {
        background: #E9F9EE !important;
        color: #27C76F;
    }
    .bg-gradient-blue {
        background: linear-gradient(90deg, rgba(10,6,68,1) 0%, rgba(7,13,46,1) 0%, rgba(41,20,110,1) 44%, rgba(35,10,112,1) 50%, rgba(69,28,144,1) 100%, rgba(215,246,247,1) 100%); !important;

    }
    .bg-gradient-pink {
        background: linear-gradient(90deg, rgba(10,6,68,1) 0%, rgba(204,147,5,1) 0%, rgba(189,123,10,1) 100%, rgba(237,227,200,1) 100%, rgba(240,133,219,1) 100%, rgba(215,246,247,1) 100%);

    }
    .bg-gradient-primary {
        background: linear-gradient(
                87deg
                , #5e72e4 0, #825ee4 100%) !important;
    }
    .bg-info {
        background: #EFEDFD !important;
    }
    .clx-avatar {
        display: inline-block;
        font-size: 1.3em;
        width: 42px;
        height: 42px;
        line-height: 2;
        text-align: center;
        border-radius: 0%;
        background: #eee5ff;
        vertical-align: middle;
        color: #a47dfd;
    }
    .text-light {
        color: #ced4da !important;
    }
    .table-info{
        background-color: #EFEDFD;
    }

    .alert-primary .close, .bg-light-primary {
        color: #7367F0!important;
    }




    .user-info-title {
        width: 11.785rem;
    }
</style>
{/block}

{block name="content"}

    <div class="row">
        <!-- User Card starts-->
        <div class="col-md-12">
            <div class="card user-card">
                <div class="card-body" >
                    <h2>{$plan->name} [{$order->tracking_id}]</h2>
                    <div class="hr-line-dashed"></div>
                    <div class="row">
                        <div class="col-xl-6 col-lg-12 mt-2 mt-xl-0">
                            <div class="user-info-wrapper">

                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>



                                        <span class="card-text user-info-title text-muted font-weight-bold mb-0 ml-3">{$_L['Date']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {$order->date}

                                    </p>
                                </div>
                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bookmark"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path></svg>
                                        <span class="card-text user-info-title text-muted  font-weight-bold mb-0 ml-3">{$_L['Tracking Id']}</span>
                                    </div>
                                    <p class="card-text mb-0">{$order->tracking_id}</p>
                                </div>
                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">



                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <span class="card-text user-info-title text-muted  font-weight-bold mb-0 ml-3">{$_L['Client']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {if !empty($contact['account'])}
                                            {$contact['account']}
                                        {/if}
                                    </p>
                                </div>
                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                        <span class="card-text user-info-title text-muted font-weight-bold mb-0 ml-3">{$_L['Address']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {if !empty($contact['address'])}
                                            {$contact['address']}
                                        {/if}

                                    </p>
                                </div>
                                <div class="d-flex flex-wrap mb-2">
                                    <div class="user-info-title text-muted">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map"><polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"></polygon><line x1="8" y1="2" x2="8" y2="18"></line><line x1="16" y1="6" x2="16" y2="22"></line></svg>
                                        <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['City']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {if !empty($contact['city'])}
                                            {$contact['city']}
                                        {/if}
                                    </p>
                                </div>
                                <div class="d-flex flex-wrap mb-2">
                                    <div class="user-info-title text-muted">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-flag"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"></path><line x1="4" y1="22" x2="4" y2="15"></line></svg>

                                        <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['Country']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {if !empty($contact['country'])}
                                            {$contact['country']}
                                        {/if}
                                    </p>
                                </div>

                            </div>

                        </div>
                        <div class="col-xl-6 col-lg-12 mt-2 mt-xl-0">
                            <div class="user-info-wrapper">


                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">


                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-credit-card"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
                                        <span class="card-text user-info-title text-muted  font-weight-bold mb-0 ml-3">{$_L['Amount']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {$order->total}
                                    </p>
                                </div>
                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">


                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-compass"><circle cx="12" cy="12" r="10"></circle><polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"></polygon></svg>
                                        <span class="card-text user-info-title text-muted  font-weight-bold mb-0 ml-3">{$_L['Invoice Number']}</span>
                                    </div>
                                    <p class="card-text mb-0">{$order->invoice_id}</p>
                                </div>
                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">


                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layers"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>
                                        <span class="card-text user-info-title text-muted font-weight-bold mb-0 ml-3">{$_L['Status']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {cloudonex_get_order_status_with_badge($order->status)}
                                       </p>
                                </div>
                                <div class="d-flex flex-wrap mb-2">
                                    <div class="user-info-title text-muted">


                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-tag"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
                                        <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['Type']}</span>
                                    </div>
                                    <p class="card-text mb-0">{{__($order->type)}}</p>
                                </div>
                                <div class="d-flex flex-wrap mb-2">
                                    <div class="user-info-title text-muted">


                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-database"><ellipse cx="12" cy="5" rx="9" ry="3"></ellipse><path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"></path><path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path></svg>

                                        <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['Domain']}</span>
                                    </div>
                                    <p class="card-text mb-0">{$order->domain}</p>
                                </div>

                            </div>

                        </div>
                    </div>

                    <div class="hr-line-dashed"></div>

                    {if $order->status != 'Active'}
                        <a href="{$base_url}hostbilling/set-order-status/{$order->id}/approve" class="btn btn-primary">{$_L['Approve Order']}</a>
                    {/if}

                    {if $order->status != 'Pending'}
                        <a href="{$base_url}hostbilling/set-order-status/{$order->id}/pending" class="btn btn-primary">{$_L['Set Pending']}</a>
                    {/if}

                    {if $order->status != 'Cancelled'}
                        <a href="{$base_url}hostbilling/set-order-status/{$order->id}/cancel" class="btn btn-primary">{$_L['Cancel Order']}</a>
                    {/if}

                    {if $order->status != 'Fraud' and $order->status != 'Active'}
                        <a href="{$base_url}hostbilling/set-order-status/{$order->id}/fraud" class="btn btn-primary">{$_L['Set as Fraud']}</a>
                    {/if}


                    <a href="javascript:;" onclick="confirmThenGoToUrl(event,'hostbilling/delete-order/{$order->id}');" class="btn btn-danger">{$_L['Delete Order']}</a>


                    {if $order->status == 'Active'}

                        <div class="hr-line-dashed"></div>



                        <div class="row">
                            <div class="col-md-4">

                                <h3>{$_L['Automations']}</h3>

                                <hr>

                                <div class="mb-3">
                                    <label>{$_L['Automation Server']}</label>
                                    <select class="custom-select" id="automation_server">
                                        <option value="">{__('None')}</option>
                                        {foreach $hosting_servers as $hosting_server}
                                            <option value="{$hosting_server->id}"
                                            {if $hosting_server->id === $order->server_id}
                                                selected
                                                {elseif !empty($server) && $server->id == $hosting_server->id}
                                                selected
                                            {/if}
                                            >{$hosting_server->name}</option>
                                        {/foreach}
                                    </select>
                                </div>

                                {if !$order->automation_run}

                                    {if $server}


                                        <form id="form_automation">

                                            <h4 class="mb-3">{$server->name}</h4>




                                            {if $server->type === 'cpanel'}
                                                <h5 class="mb-3">cPanel</h5>

                                                <div class="mb-3">
                                                    <label>{$_L['Domain']}</label>
                                                    <input class="form-control" id="automation_input_domain" value="{$order->domain}" name="domain">
                                                </div>

                                                <div class="mb-3">
                                                    <label>{$_L['Username']}</label>
                                                    <input class="form-control" id="automation_input_username" name="username">
                                                </div>
                                                <div class="mb-3">
                                                    <label>{$_L['Email']}</label>
                                                    <input class="form-control" name="email" value="{if !empty($contact->email)}{$contact->email}{/if}">
                                                </div>
                                                <div class="mb-3">
                                                    <label>{$_L['Password']}</label>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" name="password" id="automation_input_password" aria-label="Password" aria-describedby="btn_regenerate_password">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-outline-default waves-effect waves-themed" type="button" id="btn_regenerate_password">{$_L['Regenerate Password']}</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label>{__('Package')}</label>
                                                    <input class="form-control" value="{$plan->api_name}" name="plan">
                                                </div>


                                                {elseif $server->type === 'directadmin'}

                                                    <h5 class="mb-3">DirectAdmin</h5>

                                                    <div class="mb-3">
                                                        <label>{$_L['Domain']}</label>
                                                        <input class="form-control" id="automation_input_domain" value="{$order->domain}" name="domain">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label>{$_L['Username']}</label>
                                                        <input class="form-control" id="automation_input_username" name="username">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label>{$_L['Email']}</label>
                                                        <input class="form-control" name="email" value="{if !empty($contact->email)}{$contact->email}{/if}">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label>{$_L['Password']}</label>
                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="password" id="automation_input_password" aria-label="Password" aria-describedby="btn_regenerate_password">
                                                            <div class="input-group-append">
                                                                <button class="btn btn-outline-default waves-effect waves-themed" type="button" id="btn_regenerate_password">{$_L['Regenerate Password']}</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label>{__('Package')}</label>
                                                        <input class="form-control" value="{$plan->api_name}" name="plan">
                                                    </div>


                                                <div class="mb-3">
                                                    <label>{__('IP')}</label>
                                                    <input class="form-control" value="{$server->host}" name="ip">
                                                </div>


                                            {else}

                                                {if !empty($form_fields['domain'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['domain']['label']}</label>
                                                        <input class="form-control" id="automation_input_domain" value="{$order->domain}" name="domain">
                                                    </div>


                                                {/if}

                                                {if !empty($form_fields['first_name'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['first_name']['label']}</label>
                                                        <input class="form-control" value="{$contact['first_name']}" name="first_name">
                                                        {if !empty($form_fields['first_name']['help_block'])}
                                                            <p>{$form_fields['first_name']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['last_name'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['last_name']['label']}</label>
                                                        <input class="form-control" value="{$contact['last_name']}" name="last_name">
                                                        {if !empty($form_fields['last_name']['help_block'])}
                                                            <p>{$form_fields['last_name']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['address'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['address']['label']}</label>
                                                        <input class="form-control"
                                                               {if !empty($contact['address'])}
                                                                   value="{$contact['address']}"
                                                                   {elseif !empty($form_fields['address']['default'])}
                                                                   value="{$form_fields['address']['default']}"
                                                               {/if}
                                                               name="address">
                                                        {if !empty($form_fields['address']['help_block'])}
                                                            <p>{$form_fields['address']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['city'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['city']['label']}</label>
                                                        <input class="form-control"
                                                                {if !empty($contact['city'])}
                                                                    value="{$contact['city']}"
                                                                {elseif !empty($form_fields['city']['default'])}
                                                                    value="{$form_fields['city']['default']}"
                                                                {/if}
                                                               name="city">
                                                        {if !empty($form_fields['city']['help_block'])}
                                                            <p>{$form_fields['city']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['state'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['state']['label']}</label>
                                                        <input class="form-control"
                                                                {if !empty($contact['state'])}
                                                                    value="{$contact['state']}"
                                                                {elseif !empty($form_fields['state']['default'])}
                                                                    value="{$form_fields['state']['default']}"
                                                                {/if}
                                                               name="state">
                                                        {if !empty($form_fields['state']['help_block'])}
                                                            <p>{$form_fields['state']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['zip'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['zip']['label']}</label>
                                                        <input class="form-control"
                                                                {if !empty($contact['zip'])}
                                                                    value="{$contact['zip']}"
                                                                {elseif !empty($form_fields['zip']['default'])}
                                                                    value="{$form_fields['zip']['default']}"
                                                                {/if}
                                                               name="zip">
                                                        {if !empty($form_fields['zip']['help_block'])}
                                                            <p>{$form_fields['zip']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['country'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['country']['label']}</label>
                                                        <input class="form-control"
                                                                {if !empty($contact['country'])}
                                                                    value="{$contact['country']}"
                                                                {elseif !empty($form_fields['country']['default'])}
                                                                    value="{$form_fields['country']['default']}"
                                                                {/if}
                                                               name="country">
                                                        {if !empty($form_fields['country']['help_block'])}
                                                            <p>{$form_fields['country']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['email'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['email']['label']}</label>
                                                        <input class="form-control" value="{$contact['email']}" name="email">
                                                        {if !empty($form_fields['email']['help_block'])}
                                                            <p>{$form_fields['email']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['phone'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['phone']['label']}</label>
                                                        <input class="form-control"
                                                                {if !empty($contact['phone'])}
                                                                    value="{$contact['phone']}"
                                                                {elseif !empty($form_fields['phone']['default'])}
                                                                    value="{$form_fields['phone']['default']}"
                                                                {/if}
                                                               name="phone">
                                                        {if !empty($form_fields['phone']['help_block'])}
                                                            <p>{$form_fields['phone']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['username'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['username']['label']}</label>
                                                        <input class="form-control" value="{$order->username}" name="username">
                                                        {if !empty($form_fields['username']['help_block'])}
                                                            <p>{$form_fields['username']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}

                                                {if !empty($form_fields['password'])}

                                                    <label>{$form_fields['password']['label']}</label>

                                                    {if $order->password}

                                                        <div class="mb-3">

                                                            <input class="form-control" value="{$order->password}" name="password">
                                                            {if !empty($form_fields['password']['help_block'])}
                                                                <p>{$form_fields['password']['help_block']}</p>
                                                            {/if}

                                                        </div>

                                                        {else}

                                                        <div class="input-group">
                                                            <input type="text" class="form-control" name="password" id="automation_input_password" aria-label="Password" aria-describedby="btn_regenerate_password">
                                                            <div class="input-group-append">
                                                                <button class="btn btn-outline-default waves-effect waves-themed" type="button" id="btn_regenerate_password">{$_L['Regenerate Password']}</button>
                                                            </div>
                                                        </div>
                                                    {/if}





                                                {/if}

                                                {if !empty($form_fields['plan'])}

                                                    <div class="mb-3">
                                                        <label>{$form_fields['plan']['label']}</label>
                                                        <input class="form-control" value="{$plan->api_name}" name="plan">
                                                        {if !empty($form_fields['plan']['help_block'])}
                                                        <p>{$form_fields['plan']['help_block']}</p>
                                                        {/if}

                                                    </div>

                                                {/if}



                                            {/if}

                                            <button class="btn btn-primary" id="btn_automation_create_account">{$_L['Create Account']}</button>

                                            <input type="hidden" name="order_id" value="{$order->id}">
                                            <input type="hidden" name="action" value="create_account">

                                        </form>





                                        {else}

                                        <p> {$_L['No server/hosting provider is defined for this Hosting Plan,']}
                                             <br>
                                            {if $plan}
                                                <a href="{$base_url}hostbilling/hosting/{$plan->id}/">{$_L['Edit Hosting Plan']}</a>
                                            {/if}
                                        </p>

                                    {/if}



                                    {else}




                                    <h5>{$_L['Client Credentials']}</h5>

                                    <div class="hr-line-dashed"></div>

                                    {if !empty($order->login_url)}
                                        <p>
                                            <a href="{$order->login_url}" target="_blank">{$order->login_url}</a>
                                        </p>
                                    {/if}

                                    {if !empty($order->username)}
                                        <div class="mb-3">
                                            <label>{$_L['Username']}</label>
                                            <input class="form-control" value="{$order->username}">
                                        </div>
                                    {/if}

                                    {if !empty($order->password)}
                                        <div class="mb-3">
                                            <label>{$_L['Password']}</label>
                                            <input class="form-control" value="{$order->password}">
                                        </div>
                                    {/if}

                                {/if}


                            </div>

                            <div class="col-md-8">
                                <h4>{$_L['Order']}</h4>
                                <hr>
                                <form method="post" id="form_main">

                                    <div class="mb-3">
                                        <label for="login_type">{$_L['Type']}</label>
                                        <select class="custom-select" name="login_type" id="login_type">
                                            <option value="">{__('None')}</option>
                                            {foreach $supported_server_types as $key => $value}
                                                <option value="{$key}"

                                                        {if $order->login_type == $key}
                                                            selected
                                                        {/if}

                                                >{$value['name']}</option>
                                            {/foreach}
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="login_url">{__('URL')}</label>
                                        <input class="form-control" value="{$order->login_url}" name="login_url" id="login_url">
                                    </div>

                                    <div class="mb-3">
                                        <label for="hosting_order_username">{__('Username')}</label>
                                        <input class="form-control" value="{$order->username}" name="username" id="hosting_order_username">
                                    </div>

                                    <div class="mb-3">
                                        <label for="hosting_order_password">{__('Password')}</label>
                                        <input class="form-control" value="{$order->password}" name="password" id="hosting_order_password">
                                    </div>


                                    <h5 class="my-3">{__('Activation Message')}</h5>
                                    <div class="mb-3">
                                        <label for="activation_subject">{$_L['Subject']}</label>
                                        <input type="text" class="form-control" id="activation_subject" name="activation_subject" value="{$order->activation_subject}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="activation_message">{$_L['Message']}</label>
                                        <textarea class="form-control" id="activation_message" name="activation_message" rows="3">{$order->activation_message}</textarea>
                                    </div>

                                    <input type="hidden" name="order_id" id="order_id" value="{$order->id}">

                                    <button type="submit" id="btn_activation_message_save" class="btn btn-primary">{$_L['Save']}</button>
                                    <button type="submit" id="btn_activation_message_send" class="btn btn-danger">{$_L['Send']}</button>

                                </form>
                            </div>
                        </div>



                    {/if}






                </div>
            </div>

        </div>

    </div>


{/block}

{block name=script}

    <script>

        function generateRandomPassword(letters, numbers, either) {
            let chars = [
                "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", // letters
                "0123456789", // numbers
                "*@#" // either
            ];

            return [letters, numbers, either].map(function(len, i) {
                return Array(len).fill(chars[i]).map(function(x) {
                    return x[Math.floor(Math.random() * x.length)];
                }).join('');
            }).concat().join('').split('').sort(function(){
                return 0.5-Math.random();
            }).join('')
        }

        $(function () {
            $('#activation_message').redactor(
                {
                    minHeight: 200
                }
            );

            let $btn_activation_message_save = $('#btn_activation_message_save');
            let $btn_activation_message_send = $('#btn_activation_message_send');
            let $form_main = $('#form_main');

            $btn_activation_message_save.on('click',function (event) {
                event.preventDefault();
                $btn_activation_message_save.prop('disabled',true);
                axios.post(base_url + 'hostbilling/save-order',$form_main.serialize()).then(function (response) {
                    $btn_activation_message_save.prop('disabled',false);

                    toastr.success('Saved.');

                }).catch(function (error) {

                    $btn_activation_message_save.prop('disabled',false);

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });
            });

            $btn_activation_message_send.on('click',function (event) {
                event.preventDefault();
                $btn_activation_message_send.prop('disabled',true);
                axios.post(base_url + 'hostbilling/save-and-send-order-email',$form_main.serialize()).then(function (response) {
                    $btn_activation_message_send.prop('disabled',false);

                    toastr.success('Email Sent.');

                }).catch(function (error) {

                    $btn_activation_message_send.prop('disabled',false);

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });
            });

            let $btn_automation_create_account = $('#btn_automation_create_account');
            let $form_automation = $('#form_automation');

            $form_automation.on('submit',function (event) {
                event.preventDefault();
                $btn_automation_create_account.prop('disabled',true);
                $.post(base_url + 'hostbilling/run-automation', $form_automation.serialize())
                    .done(function (data) {
                        $btn_automation_create_account.prop('disabled',false);
                        location.reload();
                    }).fail(function(data) {
                    $btn_automation_create_account.prop('disabled',false);
                    let errors = $.parseJSON(data.responseText);
                    $.each(errors, function(key, value) {
                        toastr.error(value);
                    });
                });



            });



            let $btn_regenerate_password = $('#btn_regenerate_password');
            let $automation_input_password = $('#automation_input_password');
            $automation_input_password.val(generateRandomPassword(8,3,2));
            $btn_regenerate_password.on('click',function () {
                $automation_input_password.val(generateRandomPassword(8,3,2));
            });

            let $automation_input_domain = $('#automation_input_domain');
            let $automation_input_username = $('#automation_input_username');

            if($automation_input_domain.val())
                {
                    $automation_input_username.val($automation_input_domain.val().split('.')[0].substring(0,8));
                }

            let $automation_server = $('#automation_server');
            $automation_server.on('change',function () {
                $.post(base_url + 'hostbilling/change-automation-server-for-order', {
                    order_id: {$order->id},
                    server_id: $automation_server.val(),
                })
                    .done(function (data) {

                        toastr.success('Updated!');

                    }).fail(function(data) {
                    toastr.error('Unable to change!');
                });
            });




        });

    </script>


{/block}
