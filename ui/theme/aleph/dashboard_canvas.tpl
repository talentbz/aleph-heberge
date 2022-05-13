{extends file="$layouts_admin"}


{block name="content"}
    <div class="row">


        <div class="col-lg-12">
            <div id="panel-1" class="panel" data-panel-lock="false" data-panel-close="false" data-panel-collapsed="false"  data-panel-locked="false" data-panel-refresh="false" data-panel-reset="false">
                <div class="panel-hdr">
                    <h2>
                        {$_L['Cash Flow']}
                    </h2>

                    <div class="panel-toolbar">
                        <a href="{$_url}dashboard" data-toggle="tooltip" data-original-title="{$_L['Refresh']}">
                            <span class="svg-icon svg-icon-primary svg-icon-2x"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <path d="M8.43296491,7.17429118 L9.40782327,7.85689436 C9.49616631,7.91875282 9.56214077,8.00751728 9.5959027,8.10994332 C9.68235021,8.37220548 9.53982427,8.65489052 9.27756211,8.74133803 L5.89079566,9.85769242 C5.84469033,9.87288977 5.79661753,9.8812917 5.74809064,9.88263369 C5.4720538,9.8902674 5.24209339,9.67268366 5.23445968,9.39664682 L5.13610134,5.83998177 C5.13313425,5.73269078 5.16477113,5.62729274 5.22633424,5.53937151 C5.384723,5.31316892 5.69649589,5.25819495 5.92269848,5.4165837 L6.72910242,5.98123382 C8.16546398,4.72182424 10.0239806,4 12,4 C16.418278,4 20,7.581722 20,12 C20,16.418278 16.418278,20 12,20 C7.581722,20 4,16.418278 4,12 L6,12 C6,15.3137085 8.6862915,18 12,18 C15.3137085,18 18,15.3137085 18,12 C18,8.6862915 15.3137085,6 12,6 C10.6885336,6 9.44767246,6.42282109 8.43296491,7.17429118 Z" fill="#000000" fill-rule="nonzero"/>
    </g>
</svg></span>
                        </a>
                    </div>

                </div>

                <div class="panel-container show">
                    <div class="panel-content border-left-0 border-right-0 border-top-0"

                         {if !empty($config['admin_dark_theme'])}
                             style="background: #232F47;"
                             {else}
                             style="background: #EEF0F7;"
                         {/if}

                    >
                        <div class="row no-gutters">


                            <div class="col-lg-8 col-xl-8">

                                <div style="padding-left: 1rem; padding-right: 1rem;">

                                    <div class="row">



                                        <div class="{if $config['leads'] && $config['companies']}col-md-4 {else} col-md-6{/if}">

                                            <a  href="{$base_url}contacts/list/">

                                                <div class="card mb-2" style="



                                                {if !empty($config['admin_dark_theme'])}
                                                        background-color: #213137;
                                                {else}
                                                        background-color: #4344A2;
                                                {/if}

                                                height: 120px"

                                                >


                                                    <div class="card-body" >
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="h1 text-white mb-0">{$customers_total}</div>


                                                            </div>
                                                            <div class="symbol symbol-circle symbol-light symbol-40 flex-shrink-0 mr-3">
                                                                <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor]" class="bi bi-person-fill" viewBox="0 0 16 16">
  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
</svg>
                                </span>                            </div>
                                                            </div>

                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <p class="text-white text-hover-primary font-weight-bold font-size-lg mt-1">{$_L['Customers']}</p>

                                                            </div>




                                                        </div>

                                                    </div>

                                                </div>

                                            </a>


                                        </div>

                                        {if isset($config['companies']) && $config['companies']}

                                            <div class="{if $config['leads'] && $config['companies']}col-md-4 {else} col-md-6{/if}">

                                                <a href="{$base_url}contacts/companies/">
                                                    <div class="card mb-2" style="

                                                    {if !empty($config['admin_dark_theme'])}
                                                            background-color: #372F29;
                                                    {else}
                                                            background-color: #4344A2;
                                                    {/if}

                                                    height: 120px">

                                                        <div class="card-body" >
                                                            <div class="row">
                                                                <div class="col">
                                                                    <div class="h1 text-white mb-0 ">{$companies_total}</div>


                                                                </div>

                                                                <div class="symbol symbol-circle symbol-light symbol-40 flex-shrink-0 mr-3">
                                                                    <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bar-chart-fill" viewBox="0 0 16 16">
  <path d="M1 11a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1v-3zm5-4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V7zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1V2z"/>
</svg>
                                </span>                            </div>
                                                                </div>


                                                            </div>


                                                            <p class=" text-white text-hover-primary font-weight-bold font-size-lg  mt-1">{$_L['Companies']}</p>
                                                        </div>

                                                    </div>
                                                </a>


                                            </div>

                                        {/if}





                                        {if isset($config['leads']) && $config['leads']}

                                            <div class="{if $config['leads'] && $config['companies']}col-md-4 {else} col-md-6{/if}">

                                                <a href="{$base_url}leads/">

                                                    <div class="card mb-2" style="

                                                    {if !empty($config['admin_dark_theme'])}
                                                            background-color: #372533;
                                                    {else}
                                                            background-color: #5B34F4;
                                                    {/if}
                                                     height: 120px"
                                                    >
                                                        <div class="card-body">

                                                            <div class="row">
                                                                <div class="col">

                                                                    <div class="h1 text-white  mb-0">{$leads_total}</div>

                                                                </div>
                                                                <div class="symbol symbol-circle symbol-light symbol-40 flex-shrink-0 mr-3">
                                                                    <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shift-fill" viewBox="0 0 16 16">
  <path d="M7.27 2.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v3a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-3H1.654C.78 10.5.326 9.455.924 8.816L7.27 2.047z"/>
