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

    </style>


{/block}

{block name="content"}

    <div class="subheader">
        <h1 class="subheader-title">
            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                        <rect x="0" y="0" width="24" height="24"/>
                        <path d="M8.40093151,17 L5,17 C3.34314575,17 2,15.1568542 2,13.5 C2,11.8431458 3.34314575,10 5,10 L6,10 L6,8 L21,8 L21,11.5 C21,15.6421356 17.6421356,19 13.5,19 C11.5309185,19 9.73907026,18.2411745 8.40093151,17 Z M6.86504659,15 C6.38614142,14.0940164 6.08736465,13.0781211 6.01640228,12 L5,12 C4.44771525,12 4,12.9477153 4,13.5 C4,14.0522847 4.44771525,15 5,15 L6.86504659,15 Z" fill="#000000"/>
                        <rect fill="#000000" opacity="0.3" x="6" y="21" width="15" height="2" rx="1"/>
                        <path d="M8.11576273,0 L9.27322553,1.15267194 C8.41777098,2.01168201 8.42065331,3.40153019 9.27966338,4.25698473 C9.35322262,4.3302395 9.4318859,4.39818368 9.51506091,4.46030566 L10,4.82249831 L9.02250371,6.13126634 L8.53756462,5.76907368 C8.39249331,5.66072242 8.25529121,5.54221626 8.12699144,5.41444753 C6.62873232,3.92238985 6.62370505,1.49825912 8.11576273,0 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                        <path d="M13.1157627,1 L14.2732255,2.15267194 C13.417771,3.01168201 13.4206533,4.40153019 14.2796634,5.25698473 C14.3532226,5.3302395 14.4318859,5.39818368 14.5150609,5.46030566 L15,5.82249831 L14.0225037,7.13126634 L13.5375646,6.76907368 C13.3924933,6.66072242 13.2552912,6.54221626 13.1269914,6.41444753 C11.6287323,4.92238985 11.6237051,2.49825912 13.1157627,1 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                        <path d="M18.1157627,0 L19.2732255,1.15267194 C18.417771,2.01168201 18.4206533,3.40153019 19.2796634,4.25698473 C19.3532226,4.3302395 19.4318859,4.39818368 19.5150609,4.46030566 L20,4.82249831 L19.0225037,6.13126634 L18.5375646,5.76907368 C18.3924933,5.66072242 18.2552912,5.54221626 18.1269914,5.41444753 C16.6287323,3.92238985 16.6237051,1.49825912 18.1157627,0 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"/>
                    </g>
                </svg>

            Projects <span class='fw-300'></span>
        </h1>
        <div class="subheader-block d-lg-flex align-items-center">
            <a href="{$_url}projects/project" class="btn btn-primary">Create New Project</a>
        </div>

    </div>


    <div class="row">
        <div class="col-md-12">
            <div class="tabs-container">
{*                <ul class="nav nav-tabs">*}
{*                    <li class="active"><a class="nav-link active show" href="{$_url}projects">Projects</a></li>*}

