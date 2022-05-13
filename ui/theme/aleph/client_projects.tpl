{extends file="$layouts_client"}


{block name="content"}
    <div class="panel">
        <div class="panel-hdr">
            <h2>{$_L['Projects']}</h2>

        </div>

    </div>




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
                                        {* <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                <rect x="0" y="0" width="24" height="24"/>
                                                <circle fill="#000000" cx="12" cy="5" r="2"/>
                                                <circle fill="#000000" cx="12" cy="12" r="2"/>
                                                <circle fill="#000000" cx="12" cy="19" r="2"/>
                                            </g>
                                        </svg> *}
                                    </a>
                                    {* <div class="dropdown-menu dropdown-menu-right" style="">

                                        <a class="dropdown-item" href="{$_url}projects/view/{$project->id}">{$_L['View']}</a>



                                    </div> *}
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


{/block}