</svg>
                                </span>                            </div>
                                                                </div>


                                                            </div>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <p class="text-white text-hover-primary font-weight-bold font-size-lg mt-1">{$_L['Leads']}</p>

                                                                </div>
                                                                <div class="col">


                                                                </div>
                                                            </div>



                                                        </div>
                                                    </div>

                                                </a>

                                            </div>
                                        {/if}

                                    </div>
                                </div>


                                <div class="position-relative">



                                    <div class="col-md-12 mt-3">
                                        <div class="card mb-3 shadow-none">
                                            <div class="card-body">
                                                <div id="cash_flow_chart">

                                                </div>


                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                            <div class="col-lg-4 col-xl-4">

                                <div class="p-8  mb-2 rounded-xl flex-grow-1" style="
                                {if !empty($config['admin_dark_theme'])}
                                        background: #232F47;
                                {else}
                                        background: #EEF0F7;
                                {/if}
                                 border-radius: 4px; padding: 26px 20px; margin-left:1rem; margin-right:1rem;">
                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-5">
                                        <div class="symbol symbol-circle symbol-light-success symbol-40 flex-shrink-0 mr-3">
                                            <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#fff" class="bi bi-credit-card-fill" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v1H0V4zm0 3v5a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7H0zm3 2h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-1a1 1 0 0 1 1-1z"/>
</svg>
                                </span>                            </div>
                                        </div>
                                        <div>
                                            <h3 class="text-dark">{formatCurrency($ti,$config['home_currency'])}</h3>
                                            <div class="font-size-sm text-muted-green">{$_L['Income Today']}</div>
                                        </div>
                                    </div>
                                    <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-5">
                                        <div class="symbol symbol-circle symbol-light-warning symbol-40 flex-shrink-0 mr-3">
                                            <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <path d="M4,4 L20,4 C21.1045695,4 22,4.8954305 22,6 L22,18 C22,19.1045695 21.1045695,20 20,20 L4,20 C2.8954305,20 2,19.1045695 2,18 L2,6 C2,4.8954305 2.8954305,4 4,4 Z" fill="#000000" opacity="0.3"/>
        <path d="M18.5,11 L5.5,11 C4.67157288,11 4,11.6715729 4,12.5 L4,13 L8.58578644,13 C8.85100293,13 9.10535684,13.1053568 9.29289322,13.2928932 L10.2928932,14.2928932 C10.7456461,14.7456461 11.3597108,15 12,15 C12.6402892,15 13.2543539,14.7456461 13.7071068,14.2928932 L14.7071068,13.2928932 C14.8946432,13.1053568 15.1489971,13 15.4142136,13 L20,13 L20,12.5 C20,11.6715729 19.3284271,11 18.5,11 Z" fill="#000000"/>
        <path d="M5.5,6 C4.67157288,6 4,6.67157288 4,7.5 L4,8 L20,8 L20,7.5 C20,6.67157288 19.3284271,6 18.5,6 L5.5,6 Z" fill="#000000"/>
    </g>
</svg></span>                            </div>
                                        </div>
                                        <div>
                                            <h3 class="text-dark">{formatCurrency($te,$config['home_currency'])}</h3>
                                            <div class="font-size-sm text-muted-green">{$_L['Expense Today']}</div>
                                        </div>
                                    </div>
                                    <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-5">
                                        <div class="symbol symbol-circle symbol-light-primary symbol-40 flex-shrink-0 mr-3">
                                            <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <rect fill="#000000" opacity="0.3" x="2" y="4" width="20" height="5" rx="1"/>
        <path d="M5,7 L8,7 L8,21 L7,21 C5.8954305,21 5,20.1045695 5,19 L5,7 Z M19,7 L19,19 C19,20.1045695 18.1045695,21 17,21 L11,21 L11,7 L19,7 Z" fill="#000000"/>
    </g>
</svg></span>                            </div>
                                        </div>
                                        <div>
                                            <h3 class="text-dark">{formatCurrency($mi,$config['home_currency'])}</h3>
                                            <div class="font-size-sm text-muted-green">{$_L['Income This Month']}</div>
                                        </div>
                                    </div>
                                    <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-5">
                                        <div class="symbol symbol-circle symbol-light-danger symbol-40 flex-shrink-0 mr-3">
                                            <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <rect fill="#000000" opacity="0.3" x="2" y="5" width="20" height="14" rx="2"/>
        <rect fill="#000000" x="2" y="8" width="20" height="3"/>
        <rect fill="#000000" opacity="0.3" x="16" y="14" width="4" height="2" rx="1"/>
    </g>
