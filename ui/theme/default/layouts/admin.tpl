{extends file="layouts/base.tpl"}
{block name="head_extras_from_layout"}
    <script>
        var clx_admin_layout = 1;
    </script>

    {if !empty($config['admin_dark_theme'])}
        <style>
            html body {
                background-color: #1E1E2C;
                color: #fff;
            }
            html body a {
                color: #3699ff;
            }
            .page-header {
                background-color: #1E1E2C;
            }

            .page-content {
                background-color: #151520;
            }
            .panel, .card {
                background-color: #1E1E2C;
            }
            .panel-hdr {
                background: #1E1E2C;
            }
            .panel-hdr h2 {
                color: #fff;
            }
            .table-bordered td, .table-bordered th {
                border: 1px solid #323248;
            }
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #2B2C3F;
            }
            .text-dark {
                color: #fff!important;
            }
            .text-muted, .text-muted-green {
                color: #565674!important;
            }
            .panel {
                border: 0;
            }

            .table thead th {
                border-bottom: 2px solid #323248;
            }

            .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
                color: #fff;
            }
            .table {
                color: #fff;
            }

            .btn-default {
                background-color: #565773;
                background-image: none;
                color: #fff;
            }
            .fc-head-container thead tr {
                background-image: none;
            }
            .fc-other-month {
                background-image: none;
                background-color: #15151F;
                background-size: 1rem 1rem;
            }
            .progress {
                background-color: #323347;
            }
            .alert-info {
                color: #fff;
                background-color: #2f264f;
                border-color: transparent;
            }

            .badge.badge-outline-danger {
                color: #f64e60;
                background-color: #3a2434;
            }

            .page-content {
                color: #fff;
            }

            .symbol .symbol-label {
                background-color: #565772;
            }

            .clx-avatar {
                background: #372533;
                color: #E45B64;
            }

            .form-control {
                background-color: #1b1b29;
                border-color: #1b1b29;
                color: #92929f;
            }

            .select2-container--default .select2-selection--single {
                background-color: #1b1b29;
                border: 1px solid #1b1b29;
                border-radius: 4px;
            }
            .select2-container--default .select2-selection--single .select2-selection__rendered {
                color: #fff;
            }

            .form-control:focus {
                background-color: #171723;
                border-color: #171723;
                color: #92929f;
            }

            .custom-control-label::before {
                background-color: #2B2C3F;
                border: #3c3d5a solid 2px;
            }

            .settings-panel .list:hover {
                color: #6d6d80;
                background: #323347;
            }

            .table td, .table th {
                padding: .75rem;
                vertical-align: top;
                border-top: 1px solid #6d6d80;
            }



            .table-hover tbody tr:hover {
                color: #fff;
                background: #323347;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                color: #6d6d80;
                background-color: #323347;
            }

            .settings-panel h5 {
                color: #fff;
            }

            .alert-danger {
                border-color: rgba(255,168,0,.5);
                color: #fff;
                background-color: #392f28;
            }

            .page-link {
                color: #fff;
                background-color: #3699ff;
                border-color: transparent;
            }
            .pagination .page-item:first-child:not(.active) .page-link, .pagination .page-item:last-child:not(.active) .page-link, .pagination .page-item.disabled .page-link {
                background: #232F47;
            }

            .input-group-text {

                background-color: #1b1b29;
                border: 1px solid #1b1b29;
            }

            .select2-dropdown {
                background-color: #171723;
                border-color: #171723;
            }

            .select2-results__message {
                color: #92929f !important;
            }

            .select2-container--default .select2-selection--multiple {
                background-color: #171723;
                border-color: #171723;
                color: #fff;
            }
            .select2-search--dropdown:before {
                color: #fff;
            }

            .select2-container--default .select2-search--dropdown .select2-search__field {
                background-color: #171723;
                border-color: #171723;
                color: #fff;
            }

            .table-bordered {
                border: none;
            }

            .table thead th {
                background-color: #1E1E2B;
            }

            .list-group-item {
                background-color: #1E1E2B;
            }

            .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
                background-color: #1E1E2B;

            }

            .nav-tabs-clean .nav-item .nav-link.active {
                border-bottom: 1px solid #3699ff;
                color: #3699ff;
            }

            .nav-tabs .nav-item .nav-link.active:not(:hover) {
                color: #3699ff;
            }

            .form-control:disabled, .form-control[readonly] {
                background-color: #1b1b29;
                border-color: #1b1b29;
                color: #92929f;
            }

            .redactor-box, .redactor-editor {
                background-color: #1b1b29;
            }
            .redactor-toolbar {
                background: #323347;
            }
            .redactor-toolbar li a {
                color: #fff;
            }
            .redactor-editor {
                border: 1px solid #2b2b40;
            }


            .dashboard-stat2 {

                background-color: #1b1b29;

            }

        </style>
    {/if}

