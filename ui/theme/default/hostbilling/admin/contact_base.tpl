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
            padding: 12px;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        .icon {
            width: 3rem;
            height: 3rem;
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
            border-radius: 50% !important;
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
        .bg-gradient-warning {
            background: #FFF4E9 !important;
            color: #FF9F43;
        }
        .bg-gradient-info{
            background: #E8F9FD !important;
            color: #E8F9FD;
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
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 flex-column justify-content-between border-container-lg">
                        <div class="user-avatar-section ">
                            <div class="d-flex justify-content-start">


                                <div class="thumb-info mb-md">
                                    {if $contact['img'] eq 'gravatar'}
                                        <img src="http://www.gravatar.com/avatar/{($contact['email'])|md5}?s=400"  style="max-width: 120px; class="img-thumbnail img-responsive" alt="{$contact['fname']} {$contact['lname']}">
                                    {elseif $contact['img'] eq ''}
                                        <img src="{$app_url}storage/system/profile-icon.png" class="img-thumbnail img-fluid" alt="{$contact['fname']} {$contact['lname']}">
                                    {else}
                                        <img src="{{APP_URL}}/{$contact['img']}" class="img-thumbnail img-fluid" style="font-size: 50px; alt="{$contact['fname']} {$contact['lname']}">
                                    {/if}
                                    <div class="thumb-info-title">
                                        <span class="thumb-info-inner">{$contact['fname']} {$contact['lname']}</span>

                                    </div>

                                    <div class="user-info mt-3">
                                        <h4 class="mb-0">{$contact->account}</h4>
                                        <span class="card-text">{$contact->email}</span>
                                    </div>
                                </div>



                            </div>
                        </div>
                        <div class="d-flex flex-wrap align-items-center user-total-numbers mt-4">
                            <div class="d-flex align-items-center mr-2">
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-info text-white rounded-circle shadow">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#7367F0" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-phone"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>

                                    </div>
                                </div>
                                <div class="ml-1">
                                    <h5 class="mb-0">{$tickets_count}</h5>
                                    <small>{$_L['Tickets']}</small>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#27C76F" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-credit-card"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>


                                    </div>
                                </div>
                                <div class="ml-1">
                                    <h5 class="mb-0">{$invoices_count}</h5>
                                    <small>{$_L['Invoices']}</small>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow">


                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#07CFE7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-dollar-sign"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
                                    </div>
                                </div>
                                <div class="ml-1">
                                    <h5 class="mb-0">{$quotes_count}</h5>
                                    <small>{$_L['Total Quotes']} </small>
                                </div>
                            </div>

                        </div>

                        {if $config['add_fund'] eq '1'}
                            <hr>

                            <h3>{$_L['Balance']} : <span class="amount">{{formatCurrency($contact->balance,$config['home_currency'])}}</span></h3>
                            <a href="javascript:void(0)" class="btn btn-primary add_fund">{$_L['Add Fund']}</a>
                            <a href="javascript:void(0)" class="btn btn-danger return_fund">{$_L['Return Fund']}</a>
                        {/if}
                    </div>
                    <div class="col-xl-6 col-lg-12 mt-2 mt-xl-0">
                        <div class="user-info-wrapper">

                            <div class="d-flex flex-wrap my-50 mb-2">
                                <div class="user-info-title text-muted">

                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                                    <span class="card-text user-info-title text-muted font-weight-bold mb-0 ml-3">{$_L['Company Name']}</span>
                                </div>
                                <p class="card-text mb-0">
                                    {$contact->company}

                                </p>
                            </div>
                            <div class="d-flex flex-wrap my-50 mb-2">
                                <div class="user-info-title text-muted">

                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bookmark"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path></svg>
                                    <span class="card-text user-info-title text-muted  font-weight-bold mb-0 ml-3">{$_L['Tags']}</span>
                                </div>
                                <p class="card-text mb-0">
                                    {$contact->tags}
                                </p>
                            </div>
                            <div class="d-flex flex-wrap my-50 mb-2">
                                <div class="user-info-title text-muted">


                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-compass"><circle cx="12" cy="12" r="10"></circle><polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"></polygon></svg>
                                    <span class="card-text user-info-title text-muted  font-weight-bold mb-0 ml-3">{$_L['Group']}</span>
                                </div>
                                <p class="card-text mb-0">
                                    {$contact->gname}
                                </p>
                            </div>
                            <div class="d-flex flex-wrap my-50 mb-2">
                                <div class="user-info-title text-muted">

                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                    <span class="card-text user-info-title text-muted font-weight-bold mb-0 ml-3">{$_L['Address']}</span>
                                </div>
                                <p class="card-text mb-0">{$contact->address}</p>
                            </div>
                            <div class="d-flex flex-wrap mb-2">
                                <div class="user-info-title text-muted">

                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map"><polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"></polygon><line x1="8" y1="2" x2="8" y2="18"></line><line x1="16" y1="6" x2="16" y2="22"></line></svg>
                                    <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3"></span>
                                </div>
                                <p class="card-text mb-0">{$contact->city}</p>
                            </div>
                            <div class="d-flex flex-wrap mb-2">
                                <div class="user-info-title text-muted">

                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-flag"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"></path><line x1="4" y1="22" x2="4" y2="15"></line></svg>

                                    <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['Country']}</span>
                                </div>
                                <p class="card-text mb-0">{$contact->country}</p>
                            </div>

                        </div>
                        {if $config['client_dashboard'] eq '1'}
                            <hr>

                            {if $contact->autologin neq ''}
                                <form class="form-horizontal" method="post">
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="form-group h5">
                                                <label for="auto_login_url">{$_L['Auto Login URL']}</label>
                                                <input class="form-control" type="text" id="auto_login_url" name="auto_login_url" value="{$_url}client/autologin/{$contact->autologin}">
                                            </div>
                                            <p class="help-block">
                                                <a class="h6 text-info" href="{$_url}client/autologin/{$contact->autologin}" target="_blank">{$_L['Login As Customer']}</a> |
                                                <a href="{$_url}contacts/revoke_auto_login/{$contact->id}/">{$_L['Revoke Auto Login']}</a> |
                                                <a href="{$_url}contacts/gen_auto_login/{$contact->id}/">{$_L['Re Generate URL']}</a>
                                            </p>
                                        </div>
                                    </div>

                                </form>



                            {else}
                                <a href="{$_url}contacts/gen_auto_login/{$contact->id}/" class="md-btn md-btn-primary"> {$_L['Create Auto Login URL']}</a>
                            {/if}
                        {/if}
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

<div class="row">
    <div class="col-md-12">
        <div  class="card mt-3">

            <div class="card-body">
                <div class="panel-content">

                    <ul class="nav nav-pills nav-justified">
                        <li class="nav-item"><a class="nav-link {if $tab == 'orders'}active{/if}" href="{$base_url}contacts/view/{$contact->id}/orders/"><strong>{$_L['Hosting Orders']}</strong></a></li>
                        <li class="nav-item"><a class="nav-link {if $tab == 'domains'}active{/if}" href="{$base_url}contacts/view/{$contact->id}/domains/"><strong>{$_L['Domain Orders']}</strong></a></li>
                        <li class="nav-item"><a class="nav-link {if $tab == 'tickets'}active{/if}" href="{$base_url}contacts/view/{$contact->id}/tickets/"><strong>{$_L['Tickets']}</strong></a></li>
                        <li class="nav-item"><a class="nav-link {if $tab == 'invoices'}active{/if}" href="{$base_url}contacts/view/{$contact->id}/invoices/"><strong>{$_L['Invoices']}</strong></a></li>
                        <li class="nav-item"><a class="nav-link {if $tab == 'quotes'}active{/if}" href="{$base_url}contacts/view/{$contact->id}/quotes/"><strong>{$_L['Quotes']}</strong></a></li>
                        <li class="nav-item"><a class="nav-link {if $tab == 'edit'}active{/if}" href="{$base_url}contacts/view/{$contact->id}/edit/"><strong>{$_L['Edit']}</strong></a></li>


                    </ul>
                    <div class="tab-content py-3">
                        <div class="tab-pane fade show active">
                            {block name="inner_content"}{/block}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




    {/block}




    {block name=script}

        <script>

            $(function () {

                $('.add_fund').on('click',function (e) {
                    e.preventDefault();

                    bootbox.prompt({
                        title: "Add Fund",
                        value: "",
                        buttons: {
                            'cancel': {
                                label: 'Cancel'
                            },
                            'confirm': {
                                label: 'OK'
                            }
                        },
                        callback: function(result) {
                            if (result === null) {

                            } else {

                                $.redirectPost(base_url + "contacts/add_fund/",{ amount: result, cid: '{$contact->id}' });

                            }
                        }
                    });
                });


                $('.return_fund').on('click',function (e) {
                    e.preventDefault();

                    bootbox.prompt({
                        title: "Return Fund",
                        value: "",
                        buttons: {
                            'cancel': {
                                label: 'Cancel'
                            },
                            'confirm': {
                                label: 'OK'
                            }
                        },
                        callback: function(result) {
                            if (result === null) {

                            } else {
                                $.redirectPost(base_url + "contacts/return_fund/",{ amount: result, cid: '{$contact->id}' });

                            }
                        }
                    });
                });



            });

        </script>


    {/block}
