{extends file="project_base.tpl"}

{block name="project_content"}
    {block name="head"}
        <style>
            .contact-box {
            {if $config['nstyle'] == 'dark_mode'}
                background-color: rgba(255,255,255,.05);
                border: 1px solid #394156;
            {else}
                background-color: #ffffff;
                border: 1px solid #e7eaec;
            {/if}
                padding: 20px;
                margin-bottom: 20px;
            }

            .contact-box > a {
                color: inherit;
            }

            .img-fluid {
                max-width: 100%;
                height: auto;
            }

            .rounded-circle {
                border-radius: 50%!important;
            }



            .user-stacked{
                margin: 3px 1px 1px -11px;
                border: 2px solid #fff;
                border-radius: 50%;
            }

            .user-stacked .profile-image{
                width: 40px;
                height: 40px;
            }

            .arrow-none.dropdown-toggle:after {
                content: none!important;
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
            .text-default{
                color: #525f7f;
            }
            p {
                font-size: 1rem;
                font-weight: 300;
                line-height: 1.7;
            }




        </style>
    {/block}


    <div class="col-md-12">
        <div class="panel-content">


            <div class="d-flex justify-content-between">
                <h3><strong>{$project->name}</strong></h3>


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

                        <a class="dropdown-item" href="{$_url}projects/project/{$project->id}">{$_L['Edit']}</a>
                        <a class="dropdown-item" href="{$_url}projects/delete/{$project->id}">{$_L['Delete']}</a>

                    </div>
                </div>
            </div>
            <span class="badge badge-success mb-4">{$project->status}</span>

            <div class="mb-5" >
                <p class="text-muted"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <rect x="0" y="0" width="24" height="24"/>
                            <g transform="translate(12.500000, 12.000000) rotate(-315.000000) translate(-12.500000, -12.000000) translate(6.000000, 1.000000)" fill="#000000" opacity="0.3">
                                <path d="M0.353553391,7.14644661 L3.35355339,7.14644661 C3.4100716,7.14644661 3.46549471,7.14175791 3.51945496,7.13274826 C3.92739876,8.3050906 5.04222146,9.14644661 6.35355339,9.14644661 C8.01040764,9.14644661 9.35355339,7.80330086 9.35355339,6.14644661 C9.35355339,4.48959236 8.01040764,3.14644661 6.35355339,3.14644661 C5.04222146,3.14644661 3.92739876,3.98780262 3.51945496,5.16014496 C3.46549471,5.15113531 3.4100716,5.14644661 3.35355339,5.14644661 L0.436511831,5.14644661 C0.912589923,2.30873327 3.3805571,0.146446609 6.35355339,0.146446609 C9.66726189,0.146446609 12.3535534,2.83273811 12.3535534,6.14644661 L12.3535534,19.1464466 C12.3535534,20.2510161 11.4581229,21.1464466 10.3535534,21.1464466 L2.35355339,21.1464466 C1.24898389,21.1464466 0.353553391,20.2510161 0.353553391,19.1464466 L0.353553391,7.14644661 Z" transform="translate(6.353553, 10.646447) rotate(-360.000000) translate(-6.353553, -10.646447) "/>
                                <rect x="2.35355339" y="13.1464466" width="8" height="2" rx="1"/>
                                <rect x="3.35355339" y="17.1464466" width="6" height="2" rx="1"/>
                            </g>
                        </g>
                    </svg> <span class="h5">Budget </span><br>
                <h4>
                    <span class="text-info h5">{$project->budget}</span></p>
                </h4>

            </div>

            <div class="row">
                <div class="col mb-3">
                    <p class="text-muted"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <rect x="0" y="0" width="24" height="24"/>
                                <path d="M10.9630156,7.5 L11.0475062,7.5 C11.3043819,7.5 11.5194647,7.69464724 11.5450248,7.95024814 L12,12.5 L15.2480695,14.3560397 C15.403857,14.4450611 15.5,14.6107328 15.5,14.7901613 L15.5,15 C15.5,15.2109164 15.3290185,15.3818979 15.1181021,15.3818979 C15.0841582,15.3818979 15.0503659,15.3773725 15.0176181,15.3684413 L10.3986612,14.1087258 C10.1672824,14.0456225 10.0132986,13.8271186 10.0316926,13.5879956 L10.4644883,7.96165175 C10.4845267,7.70115317 10.7017474,7.5 10.9630156,7.5 Z" fill="#000000"/>
                                <path d="M7.38979581,2.8349582 C8.65216735,2.29743306 10.0413491,2 11.5,2 C17.2989899,2 22,6.70101013 22,12.5 C22,18.2989899 17.2989899,23 11.5,23 C5.70101013,23 1,18.2989899 1,12.5 C1,11.5151324 1.13559454,10.5619345 1.38913364,9.65805651 L3.31481075,10.1982117 C3.10672013,10.940064 3,11.7119264 3,12.5 C3,17.1944204 6.80557963,21 11.5,21 C16.1944204,21 20,17.1944204 20,12.5 C20,7.80557963 16.1944204,4 11.5,4 C10.54876,4 9.62236069,4.15592757 8.74872191,4.45446326 L9.93948308,5.87355717 C10.0088058,5.95617272 10.0495583,6.05898805 10.05566,6.16666224 C10.0712834,6.4423623 9.86044965,6.67852665 9.5847496,6.69415008 L4.71777931,6.96995273 C4.66931162,6.97269931 4.62070229,6.96837279 4.57348157,6.95710938 C4.30487471,6.89303938 4.13906482,6.62335149 4.20313482,6.35474463 L5.33163823,1.62361064 C5.35654118,1.51920756 5.41437908,1.4255891 5.49660017,1.35659741 C5.7081375,1.17909652 6.0235153,1.2066885 6.2010162,1.41822583 L7.38979581,2.8349582 Z" fill="#000000" opacity="0.3"/>
                            </g>
                        </svg>Start Date <br>
                    <h4><span class="badge badge-success">{$project->start_date}</span></h4>
                    </p>
                </div>
                <div class="col">
                    <p class="text-muted"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <rect x="0" y="0" width="24" height="24"/>
                                <path d="M10.9630156,7.5 L11.0475062,7.5 C11.3043819,7.5 11.5194647,7.69464724 11.5450248,7.95024814 L12,12.5 L15.2480695,14.3560397 C15.403857,14.4450611 15.5,14.6107328 15.5,14.7901613 L15.5,15 C15.5,15.2109164 15.3290185,15.3818979 15.1181021,15.3818979 C15.0841582,15.3818979 15.0503659,15.3773725 15.0176181,15.3684413 L10.3986612,14.1087258 C10.1672824,14.0456225 10.0132986,13.8271186 10.0316926,13.5879956 L10.4644883,7.96165175 C10.4845267,7.70115317 10.7017474,7.5 10.9630156,7.5 Z" fill="#000000"/>
                                <path d="M7.38979581,2.8349582 C8.65216735,2.29743306 10.0413491,2 11.5,2 C17.2989899,2 22,6.70101013 22,12.5 C22,18.2989899 17.2989899,23 11.5,23 C5.70101013,23 1,18.2989899 1,12.5 C1,11.5151324 1.13559454,10.5619345 1.38913364,9.65805651 L3.31481075,10.1982117 C3.10672013,10.940064 3,11.7119264 3,12.5 C3,17.1944204 6.80557963,21 11.5,21 C16.1944204,21 20,17.1944204 20,12.5 C20,7.80557963 16.1944204,4 11.5,4 C10.54876,4 9.62236069,4.15592757 8.74872191,4.45446326 L9.93948308,5.87355717 C10.0088058,5.95617272 10.0495583,6.05898805 10.05566,6.16666224 C10.0712834,6.4423623 9.86044965,6.67852665 9.5847496,6.69415008 L4.71777931,6.96995273 C4.66931162,6.97269931 4.62070229,6.96837279 4.57348157,6.95710938 C4.30487471,6.89303938 4.13906482,6.62335149 4.20313482,6.35474463 L5.33163823,1.62361064 C5.35654118,1.51920756 5.41437908,1.4255891 5.49660017,1.35659741 C5.7081375,1.17909652 6.0235153,1.2066885 6.2010162,1.41822583 L7.38979581,2.8349582 Z" fill="#000000" opacity="0.3"/>
                            </g>
                        </svg> Due Date <br>
                    <h4><span class="badge badge-danger">{$project->due_date}</span></h4></p>
                </div>

            </div>

            {if $has_tasks}

                <p class="mb-2 font-weight-semibold text-default">{round(($tasks_status[$project->id]['completed']*100)/$tasks_status[$project->id]['total'])}% {$_L['tasks completed']}. <span class="float-right">
                                                    {$tasks_status[$project->id]['completed']}/{$tasks_status[$project->id]['total']}</span></p>


                <div class="progress mb-3" style="height: 7px;">
                    <div class="progress-bar" role="progressbar" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100" style="width: {round(($tasks_status[$project->id]['completed']*100)/$tasks_status[$project->id]['total'])}%;">
                    </div>
                </div>

            {/if}



            {if $project->members}
                <p class="text-default h5">{$_L['Team Members']}</p>
                <div class="fs-sm d-flex align-items-center my-3">
                    {if $project->members}
                        <div class="fs-sm d-flex align-items-center my-3">
                            {foreach json_decode($project->members) as $member}
                                {if isset($staffs[$member])}
                                    <a href="javascript:;" class="btn-m-s user-stacked">

                                        {if $staffs[$member]->img}
                                            <img src="{{APP_URL}}/{{$staffs[$member]->img}}" class="profile-image rounded-circle" alt="{$user->fullname}">
                                        {else}
                                            <img src="{{APP_URL}}/ui/lib/img/default-user-avatar.png" class="profile-image rounded-circle" alt="{$user->fullname}">
                                        {/if}

                                    </a>
                                {/if}
                            {/foreach}
                        </div>
                    {/if}
                </div>
            {/if}


            {if $project->description}
                <div class="hr-line-dashed"></div>
                <div class="text-default">
                    <p>
                        {$project->description}
                    </p>

                </div>
            {/if}



        </div>




    </div>




{/block}