{/block}
{block name="content_body"}
    <aside class="page-sidebar">
        <div class="page-logo">
            <a href="{$_url}dashboard" class="page-logo-link d-flex align-items-center position-relative">

                {if isset($config['logo_square'])}
                    <img src="{{APP_URL}}/storage/system/{{$config['logo_square']}}" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                {else}
                    <img src="{{APP_URL}}/storage/system/logo-512x512.png?v=2" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                {/if}


                {if isset($config['logo_text'])}
                    <span class="page-logo-text mr-1">{$config['logo_text']}</span>
                {else}
                    <span class="page-logo-text mr-1">CloudOnex</span>
                {/if}

            </a>
        </div>

        <nav id="clx-primary-navigation" class="primary-nav" role="navigation">

            <div class="info-card">
                {if $user->img}
                    <img src="{{APP_URL}}/{{$user->img}}" class="profile-image rounded-circle" alt="{$user->fullname}">
                {else}
                    <img src="{{APP_URL}}/ui/lib/img/default-user-avatar.png" class="profile-image rounded-circle" alt="{$user->fullname}">
                {/if}


                <div class="info-card-text">
                    <a href="{$_url}settings/users-edit/{$user->id}" class="d-flex align-items-center text-white">
                                    <span class="text-truncate text-truncate-sm d-inline-block">
                                        {$user->fullname}
                                    </span>
                    </a>
                </div>

                {if isset($config['hide_cover_image']) && $config['hide_cover_image']==1}

                    {else}

                    <img src="{APP_URL}/ui/theme/default/img/cover-2-lg.png" class="cover" alt="cover">

                {/if}



            </div>
            <ul id="clx-navigation-menu" class="nav-menu">

                {$admin_extra_nav[0]}

                {if has_access($user->roleid,'reports')}
                    <li {if $selected_navigation eq 'dashboard'}class="active"{/if}><a href="{$_url}{$config['redirect_url']}">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"></rect>
                                    <rect fill="#000000" opacity="0.3" x="13" y="4" width="3" height="16" rx="1.5"></rect>
                                    <rect fill="#000000" x="8" y="9" width="3" height="11" rx="1.5"></rect>
                                    <rect fill="#000000" x="18" y="11" width="3" height="9" rx="1.5"></rect>
                                    <rect fill="#000000" x="3" y="13" width="3" height="7" rx="1.5"></rect>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Dashboard']}</span></a></li>
                {/if}

                {$admin_extra_nav[1]}

                {if has_access($user->roleid,'customers')}

                    <li class="{if $selected_navigation eq 'contacts'}active  open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <polygon points="0 0 24 0 24 24 0 24"/>
                                    <path d="M12,11 C9.790861,11 8,9.209139 8,7 C8,4.790861 9.790861,3 12,3 C14.209139,3 16,4.790861 16,7 C16,9.209139 14.209139,11 12,11 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                    <path d="M3.00065168,20.1992055 C3.38825852,15.4265159 7.26191235,13 11.9833413,13 C16.7712164,13 20.7048837,15.2931929 20.9979143,20.2 C21.0095879,20.3954741 20.9979143,21 20.2466999,21 C16.541124,21 11.0347247,21 3.72750223,21 C3.47671215,21 2.97953825,20.45918 3.00065168,20.1992055 Z" fill="#000000" fill-rule="nonzero"/>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Customers']}</span>
                        </a>
                        <ul>
                            {if has_access($user->roleid,'customers','create')}
                                <li>
                                    <a href="{$_url}contacts/add">
                                        <span class="nav-link-text">{$_L['Add Customer']}</span>
                                    </a>
                                </li>
                            {/if}

                            <li>
                                <a href="{$_url}contacts/list">
                                    <span class="nav-link-text">{$_L['List Customers']}</span>
                                </a>
                            </li>

                            {if has_access($user->roleid,'companies','view') && ($config['companies'])}
                                <li>
                                    <a href="{$_url}contacts/companies">
                                        <span class="nav-link-text">{$_L['Companies']}</span>
                                    </a>
                                </li>
                            {/if}
                            <li>
                                <a href="{$_url}contacts/groups">
                                    <span class="nav-link-text">{$_L['Groups']}</span>
                                </a>
                            </li><li>
                                <a href="{$_url}contacts/drive">
                                    <span class="nav-link-text">{$_L['Files']}</span>
                                </a>
                            </li>

                        </ul>
                    </li>

                {/if}

                {$admin_extra_nav[2]}

                {if has_access($user->roleid,'transactions') || has_access($user->roleid,'transactions','create')}
                    {if $config['accounting'] eq '1'}

                        <li class="{if $selected_navigation eq 'transactions'}active  open{/if}">
                            <a href="#">
                                {*                                    <i class="fal fa-landmark"></i>*}
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <rect fill="#000000" opacity="0.3" x="7" y="4" width="10" height="4"/>
                                        <path d="M7,2 L17,2 C18.1045695,2 19,2.8954305 19,4 L19,20 C19,21.1045695 18.1045695,22 17,22 L7,22 C5.8954305,22 5,21.1045695 5,20 L5,4 C5,2.8954305 5.8954305,2 7,2 Z M8,12 C8.55228475,12 9,11.5522847 9,11 C9,10.4477153 8.55228475,10 8,10 C7.44771525,10 7,10.4477153 7,11 C7,11.5522847 7.44771525,12 8,12 Z M8,16 C8.55228475,16 9,15.5522847 9,15 C9,14.4477153 8.55228475,14 8,14 C7.44771525,14 7,14.4477153 7,15 C7,15.5522847 7.44771525,16 8,16 Z M12,12 C12.5522847,12 13,11.5522847 13,11 C13,10.4477153 12.5522847,10 12,10 C11.4477153,10 11,10.4477153 11,11 C11,11.5522847 11.4477153,12 12,12 Z M12,16 C12.5522847,16 13,15.5522847 13,15 C13,14.4477153 12.5522847,14 12,14 C11.4477153,14 11,14.4477153 11,15 C11,15.5522847 11.4477153,16 12,16 Z M16,12 C16.5522847,12 17,11.5522847 17,11 C17,10.4477153 16.5522847,10 16,10 C15.4477153,10 15,10.4477153 15,11 C15,11.5522847 15.4477153,12 16,12 Z M16,16 C16.5522847,16 17,15.5522847 17,15 C17,14.4477153 16.5522847,14 16,14 C15.4477153,14 15,14.4477153 15,15 C15,15.5522847 15.4477153,16 16,16 Z M16,20 C16.5522847,20 17,19.5522847 17,19 C17,18.4477153 16.5522847,18 16,18 C15.4477153,18 15,18.4477153 15,19 C15,19.5522847 15.4477153,20 16,20 Z M8,18 C7.44771525,18 7,18.4477153 7,19 C7,19.5522847 7.44771525,20 8,20 L12,20 C12.5522847,20 13,19.5522847 13,19 C13,18.4477153 12.5522847,18 12,18 L8,18 Z M7,4 L7,8 L17,8 L17,4 L7,4 Z" fill="#000000"/>
                                    </g>
                                </svg>
                                <span class="nav-link-text">{$_L['Accounting']}</span>
                            </a>
                            <ul>



                                {if has_access($user->roleid,'transactions','create')}

                                    <li>
                                        <a href="{$_url}transactions/deposit">
                                            <span class="nav-link-text">{$_L['New Deposit']}</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="{$_url}transactions/expense">
                                            <span class="nav-link-text">{$_L['New Expense']}</span>
                                        </a>
                                    </li>


                                {/if}


                                {if has_access($user->roleid,'transactions','view')}

                                    <li>
                                        <a href="{$_url}transactions/transfer">
                                            <span class="nav-link-text">{$_L['Transfer']}</span>
                                        </a>
                                    </li>

                                    <li>
                                        <a href="{$_url}transactions/bills">
                                            <span class="nav-link-text">{$_L['Bills']}</span>
                                        </a>
                                    </li>

                                    <li>
                                        <a href="{$_url}transactions/list">
                                            <span class="nav-link-text">{$_L['View Transactions']}</span>
                                        </a>
                                    </li>


                                {/if}



                                {if has_access($user->roleid,'bank_n_cash')}

                                    <li>
                                        <a href="{$_url}transactions/uncleared">
                                            <span class="nav-link-text">{$_L['Uncleared Transactions']}</span>
                                        </a>
                                    </li>

                                    <li>
                                        <a href="{$_url}accounts/list">
                                            <span class="nav-link-text">{$_L['Accounts']}</span>
                                        </a>
                                    </li>

                                    <li>
                                        <a href="{$_url}accounts/add">
                                            <span class="nav-link-text">{$_L['New Account']}</span>
                                        </a>
                                    </li>


                                {/if}


                        {if has_access($user->roleid,'assets','view')}
                            <li>
                                <a href="{$_url}assets/list">
                                    <span class="nav-link-text">{$_L['Assets']}</span>
                                </a>
                            </li>

                        {/if}



                            </ul>
                        </li>



                    {/if}
                {/if}

                {$admin_extra_nav[3]}

                {if has_access($user->roleid,'sales') || has_access($user->roleid,'sales','create')}

                    {if ($config['invoicing'] eq '1') OR ($config['quotes'] eq '1')}



                        <li class="{if $selected_navigation eq 'invoices'}active open{/if}">
                            <a href="#">

                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <circle fill="#000000" opacity="0.3" cx="20.5" cy="12.5" r="1.5"/>
                                        <rect fill="#000000" opacity="0.3" transform="translate(12.000000, 6.500000) rotate(-15.000000) translate(-12.000000, -6.500000) " x="3" y="3" width="18" height="7" rx="1"/>
                                        <path d="M22,9.33681558 C21.5453723,9.12084552 21.0367986,9 20.5,9 C18.5670034,9 17,10.5670034 17,12.5 C17,14.4329966 18.5670034,16 20.5,16 C21.0367986,16 21.5453723,15.8791545 22,15.6631844 L22,18 C22,19.1045695 21.1045695,20 20,20 L4,20 C2.8954305,20 2,19.1045695 2,18 L2,6 C2,4.8954305 2.8954305,4 4,4 L20,4 C21.1045695,4 22,4.8954305 22,6 L22,9.33681558 Z" fill="#000000"/>
                                    </g>
                                </svg>
                                <span class="nav-link-text">{$_L['Sales']}</span></a>
                            <ul>

                                {if $config['invoicing'] eq '1'}

                                    {if has_access($user->roleid,'sales','view')}
                                        <li><a href="{$_url}invoices/list"><span class="nav-link-text">{$_L['Invoices']}</span></a></li>
                                    {/if}

                                    {if has_access($user->roleid,'sales','create')}
                                        <li><a href="{$_url}invoices/add"><span class="nav-link-text">{$_L['New Invoice']}</span></a></li>
                                        {if isset($config['pos']) && $config['pos'] eq '1' }
                                            <li><a href="{$_url}invoices/add/1/0/pos"><span class="nav-link-text">{$_L['POS']}</span></a></li>
                                        {/if}
                                    {/if}





                                    {if has_access($user->roleid,'sales','view')}

                                        <li><a href="{$_url}invoices/list-recurring"><span class="nav-link-text">{$_L['Recurring Invoices']}</span></a></li>
                                    {/if}


                                    {if has_access($user->roleid,'sales','create')}

                                        <li><a href="{$_url}invoices/add/recurring"><span class="nav-link-text">{$_L['New Recurring Invoice']}</span></a></li>

                                    {/if}

                                {/if}

                                {if isset($config['delivery_challans']) && ($config['delivery_challans'] == 1)}

                                    <li><a href="{$_url}sales/delivery_challans"><span class="nav-link-text">{$_L['Delivery Challans']}</span></a></li>

                                {/if}

                                {if $config['quotes'] eq '1'}

                                    {if has_access($user->roleid,'sales','view')}

                                        <li><a href="{$_url}quotes/list"><span class="nav-link-text">{$_L['Quotes']}</span></a></li>

                                    {/if}

                                    {if has_access($user->roleid,'sales','create')}
                                        <li><a href="{$_url}quotes/new"><span class="nav-link-text">{$_L['Create New Quote']}</span></a></li>
                                    {/if}
                                {/if}

                                {if has_access($user->roleid,'transactions')}

                                    <li><a href="{$_url}invoices/payments"><span class="nav-link-text">{$_L['Payments']}</span></a></li>
                                {/if}

                                {foreach $sub_menu_admin['sales'] as $sm_sales}

                                    {$sm_sales}


                                {/foreach}

                            </ul>
                        </li>

                    {/if}

                {/if}


                {if has_access($user->roleid,'suppliers') && ($config['suppliers'])}

                    <li class="{if $selected_navigation eq 'suppliers'}active open{/if}">
                        <a href="#">

                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"></rect>
                                    <path d="M5.5,4 L9.5,4 C10.3284271,4 11,4.67157288 11,5.5 L11,6.5 C11,7.32842712 10.3284271,8 9.5,8 L5.5,8 C4.67157288,8 4,7.32842712 4,6.5 L4,5.5 C4,4.67157288 4.67157288,4 5.5,4 Z M14.5,16 L18.5,16 C19.3284271,16 20,16.6715729 20,17.5 L20,18.5 C20,19.3284271 19.3284271,20 18.5,20 L14.5,20 C13.6715729,20 13,19.3284271 13,18.5 L13,17.5 C13,16.6715729 13.6715729,16 14.5,16 Z" fill="#000000"></path>
                                    <path d="M5.5,10 L9.5,10 C10.3284271,10 11,10.6715729 11,11.5 L11,18.5 C11,19.3284271 10.3284271,20 9.5,20 L5.5,20 C4.67157288,20 4,19.3284271 4,18.5 L4,11.5 C4,10.6715729 4.67157288,10 5.5,10 Z M14.5,4 L18.5,4 C19.3284271,4 20,4.67157288 20,5.5 L20,12.5 C20,13.3284271 19.3284271,14 18.5,14 L14.5,14 C13.6715729,14 13,13.3284271 13,12.5 L13,5.5 C13,4.67157288 13.6715729,4 14.5,4 Z" fill="#000000" opacity="0.3"></path>
                                </g>
                            </svg>

                            <span class="nav-link-text">{$_L['Suppliers']}</span></a>
                        <ul>

                            {if has_access($user->roleid,'suppliers','create')}
                                <li><a href="{$_url}contacts/add/supplier"><span class="nav-link-text">{$_L['Add Supplier']}</span></a></li>
                            {/if}
                            {if has_access($user->roleid,'suppliers','view')}
                                <li><a href="{$_url}contacts/list/supplier"><span class="nav-link-text">{$_L['List Suppliers']}</span></a></li>
                            {/if}

                        </ul>
                    </li>

                {/if}


                {if has_access($user->roleid,'purchase') && ($config['purchase'])}


                    <li class="{if $selected_navigation eq 'purchase'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M4,4 L20,4 C21.1045695,4 22,4.8954305 22,6 L22,18 C22,19.1045695 21.1045695,20 20,20 L4,20 C2.8954305,20 2,19.1045695 2,18 L2,6 C2,4.8954305 2.8954305,4 4,4 Z" fill="#000000" opacity="0.3"/>
                                    <path d="M18.5,11 L5.5,11 C4.67157288,11 4,11.6715729 4,12.5 L4,13 L8.58578644,13 C8.85100293,13 9.10535684,13.1053568 9.29289322,13.2928932 L10.2928932,14.2928932 C10.7456461,14.7456461 11.3597108,15 12,15 C12.6402892,15 13.2543539,14.7456461 13.7071068,14.2928932 L14.7071068,13.2928932 C14.8946432,13.1053568 15.1489971,13 15.4142136,13 L20,13 L20,12.5 C20,11.6715729 19.3284271,11 18.5,11 Z" fill="#000000"/>
                                    <path d="M5.5,6 C4.67157288,6 4,6.67157288 4,7.5 L4,8 L20,8 L20,7.5 C20,6.67157288 19.3284271,6 18.5,6 L5.5,6 Z" fill="#000000"/>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Purchase']}</span></a>
                        <ul class="nav nav-second-level">

                            <li><a href="{$_url}purchases/list"><span class="nav-link-text">{$_L['Purchase Orders']}</span></a></li>
                            <li><a href="{$_url}purchases/add"><span class="nav-link-text">{$_L['New Purchase Order']}</span></a></li>


                        </ul>
                    </li>



                {/if}


                {if has_access($user->roleid,'subscriptions') && (!empty($config['subscriptions'])) && $config['subscriptions']}

                    <li class="{if $selected_navigation eq 'subscriptions'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M2,6 L21,6 C21.5522847,6 22,6.44771525 22,7 L22,17 C22,17.5522847 21.5522847,18 21,18 L2,18 C1.44771525,18 1,17.5522847 1,17 L1,7 C1,6.44771525 1.44771525,6 2,6 Z M11.5,16 C13.709139,16 15.5,14.209139 15.5,12 C15.5,9.790861 13.709139,8 11.5,8 C9.290861,8 7.5,9.790861 7.5,12 C7.5,14.209139 9.290861,16 11.5,16 Z" fill="#000000" opacity="0.3" transform="translate(11.500000, 12.000000) rotate(-345.000000) translate(-11.500000, -12.000000) "/>
                                    <path d="M2,6 L21,6 C21.5522847,6 22,6.44771525 22,7 L22,17 C22,17.5522847 21.5522847,18 21,18 L2,18 C1.44771525,18 1,17.5522847 1,17 L1,7 C1,6.44771525 1.44771525,6 2,6 Z M11.5,16 C13.709139,16 15.5,14.209139 15.5,12 C15.5,9.790861 13.709139,8 11.5,8 C9.290861,8 7.5,9.790861 7.5,12 C7.5,14.209139 9.290861,16 11.5,16 Z M11.5,14 C12.6045695,14 13.5,13.1045695 13.5,12 C13.5,10.8954305 12.6045695,10 11.5,10 C10.3954305,10 9.5,10.8954305 9.5,12 C9.5,13.1045695 10.3954305,14 11.5,14 Z" fill="#000000"/>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Subscriptions']}</span></a>
                        <ul class="nav nav-second-level">

                            <li><a href="{$_url}subscriptions/plans"><span class="nav-link-text">{__('Subscription Plans')}</span></a></li>

                            <li><a href="{$_url}subscriptions/list"><span class="nav-link-text">{$_L['List Subscriptions']}</span></a></li>
                            <li><a href="{$_url}subscriptions/add"><span class="nav-link-text">{$_L['New Subscription']}</span></a></li>
                            <li><a href="{$_url}subscriptions/summary"><span class="nav-link-text">{$_L['Summary']}</span></a></li>


                        </ul>
                    </li>

                {/if}


                {if has_access($user->roleid,'contracts') && (!empty($config['contracts'])) && $config['contracts']}

                    <li class="{if $selected_navigation eq 'contracts'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M8,3 L8,3.5 C8,4.32842712 8.67157288,5 9.5,5 L14.5,5 C15.3284271,5 16,4.32842712 16,3.5 L16,3 L18,3 C19.1045695,3 20,3.8954305 20,5 L20,21 C20,22.1045695 19.1045695,23 18,23 L6,23 C4.8954305,23 4,22.1045695 4,21 L4,5 C4,3.8954305 4.8954305,3 6,3 L8,3 Z" fill="#000000" opacity="0.3"/>
                                    <path d="M10.875,15.75 C10.6354167,15.75 10.3958333,15.6541667 10.2041667,15.4625 L8.2875,13.5458333 C7.90416667,13.1625 7.90416667,12.5875 8.2875,12.2041667 C8.67083333,11.8208333 9.29375,11.8208333 9.62916667,12.2041667 L10.875,13.45 L14.0375,10.2875 C14.4208333,9.90416667 14.9958333,9.90416667 15.3791667,10.2875 C15.7625,10.6708333 15.7625,11.2458333 15.3791667,11.6291667 L11.5458333,15.4625 C11.3541667,15.6541667 11.1145833,15.75 10.875,15.75 Z" fill="#000000"/>
                                    <path d="M11,2 C11,1.44771525 11.4477153,1 12,1 C12.5522847,1 13,1.44771525 13,2 L14.5,2 C14.7761424,2 15,2.22385763 15,2.5 L15,3.5 C15,3.77614237 14.7761424,4 14.5,4 L9.5,4 C9.22385763,4 9,3.77614237 9,3.5 L9,2.5 C9,2.22385763 9.22385763,2 9.5,2 L11,2 Z" fill="#000000"/>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Contracts']}</span></a>
                        <ul class="nav nav-second-level">

                            <li><a href="{$_url}contracts/list"><span class="nav-link-text">{$_L['List Contracts']}</span></a></li>
                            <li><a href="{$_url}contracts/add"><span class="nav-link-text">{$_L['New Contract']}</span></a></li>

                            <li><a href="{$_url}contracts/summary"><span class="nav-link-text">{$_L['Summary']}</span></a></li>


                        </ul>
                    </li>

                {/if}




                {if has_access($user->roleid,'projects') && ($config['projects'])}
                    <li {if $selected_navigation eq 'projects'}class="active"{/if}><a href="{$_url}projects">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M4,9.67471899 L10.880262,13.6470401 C10.9543486,13.689814 11.0320333,13.7207107 11.1111111,13.740321 L11.1111111,21.4444444 L4.49070127,17.526473 C4.18655139,17.3464765 4,17.0193034 4,16.6658832 L4,9.67471899 Z M20,9.56911707 L20,16.6658832 C20,17.0193034 19.8134486,17.3464765 19.5092987,17.526473 L12.8888889,21.4444444 L12.8888889,13.6728275 C12.9050191,13.6647696 12.9210067,13.6561758 12.9368301,13.6470401 L20,9.56911707 Z" fill="#000000"/>
                                    <path d="M4.21611835,7.74669402 C4.30015839,7.64056877 4.40623188,7.55087574 4.5299008,7.48500698 L11.5299008,3.75665466 C11.8237589,3.60013944 12.1762411,3.60013944 12.4700992,3.75665466 L19.4700992,7.48500698 C19.5654307,7.53578262 19.6503066,7.60071528 19.7226939,7.67641889 L12.0479413,12.1074394 C11.9974761,12.1365754 11.9509488,12.1699127 11.9085461,12.2067543 C11.8661433,12.1699127 11.819616,12.1365754 11.7691509,12.1074394 L4.21611835,7.74669402 Z" fill="#000000" opacity="0.3"/>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Projects']}</span></a></li>
                {/if}


                {if has_access($user->roleid,'leads','view') && ($config['leads'])}

                    <li class="{if $selected_navigation eq 'leads'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <circle fill="#000000" opacity="0.3" cx="12" cy="12" r="10"/>
                                    <path d="M12,11 C10.8954305,11 10,10.1045695 10,9 C10,7.8954305 10.8954305,7 12,7 C13.1045695,7 14,7.8954305 14,9 C14,10.1045695 13.1045695,11 12,11 Z M7.00036205,16.4995035 C7.21569918,13.5165724 9.36772908,12 11.9907452,12 C14.6506758,12 16.8360465,13.4332455 16.9988413,16.5 C17.0053266,16.6221713 16.9988413,17 16.5815,17 L7.4041679,17 C7.26484009,17 6.98863236,16.6619875 7.00036205,16.4995035 Z" fill="#000000" opacity="0.3"/>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Leads']}</span></a>
                        <ul class="nav nav-second-level">

                            <li><a href="{$_url}leads/"><span class="nav-link-text">{$_L['Leads']}</span></a></li>
                            <li><a href="{$_url}leads/web-to-lead/"><span class="nav-link-text">{$_L['Web to Lead']}</span></a></li>

                        </ul>
                    </li>

                {/if}


                {if has_access($user->roleid,'sms') && ($config['sms'])}

                    <li class="{if $selected_navigation eq 'sms'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M21.9999843,15.009808 L22.0249378,15 L22.0249378,19.5857864 C22.0249378,20.1380712 21.5772226,20.5857864 21.0249378,20.5857864 C20.7597213,20.5857864 20.5053674,20.4804296 20.317831,20.2928932 L18.0249378,18 L5,18 C3.34314575,18 2,16.6568542 2,15 L2,6 C2,4.34314575 3.34314575,3 5,3 L19,3 C20.6568542,3 22,4.34314575 22,6 L22,15 C22,15.0032706 21.9999948,15.0065399 21.9999843,15.009808 Z M6.16794971,10.5547002 C7.67758127,12.8191475 9.64566871,14 12,14 C14.3543313,14 16.3224187,12.8191475 17.8320503,10.5547002 C18.1384028,10.0951715 18.0142289,9.47430216 17.5547002,9.16794971 C17.0951715,8.86159725 16.4743022,8.98577112 16.1679497,9.4452998 C15.0109146,11.1808525 13.6456687,12 12,12 C10.3543313,12 8.9890854,11.1808525 7.83205029,9.4452998 C7.52569784,8.98577112 6.90482849,8.86159725 6.4452998,9.16794971 C5.98577112,9.47430216 5.86159725,10.0951715 6.16794971,10.5547002 Z" fill="#000000"/>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['SMS']}</span></a>
                        <ul>

                            <li><a href="{$_url}sms/init/send"><span class="nav-link-text">{$_L['Send Single SMS']}</span></a></li>
                            <li><a href="{$_url}sms/init/bulk"><span class="nav-link-text">{$_L['Send Bulk SMS']}</span></a></li>
                            <li><a href="{$_url}sms/init/sent"><span class="nav-link-text">{$_L['Sent']}</span></a></li>
                            <li><a href="{$_url}sms/init/templates"><span class="nav-link-text">{$_L['SMS Templates']}</span></a></li>
                            <li><a href="{$_url}sms/init/settings"><span class="nav-link-text">{$_L['Settings']}</span></a></li>


                        </ul>
                    </li>



                {/if}


                {if has_access($user->roleid,'support') && ($config['support'])}

                    <li class="{if $selected_navigation eq 'support'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M7.14296018,11.6653622 C7.06267828,11.7456441 6.95746388,11.7962128 6.84462255,11.8087507 C6.57016914,11.8392455 6.32295974,11.641478 6.29246492,11.3670246 L5.76926113,6.65819047 C5.76518362,6.62149288 5.76518362,6.58445654 5.76926113,6.54775895 C5.79975595,6.27330553 6.04696535,6.07553802 6.32141876,6.10603284 L11.0302529,6.62923663 C11.1430942,6.64177456 11.2483086,6.69234321 11.3285905,6.77262511 C11.5238526,6.96788726 11.5238526,7.28446974 11.3285905,7.47973189 L9.94288211,8.86544026 L11.4443443,10.3669024 C11.6396064,10.5621646 11.6396064,10.8787471 11.4443443,11.0740092 L10.7372375,11.781116 C10.5419754,11.9763782 10.2253929,11.9763782 10.0301307,11.781116 L8.52866855,10.2796538 L7.14296018,11.6653622 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                    <path d="M12.0799676,14.7839934 L14.2839934,12.5799676 C14.8927139,11.9712471 15.0436229,11.0413042 14.6586342,10.2713269 L14.5337539,10.0215663 C14.1487653,9.25158901 14.2996742,8.3216461 14.9083948,7.71292558 L17.6411989,4.98012149 C17.836461,4.78485934 18.1530435,4.78485934 18.3483056,4.98012149 C18.3863063,5.01812215 18.4179321,5.06200062 18.4419658,5.11006808 L19.5459415,7.31801948 C20.3904962,9.0071287 20.0594452,11.0471565 18.7240871,12.3825146 L12.7252616,18.3813401 C11.2717221,19.8348796 9.12170075,20.3424308 7.17157288,19.6923882 L4.75709327,18.8875616 C4.49512161,18.8002377 4.35354162,18.5170777 4.4408655,18.2551061 C4.46541191,18.1814669 4.50676633,18.114554 4.56165376,18.0596666 L7.21292558,15.4083948 C7.8216461,14.7996742 8.75158901,14.6487653 9.52156634,15.0337539 L9.77132688,15.1586342 C10.5413042,15.5436229 11.4712471,15.3927139 12.0799676,14.7839934 Z" fill="#000000"/>
                                </g>

                                <span class="nav-link-text">{$_L['Support']}</span></a>
                        <ul>

                            <li><a href="{$_url}tickets/admin/create"><span class="nav-link-text">{$_L['Open New Ticket']}</span></a></li>
                            <li><a href="{$_url}tickets/admin/list"><span class="nav-link-text">{$_L['Tickets']}</span></a></li>
                            <li><a href="{$_url}tickets/admin/predefined_replies"><span class="nav-link-text">{$_L['Predefined Replies']}</span></a></li>
                            <li><a href="{$_url}tickets/admin/departments"><span class="nav-link-text">{$_L['Departments']}</span></a></li>


                        </ul>
                    </li>


                {/if}


                {if has_access($user->roleid,'kb') && ($config['kb'])}

                    <li class="{if $selected_navigation eq 'kb'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"></rect>
                                    <path d="M13.6855025,18.7082217 C15.9113859,17.8189707 18.682885,17.2495635 22,17 C22,16.9325178 22,13.1012863 22,5.50630526 L21.9999762,5.50630526 C21.9999762,5.23017604 21.7761292,5.00632908 21.5,5.00632908 C21.4957817,5.00632908 21.4915635,5.00638247 21.4873465,5.00648922 C18.658231,5.07811173 15.8291155,5.74261533 13,7 C13,7.04449645 13,10.79246 13,18.2438906 L12.9999854,18.2438906 C12.9999854,18.520041 13.2238496,18.7439052 13.5,18.7439052 C13.5635398,18.7439052 13.6264972,18.7317946 13.6855025,18.7082217 Z" fill="#000000"></path>
                                    <path d="M10.3144829,18.7082217 C8.08859955,17.8189707 5.31710038,17.2495635 1.99998542,17 C1.99998542,16.9325178 1.99998542,13.1012863 1.99998542,5.50630526 L2.00000925,5.50630526 C2.00000925,5.23017604 2.22385621,5.00632908 2.49998542,5.00632908 C2.50420375,5.00632908 2.5084219,5.00638247 2.51263888,5.00648922 C5.34175439,5.07811173 8.17086991,5.74261533 10.9999854,7 C10.9999854,7.04449645 10.9999854,10.79246 10.9999854,18.2438906 L11,18.2438906 C11,18.520041 10.7761358,18.7439052 10.4999854,18.7439052 C10.4364457,18.7439052 10.3734882,18.7317946 10.3144829,18.7082217 Z" fill="#000000" opacity="0.3"></path>
                                </g>
                            </svg>
                            <span class="nav-link-text">{$_L['Knowledgebase']}</span></a>
                        <ul>

                            {if has_access($user->roleid,'kb','create')}
                                <li><a href="{$_url}kb/a/edit"><span class="nav-link-text">{$_L['New Article']}</span></a></li>
                            {/if}
                            <li><a href="{$_url}kb/a/all"><span class="nav-link-text">{$_L['All Articles']}</span></a></li>


                        </ul>
                    </li>



                {/if}
                {if has_access($user->roleid,'orders') && ($config['orders'])}

                    {if ($config['orders'] eq '1')}



                        <li class="{if $selected_navigation eq 'orders'}active open{/if}">
                            <a href="#">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <path d="M14,9 L14,8 C14,6.8954305 13.1045695,6 12,6 C10.8954305,6 10,6.8954305 10,8 L10,9 L8,9 L8,8 C8,5.790861 9.790861,4 12,4 C14.209139,4 16,5.790861 16,8 L16,9 L14,9 Z M14,9 L14,8 C14,6.8954305 13.1045695,6 12,6 C10.8954305,6 10,6.8954305 10,8 L10,9 L8,9 L8,8 C8,5.790861 9.790861,4 12,4 C14.209139,4 16,5.790861 16,8 L16,9 L14,9 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                        <path d="M6.84712709,9 L17.1528729,9 C17.6417121,9 18.0589022,9.35341304 18.1392668,9.83560101 L19.611867,18.671202 C19.7934571,19.7607427 19.0574178,20.7911977 17.9678771,20.9727878 C17.8592143,20.9908983 17.7492409,21 17.6390792,21 L6.36092084,21 C5.25635134,21 4.36092084,20.1045695 4.36092084,19 C4.36092084,18.8898383 4.37002252,18.7798649 4.388133,18.671202 L5.86073316,9.83560101 C5.94109783,9.35341304 6.35828794,9 6.84712709,9 Z" fill="#000000"/>
                                    </g>

                                    <span class="nav-link-text">{$_L['Orders']}</span></a>
                            <ul>
                                <li><a href="{$_url}orders/list"><span class="nav-link-text">{$_L['List All Orders']}</span></a></li>
                                <li><a href="{$_url}orders/add"><span class="nav-link-text">{$_L['Add New Order']}</span></a></li>

                            </ul>
                        </li>

                    {/if}

                {/if}
                {if has_access($user->roleid,'hr') && ($config['hrm'])}

                    {if ($config['hrm'] eq '1')}

                        <li class="{if $selected_navigation eq 'hrm'}active open{/if}">
                            <a href="#">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <polygon points="0 0 24 0 24 24 0 24"/>
                                        <path d="M18,14 C16.3431458,14 15,12.6568542 15,11 C15,9.34314575 16.3431458,8 18,8 C19.6568542,8 21,9.34314575 21,11 C21,12.6568542 19.6568542,14 18,14 Z M9,11 C6.790861,11 5,9.209139 5,7 C5,4.790861 6.790861,3 9,3 C11.209139,3 13,4.790861 13,7 C13,9.209139 11.209139,11 9,11 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                                        <path d="M17.6011961,15.0006174 C21.0077043,15.0378534 23.7891749,16.7601418 23.9984937,20.4 C24.0069246,20.5466056 23.9984937,21 23.4559499,21 L19.6,21 C19.6,18.7490654 18.8562935,16.6718327 17.6011961,15.0006174 Z M0.00065168429,20.1992055 C0.388258525,15.4265159 4.26191235,13 8.98334134,13 C13.7712164,13 17.7048837,15.2931929 17.9979143,20.2 C18.0095879,20.3954741 17.9979143,21 17.2466999,21 C13.541124,21 8.03472472,21 0.727502227,21 C0.476712155,21 -0.0204617505,20.45918 0.00065168429,20.1992055 Z" fill="#000000" fill-rule="nonzero"/>
                                    </g>

                                    <span class="nav-link-text">
                                        <span class="nav-link-text">{$_L['HRM']}</span></span></a>
                            <ul>
                                <li><a href="{$_url}hrm/employees"><span class="nav-link-text">{$_L['Employees']}</span></a></li>
                                <li><a href="{$_url}hrm/attendance"><span class="nav-link-text">{$_L['Attendance']}</span></a></li>
                                <li><a href="{$_url}hrm/payroll"><span class="nav-link-text">{$_L['Payroll']}</span></a></li>
{*                                <li><a href="{$_url}hrm/departments"><span class="nav-link-text">{$_L['Departments']}</span></a></li>*}


                            </ul>
                        </li>

                    {/if}

                {/if}


                {if has_access($user->roleid,'documents') && ($config['documents'])}
                    <li {if $selected_navigation eq 'documents'}class="active open"{/if}>
                        <a href="{$_url}documents">
                            {*                                <i class="fal fa-file"></i>*}

                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M4.5,21 L21.5,21 C22.3284271,21 23,20.3284271 23,19.5 L23,8.5 C23,7.67157288 22.3284271,7 21.5,7 L11,7 L8.43933983,4.43933983 C8.15803526,4.15803526 7.77650439,4 7.37867966,4 L4.5,4 C3.67157288,4 3,4.67157288 3,5.5 L3,19.5 C3,20.3284271 3.67157288,21 4.5,21 Z" fill="#000000" opacity="0.3"/>
                                    <path d="M2.5,19 L19.5,19 C20.3284271,19 21,18.3284271 21,17.5 L21,6.5 C21,5.67157288 20.3284271,5 19.5,5 L9,5 L6.43933983,2.43933983 C6.15803526,2.15803526 5.77650439,2 5.37867966,2 L2.5,2 C1.67157288,2 1,2.67157288 1,3.5 L1,17.5 C1,18.3284271 1.67157288,19 2.5,19 Z" fill="#000000"/>
                                </g></svg>



                            <span class="nav-link-text">{$_L['Documents']}</span></a></li>
                {/if}



                {if has_access($user->roleid,'tasks') && ($config['tasks'])}
                    <li {if $selected_navigation eq 'tasks'}class="active open"{/if}><a href="{$_url}tasks">

                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M10,4 L21,4 C21.5522847,4 22,4.44771525 22,5 L22,7 C22,7.55228475 21.5522847,8 21,8 L10,8 C9.44771525,8 9,7.55228475 9,7 L9,5 C9,4.44771525 9.44771525,4 10,4 Z M10,10 L21,10 C21.5522847,10 22,10.4477153 22,11 L22,13 C22,13.5522847 21.5522847,14 21,14 L10,14 C9.44771525,14 9,13.5522847 9,13 L9,11 C9,10.4477153 9.44771525,10 10,10 Z M10,16 L21,16 C21.5522847,16 22,16.4477153 22,17 L22,19 C22,19.5522847 21.5522847,20 21,20 L10,20 C9.44771525,20 9,19.5522847 9,19 L9,17 C9,16.4477153 9.44771525,16 10,16 Z" fill="#000000"/>
                                    <rect fill="#000000" opacity="0.3" x="2" y="4" width="5" height="16" rx="1"/>
                                </g>

                                <span class="nav-link-text">{$_L['Tasks']}</span></a></li>
                {/if}



                {if has_access($user->roleid,'calendar') && ($config['calendar'])}
                    <li {if $selected_navigation eq 'calendar'}class="active open"{/if}><a href="{$_url}calendar/events">
                            {*                                <i class="fal fa-calendar-check"></i>*}

                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M10.9630156,7.5 L11.0475062,7.5 C11.3043819,7.5 11.5194647,7.69464724 11.5450248,7.95024814 L12,12.5 L15.2480695,14.3560397 C15.403857,14.4450611 15.5,14.6107328 15.5,14.7901613 L15.5,15 C15.5,15.2109164 15.3290185,15.3818979 15.1181021,15.3818979 C15.0841582,15.3818979 15.0503659,15.3773725 15.0176181,15.3684413 L10.3986612,14.1087258 C10.1672824,14.0456225 10.0132986,13.8271186 10.0316926,13.5879956 L10.4644883,7.96165175 C10.4845267,7.70115317 10.7017474,7.5 10.9630156,7.5 Z" fill="#000000"/>
                                    <path d="M7.38979581,2.8349582 C8.65216735,2.29743306 10.0413491,2 11.5,2 C17.2989899,2 22,6.70101013 22,12.5 C22,18.2989899 17.2989899,23 11.5,23 C5.70101013,23 1,18.2989899 1,12.5 C1,11.5151324 1.13559454,10.5619345 1.38913364,9.65805651 L3.31481075,10.1982117 C3.10672013,10.940064 3,11.7119264 3,12.5 C3,17.1944204 6.80557963,21 11.5,21 C16.1944204,21 20,17.1944204 20,12.5 C20,7.80557963 16.1944204,4 11.5,4 C10.54876,4 9.62236069,4.15592757 8.74872191,4.45446326 L9.93948308,5.87355717 C10.0088058,5.95617272 10.0495583,6.05898805 10.05566,6.16666224 C10.0712834,6.4423623 9.86044965,6.67852665 9.5847496,6.69415008 L4.71777931,6.96995273 C4.66931162,6.97269931 4.62070229,6.96837279 4.57348157,6.95710938 C4.30487471,6.89303938 4.13906482,6.62335149 4.20313482,6.35474463 L5.33163823,1.62361064 C5.35654118,1.51920756 5.41437908,1.4255891 5.49660017,1.35659741 C5.7081375,1.17909652 6.0235153,1.2066885 6.2010162,1.41822583 L7.38979581,2.8349582 Z" fill="#000000" opacity="0.3"/>
                                </g>
                                <span class="nav-link-text">{$_L['Calendar']}</span></a></li>
                {/if}
                {$admin_extra_nav[4]}
                {$admin_extra_nav[5]}

                {if has_access($user->roleid,'products_n_services')}

                    {if ($config['invoicing'] eq '1') OR ($config['quotes'] eq '1')}
                        <li class="{if $selected_navigation eq 'ps'}active open{/if}">
                            <a href="#">

                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <rect x="0" y="0" width="24" height="24"/>
                                        <path d="M5.5,2 L18.5,2 C19.3284271,2 20,2.67157288 20,3.5 L20,6.5 C20,7.32842712 19.3284271,8 18.5,8 L5.5,8 C4.67157288,8 4,7.32842712 4,6.5 L4,3.5 C4,2.67157288 4.67157288,2 5.5,2 Z M11,4 C10.4477153,4 10,4.44771525 10,5 C10,5.55228475 10.4477153,6 11,6 L13,6 C13.5522847,6 14,5.55228475 14,5 C14,4.44771525 13.5522847,4 13,4 L11,4 Z" fill="#000000" opacity="0.3"/>
                                        <path d="M5.5,9 L18.5,9 C19.3284271,9 20,9.67157288 20,10.5 L20,13.5 C20,14.3284271 19.3284271,15 18.5,15 L5.5,15 C4.67157288,15 4,14.3284271 4,13.5 L4,10.5 C4,9.67157288 4.67157288,9 5.5,9 Z M11,11 C10.4477153,11 10,11.4477153 10,12 C10,12.5522847 10.4477153,13 11,13 L13,13 C13.5522847,13 14,12.5522847 14,12 C14,11.4477153 13.5522847,11 13,11 L11,11 Z M5.5,16 L18.5,16 C19.3284271,16 20,16.6715729 20,17.5 L20,20.5 C20,21.3284271 19.3284271,22 18.5,22 L5.5,22 C4.67157288,22 4,21.3284271 4,20.5 L4,17.5 C4,16.6715729 4.67157288,16 5.5,16 Z M11,18 C10.4477153,18 10,18.4477153 10,19 C10,19.5522847 10.4477153,20 11,20 L13,20 C13.5522847,20 14,19.5522847 14,19 C14,18.4477153 13.5522847,18 13,18 L11,18 Z" fill="#000000"/>
                                    </g>



                                    <span class="nav-link-text">{$_L['Products n Services']}</span>
                            </a>
                            <ul>
                                {if $config['inventory'] eq '1'}
                                    {*<li><a href="{$_url}inventory/dashboard/">{$_L['Inventory']}</a></li>*}
                                {/if}
                                <li><a href="{$_url}ps/products"><span class="nav-link-text">{$_L['Products']}</span> </a></li>
                                <li><a href="{$_url}ps/p-new"><span class="nav-link-text">{$_L['New Product']}</span></a></li>
                                <li><a href="{$_url}ps/services"><span class="nav-link-text">{$_L['Services']}</span></a></li>
                                <li><a href="{$_url}ps/s-new"><span class="nav-link-text">{$_L['New Service']}</span></a></li>


                            </ul>
                        </li>
                    {/if}

                {/if}

                {$admin_extra_nav[6]}

                {if has_access($user->roleid,'reports')}



                    <li class="{if $selected_navigation eq 'reports'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <rect fill="#000000" opacity="0.3" x="12" y="4" width="3" height="13" rx="1.5"/>
                                    <rect fill="#000000" opacity="0.3" x="7" y="9" width="3" height="8" rx="1.5"/>
                                    <path d="M5,19 L20,19 C20.5522847,19 21,19.4477153 21,20 C21,20.5522847 20.5522847,21 20,21 L4,21 C3.44771525,21 3,20.5522847 3,20 L3,4 C3,3.44771525 3.44771525,3 4,3 C4.55228475,3 5,3.44771525 5,4 L5,19 Z" fill="#000000" fill-rule="nonzero"/>
                                    <rect fill="#000000" opacity="0.3" x="17" y="11" width="3" height="6" rx="1.5"/>
                                </g>

                                <span class="nav-link-text">{$_L['Reports']} </span></a>
                        <ul>



                            {if $config['accounting'] eq '1'}

                                <li><a href="{$_url}transactions/list/0/0/reports"><span class="nav-link-text">{$_L['Transactions']}</span> </a></li>
                                <li><a href="{$_url}reports/invoices"><span class="nav-link-text">{$_L['Invoices']}</span></a></li>
                                <li><a href="{$_url}reports/purchases"><span class="nav-link-text">{$_L['Purchases']}</span></a></li>
                                <li><a href="{$_url}reports/statement"><span class="nav-link-text">{$_L['Account Statement']}</span></a></li>
                                <li><a href="{$_url}reports/income"><span class="nav-link-text">{$_L['Income Reports']}</span></a></li>
                                <li><a href="{$_url}reports/expense"><span class="nav-link-text">{$_L['Expense Reports']}</span></a></li>
                                <li><a href="{$_url}reports/income-vs-expense"><span class="nav-link-text">{$_L['Income Vs Expense']}</span></a></li>
                                <li><a href="{$_url}reports/by-date"><span class="nav-link-text">{$_L['Reports by Date']}</span></a></li>
                                <li><a href="{$_url}transactions/list/0/income/reports"><span class="nav-link-text">{$_L['All Income']}</span></a></li>
                                <li><a href="{$_url}transactions/list/0/expense/reports"><span class="nav-link-text">{$_L['All Expense']}</span></a></li>


                            {/if}



                            <li><a href="{$_url}reports/sales">{$_L['Sales']}</a></li>


                            <li><a href="{$_url}reports/invoices_expense">{$_L['Invoices Vs Expense']}</a></li>


                            <li><a href="{$_url}reports/export">{$_L['Export']}</a></li>

                            {foreach $sub_menu_admin['reports'] as $sm_report}

                                {$sm_report}


                            {/foreach}


                        </ul>
                    </li>

                {/if}

                {if has_access($user->roleid,'utilities')}

                    <li class="{if $selected_navigation eq 'util'}active open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M9,15 L7.5,15 C6.67157288,15 6,15.6715729 6,16.5 C6,17.3284271 6.67157288,18 7.5,18 C8.32842712,18 9,17.3284271 9,16.5 L9,15 Z M9,15 L9,9 L15,9 L15,15 L9,15 Z M15,16.5 C15,17.3284271 15.6715729,18 16.5,18 C17.3284271,18 18,17.3284271 18,16.5 C18,15.6715729 17.3284271,15 16.5,15 L15,15 L15,16.5 Z M16.5,9 C17.3284271,9 18,8.32842712 18,7.5 C18,6.67157288 17.3284271,6 16.5,6 C15.6715729,6 15,6.67157288 15,7.5 L15,9 L16.5,9 Z M9,7.5 C9,6.67157288 8.32842712,6 7.5,6 C6.67157288,6 6,6.67157288 6,7.5 C6,8.32842712 6.67157288,9 7.5,9 L9,9 L9,7.5 Z M11,13 L13,13 L13,11 L11,11 L11,13 Z M13,11 L13,7.5 C13,5.56700338 14.5670034,4 16.5,4 C18.4329966,4 20,5.56700338 20,7.5 C20,9.43299662 18.4329966,11 16.5,11 L13,11 Z M16.5,13 C18.4329966,13 20,14.5670034 20,16.5 C20,18.4329966 18.4329966,20 16.5,20 C14.5670034,20 13,18.4329966 13,16.5 L13,13 L16.5,13 Z M11,16.5 C11,18.4329966 9.43299662,20 7.5,20 C5.56700338,20 4,18.4329966 4,16.5 C4,14.5670034 5.56700338,13 7.5,13 L11,13 L11,16.5 Z M7.5,11 C5.56700338,11 4,9.43299662 4,7.5 C4,5.56700338 5.56700338,4 7.5,4 C9.43299662,4 11,5.56700338 11,7.5 L11,11 L7.5,11 Z" fill="#000000" fill-rule="nonzero"/>
                                </g>



                                <span class="nav-link-text">{$_L['Utilities']} </span></a>
                        <ul class="nav nav-second-level">
                            <li><a href="{$_url}util/activity"><span class="nav-link-text">{$_L['Activity Log']}</span></a></li>
                            <li><a href="{$_url}util/sent-emails"><span class="nav-link-text">{$_L['Email Message Log']}</span></a></li>
                            <li><a href="{$_url}util/invoice_access_log"><span class="nav-link-text">{$_L['Invoice Access Log']}</span></a></li>
                            <li><a href="{$_url}util/backups"><span class="nav-link-text">{$_L['Backup']}</span></a></li>
                            <li><a href="{$_url}util/dbstatus"><span class="nav-link-text">{$_L['Database Status']}</span></a></li>
                            <li><a href="{$_url}util/cronlogs"><span class="nav-link-text">{$_L['CRON Log']}</span></a></li>
                            <li><a href="{$_url}util/integrationcode"><span class="nav-link-text">{$_L['Integration Code']}</span></a></li>
                            <li><a href="{$_url}util/sys_status"><span class="nav-link-text">{$_L['System Status']}</span></a></li>
                            {*                                <li><a href="{$_url}terminal">{$_L['Terminal']}</a></li>*}
                            {*<li><a id="app_media" href="javascript:;" data-src="{$_url}mediabox">{$_L['Media']}</a></li>*}

                            {if ($config['password_manager']) && has_access($user->roleid,'password_manager')}
                                <li><a href="{$_url}password_manager"><span class="nav-link-text">{$_L['Password Manager']}</span></a></li>
                            {/if}

                            {foreach $sub_menu_admin['utilities'] as $sm_utility}

                                {$sm_utility}


                            {/foreach}

                            <li><a href="{$_url}util/tools"><span class="nav-link-text">{$_L['Tools']}</span></a></li>
                        </ul>
                    </li>

                {/if}

                {if has_access($user->roleid,'appearance')}

                    <li class="{if $selected_navigation eq 'appearance'}active open{/if}" id="li_appearance">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M2.56066017,10.6819805 L4.68198052,8.56066017 C5.26776695,7.97487373 6.21751442,7.97487373 6.80330086,8.56066017 L8.9246212,10.6819805 C9.51040764,11.267767 9.51040764,12.2175144 8.9246212,12.8033009 L6.80330086,14.9246212 C6.21751442,15.5104076 5.26776695,15.5104076 4.68198052,14.9246212 L2.56066017,12.8033009 C1.97487373,12.2175144 1.97487373,11.267767 2.56066017,10.6819805 Z M14.5606602,10.6819805 L16.6819805,8.56066017 C17.267767,7.97487373 18.2175144,7.97487373 18.8033009,8.56066017 L20.9246212,10.6819805 C21.5104076,11.267767 21.5104076,12.2175144 20.9246212,12.8033009 L18.8033009,14.9246212 C18.2175144,15.5104076 17.267767,15.5104076 16.6819805,14.9246212 L14.5606602,12.8033009 C13.9748737,12.2175144 13.9748737,11.267767 14.5606602,10.6819805 Z" fill="#000000" opacity="0.3"/>
                                    <path d="M8.56066017,16.6819805 L10.6819805,14.5606602 C11.267767,13.9748737 12.2175144,13.9748737 12.8033009,14.5606602 L14.9246212,16.6819805 C15.5104076,17.267767 15.5104076,18.2175144 14.9246212,18.8033009 L12.8033009,20.9246212 C12.2175144,21.5104076 11.267767,21.5104076 10.6819805,20.9246212 L8.56066017,18.8033009 C7.97487373,18.2175144 7.97487373,17.267767 8.56066017,16.6819805 Z M8.56066017,4.68198052 L10.6819805,2.56066017 C11.267767,1.97487373 12.2175144,1.97487373 12.8033009,2.56066017 L14.9246212,4.68198052 C15.5104076,5.26776695 15.5104076,6.21751442 14.9246212,6.80330086 L12.8033009,8.9246212 C12.2175144,9.51040764 11.267767,9.51040764 10.6819805,8.9246212 L8.56066017,6.80330086 C7.97487373,6.21751442 7.97487373,5.26776695 8.56066017,4.68198052 Z" fill="#000000"/>
                                </g>


                                <span class="nav-link-text">{$_L['Appearance']} </span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">

                            <li><a href="{$_url}appearance/ui"><span class="nav-link-text">{$_L['User Interface']}</span></a></li>
                            <li><a href="{$_url}appearance/customize"><span class="nav-link-text">{$_L['Customize']}</span></a></li>

                            {foreach $sub_menu_admin['appearance'] as $sm_appearance}

                                {$sm_appearance}


                            {/foreach}

                            <li><a href="{$_url}appearance/editor"><span class="nav-link-text">{$_L['Editor']}</span></a></li>

                            <li><a href="{$_url}appearance/themes"><span class="nav-link-text">{$_L['Themes']}</span></a></li>

                        </ul>
                    </li>

                {/if}

                {if has_access($user->roleid,'plugins') && ($config['plugins'])}
                    <li {if $selected_navigation eq 'plugins'}class="active open"{/if}><a href="{$_url}settings/plugins/">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M12.4644661,14.5355339 L9.46446609,14.5355339 C8.91218134,14.5355339 8.46446609,14.9832492 8.46446609,15.5355339 C8.46446609,16.0878187 8.91218134,16.5355339 9.46446609,16.5355339 L12.4644661,16.5355339 L12.4644661,17.5355339 C12.4644661,18.6401034 11.5690356,19.5355339 10.4644661,19.5355339 L6.46446609,19.5355339 C5.35989659,19.5355339 4.46446609,18.6401034 4.46446609,17.5355339 L4.46446609,13.5355339 C4.46446609,12.4309644 5.35989659,11.5355339 6.46446609,11.5355339 L10.4644661,11.5355339 C11.5690356,11.5355339 12.4644661,12.4309644 12.4644661,13.5355339 L12.4644661,14.5355339 Z" fill="#000000" opacity="0.3" transform="translate(8.464466, 15.535534) rotate(-45.000000) translate(-8.464466, -15.535534) "/>
                                    <path d="M11.5355339,9.46446609 L14.5355339,9.46446609 C15.0878187,9.46446609 15.5355339,9.01675084 15.5355339,8.46446609 C15.5355339,7.91218134 15.0878187,7.46446609 14.5355339,7.46446609 L11.5355339,7.46446609 L11.5355339,6.46446609 C11.5355339,5.35989659 12.4309644,4.46446609 13.5355339,4.46446609 L17.5355339,4.46446609 C18.6401034,4.46446609 19.5355339,5.35989659 19.5355339,6.46446609 L19.5355339,10.4644661 C19.5355339,11.5690356 18.6401034,12.4644661 17.5355339,12.4644661 L13.5355339,12.4644661 C12.4309644,12.4644661 11.5355339,11.5690356 11.5355339,10.4644661 L11.5355339,9.46446609 Z" fill="#000000" transform="translate(15.535534, 8.464466) rotate(-45.000000) translate(-15.535534, -8.464466) "/>
                                </g>


                                <span class="nav-link-text">{$_L['Plugins']}</span></a></li>
                {/if}


                {if has_access($user->roleid,'settings')}
                    <li class="{if $selected_navigation eq 'settings'}active open{/if}" id="li_settings">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <rect x="0" y="0" width="24" height="24"/>
                                    <path d="M5,8.6862915 L5,5 L8.6862915,5 L11.5857864,2.10050506 L14.4852814,5 L19,5 L19,9.51471863 L21.4852814,12 L19,14.4852814 L19,19 L14.4852814,19 L11.5857864,21.8994949 L8.6862915,19 L5,19 L5,15.3137085 L1.6862915,12 L5,8.6862915 Z M12,15 C13.6568542,15 15,13.6568542 15,12 C15,10.3431458 13.6568542,9 12,9 C10.3431458,9 9,10.3431458 9,12 C9,13.6568542 10.3431458,15 12,15 Z" fill="#000000"/>
                                </g>


                                <span class="nav-link-text">{$_L['Settings']} </span></a>
                        <ul class="nav nav-second-level">
                            <li><a href="{$_url}settings/app"><span class="nav-link-text">{$_L['General Settings']}</span></a></li>
                            <li><a href="{$_url}settings/users"><span class="nav-link-text">{$_L['Staff']}</span></a></li>
                            <li><a href="{$_url}settings/roles"><span class="nav-link-text">{$_L['Roles']}</span></a></li>
                            <li><a href="{$_url}settings/localisation"><span class="nav-link-text">{$_L['Localisation']}</span></a></li>
                            <li><a href="{$_url}settings/currencies"><span class="nav-link-text">{$_L['Currencies']}</span></a></li>
                            <li><a href="{$_url}settings/pg"><span class="nav-link-text">{$_L['Payment Gateways']}</span></a></li>

                            {if $config['accounting'] eq '1'}
                                <li><a href="{$_url}settings/expense-categories"><span class="nav-link-text">{$_L['Expense Categories']}</span></a></li>
                                <li><a href="{$_url}settings/expense-types"><span class="nav-link-text">{$_L['Expense Types']}</span></a></li>
                                <li><a href="{$_url}settings/income-categories"><span class="nav-link-text">{$_L['Income Categories']}</span></a></li>
                                <li><a href="{$_url}settings/units"><span class="nav-link-text">{$_L['Units']}</span></a></li>
                                <li><a href="{$_url}settings/tags"><span class="nav-link-text">{$_L['Manage Tags']}</span></a></li>
                                <li><a href="{$_url}settings/pmethods"><span class="nav-link-text">{$_L['Payment Methods']}</span></a></li>
                                <li><a href="{$_url}tax/list"><span class="nav-link-text">{$_L['Sales Taxes']}</span></a></li>
                            {/if}


                            <li><a href="{$_url}settings/emls"><span class="nav-link-text">{$_L['Email Settings']}</span></a></li>
                            <li><a href="{$_url}settings/email-templates"><span class="nav-link-text">{$_L['Email Templates']}</span></a></li>
                            <li><a href="{$_url}settings/customfields"><span class="nav-link-text">{$_L['Custom Contact Fields']}</span></a></li>
                            <li><a href="{$_url}settings/automation"><span class="nav-link-text">{$_L['Automation Settings']}</span></a></li>
                            <li><a href="{$_url}settings/api"><span class="nav-link-text">{$_L['API Access']}</span></a></li>
                            {foreach $sub_menu_admin['settings'] as $sm_settings}

                                {$sm_settings}


                            {/foreach}
                            <li><a href="{$_url}settings/features"><span class="nav-link-text">{$_L['Choose Features']}</span></a></li>