</svg></span>                            </div>
                                        </div>
                                        <div>
                                            <h3 class="text-dark">{formatCurrency($me,$config['home_currency'])}</h3>
                                            <div class="font-size-sm text-muted-green">{$_L['Expense This Month']}</div>
                                        </div>
                                    </div>
                                    <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center mb-5">
                                        <div class="symbol symbol-circle symbol-light-success symbol-40 flex-shrink-0 mr-3">
                                            <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"></rect>
        <rect fill="#000000" opacity="0.3" x="13" y="4" width="3" height="16" rx="1.5"></rect>
        <rect fill="#000000" x="8" y="9" width="3" height="11" rx="1.5"></rect>
        <rect fill="#000000" x="18" y="11" width="3" height="9" rx="1.5"></rect>
        <rect fill="#000000" x="3" y="13" width="3" height="7" rx="1.5"></rect>
    </g>
</svg><!--end::Svg Icon--></span>                            </div>
                                        </div>
                                        <div>
                                            <h3 class="text-dark">{formatCurrency($total_income,$config['home_currency'])}</h3>
                                            <div class="font-size-sm text-muted-green">{$_L['Total Income']}</div>
                                        </div>
                                    </div>
                                    <!--end::Item-->

                                    <!--begin::Item-->
                                    <div class="d-flex align-items-center">
                                        <div class="symbol symbol-circle symbol-light-danger symbol-40 flex-shrink-0 mr-3">
                                            <div class="symbol-label">
                                <span class="svg-icon svg-icon-md svg-icon-white"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <rect x="0" y="0" width="24" height="24"/>
        <rect fill="#000000" opacity="0.3" x="12" y="4" width="3" height="13" rx="1.5"/>
        <rect fill="#000000" opacity="0.3" x="7" y="9" width="3" height="8" rx="1.5"/>
        <path d="M5,19 L20,19 C20.5522847,19 21,19.4477153 21,20 C21,20.5522847 20.5522847,21 20,21 L4,21 C3.44771525,21 3,20.5522847 3,20 L3,4 C3,3.44771525 3.44771525,3 4,3 C4.55228475,3 5,3.44771525 5,4 L5,19 Z" fill="#000000" fill-rule="nonzero"/>
        <rect fill="#000000" opacity="0.3" x="17" y="11" width="3" height="6" rx="1.5"/>
    </g>