{*                </ul>*}


                <div class="row">

                    {foreach $projects as $project}

                        <div class="col-lg-4">

                            <div class="panel">

                                <div class="panel-container">



                                        <div class="panel-content">

                                            <div class="d-flex justify-content-between">
                                                <h3><span class="h4">{$project->name}</span></h3>
                                                <div class="dropdown">
                                                    <a href="#" class="dropdown-toggle card-drop arrow-none" data-toggle="dropdown" aria-expanded="false">
                                                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                                <rect x="0" y="0" width="24" height="24"/>
                                                                <circle fill="#000000" cx="12" cy="5" r="2"/>
                                                                <circle fill="#000000" cx="12" cy="12" r="2"/>
                                                                <circle fill="#000000" cx="12" cy="19" r="2"/>
                                                            </g>
                                                        </svg>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-right" style="">

                                                        <a class="dropdown-item" href="{$_url}projects/view/{$project->id}">{$_L['View']}</a>

                                                        <a class="dropdown-item" href="{$_url}projects/project/{$project->id}">{$_L['Edit']}</a>
                                                        <a class="dropdown-item" href="{$_url}projects/delete/{$project->id}">{$_L['Delete']}</a>

                                                    </div>
                                                </div>
                                            </div>



                                            <p class="text-muted"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                        <rect x="0" y="0" width="24" height="24"/>
                                                        <circle fill="#000000" opacity="0.3" cx="12" cy="12" r="10"/>
                                                        <path d="M12,11 C10.8954305,11 10,10.1045695 10,9 C10,7.8954305 10.8954305,7 12,7 C13.1045695,7 14,7.8954305 14,9 C14,10.1045695 13.1045695,11 12,11 Z M7.00036205,16.4995035 C7.21569918,13.5165724 9.36772908,12 11.9907452,12 C14.6506758,12 16.8360465,13.4332455 16.9988413,16.5 C17.0053266,16.6221713 16.9988413,17 16.5815,17 L7.4041679,17 C7.26484009,17 6.98863236,16.6619875 7.00036205,16.4995035 Z" fill="#000000" opacity="0.3"/>
                                                    </g>
                                                </svg>
                                                {if $project->contact_id && isset($contacts[$project->contact_id])}
                                                    {$contacts[$project->contact_id]->account}
                                                {/if}</p>


                                            {if $project->status == 'Completed'}
                                                <span class="badge badge-outline text-uppercase badge-outline-success mb-4">{$project->status}</span>
                                                {else}
                                                <span class="badge badge-outline text-uppercase badge-outline-danger mb-4">{$project->status}</span>
                                            {/if}




                                            {if $project->budget}
                                                <p class="mb-2">Budget: <span>{formatCurrency($project->budget,$project->currency)}</span></p>
                                            {/if}




                                            <p class="text-muted mb-4">{$project->summary}</p>


                                            <div class="row">
                                                <div class="col mb-3">
                                                    <div class="mb-2">
                                                        <i class="fal fa-calendar"></i> <strong><span>{$_L['Start Date']}</span></strong>
                                                    </div>
                                                    <span class="badge badge-outline text-uppercase badge-outline-success">{date( $config['df'], strtotime($project->start_date))}</span>
                                                </div>
                                                <div class="col">
                                                    <div class="mb-2">
                                                        <i class="fal fa-calendar"></i> <strong>{$_L['Due Date']}</strong>
                                                    </div>
                                                    <span class="badge badge-outline text-uppercase badge-outline-danger">{date( $config['df'], strtotime($project->due_date))}</span>
                                                </div>
                                            </div>



                                            {if $project->members}
                                                <div class="fs-sm d-flex align-items-center my-3">
                                                    {foreach json_decode($project->members) as $member}
                                                        {if isset($staffs[$member])}
                                                            <a href="javascript:;" class="btn-m-s user-stacked">

                                                                {if $staffs[$member]->img}
                                                                    <img src="{{APP_URL}}/{{$staffs[$member]->img}}" class="profile-image rounded-circle" alt="{{$staffs[$member]->fullname}}">
                                                                {else}
                                                                    <span class="clx-avatar">{sp_get_contact_image($staffs[$member])}</span>
                                                                {/if}

                                                            </a>
                                                        {/if}
                                                    {/foreach}
                                                </div>
                                            {/if}


                                            {if isset($tasks_status[$project->id])}

                                                <p class="mb-2 font-weight-semibold">{round(($tasks_status[$project->id]['completed']*100)/$tasks_status[$project->id]['total'])}% {$_L['tasks completed']}. <span class="float-right">
                                                    {$tasks_status[$project->id]['completed']}/{$tasks_status[$project->id]['total']}</span></p>


                                                <div class="progress mb-3" style="height: 7px;">
                                                    <div class="progress-bar" role="progressbar" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100" style="width: {round(($tasks_status[$project->id]['completed']*100)/$tasks_status[$project->id]['total'])}%;">
                                                    </div>
                                                </div>

                                            {/if}






{*                                          <h5>*}
{*                                              <p>*}
{*                                                  <strong>Project Manager:</strong>*}
{*                                                  {if $project->project_manager_id && isset($staffs[$project->project_manager_id])}*}
{*                                                      {$staffs[$project->project_manager_id]->fullname}*}
{*                                                  {/if}*}
{*                                              </p>*}
{*                                          </h5>*}




                                        </div>




                                </div>



                            </div>

                        </div>

                        {foreachelse}

                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <h2>{$_L['No Data Available']}</h2>
                                </div>
                            </div>
                        </div>

                    {/foreach}


                </div>
{*                <div class="tab-content">*}
{*                    <div class="tab-pane active show">*}
{*                        <div class="panel-body panel-body-with-border" style="{if $config['nstyle'] == 'dark_mode'} background-color: #272E48; border-color: #495471; {else} background-color: #fff; {/if}">*}

