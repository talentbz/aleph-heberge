{extends file="hostbilling/layouts/base.tpl"}
{block name="content_body"}


    <aside class="page-sidebar">
        <div class="page-logo">
            <a href="{$_url}client/dashboard/" class="page-logo-link d-flex align-items-center position-relative">

                {if empty($config['header_show_logo_as'])}

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

                {else}

                    <img src="{{APP_URL}}/storage/system/{{$config['logo_default']}}" style="width: auto; max-height: 28px;" alt="{{$config['CompanyName']}}" aria-roledescription="logo">

                {/if}



            </a>
        </div>



        <nav id="clx-primary-navigation" class="primary-nav" role="navigation">

            {if !empty($user)}


                <div class="info-card">
                    {if $user->img}
                        <img src="{{APP_URL}}/{{$user->img}}" class="profile-image rounded-circle" alt="{$user->account}">
                    {else}
                        <img src="{{APP_URL}}/ui/lib/img/default-user-avatar.png" class="profile-image rounded-circle" alt="{$user->account}">
                    {/if}


                    <div class="info-card-text">
                        <a href="{$base_url}client/profile/" class="d-flex align-items-center text-white">
                                    <span class="text-truncate text-truncate-sm d-inline-block">
                                        {$user->account}
                                    </span>
                        </a>
                    </div>

                    <img src="{APP_URL}/ui/theme/default/img/cover-2-lg.png" class="cover" alt="cover">

                </div>

            {/if}






            <ul id="clx-navigation-menu" class="nav-menu">

                {if !empty($user)}

                    {$client_extra_nav[0]}


                    <li {if $selected_navigation eq 'dashboard'}class="active"{/if}><a href="{$_url}client/dashboard/">

                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                            <span class="nav-link-text">{$_L['Home']}</span></a></li>

                {else}

                    <li {if $selected_navigation eq 'dashboard'}class="active"{/if}><a href="{$_url}client/">

                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                            <span class="nav-link-text">{$_L['Home']}</span></a></li>



                {/if}

                {if count($groups)}

                    <li class="{if $selected_navigation eq 'items'}active  open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-cart"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                            <span class="nav-link-text">{$_L['Place New Order']}</span>
                        </a>
                        <ul>

                            {foreach $groups as $group}
                                <li>
                                    <a href="{$base_url}client/items/{$group->slug}/">
                                        <span class="nav-link-text">{$group->name}</span>
                                    </a>
                                </li>
                            {/foreach}





                        </ul>
                    </li>

                {/if}


                {if !empty($user)}

                    <li class="{if $selected_navigation eq 'my_items'}active  open{/if}">
                        <a href="#">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layers"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>
                            <span class="nav-link-text">{$_L['My Orders']}</span>
                        </a>
                        <ul>
                            <li>
                                <a href="{$_url}client/domain-orders/">
                                    <span class="nav-link-text">{$_L['Domain Orders']}</span>
                                </a>
                            </li>
                            <li>
                                <a href="{$_url}client/hosting-orders/">
                                    <span class="nav-link-text">{$_L['Hosting Orders']}</span>
                                </a>
                            </li>


                        </ul>
                    </li>

                {/if}



                <li class="{if $selected_navigation eq 'domains'}active  open{/if}">
                    <a href="#">

                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-globe"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                        <span class="nav-link-text">{$_L['Domains']}</span>
                    </a>
                    <ul>


                        <li>
                            <a href="{$_url}client/whois/">
                                <span class="nav-link-text">{$_L['WHOIS Lookup']}</span>
                            </a>
                        </li>



                        <li>
                            <a href="{$_url}client/domain-register/">
                                <span class="nav-link-text">{$_L['Register Domain']}</span>
                            </a>
                        </li>



                    </ul>
                </li>


                <li {if $selected_navigation eq 'kb'}class="active"{/if}><a href="{$_url}client/kb/">


                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-book-open"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path></svg>
                        <span class="nav-link-text">{$_L['Knowledgebase']}</span></a></li>




                    {$client_extra_nav[1]}


                    {$client_extra_nav[2]}

                {if !empty($user)}

                    <li class="{if $selected_navigation eq 'orders'}active  open{/if}">
                        <a href="#">


                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-credit-card"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
                            <span class="nav-link-text">{$_L['Billing']}</span>
                        </a>
                        <ul>
                            {if !empty($user) && has_access($user->roleid,'customers','create')}
                                <li>
                                    <a href="{$_url}client/invoices/" >
                                        <span class="nav-link-text">{$_L['Invoices']}</span>
                                    </a>
                                </li>
                            {/if}

                            <li>
                                <a href="{$_url}client/quotes/">
                                    <span class="nav-link-text">{$_L['Quotes']}</span>
                                </a>
                            </li>


                        </ul>
                    </li>

                {/if}





                    {$client_extra_nav[3]}

                {if !empty($user)}

                    {if $config['support']}

                        <li class="{if $selected_navigation eq 'support'}active  open{/if}">
                            <a href="#">


                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file-text"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                                <span class="nav-link-text">{$_L['Support']}</span>
                            </a>
                            <ul>
                                <li>
                                    <a href="{$_url}client/downloads/">
                                        <span class="nav-link-text">{$_L['Documents']}</span>
                                    </a>
                                </li>

                                <li>
                                    <a href="{$_url}client/tickets/new">
                                        <span class="nav-link-text">{$_L['Open New Ticket']}</span>
                                    </a>
                                </li>

                                <li>
                                    <a href="{$_url}client/tickets/all">
                                        <span class="nav-link-text">{$_L['Tickets']}</span>
                                    </a>
                                </li>


                            </ul>
                        </li>

                    {/if}

                    <li {if $selected_navigation eq 'profile'}class="active"{/if}><a href="{$_url}client/profile/">

                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            <span class="nav-link-text">{$_L['Profile']}</span></a></li>


                {/if}


                {if empty($user)}

                    <li class="{if $selected_navigation eq 'profile'}active  open{/if}">
                        <a href="#">

                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            <span class="nav-link-text">{$_L['Account']}</span>
                        </a>
                        <ul>
                            <li>
                                <a href="{$_url}client/login/">
                                    <span class="nav-link-text">{$_L['Login']}</span>
                                </a>
                            </li>

                            {if $config['allow_customer_registration'] eq '1'}

                                <li>
                                    <a href="{$_url}client/register/">
                                        <span class="nav-link-text">{$_L['Register']}</span>
                                    </a>
                                </li>
                                
                            {/if}





                        </ul>
                    </li>


                {/if}












                    {$client_extra_nav[9]}







            </ul>



        </nav>

    </aside>

    <div class="page-content-wrapper">
        <header class="page-header" role="banner">
            <div class="page-logo">
                <a href="{$_url}client/dashboard/" class="page-logo-link press-scale-down d-flex align-items-center position-relative">
                    {if empty($config['header_show_logo_as'])}

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

                    {else}

                        <img src="{{APP_URL}}/storage/system/{{$config['logo_default']}}" style="width: auto; max-height: 28px;" alt="{{$config['CompanyName']}}" aria-roledescription="logo">

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


                {if $shopping_cart && $shopping_cart->items_count}
                    <div>
                        <a href="{$base_url}client/checkout/" class="header-icon cursor-pointer">
                            <i class="fal fa-shopping-cart"></i>
                            <span class="badge badge-icon">{$shopping_cart->items_count}</span>
                        </a>

                    </div>
                {/if}


                {if isset($config['allow_customer_change_language']) && $config['allow_customer_change_language']}

                <div>
                    <a href="javasctipt:;" id="get_activity" class="header-icon cursor-pointer" data-toggle="dropdown">
                            <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <path d="M13.2070325,4 C13.0721672,4.47683179 13,4.97998812 13,5.5 C13,8.53756612 15.4624339,11 18.5,11 C19.0200119,11 19.5231682,10.9278328 20,10.7929675 L20,17 C20,18.6568542 18.6568542,20 17,20 L7,20 C5.34314575,20 4,18.6568542 4,17 L4,7 C4,5.34314575 5.34314575,4 7,4 L13.2070325,4 Z" fill="#000000"/>
        <circle fill="#000000" opacity="0.3" cx="18.5" cy="5.5" r="2.5"/>
    </g>