{*                            {if !defined('DISABLE_ABOUT_PAGE')}*}
{*                                <li><a href="{$_url}settings/about/">{$_L['About']}</a></li>*}
{*                            {/if}*}







                        </ul>
                    </li>
                {/if}


            </ul>
        </nav>

    </aside>

    <div class="page-content-wrapper">
        <header class="page-header" role="banner">
            <div class="page-logo">
                <a href="{$_url}dashboard" class="page-logo-link press-scale-down d-flex align-items-center position-relative">
                    {if isset($config['logo_square'])}
                        <img src="{{APP_URL}}/storage/system/{{$config['logo_square']}}" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                    {else}
                        <img src="{{APP_URL}}/storage/system/logo-512x512.png?v=2" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                    {/if}

                    {if isset($config['logo_text'])}
                        <span class="page-logo-text mr-1">{{$config['logo_text']}}</span>
                    {else}
                        <span class="page-logo-text mr-1">CloudOnex</span>
                    {/if}


                    <span class="position-absolute text-white opacity-50 small pos-top pos-right mr-2 mt-n2"></span>
                </a>
            </div>
            <!-- DOC: nav menu layout change shortcut -->
            <div class="hidden-md-down dropdown-icon-menu position-relative">
                <a href="#" class="header-btn btn js-waves-off svg-icon svg-icon-primary rounded-0" style="border: none;" data-action="toggle" data-class="nav-function-hidden" title="Hide Navigation">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="32px" height="32px" viewBox="0 0 24 24" version="1.1">
                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <rect x="0" y="0" width="24" height="24"></rect>
                            <rect fill="#000000" opacity="0.3" x="4" y="5" width="16" height="2" rx="1"></rect>
                            <rect fill="#000000" opacity="0.3" x="4" y="13" width="16" height="2" rx="1"></rect>
                            <path d="M5,9 L13,9 C13.5522847,9 14,9.44771525 14,10 C14,10.5522847 13.5522847,11 13,11 L5,11 C4.44771525,11 4,10.5522847 4,10 C4,9.44771525 4.44771525,9 5,9 Z M5,17 L13,17 C13.5522847,17 14,17.4477153 14,18 C14,18.5522847 13.5522847,19 13,19 L5,19 C4.44771525,19 4,18.5522847 4,18 C4,17.4477153 4.44771525,17 5,17 Z" fill="#000000"></path>
                        </g>
                    </svg>
                </a>
                <ul>
                    <li>
                        <a href="#" class="btn js-waves-off" data-action="toggle" data-class="nav-function-minify" title="Minify Navigation">
                                <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <polygon points="0 0 24 0 24 24 0 24"/>
        <path d="M5.29288961,6.70710318 C4.90236532,6.31657888 4.90236532,5.68341391 5.29288961,5.29288961 C5.68341391,4.90236532 6.31657888,4.90236532 6.70710318,5.29288961 L12.7071032,11.2928896 C13.0856821,11.6714686 13.0989277,12.281055 12.7371505,12.675721 L7.23715054,18.675721 C6.86395813,19.08284 6.23139076,19.1103429 5.82427177,18.7371505 C5.41715278,18.3639581 5.38964985,17.7313908 5.76284226,17.3242718 L10.6158586,12.0300721 L5.29288961,6.70710318 Z" fill="#000000" fill-rule="nonzero" transform="translate(8.999997, 11.999999) scale(-1, 1) translate(-8.999997, -11.999999) "/>
        <path d="M10.7071009,15.7071068 C10.3165766,16.0976311 9.68341162,16.0976311 9.29288733,15.7071068 C8.90236304,15.3165825 8.90236304,14.6834175 9.29288733,14.2928932 L15.2928873,8.29289322 C15.6714663,7.91431428 16.2810527,7.90106866 16.6757187,8.26284586 L22.6757187,13.7628459 C23.0828377,14.1360383 23.1103407,14.7686056 22.7371482,15.1757246 C22.3639558,15.5828436 21.7313885,15.6103465 21.3242695,15.2371541 L16.0300699,10.3841378 L10.7071009,15.7071068 Z" fill="#000000" fill-rule="nonzero" opacity="0.3" transform="translate(15.999997, 11.999999) scale(-1, 1) rotate(-270.000000) translate(-15.999997, -11.999999) "/>
    </g>
