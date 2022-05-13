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
                    <div class="row">
                        <div class="col-xl-6 col-lg-12 mt-2 mt-xl-0">
                            <div class="user-info-wrapper">

                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>



                                        <span class="card-text user-info-title text-muted font-weight-bold mb-0 ml-3">{$_L['Date']} </span>
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

                                        {if isset($contacts[$order->contact_id])}
                                            {$contacts[$order->contact_id]->account}
                                        {/if}
                                    </p>
                                </div>
                                <div class="d-flex flex-wrap my-50 mb-2">
                                    <div class="user-info-title text-muted">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                        <span class="card-text user-info-title text-muted font-weight-bold mb-0 ml-3">{$_L['Address']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {if isset($contacts[$order->contact_id])}
                                            {$contacts[$order->contact_id]->address}
                                        {/if}

                                    </p>
                                </div>
                                <div class="d-flex flex-wrap mb-2">
                                    <div class="user-info-title text-muted">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map"><polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"></polygon><line x1="8" y1="2" x2="8" y2="18"></line><line x1="16" y1="6" x2="16" y2="22"></line></svg>
                                        <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['City']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {if isset($contacts[$order->contact_id])}
                                            {$contacts[$order->contact_id]->city}
                                        {/if}
                                    </p>
                                </div>
                                <div class="d-flex flex-wrap mb-2">
                                    <div class="user-info-title text-muted">

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-flag"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"></path><line x1="4" y1="22" x2="4" y2="15"></line></svg>

                                        <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['Country']}</span>
                                    </div>
                                    <p class="card-text mb-0">
                                        {if isset($contacts[$order->contact_id])}
                                            {$contacts[$order->contact_id]->country}
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
                                    <p class="card-text mb-0"><span class="badge badge-secondary"> {$order->status}</span>
                                    </p>
                                </div>
                                <div class="d-flex flex-wrap mb-2">
                                    <div class="user-info-title text-muted">


                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-tag"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
                                        <span class="card-text user-info-title  text-muted font-weight-bold mb-0 ml-3">{$_L['Type']}</span>
                                    </div>
                                    <p class="card-text mb-0">{$order->type}</p>
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
                        <a href="{$base_url}hostbilling/set-domain-order-status/{$order->id}/approve" class="btn btn-primary">{$_L['Approve Order']}</a>
                    {/if}

                    {if $order->status != 'Pending'}
                        <a href="{$base_url}hostbilling/set-domain-order-status/{$order->id}/pending" class="btn btn-primary">{$_L['Set Pending']}</a>
                    {/if}

                    {if $order->status != 'Cancelled'}
                        <a href="{$base_url}hostbilling/set-domain-order-status/{$order->id}/cancel" class="btn btn-primary">{$_L['Cancel Order']}</a>
                    {/if}

                    {if $order->status != 'Fraud' and $order->status != 'Active'}
                        <a href="{$base_url}hostbilling/set-domain-order-status/{$order->id}/fraud" class="btn btn-primary">{$_L['Set as Fraud']}</a>
                    {/if}

                    <a href="javascript:;" onclick="confirmThenGoToUrl(event,'hostbilling/delete-domain-order/{$order->id}');" class="btn btn-danger">{$_L['Delete Order']}</a>

                    <div class="hr-line-dashed"></div>

                    {if $order->status == 'Active'}

                        <div class="hr-line-dashed"></div>



                        <div class="row">
                            <div class="col-md-4">

                                <h4>{$_L['Automation']}</h4>
                                <hr>

                                <p>{$_L['No automation is configured.']}</p>

                            </div>
                            <div class="col-md-8">
                                <h4>{$_L['Activation Message']}</h4>
                                <hr>
                                <form method="post" id="form_main">
                                    <div class="form-group">
                                        <label for="activation_subject">{$_L['Subject']}</label>
                                        <input type="text" class="form-control" id="activation_subject" name="activation_subject" value="{$order->activation_subject}">
                                    </div>
                                    <div class="form-group">
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
                axios.post(base_url + 'hostbilling/save-domain-order',$form_main.serialize()).then(function (response) {
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

        });

    </script>


{/block}
