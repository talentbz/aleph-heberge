{extends file="hostbilling/layouts/new_base/base.tpl"}




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
            background: linear-gradient(
                    87deg
                    , #2dce89 0, #2dcecc 100%) !important;
        }
        .bg-gradient-info {
            background: linear-gradient(
                    87deg
                    , #11cdef 0, #1171ef 100%) !important;
        }

        .bg-gradient-blue {
            background: linear-gradient(90deg, rgba(10,6,68,1) 0%, rgba(7,13,46,1) 0%, rgba(41,20,110,1) 44%, rgba(35,10,112,1) 50%, rgba(69,28,144,1) 100%, rgba(215,246,247,1) 100%); !important;

        }
        .bg-gradient-pink {
            background: linear-gradient(90deg, rgba(10,6,68,1) 0%, rgba(204,147,5,1) 0%, rgba(189,123,10,1) 100%, rgba(237,227,200,1) 100%, rgba(240,133,219,1) 100%, rgba(215,246,247,1) 100%);

        }






    </style>
{/block}


{block name="new_content"}
<main id="clx-page-content" role="main" class="page-content">





    <div class="row">

        <div class="col-md-4 ">
            <div class="card">


                <div class="card-body">
                    <div class="text-center">

                        {if $user->img}
                            <img src="{{APP_URL}}/{{$user->img}}" style="max-width: 130px;"class="rounded-circle m-t-xs img-fluid avatar-xl mb-4" alt="{$user->fullname}">
                        {else}
                            <img src="{{APP_URL}}/ui/lib/img/default-user-avatar.png" class="rounded-circle shadow-2 img-thumbnail" alt="{$user->fullname}">
                        {/if}


                        <h3 class="h2">{$user->account}</h3>



                        <address>

                            <br>


                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="28px" height="28px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="30" height="30"/>
                                    <path d="M11.914857,14.1427403 L14.1188827,11.9387145 C14.7276032,11.329994 14.8785122,10.4000511 14.4935235,9.63007378 L14.3686433,9.38031323 C13.9836546,8.61033591 14.1345636,7.680393 14.7432841,7.07167248 L17.4760882,4.33886839 C17.6713503,4.14360624 17.9879328,4.14360624 18.183195,4.33886839 C18.2211956,4.37686904 18.2528214,4.42074752 18.2768552,4.46881498 L19.3808309,6.67676638 C20.2253855,8.3658756 19.8943345,10.4059034 18.5589765,11.7412615 L12.560151,17.740087 C11.1066115,19.1936265 8.95659008,19.7011777 7.00646221,19.0511351 L4.5919826,18.2463085 C4.33001094,18.1589846 4.18843095,17.8758246 4.27575484,17.613853 C4.30030124,17.5402138 4.34165566,17.4733009 4.39654309,17.4184135 L7.04781491,14.7671417 C7.65653544,14.1584211 8.58647835,14.0075122 9.35645567,14.3925008 L9.60621621,14.5173811 C10.3761935,14.9023698 11.3061364,14.7514608 11.914857,14.1427403 Z" fill="#000000"/>
                                </g>
                            </svg>
                            <span class="text-info h5"> {$user->phone}</span>




                            <br>

                            <span class="h5">{$user->email}</span>
                            <br>
                            {if $config['show_business_number'] eq '1'}
                                <br>

                                <strong class="h6">{$config['label_business_number']}</strong> {$user->business_number}


                            {/if}


                            <div class="mt-3">
                                {if $user->company neq ''}
                                    {$user->company}
                                    <br>

                                {/if}
                                {$user->address} <br>
                                {$user->city} <br>
                                {$user->state} - {$user->zip} <br>
                                {$user->country}
                            </div>





                        </address>


                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-3">
                    <a href="{$base_url}client/hosting-orders/">
                        <div class="card card-stats">
                            <!-- Card body -->
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">{__('Services')}</h5>
                                        <span class="h2 font-weight-bold mb-0">{$hosting_orders_count}</span>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-gradient-blue text-white rounded-circle shadow">
                                            <i class="fal fa-database fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="{$base_url}client/tickets/all">
                        <div class="card card-stats">
                            <!-- Card body -->
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">{__('Tickets')}</h5>
                                        <span class="h2 font-weight-bold mb-0">{$tickets_count}</span>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">
                                            <i class="fal fa-phone fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>

                </div>
                <div class="col-md-3">
                    <a href="{$base_url}client/invoices/">
                        <div class="card card-stats">
                            <!-- Card body -->
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0"> {$_L['Invoices']}</h5>
                                        <span class="h2 font-weight-bold mb-0">{$invoices_count}</span>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-gradient-pink text-white rounded-circle shadow">
                                            <i class="fal fa-credit-card fa-2x"></i>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="{$base_url}client/domain-orders/">
                        <div class="card card-stats">
                            <!-- Card body -->
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0">{__('Domains')}</h5>
                                        <span class="h2 font-weight-bold mb-0">{$domains_count}</span>
                                    </div>
                                    <div class="col-auto">
                                        <div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow">
                                            <i class="fal fa-arrow-alt-right fa-2x"></i>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </a>
                </div>

            </div>
            <div class="card mt-3">
                <div class="card-header">


                    <h2>{$_L['Recent Invoices']}</h2>


                </div>
                <div class="card-body">
                    <div class="table-responsive">

                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>{$_L['Invoice']}</th>
                                <th>{$_L['Status']}</th>
                                <th>{$_L['Created']}</th>
                            </tr>
                            </thead>
                            <tbody>

                            {foreach $invoices as $recent_invoice}

                                <tr>
                                    <td>
                                        <a target="_blank" href="{$base_url}client/iview/{$recent_invoice->id}/token_{$recent_invoice->vtoken}/">
                                            {cloudonex_get_invoice_number($recent_invoice)}
                                        </a>
                                    </td>
                                    <td>
                                        {cloudonex_get_invoice_status_with_badge($recent_invoice->status)}
                                    </td>
                                    <td>
                                        {date( $config['df'], strtotime($recent_invoice->date))}
                                    </td>
                                </tr>

                            {/foreach}


                            </tbody>
                        </table>

                    </div>
                </div>

            </div>





        </div>





    </div>




    <div class="row mt-3">

        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Recent Orders']}</h3>
                    <div class="hr-line-dashed"></div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>{$_L['Order']}</th>
                            <th> {$_L['Domain']}</th>
                            <th>{$_L['Date']}</th>
                            <th>{$_L['Total']}</th>
                            <th>{$_L['Status']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $recent_orders as $recent_order}

                            <tr>
                                <td>
                                    <a href="{$base_url}client/view-order/{$recent_order->id}/" class="font-weight-bold">
                                        {$recent_order->tracking_id|escape}
                                    </a>
                                </td>
                                <td>
                                    {{$recent_order->domain|escape}}
                                </td>
                                <td>
                                    {date( $config['df'], strtotime($recent_order->created_at))}
                                </td>
                                <td>
                                    {formatCurrency($recent_order->total,$config['home_currency'])}
                                </td>
                                <td>
                                    {cloudonex_get_order_status_with_badge($recent_order->status)}
                                </td>
                            </tr>


                        {/foreach}

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Recent Domains']}</h3>
                    <div class="hr-line-dashed"></div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>{$_L['Order']}</th>
                            <th>{$_L['Domain']}</th>
                            <th>{$_L['Date']}</th>
                            <th>{$_L['Total']}</th>
                            <th>{$_L['Status']}</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $recent_domains as $recent_order}

                            <tr>
                                <td>
                                    <a href="{$base_url}client/view-domain/{$recent_order->id}/" class="font-weight-bold">
                                        {$recent_order->tracking_id|escape}
                                    </a>
                                </td>
                                <td>
                                    {{$recent_order->domain|escape}}
                                </td>
                                <td>
                                    {date( $config['df'], strtotime($recent_order->created_at))}
                                </td>
                                <td>
                                    {formatCurrency($recent_order->total,$config['home_currency'])}
                                </td>
                                <td>
                                    {cloudonex_get_order_status_with_badge($recent_order->status)}
                                </td>
                            </tr>


                        {/foreach}

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <div class="card mt-3">
        <div class="card-body">
            <h3>{$_L['Recent Tickets']}</h3>
            <div class="hr-line-dashed"></div>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>{$_L['Ticket']}</th>
                    <th>{$_L['Subject']}</th>
                    <th>{$_L['Status']}</th>
                    <th>{$_L['Last Update']}</th>
                </tr>
                </thead>
                <tbody>
                {foreach $recent_tickets as $recent_ticket}
                    <tr>
                        <td>
                            <a href="{$base_url}client/tickets/view/{$recent_ticket->tid}" class="font-weight-bold">
                                {$recent_ticket->tid}
                            </a>
                        </td>
                        <td>
                            <a href="{$base_url}client/tickets/view/{$recent_ticket->tid}" class="font-weight-bold">
                                {$recent_ticket->subject|escape}
                            </a>
                        </td>
                        <td>
                            {cloudonex_get_ticket_status_with_badge($recent_ticket->status|escape)}
                        </td>
                        <td>
                            {date( $config['df'], strtotime($recent_ticket->updated_at))}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>



</main>
{/block}

{block name=script}

    <script>

    </script>


{/block}