</svg></span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="btn js-waves-off" data-action="toggle" data-class="clx-fixed-navigation" title="Lock Navigation">
                                <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <mask fill="white">
            <use xlink:href="#path-1"/>
        </mask>
        <g/>
        <path d="M7,10 L7,8 C7,5.23857625 9.23857625,3 12,3 C14.7614237,3 17,5.23857625 17,8 L17,10 L18,10 C19.1045695,10 20,10.8954305 20,12 L20,18 C20,19.1045695 19.1045695,20 18,20 L6,20 C4.8954305,20 4,19.1045695 4,18 L4,12 C4,10.8954305 4.8954305,10 6,10 L7,10 Z M12,5 C10.3431458,5 9,6.34314575 9,8 L9,10 L15,10 L15,8 C15,6.34314575 13.6568542,5 12,5 Z" fill="#000000"/>
    </g>
</svg></span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="hidden-lg-up">
                <a href="#" class="header-btn btn press-scale-down" data-action="toggle" data-class="mobile-nav-on">
                        <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="32px" height="32px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <rect fill="#000000" x="4" y="5" width="16" height="3" rx="1.5"/>
        <path d="M5.5,15 L18.5,15 C19.3284271,15 20,15.6715729 20,16.5 C20,17.3284271 19.3284271,18 18.5,18 L5.5,18 C4.67157288,18 4,17.3284271 4,16.5 C4,15.6715729 4.67157288,15 5.5,15 Z M5.5,10 L18.5,10 C19.3284271,10 20,10.6715729 20,11.5 C20,12.3284271 19.3284271,13 18.5,13 L5.5,13 C4.67157288,13 4,12.3284271 4,11.5 C4,10.6715729 4.67157288,10 5.5,10 Z" fill="#000000" opacity="0.3"/>
    </g>