{*                            <form class="form-horizontal" method="post" action="">*}
{*                                <div class="form-group">*}
{*                                    <div class="col-md-12">*}
{*                                        <div class="input-group">*}
{*                                            <div class="input-group-addon">*}
{*                                                <span class="fal fa-search"></span>*}
{*                                            </div>*}
{*                                            <input type="text" name="name" id="foo_filter" class="form-control" placeholder="{$_L['Search']}..."/>*}

{*                                        </div>*}
{*                                    </div>*}

{*                                </div>*}
{*                            </form>*}

{*                            <table class="table table-bordered table-hover sys_table footable" data-filter="#foo_filter" data-page-size="50">*}
{*                                <thead>*}
{*                                <tr>*}
{*                                    <th>#</th>*}
{*                                    <th>Name</th>*}
{*                                    <th>Project Manager</th>*}
{*                                    <th>Client</th>*}
{*                                    <th>Financials</th>*}
{*                                    <th>Start</th>*}
{*                                    <th>End</th>*}
{*                                    <th>*}
{*                                        {$_L['Status']}*}
{*                                    </th>*}
{*                                    <th class="text-right" width="140px;">{$_L['Manage']}</th>*}
{*                                </tr>*}
{*                                </thead>*}
{*                                <tbody>*}

{*                                {foreach $projects as $project}*}
{*                                    <tr>*}
{*                                        <td  data-value="1">*}
{*                                            <a href="{$_url}projects/view/{$project->id}">{$project->id}</a>*}
{*                                        </td>*}


{*                                        <td>*}
{*                                            <a href="{$_url}projects/view/{$project->id}">{$project->name}</a>*}
{*                                        </td>*}
{*                                        <td>*}
{*                                            {if $project->project_manager_id && isset($staffs[$project->project_manager_id])}*}
{*                                                {$staffs[$project->project_manager_id]->fullname}*}
{*                                            {/if}*}
{*                                        </td>*}
{*                                        <td>*}
{*                                            {if $project->contact_id && isset($contacts[$project->contact_id])}*}
{*                                                {$contacts[$project->contact_id]->account}*}
{*                                            {/if}*}

{*                                        </td>*}
{*                                        <td>*}
{*                                            {if $project->budget}*}
{*                                                {formatCurrency($project->budget,$project->currency)}*}
{*                                            {/if}*}
{*                                        </td>*}
{*                                        <td>{$project->start_date}</td>*}
{*                                        <td>{$project->due_date}</td>*}
{*                                        <td>{$project->status}</td>*}



{*                                        <td class="text-right">*}



{*                                            <a href="{$_url}projects/view/{$project->id}" class="btn btn-primary btn-xs" data-toggle="tooltip" data-placement="top" title="{$_L['View']}"><i class="fal fa-file-text-o"></i></a>*}



{*                                            <a href="{$_url}projects/project/{$project->id}" class="btn btn-info btn-xs" data-toggle="tooltip" data-placement="top" title="{$_L['Edit']}"><i class="fal fa-pencil"></i></a>*}


{*                                            <a href="{$_url}projects/delete/{$project->id}" class="btn btn-danger btn-xs cdelete" id="iiddd" data-toggle="tooltip" data-placement="top" title="{$_L['Delete']}"><i class="fal fa-trash"></i></a>*}


{*                                        </td>*}
{*                                    </tr>*}
{*                                {/foreach}*}

{*                                </tbody>*}

{*                                <tfoot>*}
{*                                <tr>*}
{*                                    <td colspan="9">*}
{*                                        <ul class="pagination">*}
{*                                        </ul>*}
{*                                    </td>*}
{*                                </tr>*}
{*                                </tfoot>*}

{*                            </table>*}




{*                        </div>*}
{*                    </div>*}

{*                </div>*}


            </div>
        </div>
    </div>


{/block}


{block name="script"}



    <script>


        $(function () {




        });

    </script>
{/block}
