{extends file="$layouts_client"}

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
    </style>
{/block}


{block name="content"}


    <div class="row">

        <div class="col-md-4">
            <div class="panel">


                <div class="panel-container">
                    <div class="panel-content">
                        <div class="text-center">

                            {if $user->img}
                                <img src="{{APP_URL}}/{{$user->img}}" style="max-width: 130px;"class="rounded-circle m-t-xs img-fluid avatar-xl mb-4" alt="{$user->fullname}">
                            {else}
                                <img src="{{APP_URL}}/ui/lib/img/default-user-avatar.png" class="profile-image rounded-circle" alt="{$user->fullname}">
                            {/if}


                            <h3 class="h2">{$user->account}</h3>

                            {if $config['add_fund'] eq '1' && $config['add_fund_client'] eq '1'}


                                <h5>{$_L['Your Current Balance']}: <span class="amount text-success">{$user->balance}</span></h5>
                                <hr>
                                <a href="javascript:void(0)" class="btn btn-primary add_fund"><i class="fal fa-plus"></i> Add Fund</a>
                                <hr>


                            {/if}

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
                                {if $config['show_business_number'] eq '1'}
                                    <br>

                                    <br>

                                    <strong class="h6">{$config['label_business_number']}</strong> {$user->business_number}
                                    <br>

                                {/if}
                                {foreach $cf as $cfs}
                                    <br>
                                    <strong class="h6">{$cfs['fieldname']}: </strong> {get_custom_field_value($cfs['id'],$user->id)}
                                {/foreach}

                                {*<a href="{$_url}client/profile/" class="btn btn-primary"><i class="icon-user-1"></i> Edit Profile</a>*}

                                {*{if $config['client_drive'] eq '1'}*}
                                {*<a href="#" id="app_media"  data-src="{$_url}client-mediabox" class="btn btn-primary"><i class="fal fa-hdd-o"></i> Drive</a>*}
                                {*{/if}*}
                                {if $user->company neq ''}
                                    {$user->company}
                                    <br>
                                    {$user->account}
                                    <br>
                                {else}
                                    {$user->account}
                                    <br>
                                {/if}
                                {$user->address} <br>
                                {$user->city} <br>
                                {$user->state} - {$user->zip} <br>
                                {$user->country}





                            </address>


                        </div>

                    </div>
                </div>

            </div>
        </div>

        <div class="col-md-8">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Recent Orders']}</h2>
                </div>

                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">

                            <table class="table table-striped sys_table">
                                <thead>
                                <tr>

                                    <th>{$_L['Date']}</th>


                                    <th>{$_L['Order']} #</th>


                                    <th>{$_L['Amount']}</th>
                                    <th>{$_L['Status']}</th>

                                </tr>
                                </thead>
                                <tbody>

                                {foreach $orders as $order}

                                    <tr>

                                        <td> {date( $config['df'], strtotime({$order->date_added}))} </td>


                                        <td>

                                            <a class="text-info h6" href="{$_url}client/order_view/{$order->id}/{$order->ordernum}/">{$order->ordernum}</a>

                                        </td>




                                        <td class="amount h6" data-a-sign="{$config['currency_code']} ">{$order->amount}</td>

                                        <td>
                                            {if $order->status eq 'Active'}
                                                <span class="badge badge-success">{ib_lan_get_line($_L[$order->status])}</span>
                                            {else}
                                                <span class="badge badge-danger">{ib_lan_get_line($_L[$order->status])}</span>
                                            {/if}
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


    </div>



    <div class="row">

        <div class="col-md-12">

            <div class="panel">
                <div class="panel-hdr">
                    <h5>{$_L['Recent Transactions']}</h5>

                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <div class="table-responsive">
                            <table class="table table-striped sys_table">
                                <th>{$_L['Date']}</th>
                                <th>{$_L['Account']}</th>


                                <th class="text-right">{$_L['Amount']}</th>

                                <th>{$_L['Description']}</th>

                                {foreach $t as $ds}
                                    <tr class="{if $ds['cr'] eq '0.00'}table-warning {else}table-info{/if}">
                                        <td>{date( $config['df'], strtotime($ds['date']))}</td>
                                        <td class="h6">{$ds['account']}</td>

                                        <td class="text-right amount">{$ds['amount']}</td>
                                        <td>{$ds['description']}</td>

                                    </tr>
                                {/foreach}



                            </table>
                        </div>



                    </div>
                </div>

            </div>




        </div>

    </div>

    <div class="row">

        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">


                    <h2>{$_L['Recent Invoices']}</h2>


                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">

                            <table class="table table-striped sys_table">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>{$_L['Account']}</th>
                                    <th>{$_L['Amount']}</th>
                                    <th>{$_L['Invoice Date']}</th>
                                    <th>{$_L['Due Date']}</th>
                                    <th>
                                        {$_L['Status']}
                                    </th>

                                    <th class="text-right">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $d as $ds}
                                    <tr>
                                        <td><a target="_blank" href="{$_url}client/iview/{$ds['id']}/token_{$ds['vtoken']}/">{$ds['invoicenum']}{if $ds['cn'] neq ''} {$ds['cn']} {else} {$ds['id']} {/if}</a> </td>
                                        <td class=" h6 text-info">{$ds['account']} </td>
                                        <td class="amount h6" data-a-sign="{if $ds['currency_symbol'] eq ''} {$config['currency_code']} {else} {$ds['currency_symbol']}{/if} ">{$ds['total']}</td>
                                        <td>{date( $config['df'], strtotime($ds['date']))}</td>
                                        <td>{date( $config['df'], strtotime($ds['duedate']))}</td>
                                        <td>

                                            {if $ds['status'] eq 'Unpaid'}
                                                <span class="badge badge-danger">{ib_lan_get_line($ds['status'])}</span>
                                            {elseif $ds['status'] eq 'Paid'}
                                                <span class="badge badge-success">{ib_lan_get_line($ds['status'])}</span>
                                            {elseif $ds['status'] eq 'Partially Paid'}
                                                <span class="badge badge-info">{ib_lan_get_line($ds['status'])}</span>
                                            {elseif $ds['status'] eq 'Cancelled'}
                                                <span class="label">{ib_lan_get_line($ds['status'])}</span>
                                            {else}
                                                {ib_lan_get_line($ds['status'])}
                                            {/if}



                                        </td>

                                        <td class="text-right">
                                            <div class="btn-group">
                                                <a target="_blank" href="{$_url}client/iview/{$ds['id']}/token_{$ds['vtoken']}/" class="btn btn-primary btn-xs"> {$_L['View']}</a>
                                                <a href="{$_url}client/ipdf/{$ds['id']}/token_{$ds['vtoken']}/dl/" class="btn btn-secondary btn-xs"> {$_L['Download']}</a>
                                                <a target="_blank" href="{$_url}iview/print/{$ds['id']}/token_{$ds['vtoken']}/" class="btn btn-danger btn-xs"> {$_L['Print']}</a>
                                            </div>


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

    </div>

    <div class="row">

        <div class="col-md-12">


            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Recent Quotes']}</h2>
                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <div class="table-responsive">
                            <table class="table sys_table">
                                <thead>
                                <tr>

                                    <th width="40%" class="h6 ">{$_L['Subject']}</th>
                                    <th>{$_L['Amount']}</th>
                                    <th>{$_L['Date Created']}</th>
                                    <th>{$_L['Expiry Date']}</th>
                                    {*<th>{$_L['Stage']}</th>*}

                                    <th class="text-right">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>

                                {foreach $q as $ds}
                                    <tr>
                                        <td><a href="{$_url}client/q/{$ds['id']}/token_{$ds['vtoken']}/" target="_blank"><span class="h6 text-info">{$ds['subject']}</span> </a> </td>
                                        <td class="amount">{$ds['total']}</td>
                                        <td class="h6 text-info">{date( $config['df'], strtotime($ds['datecreated']))}</td>
                                        <td>{date( $config['df'], strtotime($ds['validuntil']))}</td>


                                        <td class="text-right">
                                            <div class="btn-group">
                                                <a href="{$_url}client/q/{$ds['id']}/token_{$ds['vtoken']}/" target="_blank" class="btn btn-primary btn-xs"> {$_L['View']}</a>

                                                <a href="{$_url}client/qpdf/{$ds['id']}/token_{$ds['vtoken']}/dl/" class="btn btn-secondary btn-xs" > {$_L['Download']}</a>
                                                <a href="{$_url}client/qpdf/{$ds['id']}/token_{$ds['vtoken']}/" target="_blank" class="btn btn-danger btn-xs"> {$_L['Print']}</a>
                                            </div>


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

    </div>




{/block}

{block name="script"}
    <script>
        $(function () {

            $('.amount').autoNumeric('init', {

                aSign: '{$config['currency_code']} ',
                dGroup: {$config['thousand_separator_placement']},
                aPad: {$config['currency_decimal_digits']},
                pSign: '{$config['currency_symbol_position']}',
                aDec: '{$config['dec_point']}',
                aSep: '{$config['thousands_sep']}',
                vMax: '9999999999999999.00',
                vMin: '-9999999999999999.00'

            });

            $(".add_fund").click(function (e) {
                e.preventDefault();

                bootbox.prompt({
                    title: "Enter Amount",
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

                            $.redirectPost(base_url + "client/add_fund/",{ amount: result});

                        }
                    }
                });

            });
        });
    </script>
{/block}