</svg></span>
                </a>
            </div>


            <div class="ml-auto d-flex">

                {if has_access($user->roleid,'appearance')}

                    <div class="hidden-md-down">
                        <a href="{$_url}appearance/ui" class="header-icon cursor-pointer">
                            <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect opacity="0.200000003" x="0" y="0" width="24" height="24"/>
        <path d="M4.5,7 L9.5,7 C10.3284271,7 11,7.67157288 11,8.5 C11,9.32842712 10.3284271,10 9.5,10 L4.5,10 C3.67157288,10 3,9.32842712 3,8.5 C3,7.67157288 3.67157288,7 4.5,7 Z M13.5,15 L18.5,15 C19.3284271,15 20,15.6715729 20,16.5 C20,17.3284271 19.3284271,18 18.5,18 L13.5,18 C12.6715729,18 12,17.3284271 12,16.5 C12,15.6715729 12.6715729,15 13.5,15 Z" fill="#000000" opacity="0.3"/>
        <path d="M17,11 C15.3431458,11 14,9.65685425 14,8 C14,6.34314575 15.3431458,5 17,5 C18.6568542,5 20,6.34314575 20,8 C20,9.65685425 18.6568542,11 17,11 Z M6,19 C4.34314575,19 3,17.6568542 3,16 C3,14.3431458 4.34314575,13 6,13 C7.65685425,13 9,14.3431458 9,16 C9,17.6568542 7.65685425,19 6,19 Z" fill="#000000"/>
    </g>