</svg></span>                            </div>
                                        </div>
                                        <div>
                                            <h3 class="text-dark">{formatCurrency($total_expense,$config['home_currency'])}</h3>
                                            <div class="font-size-sm text-muted-green">{$_L['Total Expense']}</div>
                                        </div>
                                    </div>
                                    <!--end::Item-->
                                </div>


                            </div>
                        </div>

                    </div>
                </div>

            </div>



        </div>

        <div class="col-lg-6">
            <div id="panel-12" class="panel">
                <div class="panel-hdr">
                    <h2>
                        {$_L['Recent Clients']}
                    </h2>
                </div>
                <div class="panel-container show p-5">
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>
                                {$_L['Image']}
                            </th>

                            <th>
                                {$_L['Name']}
                            </th>


                            <th>
                                {$_L['Created']}
                            </th>
                        </tr>
                        </thead>
                        <tbody>

                        {foreach $recent_customers as $recent_customer}

                            <tr>
                                <td data-order="{$recent_customer@iteration}">
                                    <a href="{$_url}contacts/view/{$recent_customer->id}">{sp_get_contact_image($recent_customer)}</a>
                                </td>
                                <td>
                                    <a class="h6" href="{$base_url}contacts/view/{$recent_customer->id}">
                                        {$recent_customer->account}
                                    </a></br>
                                    {$recent_customer->email}
                                </td>



                                <td>
                                    {date( $config['df'], strtotime($recent_customer->created_at))}
                                </td>
                            </tr>

                        {/foreach}

                        </tbody>
                    </table>
                </div>
            </div>
        </div>





        {if isset($config['projects']) && $config['projects']}
            <div class="col-lg-6">
                <div id="panel-4" class="panel">
                    <div class="panel-hdr">
                        <h2>
                            {$_L['Recent Projects']}
                        </h2>
                    </div>
                    <div class="panel-container show p-5">
                        <table class="table table-striped">
                            <thead>
                            <tr>

                                <th class="h6">
                                    {$_L['Name']}
                                </th>
                                <th class="h6">
                                    {$_L['Budget']}

                                </th>
                                <td class="h6">
                                    {$_L['Status']}
                                </td>

                                <th class="h6">
                                    {$_L['Due Date']}
                                </th>

                            </tr>
                            </thead>
                            <tbody>

                            {foreach $recent_projects as $project}

                                <tr>

                                    <td class="h6">
                                        {$project->name}
                                    </td>
                                    <td class="h6">
                                        {formatCurrency($project->budget,$project->currency)}
                                    </td>
                                    <td>
                                        {if $project->status == 'Completed'}
                                            <span class="badge badge-outline text-uppercase badge-outline-success mb-4">{$project->status}</span>
                                        {else}
                                            <span class="badge badge-outline text-uppercase badge-outline-warning mb-4">{$project->status}</span>
                                        {/if}

                                    </td>
                                    <td>
                                        {date( $config['df'], strtotime($project->due_date))}
                                    </td>

                                </tr>

                            {/foreach}

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        {/if}


        <div class="col-lg-6">
            <div id="panel-3" class="panel" data-panel-close="false">
                <div class="panel-hdr">
                    <h2>{$_L['Recent Invoices']}</h2>

                </div>
                <div class="panel-container">

                    <div class="table-responsive  widget-table">
                        <table class="table table-striped mb-0">
                            <thead>
                            <tr>
                                <th class="h6">#</th>
                                <th class="h6">{$_L['Account']}</th>
                                <th class="h6">{$_L['Amount']}</th>
                                <th class="h6">{$_L['Invoice Date']}</th>
                                <th class="h6">{$_L['Due Date']}</th>
                                <th class="h6">{$_L['Status']}</th>
                            </tr>
                            </thead>
                            <tbody>

                            {foreach $invoices as $ds}
                                <tr class="cursor-pointer clickable-row" data-id="{$ds['id']}">
                                    <td class="text-info">
                                        <strong>
                                            {$ds['invoicenum']}{if $ds['cn'] neq ''} {$ds['cn']} {else} {$ds['id']} {/if}
                                        </strong>
                                    </td>
                                    <td>


                                        <strong>{$ds['account']}</strong> <br>
                                    </td>
                                    <td class="h6">{$ds['total']}</td>
                                    <td>{date( $config['df'], strtotime($ds['date']))}</td>
                                    <td>{date( $config['df'], strtotime($ds['duedate']))}</td>
                                    <td>
                                        {if $ds['status'] == 'Unpaid'}

                                            <span class="badge badge-outline badge-outline-danger">{ib_lan_get_line($ds['status'])}</span>

                                        {else}

                                            <span class="badge badge-outline  badge-outline-success">{ib_lan_get_line($ds['status'])}</span>

                                        {/if}


                                    </td>

                                </tr>
                            {/foreach}

                            </tbody>
                        </table>

                    </div>

                    <div class="panel-content">
                        <div id="invoice_stats"></div>
                    </div>

                </div>


            </div>
        </div>
        <div class="col-lg-6">
            <div id="panel-11" class="panel">
                <div class="panel-hdr">
                    <h2>
                        {$_L['Calendar']}
                    </h2>
                </div>
                <div class="panel-container show p-5">
                    <div id="calendar"></div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div id="panel-5" class="panel">
                <div class="panel-hdr">
                    <h2>
                        {$_L['Income_Vs_Expense']}
                    </h2>
                </div>
                <div class="panel-container show p-5">
                    <div id="chart_income_vs_expense"></div>
                </div>
            </div>
        </div>



        <div class="col-lg-6">
            <div class="panel" id="panel-7">
                <div class="panel-hdr">

                    <h2>{$_L['Latest Expense']}</h2>
                </div>
                <div class="panel-container">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <th class="h6">{$_L['Date']}</th>
                            <th class="h6">{$_L['Description']}</th>
                            <th class="text-right h6 ">{$_L['Amount']}</th>
                            {foreach $exp as $exps}
                                <tr>
                                    <td class="text-info h6">{date( $config['df'], strtotime($exps['date']))}</td>
                                    <td><a href="{$_url}transactions/manage/{$exps['id']}/"><strong>{$exps['description']}</strong></a> </td>
                                    <td class="text-right text-danger amount h6">{formatCurrency($exps['amount'],$config['home_currency'])}</td>
                                </tr>
                            {/foreach}



                        </table>
                    </div>

                </div>

            </div>

        </div>
        <div class="col-lg-6">
            <div id="panel-2" class="panel" data-panel-fullscreen="false">
                <div class="panel-hdr">
                    <h2>
                        {$_L['Expense by Category']}
                    </h2>
                </div>
                <div class="panel-container show">

                    <div class="panel-content p-0">
                        <div id="expense_chart" class=""></div>
                    </div>

                </div>
            </div>

        </div>

        <div class="col-md-6">
            <div class="panel" id="panel-6">
                <div class="panel-hdr">
                    <h2>Net Worth & Account Balances</h2>
                    <div class="panel-toolbar">

                        <a href="#" id="set_goal" class="btn btn-primary btn-xs pull-right"> Set Goal</a>
                    </div>


                </div>
                <div class="panel-container" style="min-height: 365px;">
                    <div class="panel-content">

                        <h1 class="text-center amount text-success">{formatCurrency($net_worth,$config['home_currency'])}</h1>


                        <div>
                            <span class="amount">{formatCurrency($net_worth,$config['home_currency'])}</span> {$_L['of']}<span class="amount">{$config['networth_goal']}</span>
                            <small class="float-right"><span class="amount_no_currency">{$pg}</span>%</small>

                            <div class="progress progress-small">
                                <div style="width: {$pgb}%;" class="progress-bar progress-bar-{$pgc}  bg-success"></div>
                            </div>

                        </div>


                        <table class="table table-striped" style="margin-top: 26px;">
                            <th class="text-info h6"><strong>{$_L['Account']}</strong></th>

                            <th class="text-right h6">{$_L['Balance']}</th>


                            {foreach $balances['banks'] as $bank}

                                <tr>
                                    <td class="text-info h6"><strong>{$bank->account}</strong></td>

                                    <td class="text-right h6">
                                        {if (isset($balances['balances'][$bank->id]))}
                                            {formatCurrency($balances['balances'][$bank->id],$balances['home_currency']->iso_code)}
                                        {/if}
                                    </td>

                                </tr>

                            {/foreach}



                        </table>



                    </div>





                    <div>





                    </div>






                </div>
            </div>
        </div>

        {if $config['invoicing'] && $all_data_access}


            <div class="col-md-6">

                <div class="panel" id="panel-7">
                    <div class="panel-hdr">
                        <h2>{$_L['Sales']}</h2>
                    </div>
                    <div class="panel-container">
                        <div class="panel-content">
                            <div class="ibox-content">

                                <div id="sales_pie_graph"></div>

                            </div>
                        </div>
                    </div>

                </div>


            </div>

            <div class="col-md-6">
                <div class="panel" id="panel-8">
                    <div class="panel-hdr">
                        <h2>{$_L['Sales']}</h2>
                        <div class="panel-toolbar">
                            <a href="{$_url}invoices/list/" class="btn btn-primary btn-xs pull-right"> {$_L['Invoices']}</a>
                        </div>



                    </div>
                    <div class="panel-container">
                        <table class="table table-striped " >
                            <thead>
                            <tr>

                                <th class="h6"><strong>{$_L['Name']}</strong></th>
                                <th class="h6">{$_L['Sales Count']}</th>
                                <th class="h6">{$_L['Amount']}</th>


                            </tr>
                            </thead>
                            <tbody>

                            {foreach $item_sold as $sold}
                                <tr>

                                    <td class="text-info h6">
                                        <strong>
                                            {strTrunc($sold['name'],30)}
                                        </strong>

                                    </td>
                                    <td class="h6">{floor($sold['sold_count'])}</td>
                                    <td class="amount h6">{$sold['total_amount']}</td>



                                </tr>
                            {/foreach}

                            </tbody>
                        </table>


                    </div>



                </div>

            </div>
            <div class="col-lg-6">
                <div class="panel" id="panel-6">
                    <div class="panel-hdr">

                        <h2>{$_L['Latest Income']}</h2>
                    </div>
                    <div class="panel-container">
                        <div class="table-responsive">
                            <table class="table table-striped ">
                                <th class="h6">{$_L['Date']}</th>
                                <th class="h6">{$_L['Description']}</th>
                                <th class="text-right h6">{$_L['Amount']}</th>
                                {foreach $inc as $incs}
                                    <tr>
                                        <td class="h6 text-info">{date( $config['df'], strtotime($incs['date']))}</td>
                                        <td><a href="{$_url}transactions/manage/{$incs['id']}/"><strong>{$incs['description']}</strong></a> </td>
                                        <td class="text-right text-success amount h6">{formatCurrency($incs['amount'],$config['home_currency'])}</td>
                                    </tr>
                                {/foreach}



                            </table>
                        </div>

                    </div>

                </div>

            </div>

        {/if}



    </div>


    </div>
{/block}

