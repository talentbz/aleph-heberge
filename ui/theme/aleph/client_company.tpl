{extends file="$layouts_client"}

{assign "page_content_extra_class" "p-0"}

{block name="content"}


    <div class="d-flex flex-grow-1 p-0">
        <!-- left slider -->
        <div id="js-inbox-menu" class="flex-wrap position-relative bg-white slide-on-mobile slide-on-mobile-left">
            <div class="position-absolute pos-top pos-bottom w-100">
                <div class="d-flex h-100 flex-column">
                    <div class="px-3 px-sm-4 px-lg-5 py-4 align-items-center text-center">
                        {if $company->logo_path}
                            <img src="{APP_URL}/storage/companies/{$company->logo_path}" class="img-fluid" alt="{$company->company_name}">

                        {else}
                            <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <path d="M13.5,21 L13.5,18 C13.5,17.4477153 13.0522847,17 12.5,17 L11.5,17 C10.9477153,17 10.5,17.4477153 10.5,18 L10.5,21 L5,21 L5,4 C5,2.8954305 5.8954305,2 7,2 L17,2 C18.1045695,2 19,2.8954305 19,4 L19,21 L13.5,21 Z M9,4 C8.44771525,4 8,4.44771525 8,5 L8,6 C8,6.55228475 8.44771525,7 9,7 L10,7 C10.5522847,7 11,6.55228475 11,6 L11,5 C11,4.44771525 10.5522847,4 10,4 L9,4 Z M14,4 C13.4477153,4 13,4.44771525 13,5 L13,6 C13,6.55228475 13.4477153,7 14,7 L15,7 C15.5522847,7 16,6.55228475 16,6 L16,5 C16,4.44771525 15.5522847,4 15,4 L14,4 Z M9,8 C8.44771525,8 8,8.44771525 8,9 L8,10 C8,10.5522847 8.44771525,11 9,11 L10,11 C10.5522847,11 11,10.5522847 11,10 L11,9 C11,8.44771525 10.5522847,8 10,8 L9,8 Z M9,12 C8.44771525,12 8,12.4477153 8,13 L8,14 C8,14.5522847 8.44771525,15 9,15 L10,15 C10.5522847,15 11,14.5522847 11,14 L11,13 C11,12.4477153 10.5522847,12 10,12 L9,12 Z M14,12 C13.4477153,12 13,12.4477153 13,13 L13,14 C13,14.5522847 13.4477153,15 14,15 L15,15 C15.5522847,15 16,14.5522847 16,14 L16,13 C16,12.4477153 15.5522847,12 15,12 L14,12 Z" fill="#000000"/>
        <rect fill="#FFFFFF" x="13" y="8" width="3" height="3" rx="1"/>
        <path d="M4,21 L20,21 C20.5522847,21 21,21.4477153 21,22 L21,22.4 C21,22.7313708 20.7313708,23 20.4,23 L3.6,23 C3.26862915,23 3,22.7313708 3,22.4 L3,22 C3,21.4477153 3.44771525,21 4,21 Z" fill="#000000" opacity="0.3"/>
    </g>