</svg></span>
                        </a>
                    </div>

                {/if}


                <div>

                    {if has_access($user->roleid, 'utilities')}

                        <a href="javasctipt:;" id="get_activity" class="header-icon cursor-pointer" data-toggle="dropdown">
                            <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <path d="M13.2070325,4 C13.0721672,4.47683179 13,4.97998812 13,5.5 C13,8.53756612 15.4624339,11 18.5,11 C19.0200119,11 19.5231682,10.9278328 20,10.7929675 L20,17 C20,18.6568542 18.6568542,20 17,20 L7,20 C5.34314575,20 4,18.6568542 4,17 L4,7 C4,5.34314575 5.34314575,4 7,4 L13.2070325,4 Z" fill="#000000"/>
        <circle fill="#000000" opacity="0.3" cx="18.5" cy="5.5" r="2.5"/>
    </g>
</svg></span>
                        </a>

                    {/if}

                    <div class="dropdown-menu dropdown-menu-animated dropdown-xl">
                        <div class="dropdown-header bg-trans-gradient d-flex justify-content-center align-items-center rounded-top mb-2">
                            <h4 class="m-0 text-center color-white">
                                {$_L['Notifications']}
                            </h4>
                        </div>

                        <div class="custom-scroll h-100" id="activity_loaded">
                            <div class="text-center my-3">
                                <div class="md-preloader"><svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="32" width="32" viewbox="0 0 75 75"><circle cx="37.5" cy="37.5" r="33.5" stroke-width="6"/></svg></div>
                            </div>
                        </div>
                        <div class="py-2 px-3 bg-faded d-block rounded-bottom text-center border-faded border-bottom-0 border-right-0 border-left-0">
                            <a href="{$_url}util/activity" class="fs-xs fw-500 ml-auto">{$_L['See All Activity']}</a>
                        </div>
                    </div>
                </div>

                <div>
                    <a href="javascript:;" class="header-icon cursor-pointer" data-toggle="modal" data-target=".js-modal-notes">
                            <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <path d="M8,3 L8,3.5 C8,4.32842712 8.67157288,5 9.5,5 L14.5,5 C15.3284271,5 16,4.32842712 16,3.5 L16,3 L18,3 C19.1045695,3 20,3.8954305 20,5 L20,21 C20,22.1045695 19.1045695,23 18,23 L6,23 C4.8954305,23 4,22.1045695 4,21 L4,5 C4,3.8954305 4.8954305,3 6,3 L8,3 Z" fill="#000000" opacity="0.3"/>
        <path d="M11,2 C11,1.44771525 11.4477153,1 12,1 C12.5522847,1 13,1.44771525 13,2 L14.5,2 C14.7761424,2 15,2.22385763 15,2.5 L15,3.5 C15,3.77614237 14.7761424,4 14.5,4 L9.5,4 C9.22385763,4 9,3.77614237 9,3.5 L9,2.5 C9,2.22385763 9.22385763,2 9.5,2 L11,2 Z" fill="#000000"/>
        <rect fill="#000000" opacity="0.3" x="7" y="10" width="5" height="2" rx="1"/>
        <rect fill="#000000" opacity="0.3" x="7" y="14" width="9" height="2" rx="1"/>
    </g>