{block name="script"}
    <script>

        function displayEvent(event_id=0,date=0)
        {
            $.fancybox.open({
                src  :  base_url + 'calendar/event/'+event_id+'/'+date,
                type : 'ajax',
                opts : {
                    afterShow : function( instance, current ) {
                        // $('[data-toggle="datepicker"]').datepicker();
                        // $start_time.timepicker();
                        // $end_time.timepicker();

                        $('#start').datepicker();
                        $('#start_time').timepicker();
                        $('#end').datepicker();

                        let eventForm = $('#eventForm');
                        eventForm.on('submit',function (e) {
                            e.preventDefault();
                            $.post( base_url + "calendar/save_event/", eventForm.serialize())
                                .done(function( data ) {



                                    if ($.isNumeric(data)) {

                                        location.reload();

                                    }

                                    else {
                                        toastr.error(data);
                                    }

                                });


                            return false;
                        });

                    }
                },
            });
        }

        $(function () {

            $.getJSON( "{$_url}dashboard/json_income_vs_exp/", function( data ) {
                var options1 = {
                    chart: {
                        fontFamily: 'Roboto, sans-serif',
                        height: 340,
                        {if !empty($config['admin_dark_theme'])}
                        foreColor: '#fff',
                        {/if}
                        toolbar: {
                            show: false
                        },
                        events: {
                            mounted: function(ctx, config) {
                                const highest1 = ctx.getHighestValueInSeries(0);
                                const highest2 = ctx.getHighestValueInSeries(1);

                                ctx.addPointAnnotation({
                                    x: new Date(ctx.w.globals.seriesX[0][ctx.w.globals.series[0].indexOf(highest1)]).getTime(),
                                    y: highest1,
                                    label: {
                                        style: {
                                            cssClass: 'd-none'
                                        }
                                    },
                                    customSVG: {
                                        SVG: '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="#1b55e2" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>',
                                        cssClass: undefined,
                                        offsetX: -8,
                                        offsetY: 5
                                    }
                                })

                                ctx.addPointAnnotation({
                                    x: new Date(ctx.w.globals.seriesX[1][ctx.w.globals.series[1].indexOf(highest2)]).getTime(),
                                    y: highest2,
                                    label: {
                                        style: {
                                            cssClass: 'd-none'
                                        }
                                    },
                                    customSVG: {
                                        SVG: '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="#e7515a" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>',
                                        cssClass: undefined,
                                        offsetX: -8,
                                        offsetY: 5
                                    }
                                })
                            },
                        }
                    },
                    {if !empty($config['admin_dark_theme'])}
                    colors: ["#4586DB", "#C23C3E"],
                {else}
                    colors: ["#7E5FF4", "#FB8141"],
                {/if}

                    dataLabels: {
                        enabled: false
                    },
                    stroke: {
                        width: [0, 2, 5],
                        curve: 'smooth'
                    },
                    fill: {
                        opacity: [0.85, 0.25, 1],
                        gradient: {
                            inverseColors: false,
                            shade: 'light',
                            type: "vertical",
                            opacityFrom: 1,
                            opacityTo: 1,
                            stops: [0, 100, 100, 100]
                        }
                    },

                    markers: {
                        discrete: [{
                            seriesIndex: 0,
                            dataPointIndex: 7,
                            fillColor: '#000',
                            strokeColor: '#000',
                            size: 5
                        }, {
                            seriesIndex: 2,
                            dataPointIndex: 11,
                            fillColor: '#000',
                            strokeColor: '#000',
                            size: 4
                        }]
                    },
                    subtitle: {
                        text: '{$_L['Net Worth']}',
                        align: 'left',
                        margin: 0,
                        offsetX: -10,
                        offsetY: 35,
                        floating: false,
                        style: {
                            fontSize: '14px',
                            {if !empty($config['admin_dark_theme'])}
                            color:  '#fff',
                            {else}
                            color:  '#565674',
                            {/if}
                        }
                    },
                    title: {
                        text: '{formatCurrency($net_worth,$config['home_currency'])}',
                        align: 'left',
                        margin: 0,
                        offsetX: -10,
                        offsetY: 0,
                        floating: false,
                        style: {
                            fontSize: '25px',
                            {if !empty($config['admin_dark_theme'])}
                            color:  '#fff',
                            {else}
                            color:  '#0e1726'
                            {/if}
                        },
                    },

                    series: [{
                        type: 'column',
                        name: 'Income',
                        data: data.Income,

                    }, {
                        type: 'area',
                        name: 'Expenses',
                        data: data.Expense,
                    }],
                    labels: data.Months,
                    xaxis: {


                        crosshairs: {
                            show: true
                        },
                        labels: {
                            offsetX: 0,
                            offsetY: 5,
                            style: {
                                fontSize: '12px',
                                fontFamily: 'Roboto, sans-serif',
                                cssClass: 'apexcharts-xaxis-title',
                            },
                        }
                    },
                    yaxis: {
                        labels: {
                            formatter: function(value, index) {
                                return (value / 1000) + 'K'
                            },
                            offsetX: -22,
                            offsetY: 0,
                            style: {
                                fontSize: '12px',
                                fontFamily: 'Roboto, sans-serif',
                                cssClass: 'apexcharts-yaxis-title',
                            },
                        }
                    },
                    grid: {
                        {if !empty($config['admin_dark_theme'])}
                        borderColor: "#2B2C3F"
                        {else}
                        borderColor: "#f1f1f1"
                        {/if}

                    },
                    legend: {
                        position: 'top',
                        horizontalAlign: 'right',
                        offsetY: -50,
                        fontSize: '16px',
                        fontFamily: 'Roboto, sans-serif',
                        markers: {
                            width: 10,
                            height: 10,
                            strokeWidth: 0,
                            strokeColor: '#fff',
                            fillColors: undefined,
                            radius: 12,
                            onClick: undefined,
                            offsetX: 0,
                            offsetY: 0
                        },
                        itemMargin: {
                            horizontal: 0,
                            vertical: 20
                        }
                    },
                    tooltip: {
                        theme: 'dark',
                        marker: {
                            show: true,
                        },
                        x: {
                            show: false,
                        }
                    },
                    responsive: [{
                        breakpoint: 575,
                        options: {
                            legend: {
                                offsetY: -30,
                            },
                        },
                    }],
                    plotOptions: { bar: { horizontal: !1, columnWidth: "15%", endingShape: "rounded" } },
                    {if !empty($config['admin_dark_theme'])}
                    background: '#000',
                    foreColor: '#fff',
                    {/if}
                };


                var chart1 = new ApexCharts(
                    document.querySelector("#cash_flow_chart"),
                    options1
                );

                chart1.render();
            });


            var expense_chart_options = {
                chart: {
                    height: 403,
                    type: 'bar',
                    toolbar: {
                        show: false,
                    },
                    {if !empty($config['admin_dark_theme'])}
                    foreColor: '#fff',
                    {/if}

                },
                colors: ["#5C34F4"],
                xaxis: {
                    categories: [
                        {foreach $expense_cats as $expnese_cat}
                        '{$expnese_cat->name}',
                        {/foreach}
                    ],
                },
                series: [{
                    data: [{foreach $expense_cats as $expnese_cat}
                        {$expnese_cat->total_amount},
                        {/foreach}]
                }],
                plotOptions: {
                    bar: {
                        horizontal: true,
                        endingShape: 'rounded',

                    }
                },
                grid: {
                    {if !empty($config['admin_dark_theme'])}
                    borderColor: "#2B2C3F"
                    {else}
                    borderColor: "#f1f1f1"
                    {/if}

                },
                responsive: [{
                    breakpoint: 480,
                    options: {
                        chart: {
                            width: 200
                        },
                        legend: {
                            position: 'bottom'
                        }
                    }
                }]
            }

            var expense_chart = new ApexCharts(
                document.querySelector("#expense_chart"),
                expense_chart_options
            );

            expense_chart.render();


            $.getJSON( "{$_url}dashboard/json_d_chart_data/", function( data ) {
                var chart_income_vs_expense_options = {
                    chart: {
                        height: 400,
                        type: 'bar',
                        toolbar: {
                            show: false,
                        },
                        {if !empty($config['admin_dark_theme'])}
                        foreColor: '#fff',
                        {/if}
                    },
                    plotOptions: {
                        bar: {
                            horizontal: false,
                            columnWidth: '55%',
                            endingShape: 'rounded'
                        },
                    },
                    dataLabels: {
                        enabled: false
                    },
                    stroke: {
                        show: true,
                        width: 0,
                        colors: ['transparent']
                    },
                    series: [{
                        name: '{$_L['Income']}',
                        data: data.Income
                    }, {
                        name: '{$_L['Expense']}',
                        data: data.Expense
                    }],
                    xaxis: {
                        categories: [
                            '01',
                            '02',
                            '03',
                            '04',
                            '05',
                            '06',
                            '07',
                            '08',
                            '09',
                            '10',
                            '11',
                            '12',
                            '13',
                            '14',
                            '15',
                            '16',
                            '17',
                            '18',
                            '19',
                            '20',
                            '21',
                            '22',
                            '23',
                            '24',
                            '25',
                            '26',
                            '27',
                            '28',
                            '29',
                            '30',
                            '31'
                        ],
                    },
                    yaxis: {
                        title: {
                            text: '{$_L['Amount']}'
                        }
                    },
                    colors: ["#5C34F4", "#FC9740"],
                    fill: {
                        opacity: 1

                    },
                    tooltip: {
                        y: {
                            formatter: function (val) {
                                return val
                            }
                        }
                    }
                }

                var chart_income_vs_expense = new ApexCharts(
                    document.querySelector("#chart_income_vs_expense"),
                    chart_income_vs_expense_options
                );

                chart_income_vs_expense.render();
            });

            $('.clickable-row').on('click',function () {
                window.location = base_url + 'invoices/view/' + $(this).data('id');
            });

            var invoice_stats = $("#invoice_stats");

            $.get( base_url + "dashboard/invoice_stats_json/", function( data ) {

                invoice_stats.html(' <span class="font-12 head-font txt-dark">{$_L['Unpaid']}<span class="float-right">'+ data.Unpaid.percentage +'%</span></span>\
                        <div class="progress my-2 progress-small mt-10">\
                        <div class="progress-bar progress-bar-danger" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: '+ data.Unpaid.percentage +'%" role="progressbar"> <span class="sr-only">'+ data.Unpaid.percentage +'%</span> </div>\
                        </div>\
                        <span class="font-12 head-font txt-dark">{$_L['Partially Paid']}<span class="float-right">'+ data['Partially Paid'].percentage +'%</span></span>\
                        <div class="progress my-2 progress-small mt-10">\
                        <div class="progress-bar progress-bar-info" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: '+ data['Partially Paid'].percentage +'%" role="progressbar"> <span class="sr-only">'+ data['Partially Paid'].percentage +'</span> </div>\
                        </div>\
                        <span class="font-12 head-font txt-dark">{$_L['Paid']}<span class="float-right">'+ data.Paid.percentage +'%</span></span>\
                        <div class="progress my-2 progress-small mt-10">\
                        <div class="progress-bar progress-bar-success" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: '+ data.Paid.percentage +'%" role="progressbar"> <span class="sr-only">'+ data.Paid.percentage +'</span> </div>\
                        </div>\
                        ');
                invoice_stats.slideDown( "slow" );

                // Load Account Balances



            });


            $('#clx-page-content').smartPanel({
                localStorage: true,
                onChange: function () {},
                onSave: function () {},
                opacity: 1,
                deleteSettingsKey: '#deletesettingskey-options',
                settingsKeyLabel: 'Reset settings?',
                deletePositionKey: '#deletepositionkey-options',
                positionKeyLabel: 'Reset position?',
                sortable: true,
                buttonOrder: '%collapse% %fullscreen% %close%',
                buttonOrderDropdown: '%refresh% %locked% %color% %custom% %reset%',
                // customButton: true,
                // customButtonLabel: "Custom Button",
                onCustom: function () {},
                closeButton: false,
                onClosepanel: function() {
                    if (myapp_config.debugState)
                        console.log($(this).closest(".panel").attr('id') + " onClosepanel")
                },
                fullscreenButton: true,
                onFullscreen: function() {
                    if (myapp_config.debugState)
                        console.log($(this).closest(".panel").attr('id') + " onFullscreen")
                },
                collapseButton: true,
                onCollapse: function() {
                    if (myapp_config.debugState)
                        console.log($(this).closest(".panel").attr('id') + " onCollapse")
                },
                lockedButton: false,
                lockedButtonLabel: "Lock Position",
                onLocked: function() {
                    if (myapp_config.debugState)
                        console.log($(this).closest(".panel").attr('id') + " onLocked")
                },
                // refreshButton: true,
                // refreshButtonLabel: "Refresh Content",
                // onRefresh: function() {
                //     if (myapp_config.debugState)
                //         console.log($(this).closest(".panel").attr('id') + " onRefresh")
                // },
                colorButton: true,
                colorButtonLabel: "Panel Style",
                onColor: function() {
                    if (myapp_config.debugState)
                        console.log($(this).closest(".panel").attr('id') + " onColor")
                },
                panelColors: ['bg-primary-700 bg-success-gradient',
                    'bg-primary-500 bg-info-gradient',
                    'bg-primary-600 bg-primary-gradient',
                    'bg-info-600 bg-primray-gradient',
                    'bg-info-600 bg-info-gradient',
                    'bg-info-700 bg-success-gradient',
                    'bg-success-900 bg-info-gradient',
                    'bg-success-700 bg-primary-gradient',
                    'bg-success-600 bg-success-gradient',
                    'bg-danger-900 bg-info-gradient',
                    'bg-fusion-400 bg-fusion-gradient',
                    'bg-faded'],
                resetButton: true,
                resetButtonLabel: "Reset Panel",
                onReset: function() {
                    if (myapp_config.debugState)
                        console.log( $(this).closest(".panel").attr('id') + " onReset callback" )
                }
            });


            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl,
                {
                    plugins: ['dayGrid', 'list', 'timeGrid', 'interaction', 'bootstrap'],
                    themeSystem: 'bootstrap',
                    timeZone: 'UTC',
                    //dateAlignment: "month", //week, month
                    buttonText:
                        {
                            today: 'today',
                            month: 'month',
                            week: 'week',
                            day: 'day',
                            list: 'list'
                        },
                    eventTimeFormat:
                        {
                            hour: 'numeric',
                            minute: '2-digit',
                            meridiem: 'short'
                        },
                    navLinks: true,
                    header:
                        {
                            left: 'title',
                            center: '',
                            right: 'today prev,next'
                        },
                    footer:
                        {
                            left: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek',
                            center: '',
                            right: ''
                        },
                    editable: true,
                    eventLimit: true, // allow "more" link when too many events
                    eventSources: [{
                        url: base_url + 'calendar/data/',
                        type: 'GET',
                        error: function() {
                            bootbox.alert("Unable to load data.");
                        }
                    } ],
                    viewSkeletonRender: function()
                    {
                        $('.fc-toolbar .btn-default').addClass('btn-sm');
                        $('.fc-header-toolbar h2').addClass('fs-md');
                        $('#calendar').addClass('fc-reset-order')
                    },

                    dateClick: function(info) {
                        displayEvent(0,info.dateStr);
                    },
                    eventClick: function(info) {
                        displayEvent(info.event.id);
                    }


                });

            calendar.render();

            $("#set_goal").click(function (e) {
                e.preventDefault();

                bootbox.prompt({
                    title: "Set New Goal for Net Worth",
                    value: "350,000.00",
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
                            // alert(result);
                            $.post( base_url + "settings/networth_goal/", { goal: result })
                                .done(function( data ) {
                                    location.reload();
                                });
                        }
                    }
                });

            });




            var options = {
                series: [
                    {foreach $item_sold as $sold}
                    {$sold['sold_count']},
                    {/foreach}
                ],
                chart: {
                    height: 350,
                    type: 'radialBar',
                    {if !empty($config['admin_dark_theme'])}
                    foreColor: '#fff',
                    colors: ["#4586DB", "#C23C3E"],
                    {else}
                    colors: ["#7E5FF4", "#FB8141"],
                    {/if}


                },
                plotOptions: {
                    radialBar: {
                        dataLabels: {
                            name: {
                                fontSize: '22px',
                            },
                            value: {
                                fontSize: '16px',
                            },
                            total: {
                                show: true,
                                label: '{$_L['Total']}',
                                formatter: function (w) {
                                    // By default this function returns the average of all series. The below is just an example to show the use of custom formatter function
                                    return {count($item_sold)}
                                }
                            }
                        }
                    }
                },
                labels: [
                    {foreach $item_sold as $sold}
                    '{strTrunc(addslashes($sold['name']),30)}',
                    {/foreach}
                ],
                {if !empty($config['admin_dark_theme'])}
                background: '#000',
                {/if}
            }


            var chart = new ApexCharts(document.querySelector("#sales_pie_graph"), options);
            chart.render();




        });
    </script>
{/block}