</svg></span>
                        {/if}


                    </div>
                    <div class="pr-3">



                        <a href="javascript:;" id="summary" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 active li_summary">
                            <div class="svg-icon svg-icon-primary">
                                {*                                <i class="fal fa-folder-open width-1">*}
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <path d="M3.95709826,8.41510662 L11.47855,3.81866389 C11.7986624,3.62303967 12.2013376,3.62303967 12.52145,3.81866389 L20.0429,8.41510557 C20.6374094,8.77841684 21,9.42493654 21,10.1216692 L21,19.0000642 C21,20.1046337 20.1045695,21.0000642 19,21.0000642 L4.99998155,21.0000673 C3.89541205,21.0000673 2.99998155,20.1046368 2.99998155,19.0000673 L2.99999828,10.1216672 C2.99999935,9.42493561 3.36258984,8.77841732 3.95709826,8.41510662 Z M10,13 C9.44771525,13 9,13.4477153 9,14 L9,17 C9,17.5522847 9.44771525,18 10,18 L14,18 C14.5522847,18 15,17.5522847 15,17 L15,14 C15,13.4477153 14.5522847,13 14,13 L10,13 Z" fill="#000000"/>
                                    </g></svg>
                                </i>{$_L['Summary']}
                            </div>
                        </a>


                        <a href="javascript:;" id="customers" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 li_customers">
                            <div class="svg-icon svg-icon-primary">
                                {*                                <i class="fal fa-folder-open width-1">*}
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <circle fill="#000000" opacity="0.3" cx="12" cy="12" r="10"/>
                                        <path d="M12.4208204,17.1583592 L15.4572949,11.0854102 C15.6425368,10.7149263 15.4923686,10.2644215 15.1218847,10.0791796 C15.0177431,10.0271088 14.9029083,10 14.7864745,10 L12,10 L12,7.17705098 C12,6.76283742 11.6642136,6.42705098 11.25,6.42705098 C10.965921,6.42705098 10.7062236,6.58755277 10.5791796,6.84164079 L7.5427051,12.9145898 C7.35746316,13.2850737 7.50763142,13.7355785 7.87811529,13.9208204 C7.98225687,13.9728912 8.09709167,14 8.21352549,14 L11,14 L11,16.822949 C11,17.2371626 11.3357864,17.572949 11.75,17.572949 C12.034079,17.572949 12.2937764,17.4124472 12.4208204,17.1583592 Z" fill="#000000"/>
                                    </g>
                                </svg>
                                </i>{$_L['Customers']}
                            </div>
                            <div class="fw-400 fs-xs">({Companies::countCustomers($company->id)})</div>
                        </a>





                        {if $config['invoicing'] eq '1'}

                            <a href="javascript:void(0)" id="invoices" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 li_invoices">
                                <div class="svg-icon svg-icon-primary">
                                    {*                                    <i class="fal fa-edit width-1"></i>*}
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <rect x="0" y="0" width="24" height="24"/>
                                            <circle fill="#000000" opacity="0.3" cx="20.5" cy="12.5" r="1.5"/>
                                            <rect fill="#000000" opacity="0.3" transform="translate(12.000000, 6.500000) rotate(-15.000000) translate(-12.000000, -6.500000) " x="3" y="3" width="18" height="7" rx="1"/>
                                            <path d="M22,9.33681558 C21.5453723,9.12084552 21.0367986,9 20.5,9 C18.5670034,9 17,10.5670034 17,12.5 C17,14.4329966 18.5670034,16 20.5,16 C21.0367986,16 21.5453723,15.8791545 22,15.6631844 L22,18 C22,19.1045695 21.1045695,20 20,20 L4,20 C2.8954305,20 2,19.1045695 2,18 L2,6 C2,4.8954305 2.8954305,4 4,4 L20,4 C21.1045695,4 22,4.8954305 22,6 L22,9.33681558 Z" fill="#000000"/>
                                        </g>
                                    </svg>
                                    {$_L['Invoices']}
                                </div>
                                <div class="fw-400 fs-xs">({Companies::countInvoices($company->id)})</div>
                            </a>

                        {/if}


                        {if $config['quotes'] eq '1'}

                            <a href="javascript:void(0)" id="quotes" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 li_quotes">
                                <div class="svg-icon svg-icon-primary">
                                    {*                                    <i class="fal fa-edit width-1"></i>*}

                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <polygon points="0 0 24 0 24 24 0 24"/>
                                            <path d="M3.52270623,14.028695 C2.82576459,13.3275941 2.82576459,12.19529 3.52270623,11.4941891 L11.6127629,3.54050571 C11.9489429,3.20999263 12.401513,3.0247814 12.8729533,3.0247814 L19.3274172,3.0247814 C20.3201611,3.0247814 21.124939,3.82955935 21.124939,4.82230326 L21.124939,11.2583059 C21.124939,11.7406659 20.9310733,12.2027862 20.5869271,12.5407722 L12.5103155,20.4728108 C12.1731575,20.8103442 11.7156477,21 11.2385688,21 C10.7614899,21 10.3039801,20.8103442 9.9668221,20.4728108 L3.52270623,14.028695 Z M16.9307214,9.01652093 C17.9234653,9.01652093 18.7282432,8.21174298 18.7282432,7.21899907 C18.7282432,6.22625516 17.9234653,5.42147721 16.9307214,5.42147721 C15.9379775,5.42147721 15.1331995,6.22625516 15.1331995,7.21899907 C15.1331995,8.21174298 15.9379775,9.01652093 16.9307214,9.01652093 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                        </g>
                                    </svg>

                                    {$_L['Quotes']}
                                </div>
                                <div class="fw-400 fs-xs">({Companies::countQuotes($company->id)})</div>
                            </a>

                        {/if}

                        {if $config['orders'] eq '1'}

                            <a href="javascript:void(0)" id="orders" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 li_orders">
                                <div class="svg-icon svg-icon-primary">
                                    {*                                    <i class="fal fa-edit width-1"></i>*}

                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <rect x="0" y="0" width="24" height="24"/>
                                            <path d="M12,4.56204994 L7.76822128,9.6401844 C7.4146572,10.0644613 6.7840925,10.1217854 6.3598156,9.76822128 C5.9355387,9.4146572 5.87821464,8.7840925 6.23177872,8.3598156 L11.2317787,2.3598156 C11.6315738,1.88006147 12.3684262,1.88006147 12.7682213,2.3598156 L17.7682213,8.3598156 C18.1217854,8.7840925 18.0644613,9.4146572 17.6401844,9.76822128 C17.2159075,10.1217854 16.5853428,10.0644613 16.2317787,9.6401844 L12,4.56204994 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                            <path d="M3.5,9 L20.5,9 C21.0522847,9 21.5,9.44771525 21.5,10 C21.5,10.132026 21.4738562,10.2627452 21.4230769,10.3846154 L17.7692308,19.1538462 C17.3034221,20.271787 16.2111026,21 15,21 L9,21 C7.78889745,21 6.6965779,20.271787 6.23076923,19.1538462 L2.57692308,10.3846154 C2.36450587,9.87481408 2.60558331,9.28934029 3.11538462,9.07692308 C3.23725479,9.02614384 3.36797398,9 3.5,9 Z M12,17 C13.1045695,17 14,16.1045695 14,15 C14,13.8954305 13.1045695,13 12,13 C10.8954305,13 10,13.8954305 10,15 C10,16.1045695 10.8954305,17 12,17 Z" fill="#000000"/>
                                        </g>
                                    </svg>

                                    {$_L['Orders']}
                                </div>
                                <div class="fw-400 fs-xs">({Companies::countOrders($company->id)})</div>
                            </a>

                        {/if}


                        {if $config['accounting'] eq '1'}

                            <a href="javascript:void(0)" id="transactions" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 li_transactions">
                                <div class="svg-icon svg-icon-primary">
                                    {*                                    <i class="fal fa-edit width-1"></i>*}

                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <rect x="0" y="0" width="24" height="24"/>
                                            <path d="M4,4 L20,4 C21.1045695,4 22,4.8954305 22,6 L22,18 C22,19.1045695 21.1045695,20 20,20 L4,20 C2.8954305,20 2,19.1045695 2,18 L2,6 C2,4.8954305 2.8954305,4 4,4 Z" fill="#000000" opacity="0.3"/>
                                            <path d="M18.5,11 L5.5,11 C4.67157288,11 4,11.6715729 4,12.5 L4,13 L8.58578644,13 C8.85100293,13 9.10535684,13.1053568 9.29289322,13.2928932 L10.2928932,14.2928932 C10.7456461,14.7456461 11.3597108,15 12,15 C12.6402892,15 13.2543539,14.7456461 13.7071068,14.2928932 L14.7071068,13.2928932 C14.8946432,13.1053568 15.1489971,13 15.4142136,13 L20,13 L20,12.5 C20,11.6715729 19.3284271,11 18.5,11 Z" fill="#000000"/>
                                            <path d="M5.5,6 C4.67157288,6 4,6.67157288 4,7.5 L4,8 L20,8 L20,7.5 C20,6.67157288 19.3284271,6 18.5,6 L5.5,6 Z" fill="#000000"/>
                                        </g>
                                    </svg>

                                    {$_L['Transactions']}
                                </div>
                                <div class="fw-400 fs-xs">({Companies::countTransactions($company->id)})</div>
                            </a>

                        {/if}