</svg></span>
                    </a>
                </div>
                <div>
                    <a href="#" data-toggle="dropdown" title="{$user->fullname}" class="header-icon d-flex align-items-center justify-content-center ml-2 cursor-pointer">

                        {if $user['img'] eq ''}
                            <img src="{$app_url}ui/lib/img/default-user-avatar.png"  class="profile-image rounded-circle" alt="{$user->fullname}">
                        {else}
                            <img src="{$app_url}{$user['img']}"  class="profile-image rounded-circle" alt="{$user->fullname}">
                        {/if}
                    </a>
                    <div class="dropdown-menu dropdown-menu-animated dropdown-lg">
                        <div class="dropdown-header bg-trans-gradient d-flex flex-row py-4 rounded-top">
                            <div class="d-flex flex-row align-items-center mt-1 mb-1 color-white">
                                            <span class="mr-2">

                                                {if $user['img'] eq ''}
                                                    <img src="{$app_url}ui/lib/img/default-user-avatar.png" class="rounded-circle profile-image" alt="{$user->fullname}">
                            {else}
                                <img src="{$app_url}{$user['img']}" class="rounded-circle profile-image" alt="{$user->fullname}">
                                                {/if}
                                            </span>
                                <div class="info-card-text">
                                    <div class="fs-lg text-truncate text-truncate-lg">{$user->fullname}</div>
                                    <span class="text-truncate text-truncate-md opacity-80">{$user->username}</span>
                                </div>
                            </div>
                        </div>
                        <div class="dropdown-divider m-0"></div>
                        <a href="{$_url}settings/users-edit/{$user->id}" class="dropdown-item">
                            {$_L['Edit Profile']}
                        </a>

                        <a href="{$_url}settings/change-password" class="dropdown-item">
                            {$_L['Change Password']}
                        </a>



                        <div class="dropdown-divider m-0"></div>
                        <a class="dropdown-item fw-500 pt-3 pb-3" href="{$_url}logout">
                            {$_L['Logout']}
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <main id="clx-page-content" role="main" class="page-content {if isset($page_content_extra_class)} {$page_content_extra_class} {/if}">


            {if isset($notify)}{$notify}{/if}

            {block name="content"}{/block}


        </main>

        <div class="page-content-overlay" data-action="toggle" data-class="mobile-nav-on"></div>


        <div class="modal fade js-modal-notes modal-backdrop-transparent" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-right">
                <div class="modal-content h-100">
                    <div class="dropdown-header bg-primary-900 d-flex align-items-center w-100">
                        <h3 class="text-white mt-2 mb-1">{$_L['Notes']}</h3>
                        <button type="button" class="close text-white position-absolute pos-top pos-right p-2 m-1 mr-2" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true"><i class="fal fa-times"></i></span>
                        </button>
                    </div>
                    <div class="modal-body p-0 h-100 d-flex">
                        <textarea class="form-control rounded-0" id="clx_notes_clipboard" placeholder="{$_L['Whats on your mind']}">{$user->notes}</textarea>
                    </div>
                </div>
            </div>
        </div>



    </div>

{/block}