</svg></span>
                    </a>


                        <div class="dropdown-menu dropdown-menu-animated dropdown-xl">
                            <div class="dropdown-header bg-trans-gradient d-flex justify-content-center align-items-center rounded-top mb-2">
                                <h4 class="m-0 text-center color-white">
                                    {$_L['Choose Language']}
                                </h4>
                            </div>



                            <div class="list-group">
                                {foreach $languages as $language}


                                    <a href="{$_url}client/choose-language/{$language['iso_code']}" class="list-group-item list-group-item-action">{$language['name']} </a>

                                {/foreach}

                            </div>



                        </div>




                </div>
                {/if}


                {if !empty($user)}
                    <div>
                        <a href="#" data-toggle="dropdown" title="{$user->account}" class="header-icon d-flex align-items-center justify-content-center ml-2 cursor-pointer">

                            {if $user['img'] eq ''}
                                <img src="{$app_url}ui/lib/img/default-user-avatar.png"  class="profile-image rounded-circle" alt="{$user->account}">
                            {else}
                                <img src="{$app_url}{$user['img']}"  class="profile-image rounded-circle" alt="{$user->account}">
                            {/if}
                        </a>

                        <div class="dropdown-menu dropdown-menu-animated dropdown-lg">
                            <div class="dropdown-header bg-trans-gradient d-flex flex-row py-4 rounded-top">
                                <div class="d-flex flex-row align-items-center mt-1 mb-1 color-white">
                                            <span class="mr-2">

                                                {if $user['img'] eq ''}
                                                    <img src="{$app_url}ui/lib/img/default-user-avatar.png" class="rounded-circle profile-image" alt="{$user->account}">
                            {else}
                                <img src="{$app_url}{$user['img']}" class="rounded-circle profile-image" alt="{$user->account}">
                                                {/if}
                                            </span>
                                    <div class="info-card-text">
                                        <div class="fs-lg text-truncate text-truncate-lg">{$user->account}</div>
                                        <span class="text-truncate text-truncate-md opacity-80">{$user->username}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="dropdown-divider m-0"></div>
                            <a href="{$_url}client/profile" class="dropdown-item">
                                {$_L['Edit Profile']}
                            </a>



                            <div class="dropdown-divider m-0"></div>
                            <a class="dropdown-item pt-3 pb-3" href="{$_url}client/logout">
                                {$_L['Logout']}
                            </a>
                        </div>
                    </div>
                {/if}

            </div>
        </header>

        <main id="clx-page-content" role="main" class="page-content {if isset($page_content_extra_class)} {$page_content_extra_class} {/if}">


            {if isset($notify)}{$notify}{/if}

            {block name="content"}{/block}


        </main>

        <div class="page-content-overlay" data-action="toggle" data-class="mobile-nav-on"></div>




    </div>

{/block}