{*                        <a href="javascript:void(0)" id="edit" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">*}
{*                            <div class="svg-icon svg-icon-primary">*}
{*                                *}{*                                <i class="fal fa-trash width-1"></i>*}
{*                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">*}
{*                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">*}
{*                                        <rect x="0" y="0" width="24" height="24"/>*}
{*                                        <path d="M8,17.9148182 L8,5.96685884 C8,5.56391781 8.16211443,5.17792052 8.44982609,4.89581508 L10.965708,2.42895648 C11.5426798,1.86322723 12.4640974,1.85620921 13.0496196,2.41308426 L15.5337377,4.77566479 C15.8314604,5.0588212 16,5.45170806 16,5.86258077 L16,17.9148182 C16,18.7432453 15.3284271,19.4148182 14.5,19.4148182 L9.5,19.4148182 C8.67157288,19.4148182 8,18.7432453 8,17.9148182 Z" fill="#000000" fill-rule="nonzero" transform="translate(12.000000, 10.707409) rotate(-135.000000) translate(-12.000000, -10.707409) "/>*}
{*                                        <rect fill="#000000" opacity="0.3" x="5" y="20" width="15" height="2" rx="1"/>*}
{*                                    </g>*}
{*                                </svg>*}

{*                                {$_L['Edit']}*}
{*                            </div>*}
{*                        </a>*}




                        <input type="hidden" id="cid" value="{$company->id}">

                    </div>








                </div>
            </div>
        </div>
        <div class="slide-backdrop" data-action="toggle" data-class="slide-on-mobile-left-show" data-target="#js-inbox-menu"></div> <!-- end left slider -->
        <!-- inbox container -->
        <div class="d-flex flex-column flex-grow-1 bg-white">
            <!-- inbox header -->
            <div class="flex-grow-0">
                <!-- inbox title -->
                <div class="d-flex align-items-center py-3 pl-sm-3 pr-sm-4 py-sm-4 py-lg-4 pl-lg-0 flex-shrink-0">
                    <!-- button for mobile -->
                    <a href="javascript:void(0);" class="pl-3 pr-3 py-2 d-flex d-lg-none align-items-center justify-content-center mr-2 btn" data-action="toggle" data-class="slide-on-mobile-left-show" data-target="#js-inbox-menu">
                        <i class="fal fa-ellipsis-v h1 mb-0 "></i>
                    </a>
                    <!-- end button for mobile -->
                    <h1 class="subheader-title">
                        {$company->company_name} {if $company->code}[{$company->code}]{/if}
                    </h1>
                </div>
                <!-- end inbox title -->
                <!-- inbox button shortcut -->

                <!-- end inbox button shortcut -->
            </div>
            <!-- end inbox header -->
            <!-- inbox message -->
            <div class="flex-wrap align-items-center flex-grow-1 position-relative">
                <div class="position-absolute pos-top w-100 panel">
                    <div class="panel-container">
                        <div class="panel-content">
                            <div class="d-flex h-100 flex-column">
                                <div id="application_ajaxrender" style="min-height: 200px;">

                                </div>
                                <!-- end message list -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end inbox message -->
        </div>
        <!-- end inbox container -->
        <!-- compose message -->
        <!-- end compose message -->
    </div>


    <input type="hidden" id="_lan_are_you_sure" value="{$_L['are_you_sure']}">
    <input type="hidden" id="_active_tab" value="{$tab}">
{/block}

{block name="script"}
    <script>
        $(function () {


            var $modal = $('#cloudonex_body');


            var tab = 'summary';


            function updateDiv(action,cb){

                var $ibox_form = $('#ibox_form');
                $ibox_form.block({ message: block_msg });



                $('.clx-side-menu-item').removeClass('active');
                $("#"+action).addClass("active");



                $.post(base_url +  "client/company_" +action + '/', { })
                    .done(function (data) {

                        $("#application_ajaxrender").html(data);
                        $ibox_form.unblock();

                        cb();


                        $('.amount').autoNumeric('init');

                    });

            }



            var cb  =  function cb(){



                switch(tab) {
                    case "invoices":


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

                        break;





                    default:

                    //cb = function cb (){
                    //    //  return;
                    //};

                }




            };


            updateDiv(tab,cb);

            $modal.on('click', '.li_customers', function(e){



                e.preventDefault();

                tab = 'customers';

                updateDiv(tab,cb);

            });



            $modal.on('click', '.li_summary', function(e){



                e.preventDefault();

                tab = 'summary';

                updateDiv(tab,cb);

            });

            $modal.on('click', '.li_invoices', function(e){



                e.preventDefault();

                tab = 'invoices';

                updateDiv(tab,cb);

            });


            $modal.on('click', '.li_quotes', function(e){



                e.preventDefault();

                tab = 'quotes';

                updateDiv(tab,cb);

            });


            $modal.on('click', '.li_orders', function(e){



                e.preventDefault();

                tab = 'orders';

                updateDiv(tab,cb);

            });




            $modal.on('click', '.li_transactions', function(e){



                e.preventDefault();

                tab = 'transactions';

                updateDiv(tab,cb);

            });






        });
    </script>
{/block}
