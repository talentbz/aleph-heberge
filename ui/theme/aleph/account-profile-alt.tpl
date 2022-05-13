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
            color: #2CCE89!important;}

        .text-danger{
            color: #F6365B!important;
        }
        .text-warning{
            color: #FB6340!important;
        }
        .text-primary{
            color: #10CDEF!important;
        }
        .text-light {
            color: #ced4da!important;
        }
        .text-black {
            color: #32325D!important;
        }
    </style>
{/block}


{assign "page_content_extra_class" "p-0"}

{block name="content"}


    <div class="d-flex flex-grow-1 p-0">
        <!-- left slider -->
        <div id="js-inbox-menu" class="flex-wrap position-relative bg-white slide-on-mobile slide-on-mobile-left">
            <div class="position-absolute pos-top pos-bottom w-100">
                <div class="d-flex h-100 flex-column">
                    <div class="px-3 px-sm-4 px-lg-5 py-4 align-items-center text-center">
                        {if $d['img'] eq 'gravatar'}
                            <img src="http://www.gravatar.com/avatar/{($d['email'])|md5}?s=400" class="img-fluid" alt="{$d['fname']} {$d['lname']}">
                        {elseif $d['img'] eq ''}

                            <div class="svg-icon svg-icon-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="100%" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <polygon points="0 0 24 0 24 24 0 24"/>
                                        <path d="M12,11 C9.790861,11 8,9.209139 8,7 C8,4.790861 9.790861,3 12,3 C14.209139,3 16,4.790861 16,7 C16,9.209139 14.209139,11 12,11 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                        <path d="M3.00065168,20.1992055 C3.38825852,15.4265159 7.26191235,13 11.9833413,13 C16.7712164,13 20.7048837,15.2931929 20.9979143,20.2 C21.0095879,20.3954741 20.9979143,21 20.2466999,21 C16.541124,21 11.0347247,21 3.72750223,21 C3.47671215,21 2.97953825,20.45918 3.00065168,20.1992055 Z" fill="#000000" fill-rule="nonzero"/>
                                    </g>
                                </svg>
                            </div>

                        {else}
                            <img src="{$app_url}{$d['img']}" class="img-fluid rounded-circle" alt="{$d['account']}">
                        {/if}

                        <div class="mt-3">
                            {if $d['email'] neq ''}
                                <h5 class="text-muted" style="overflow-wrap: break-word;">{$d['email']}</h5>
                            {/if}
                            {if $d['phone'] neq ''}
                                <h5 class="text-muted" style="overflow-wrap: break-word;">{$d['phone']}</h5>
                            {/if}
                        </div>

                    </div>
                    <div class="pr-3">



                        <a href="javascript:;" id="summary" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 active">
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


                        <a href="javascript:;" id="activity" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0 active">
                            <div class="svg-icon svg-icon-primary">
                                {*                                <i class="fal fa-folder-open width-1">*}
                               <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <circle fill="#000000" opacity="0.3" cx="12" cy="12" r="10"/>
                                        <path d="M12.4208204,17.1583592 L15.4572949,11.0854102 C15.6425368,10.7149263 15.4923686,10.2644215 15.1218847,10.0791796 C15.0177431,10.0271088 14.9029083,10 14.7864745,10 L12,10 L12,7.17705098 C12,6.76283742 11.6642136,6.42705098 11.25,6.42705098 C10.965921,6.42705098 10.7062236,6.58755277 10.5791796,6.84164079 L7.5427051,12.9145898 C7.35746316,13.2850737 7.50763142,13.7355785 7.87811529,13.9208204 C7.98225687,13.9728912 8.09709167,14 8.21352549,14 L11,14 L11,16.822949 C11,17.2371626 11.3357864,17.572949 11.75,17.572949 C12.034079,17.572949 12.2937764,17.4124472 12.4208204,17.1583592 Z" fill="#000000"/>
                                    </g>
                                </svg>
                                </i>{$_L['Activity']}
                            </div>
                        </a>


                        {if $is_supplier && has_access($user->roleid,'suppliers') && ($config['purchase'])}

                            <a href="javascript:void(0);" id="purchases" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                                <div>
                                    <i class="fal fa-star width-1">

                                    </i>{$_L['Purchase Orders']}
                                </div>
                                <div class="fw-400 fs-xs">({$po_count})</div>
                            </a>

                        {/if}


                        {if $config['invoicing'] eq '1'}

                            <a href="javascript:void(0)" id="invoices" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
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
                                <div class="fw-400 fs-xs">({$inv_count})</div>
                            </a>

                        {/if}


                        {if $config['quotes'] eq '1'}

                            <a href="javascript:void(0)" id="quotes" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
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
                                <div class="fw-400 fs-xs">({$quote_count})</div>
                            </a>

                        {/if}


                        {if $config['documents'] eq '1'}


                            <a href="javascript:void(0)" id="files" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                                <div class="svg-icon svg-icon-primary">
{*                                    <i class="fal fa-exclamation-triangle width-1">*}

                                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                <polygon points="0 0 24 0 24 24 0 24"/>
                                                <path d="M4.85714286,1 L11.7364114,1 C12.0910962,1 12.4343066,1.12568431 12.7051108,1.35473959 L17.4686994,5.3839416 C17.8056532,5.66894833 18,6.08787823 18,6.52920201 L18,19.0833333 C18,20.8738751 17.9795521,21 16.1428571,21 L4.85714286,21 C3.02044787,21 3,20.8738751 3,19.0833333 L3,2.91666667 C3,1.12612489 3.02044787,1 4.85714286,1 Z M8,12 C7.44771525,12 7,12.4477153 7,13 C7,13.5522847 7.44771525,14 8,14 L15,14 C15.5522847,14 16,13.5522847 16,13 C16,12.4477153 15.5522847,12 15,12 L8,12 Z M8,16 C7.44771525,16 7,16.4477153 7,17 C7,17.5522847 7.44771525,18 8,18 L11,18 C11.5522847,18 12,17.5522847 12,17 C12,16.4477153 11.5522847,16 11,16 L8,16 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                                <path d="M6.85714286,3 L14.7364114,3 C15.0910962,3 15.4343066,3.12568431 15.7051108,3.35473959 L20.4686994,7.3839416 C20.8056532,7.66894833 21,8.08787823 21,8.52920201 L21,21.0833333 C21,22.8738751 20.9795521,23 19.1428571,23 L6.85714286,23 C5.02044787,23 5,22.8738751 5,21.0833333 L5,4.91666667 C5,3.12612489 5.02044787,3 6.85714286,3 Z M8,12 C7.44771525,12 7,12.4477153 7,13 C7,13.5522847 7.44771525,14 8,14 L15,14 C15.5522847,14 16,13.5522847 16,13 C16,12.4477153 15.5522847,12 15,12 L8,12 Z M8,16 C7.44771525,16 7,16.4477153 7,17 C7,17.5522847 7.44771525,18 8,18 L11,18 C11.5522847,18 12,17.5522847 12,17 C12,16.4477153 11.5522847,16 11,16 L8,16 Z" fill="#000000" fill-rule="nonzero"/>
                                            </g>
                                        </svg>
                                    </i>{$_L['Files']}
                                </div>
                            </a>

                        {/if}

                        {if $config['accounting'] eq '1'}

                            <a href="javascript:void(0)" id="transactions" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                                <div class="svg-icon svg-icon-primary">
{*                                    <i class="fal fa-trash width-1">*}
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <rect x="0" y="0" width="24" height="24"/>
                                            <path d="M4,4 L20,4 C21.1045695,4 22,4.8954305 22,6 L22,18 C22,19.1045695 21.1045695,20 20,20 L4,20 C2.8954305,20 2,19.1045695 2,18 L2,6 C2,4.8954305 2.8954305,4 4,4 Z" fill="#000000" opacity="0.3"/>
                                            <path d="M18.5,11 L5.5,11 C4.67157288,11 4,11.6715729 4,12.5 L4,13 L8.58578644,13 C8.85100293,13 9.10535684,13.1053568 9.29289322,13.2928932 L10.2928932,14.2928932 C10.7456461,14.7456461 11.3597108,15 12,15 C12.6402892,15 13.2543539,14.7456461 13.7071068,14.2928932 L14.7071068,13.2928932 C14.8946432,13.1053568 15.1489971,13 15.4142136,13 L20,13 L20,12.5 C20,11.6715729 19.3284271,11 18.5,11 Z" fill="#000000"/>
                                            <path d="M5.5,6 C4.67157288,6 4,6.67157288 4,7.5 L4,8 L20,8 L20,7.5 C20,6.67157288 19.3284271,6 18.5,6 L5.5,6 Z" fill="#000000"/>
                                        </g>
                                    </svg>

                                    </i>{$_L['Transactions']}
                                </div>
                            </a>

                        {/if}

                        <a href="javascript:void(0)" id="email" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                            <div class="svg-icon svg-icon-primary">
{*                                <i class="fal fa-trash width-1"></i>*}

                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <path d="M5,6 L19,6 C20.1045695,6 21,6.8954305 21,8 L21,17 C21,18.1045695 20.1045695,19 19,19 L5,19 C3.8954305,19 3,18.1045695 3,17 L3,8 C3,6.8954305 3.8954305,6 5,6 Z M18.1444251,7.83964668 L12,11.1481833 L5.85557487,7.83964668 C5.4908718,7.6432681 5.03602525,7.77972206 4.83964668,8.14442513 C4.6432681,8.5091282 4.77972206,8.96397475 5.14442513,9.16035332 L11.6444251,12.6603533 C11.8664074,12.7798822 12.1335926,12.7798822 12.3555749,12.6603533 L18.8555749,9.16035332 C19.2202779,8.96397475 19.3567319,8.5091282 19.1603533,8.14442513 C18.9639747,7.77972206 18.5091282,7.6432681 18.1444251,7.83964668 Z" fill="#000000"/>
                                    </g>
                                </svg>

                                {$_L['Email']}
                            </div>
                        </a>

                        <a href="javascript:void(0)" id="log" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                            <div class="svg-icon svg-icon-primary">
{*                                <i class="fal fa-trash width-1">*}
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <path d="M11.5,5 L18.5,5 C19.3284271,5 20,5.67157288 20,6.5 C20,7.32842712 19.3284271,8 18.5,8 L11.5,8 C10.6715729,8 10,7.32842712 10,6.5 C10,5.67157288 10.6715729,5 11.5,5 Z M5.5,17 L18.5,17 C19.3284271,17 20,17.6715729 20,18.5 C20,19.3284271 19.3284271,20 18.5,20 L5.5,20 C4.67157288,20 4,19.3284271 4,18.5 C4,17.6715729 4.67157288,17 5.5,17 Z M5.5,11 L18.5,11 C19.3284271,11 20,11.6715729 20,12.5 C20,13.3284271 19.3284271,14 18.5,14 L5.5,14 C4.67157288,14 4,13.3284271 4,12.5 C4,11.6715729 4.67157288,11 5.5,11 Z" fill="#000000" opacity="0.3"/>
                                        <path d="M4.82866499,9.40751652 L7.70335558,6.90006821 C7.91145727,6.71855155 7.9330087,6.40270347 7.75149204,6.19460178 C7.73690043,6.17787308 7.72121098,6.16213467 7.70452782,6.14749103 L4.82983723,3.6242308 C4.62230202,3.44206673 4.30638833,3.4626341 4.12422426,3.67016931 C4.04415337,3.76139218 4,3.87862714 4,4.00000654 L4,9.03071508 C4,9.30685745 4.22385763,9.53071508 4.5,9.53071508 C4.62084305,9.53071508 4.73759731,9.48695028 4.82866499,9.40751652 Z" fill="#000000"/>
                                    </g>
                                </svg>


                                </i>{$_L['Log']}
                            </div>
                        </a>

                        {if ($config['password_manager']) && has_access($user->roleid,'password_manager')}
                            <a href="javascript:void(0)" id="client-password-manager" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                                <div class="svg-icon svg-icon-primary">
{*                                    <i class="fal fa-trash width-1"></i>*}
                           <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                            <rect x="0" y="0" width="24" height="24"/>
                                            <circle fill="#000000" opacity="0.3" cx="12" cy="12" r="10"/>
                                            <path d="M14.5,11 C15.0522847,11 15.5,11.4477153 15.5,12 L15.5,15 C15.5,15.5522847 15.0522847,16 14.5,16 L9.5,16 C8.94771525,16 8.5,15.5522847 8.5,15 L8.5,12 C8.5,11.4477153 8.94771525,11 9.5,11 L9.5,10.5 C9.5,9.11928813 10.6192881,8 12,8 C13.3807119,8 14.5,9.11928813 14.5,10.5 L14.5,11 Z M12,9 C11.1715729,9 10.5,9.67157288 10.5,10.5 L10.5,11 L13.5,11 L13.5,10.5 C13.5,9.67157288 12.8284271,9 12,9 Z" fill="#000000"/>
                                        </g>
                                    </svg>
                                    {$_L['Password Manager']}
                                </div>
                            </a>

                        {/if}

                        <a href="javascript:void(0)" id="credit_card_info" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                            <div class="svg-icon svg-icon-primary">
{*                                <i class="fal fa-trash width-1"></i>*}
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <rect fill="#000000" opacity="0.3" x="2" y="5" width="20" height="14" rx="2"/>
                                        <rect fill="#000000" x="2" y="8" width="20" height="3"/>
                                        <rect fill="#000000" opacity="0.3" x="16" y="14" width="4" height="2" rx="1"/>
                                    </g>
                                </svg>
                                {$_L['Credit Card Information']}
                            </div>
                        </a>



                        <a href="javascript:void(0)" id="edit" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                            <div class="svg-icon svg-icon-primary">
{*                                <i class="fal fa-trash width-1"></i>*}
                              <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <path d="M8,17.9148182 L8,5.96685884 C8,5.56391781 8.16211443,5.17792052 8.44982609,4.89581508 L10.965708,2.42895648 C11.5426798,1.86322723 12.4640974,1.85620921 13.0496196,2.41308426 L15.5337377,4.77566479 C15.8314604,5.0588212 16,5.45170806 16,5.86258077 L16,17.9148182 C16,18.7432453 15.3284271,19.4148182 14.5,19.4148182 L9.5,19.4148182 C8.67157288,19.4148182 8,18.7432453 8,17.9148182 Z" fill="#000000" fill-rule="nonzero" transform="translate(12.000000, 10.707409) rotate(-135.000000) translate(-12.000000, -10.707409) "/>
                                        <rect fill="#000000" opacity="0.3" x="5" y="20" width="15" height="2" rx="1"/>
                                    </g>
                                </svg>

                                {$_L['Edit']}
                            </div>
                        </a>

                        <a href="javascript:void(0)" id="more" class="dropdown-item clx-side-menu-item px-3 px-sm-4 pr-lg-3 pl-lg-5 py-2 fs-md d-flex justify-content-between rounded-pill border-top-left-radius-0 border-bottom-left-radius-0">
                            <div class="svg-icon svg-icon-primary">
{*                                <i class="fal fa-trash width-1"></i>*}
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <circle fill="#000000" opacity="0.3" cx="12" cy="12" r="9"/>
                                        <path d="M11.7357634,20.9961946 C6.88740052,20.8563914 3,16.8821712 3,12 C3,11.9168367 3.00112797,11.8339369 3.00336944,11.751315 C3.66233009,11.8143341 4.85636818,11.9573854 4.91262842,12.4204038 C4.9904938,13.0609191 4.91262842,13.8615942 5.45804656,14.101772 C6.00346469,14.3419498 6.15931561,13.1409372 6.6267482,13.4612567 C7.09418079,13.7815761 8.34086797,14.0899175 8.34086797,14.6562185 C8.34086797,15.222396 8.10715168,16.1034596 8.34086797,16.2636193 C8.57458427,16.423779 9.5089688,17.54465 9.50920913,17.7048097 C9.50956962,17.8649694 9.83857487,18.6793513 9.74040201,18.9906563 C9.65905192,19.2487394 9.24857641,20.0501554 8.85059781,20.4145589 C9.75315358,20.7620621 10.7235846,20.9657742 11.7357634,20.9960544 L11.7357634,20.9961946 Z M8.28272988,3.80112099 C9.4158415,3.28656421 10.6744554,3 12,3 C15.5114513,3 18.5532143,5.01097452 20.0364482,7.94408274 C20.069657,8.72412177 20.0638332,9.39135321 20.2361262,9.6327358 C21.1131932,10.8600506 18.0995147,11.7043158 18.5573343,13.5605384 C18.7589671,14.3794892 16.5527814,14.1196773 16.0139722,14.886394 C15.4748026,15.6527403 14.1574598,15.137809 13.8520064,14.9904917 C13.546553,14.8431744 12.3766497,15.3341497 12.4789081,14.4995164 C12.5805657,13.664636 13.2922889,13.6156126 14.0555619,13.2719546 C14.8184743,12.928667 15.9189236,11.7871741 15.3781918,11.6380045 C12.8323064,10.9362407 11.963771,8.47852395 11.963771,8.47852395 C11.8110443,8.44901109 11.8493762,6.74109366 11.1883616,6.69207022 C10.5267462,6.64279981 10.170464,6.88841096 9.20435656,6.69207022 C8.23764828,6.49572949 8.44144409,5.85743687 8.2887174,4.48255778 C8.25453994,4.17415686 8.25619136,3.95717082 8.28272988,3.80112099 Z M20.9991771,11.8770357 C20.9997251,11.9179585 21,11.9589471 21,12 C21,16.9406923 17.0188468,20.9515364 12.0895088,20.9995641 C16.970233,20.9503326 20.9337111,16.888438 20.9991771,11.8770357 Z" fill="#000000" opacity="0.3"/>
                                    </g>
                                </svg>
                                {$_L['More']}
                            </div>
                        </a>


                        <input type="hidden" id="cid" value="{$d['id']}">

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
                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <polygon points="0 0 24 0 24 24 0 24"/>
                                <rect fill="#000000" opacity="0.3" transform="translate(14.000000, 12.000000) rotate(-90.000000) translate(-14.000000, -12.000000) " x="13" y="5" width="2" height="14" rx="1"/>
                                <rect fill="#000000" opacity="0.3" x="3" y="3" width="2" height="18" rx="1"/>
                                <path d="M11.7071032,15.7071045 C11.3165789,16.0976288 10.6834139,16.0976288 10.2928896,15.7071045 C9.90236532,15.3165802 9.90236532,14.6834152 10.2928896,14.2928909 L16.2928896,8.29289093 C16.6714686,7.914312 17.281055,7.90106637 17.675721,8.26284357 L23.675721,13.7628436 C24.08284,14.136036 24.1103429,14.7686034 23.7371505,15.1757223 C23.3639581,15.5828413 22.7313908,15.6103443 22.3242718,15.2371519 L17.0300721,10.3841355 L11.7071032,15.7071045 Z" fill="#000000" fill-rule="nonzero" transform="translate(16.999999, 11.999997) scale(1, -1) rotate(90.000000) translate(-16.999999, -11.999997) "/>
                            </g>
                        </svg>
                    </a>
                    <!-- end button for mobile -->
                    <h1 class="subheader-title">
                        {$d['account']} {if $d['code'] neq ''}[{$d['code']}]{/if}
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
                                <!-- message list (the part that scrolls) -->
                                <div class="alert alert-danger" id="emsg" style="display: none;">
                                    <span id="emsgbody"></span>
                                </div>
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
        $(document).ready(function () {

            //var pbar = $('#progressbar');
            //pbar.hide();
            //
            //pbar.progressbar({
            //    warningMarker: 100,
            //    dangerMarker: 100,
            //    maximum: 100,
            //    step: 15
            //});

            var $modal = $('#cloudonex_body');

            var tab = $("#_active_tab").val();

            var cid = $('#cid').val();
            var _url = $("#_url").val();

            var $ibox_form = $('#ibox_form');

            function updateDiv(action,_url,cid,cb){

                $('#ibox_form').block({ message: block_msg });
                var body = $("html, body");
                body.animate({ scrollTop:0 }, '1000', 'swing');




                if (window.history.replaceState) {
                    window.history.replaceState( { } , '',  _url + 'contacts/view/'+ cid +'/' + action + '/' );
                }


                $('.clx-side-menu-item.active').removeClass('active');
                $("#"+action).addClass("active");




                $.post(_url +  "contacts/" +action + '/', {
                    cid: cid

                })
                    .done(function (data) {

                        //clearInterval(timer);
                        $("#application_ajaxrender").html(data);
                        $('#ibox_form').unblock();



                        cb();


                        $( ".mmnt" ).each(function() {
                            //   alert($( this ).html());
                            var ut = $( this ).html();
                            $( this ).html(moment.unix(ut).fromNow());
                        });

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

                    });

            }


            $("#emsg").hide();

            $(".cdelete").click(function (e) {
                e.preventDefault();
                var id = this.id;
                var lan_msg = $("#_lan_are_you_sure").val();
                bootbox.confirm(lan_msg, function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/user/" + id + '/';
                    }
                });
            });







            $("#note_update").click(function (e) {
                e.preventDefault();
                $('#ibox_panel').block({ message: null });
                var _url = $("#_url").val();
                $.post(_url + 'contacts/edit-notes/', {
                    cid: $('#cid').val(),

                    notes: $('#notes').val()

                })
                    .done(function () {
                        //bootbox.alert("Notes Saved", function() {
                        //    $("#note_update").html("Save");
                        //});
                        $('#ibox_panel').unblock();

                    });



            });




            // From version 4.1

            var cb  =  function cb(){



                switch(tab) {
                    case "edit":


                        $("#country").select2();


                        $('#tags').select2({
                            tags: true,
                            tokenSeparators: [','],
                        });

                        $('#company_id').select2();





                        break;

                    case "more":


                        var croppicHeaderOptions = {

                            uploadUrl: _url + 'sys_imgcrop/save/',
                            cropData:{
                                "email":1,
                                "rnd":"rnd"
                            },
                            cropUrl:  _url + 'sys_imgcrop/crop/',
                            outputUrlId:'picture',
                            customUploadButtonId:'cropContainerHeaderButton',
                            modal:false,
                            loaderHtml:'<div class="loader bubblingG"><span id="bubblingG_1"></span><span id="bubblingG_2"></span><span id="bubblingG_3"></span></div> ',
                            onBeforeImgUpload: function(){ console.log('onBeforeImgUpload') },
                            onAfterImgUpload: function(){ console.log('onAfterImgUpload') },
                            onImgDrag: function(){ console.log('onImgDrag') },
                            onImgZoom: function(){ console.log('onImgZoom') },
                            onBeforeImgCrop: function(){ console.log('onBeforeImgCrop') },
                            onAfterImgCrop:function(){ console.log('onAfterImgCrop') }
                        };
                        var croppic = new Croppic('croppic', croppicHeaderOptions);



                        break;

                    case 'activity':

                        $('#msg').redactor(
                            {
                                minHeight: 200 // pixels
                            }
                        );







                        break;


                    case 'email':

                        $('#content').redactor(
                            {
                                minHeight: 300 // pixels
                            }
                        );



                        break;

                    case 'files':

                        $("#c_file").select2();

                        break;

                    case 'client-password-manager':

                        var clipboard = new Clipboard('.copy_to_clipboard', {
                            text: function(trigger) {
                                return trigger.getAttribute('aria-label');
                            }
                        });

                        clipboard.on('success', function(e) {
                            toastr.success('Text Copied!');
                            e.clearSelection();
                        });

                        break;



                    default:



                }




            };





            //



            updateDiv(tab,_url,cid,cb);
            $("#summary").click(function (e) {
                e.preventDefault();

                tab = 'summary';

                updateDiv(tab,_url,cid,cb);
            });


            $("#orders").click(function (e) {
                e.preventDefault();

                tab = 'orders';

                updateDiv(tab,_url,cid,cb);
            });


            $("#files").click(function (e) {
                e.preventDefault();

                tab = 'files';

                updateDiv(tab,_url,cid,cb);
            });



            $("#invoices").click(function (e) {
                e.preventDefault();

                tab = 'invoices';
                updateDiv(tab,_url,cid,cb);
            });

            $("#purchases").click(function (e) {
                e.preventDefault();

                tab = 'purchases';
                updateDiv(tab,_url,cid,cb);
            });

            $("#credit_card_info").click(function (e) {
                e.preventDefault();

                tab = 'credit_card_info';
                updateDiv(tab,_url,cid,cb);
            });


            $("#quotes").click(function (e) {
                e.preventDefault();

                tab = 'quotes';
                updateDiv(tab,_url,cid,cb);
            });

            $("#transactions").click(function (e) {
                e.preventDefault();

                tab = 'transactions';
                updateDiv(tab,_url,cid,cb);
            });

            {if ($config['password_manager']) && has_access($user->roleid,'password_manager')}
            $("#client-password-manager").click(function (e) {
                e.preventDefault();

                tab = 'client-password-manager';
                updateDiv(tab,_url,cid,cb);
            });
            {/if}


            $("#email").click(function (e) {
                e.preventDefault();

                tab = 'email';
                updateDiv(tab,_url,cid,cb);


            });

            $("#edit").click(function (e) {
                e.preventDefault();

                tab = 'edit';
                updateDiv(tab,_url,cid,cb);
            });

            $("#log").click(function (e) {
                e.preventDefault();

                tab = 'log';
                updateDiv(tab,_url,cid,cb);
            });

            $("#more").click(function (e) {
                e.preventDefault();



                tab = 'more';

                updateDiv(tab,_url,cid,cb);
            });


            $("#activity").click(function (e) {
                e.preventDefault();
                $('.list-group a.active').removeClass('active');
                $(this).addClass("active");
                tab = 'activity';

                updateDiv('activity',_url,cid,cb);
            });

            var sysrender = $('#application_ajaxrender');
            sysrender.on('click', '#acf-post', function(e){
                e.preventDefault();
                $('#ibox_form').block({ message: null });
                var _url = $("#_url").val();
                $.post(_url + 'contacts/add-activity-post/', {

                    cid: $('#cid').val(),
                    msg: $('#msg').val(),
                    icon: $('#activity-type').val()

                })
                    .done(function (data) {

                        var sbutton = $("#acf-post");
                        var _url = $("#_url").val();
                        if ($.isNumeric(data)) {

                            window.location = _url + 'contacts/view/' + data + '/activity/';
                        }
                        else {
                            $('#ibox_form').unblock();

                            $("#emsgbody").html(data);
                            $("#emsg").show("slow");
                        }
                    });
            });




            sysrender.on('click', '#submit', function(e){
                e.preventDefault();
                $ibox_form.block({ message: null });
                var _url = $("#_url").val();
                $.post(_url + 'contacts/edit-post/', $( "#rform" ).serialize())
                    .done(function (data) {

                        var sbutton = $("#submit");
                        var _url = $("#_url").val();

                        if ($.isNumeric(data)) {

                            window.location = _url + 'contacts/view/' + data + '/edit/';
                        }
                        else {
                            $('#ibox_form').unblock();

                            $("#emsgbody").html(data);
                            $("#emsg").show("slow");
                        }
                    });
            });

            sysrender.on('click','#save_credit_card',function (e) {
                e.preventDefault();
                $ibox_form.block({ message: null });

                $.post(base_url + 'contacts/save_credit_card/', $('#credit_card_from').serialize())
                    .done(function (data) {

                        if ($.isNumeric(data)) {

                            window.location = base_url + 'contacts/view/' + data + '/credit_card_info/';
                        }
                        else {
                            $('#ibox_form').unblock();

                            $("#emsgbody").html(data);
                            $("#emsg").show("slow");
                        }
                    });

            });


            sysrender.on('click', '#send_email', function(e){
                e.preventDefault();
                $ibox_form.block({ message: null });
                var _url = $("#_url").val();

                $.post(_url + 'contacts/send_email/', {
                    cid: $('#cid').val(),

                    subject: $('#subject').val(),
                    // message: tinyMCE.activeEditor.getContent()
                    message: $('#content').val(),


                })
                    .done(function (data) {

                        var sbutton = $("#send_email");
                        var _url = $("#_url").val();
                        if ($.isNumeric(data)) {

                            window.location = _url + 'contacts/view/' + data + '/email/';
                        }
                        else {
                            $('#ibox_form').unblock();

                            $("#emsgbody").html(data);
                            $("#emsg").show("slow");
                        }
                    });
            });

            sysrender.on('click', '#assign_file', function(e){
                e.preventDefault();
                $ibox_form.block({ message: null });


                $.post(_url + 'contacts/assign_file/', {
                    cid: $('#cid').val(),

                    did: $('#c_file').val()


                })
                    .done(function (data) {


                        if ($.isNumeric(data)) {

                            window.location = _url + 'contacts/view/' + data + '/files/';
                        }
                        else {
                            $('#ibox_form').unblock();

                            $("#emsgbody").html(data);
                            $("#emsg").show("slow");

                        }
                    });
            });

            sysrender.on('click', '#no_image', function(e){
                e.preventDefault();
                $('#picture').val('');

            });

            sysrender.on('change', '#contact_note', function(){

                $.post(_url + 'contacts/edit-notes/', {

                    cid: '{$d['id']}',

                    notes: $('#contact_note').val()

                });

            });

            sysrender.on('change', '#is_primary_contact', function(){

                toastr.success('{$_L['Updated']}');

                let set = 0;
                if($(this).prop('checked')){
                    set = 1;
                }

                $.post(base_url + 'contacts/set-boolean/', {

                    contact_id: '{$d['id']}',
                    key: 'is_primary_contact',
                    value: set,

                });


            });


            sysrender.on('click', '#opt_gravatar', function(e){
                e.preventDefault();

                $('.picture').val('gravatar');

            });

            sysrender.on('click', '#more_submit', function(e){
                e.preventDefault();


                $ibox_form.block({ message: null });
                var _url = $("#_url").val();
                $.post(_url + 'contacts/edit-more/', {
                    cid: $('#cid').val(),
                    picture: $('#picture').val(),
                    facebook: $('#facebook').val(),
                    google: $('#google').val(),
                    linkedin: $('#linkedin').val()

                })
                    .done(function (data) {

                        var sbutton = $("#more_submit");
                        var _url = $("#_url").val();
                        if ($.isNumeric(data)) {

                            window.location = _url + 'contacts/view/' + data + '/';
                        }
                        else {
                            $('#ibox_form').unblock();

                            $("#emsgbody").html(data);
                            $("#emsg").show("slow");
                        }
                    });

            });

            sysrender.on('click', '.clickable', function(e){
                e.preventDefault();
                $(".compose-toolbar li").removeClass("action-active");
                $(this).addClass("action-active");
                var atype = $(this).html();

                $('#activity-type').val(atype);
            });


            sysrender.on('click', '.activity_edit', function(e){
                e.preventDefault();

                var activity_id;

                activity_id = this.id;


                $.fancybox.open({
                    src  :  base_url + 'contacts/modal_edit_activity/' +  activity_id,
                    type : 'ajax',
                    opts : {
                        touch: false,
                        keyboard: false,
                        autoFocus: false,
                        trapFocus: false,
                        afterShow : function( instance, current ) {
                            $('.edit_activity').redactor(
                                {
                                    minHeight: 200 // pixels
                                }
                            );

                        }
                    },
                });





            });


            $modal.on('click', '.modal_activity_submit', function(e){
                e.preventDefault();


                $.post( base_url + "contacts/edit_activity_post/", $("#ib_modal_edit_activity_form").serialize())
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {
                            $modal.modal('loading');
                            toastr.error(data);
                        }

                    });



            });

            $modal.on('click', '.modal_activity_edit_cancel', function(e){
                location.reload();
            });


            $modal.on('click', '.clickable', function(e){
                e.preventDefault();
                $(".compose-toolbar li").removeClass("action-active");
                $(this).addClass("action-active");
                var atype = $(this).html();

                $('#edit_activity_type').val(atype);
            });


            sysrender.on('click', '.choose_from_template', function(e){
                e.preventDefault();

                $.fancybox.open({
                    src  :  base_url + 'handler/view_email_templates/',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#tbl_email_templates').dataTable({
                                "language": {
                                    "emptyTable": "{$_L['No items to display']}",
                                    "info":      "{$_L['Showing _START_ to _END_ of _TOTAL_ entries']}",
                                    "infoEmpty":      "{$_L['Showing 0 to 0 of 0 entries']}",
                                    buttons: {
                                        pageLength: '{$_L['Show all']}'
                                    },
                                    searchPlaceholder: "{__('Search')}"
                                },
                            });
                        }
                    },
                });

            });


            $modal.on('click', '.eml_select', function(e) {
                e.preventDefault();



                var eml_id = this.id;

                $.getJSON(base_url + "handler/json_eml_tpl/"+eml_id + '/' + {$contact->id}, function (data) {

                    $("#subject").val(data.subject);

                    $('#content').redactor('code.set', data.message);

                    $.fancybox.close();


                });

            });


            sysrender.on('click', '.add_fund', function(e){
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

                            $.redirectPost(base_url + "contacts/add_fund/",{ amount: result, cid: cid});

                        }
                    }
                });

            });

            sysrender.on('click', '.return_fund', function(e){
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
                            $.redirectPost(base_url + "contacts/return_fund/",{ amount: result, cid: cid});

                        }
                    }
                });

            });

            function update_time(){
                $( ".sdate" ).each(function() {
                    //   alert($( this ).html());
                    var ut = $( this ).html();
                    $( this ).html(moment.unix(ut).format(_df));
                });

                $( ".mmnt" ).each(function() {
                    //   alert($( this ).html());
                    var ut = $( this ).html();
                    $( this ).html(moment.unix(ut).fromNow());
                });
            }

        });
    </script>
{/block}
