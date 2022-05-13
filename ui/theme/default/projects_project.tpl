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

    <div class="mx-auto" style="max-width: 800px; width: 100%;">


        <div class="row">
            <div class="col-md-12">
                <div class="panel" id="clx_form_box">
                    <div class="panel-hdr">
                        {if $project}
                            <h2><span class="h5">{$project->name}</span></h2>
                        {else}
                            <h2>{$_L['Create New Project']}</h2>
                        {/if}
                    </div>
                    <div class="panel-container">
                        <div class="panel-content">
                            <form method="post" id="mainForm" action="{$_url}projects/project-save">


                                <div class="form-group">
                                    <label for="inputName">{$_L['Name']}</label>
                                    <input class="form-control" name="name" required id="inputName" data-pristine-required data-pristine-required-message="{$_L['This field is required']}" {if $project}value="{$project->name}"{/if} >
                                </div>


                                <div class="form-group">
                                    <textarea class="form-control" maxlength="255" name="summary" placeholder="{$_L['Summary']}..." rows="3">{if $project}{$project->summary}{/if}</textarea>
                                </div>


                                <div class="form-row mb-3">

                                    {if has_access($user->roleid,'projects','all_data')}

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="admin_id">{$_L['Owner']}</label>
                                                <select class="form-control" id="admin_id" name="admin_id">
                                                    <option value="0">{$_L['None']}</option>
                                                    {foreach $staffs as $staff}
                                                        <option value="{$staff->id}"
                                                                {if $project}
                                                                    {if !empty($project->admin_id) && ($staff->id == $project->admin_id)}
                                                                        selected

                                                                    {/if}
                                                                {else}
                                                                    {if $user->id == $staff->id}
                                                                        selected
                                                                    {/if}
                                                                {/if}
                                                        >{$staff->fullname}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>

                                    {/if}


                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="project_manager_id">{$_L['Project Manager']}</label>
                                            <select class="form-control" id="project_manager_id" name="project_manager_id">
                                                <option value="0">{$_L['None']}</option>
                                                {foreach $staffs as $staff}
                                                    <option value="{$staff->id}"
                                                    {if !empty($project->project_manager_id) && ($staff->id == $project->project_manager_id)}
                                                        selected

                                                    {/if}
                                                    >{$staff->fullname}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="contact_id">{$_L['Customer']}</label>
                                            <select class="form-control" id="contact_id" name="contact_id">
                                                <option value="0">{$_L['None']}</option>
                                                {foreach $contacts as $contact}
                                                    <option value="{$contact->id}"
                                                            {if !empty($project->contact_id) && ($contact->id == $project->contact_id)}
                                                                selected

                                                            {/if}
                                                    >{$contact->account}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                {$_L['Start Date']}
                                                </label>
                                            <input type="text" class="form-control"  value="{date('Y-m-d')}" name="start_date" id="start_date" datepicker data-date-format="yyyy-mm-dd" data-auto-close="true">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>{$_L['Due Date']}</label>
                                            <input type="text" class="form-control"  value="{date('Y-m-d',strtotime('+15 days'))}" name="due_date" id="due_date" datepicker data-date-format="yyyy-mm-dd" data-auto-close="true">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>{$_L['Type']}</label>
                                            <select class="form-control" name="billing_type" id="billing_type">
                                                <option value="Internal Project" {if $project && $project->billing_type == 'Internal Project'} selected{/if}>Internal Project</option>
                                                <option value="Hourly Rate" {if $project && $project->billing_type == 'Hourly Rate'} selected{/if}>Hourly Rate</option>
                                                <option value="Fixed Rate" {if $project && $project->billing_type == 'Fixed Rate'} selected{/if}>Fixed Rate</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select class= "form-control" name="status" id="status">
                                                <option value="Draft" {if $project && $project->status == 'Draft'} selected{/if}>Draft</option>
                                                <option value="Started" {if $project && $project->status == 'Started'} selected{/if}>Started</option>
                                                <option value="Completed" {if $project && $project->status == 'Completed'} selected{/if}>Completed</option>
                                            </select>
                                        </div>
                                    </div>


                                </div>


                                <div class="form-row mb-3">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label for="team_members">{$_L['Team Members']}</label>
                                            <select class="form-control" id="team_members" name="team_members[]" multiple="multiple">
                                                {foreach $staffs as $staff}
                                                    <option value="{$staff->id}" {if in_array($staff->id,$members)}selected{/if} >{$staff->fullname}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>

                                </div>

                                <div class="form-row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="currency">{$_L['Currency']}</label>
                                            <select id="currency" name="currency" class="form-control">

                                                {foreach $currencies as $currency}
                                                    <option value="{$currency['iso_code']}" {if $config['home_currency'] eq $currency['iso_code']}selected{/if}
                                                            {if isset($currencies_all[$currency['iso_code']])}
                                                        data-a-sign="{$currencies_all[$currency['iso_code']]['symbol']}" data-a-sep="{$currencies_all[$currency['iso_code']]['thousands_separator']}" data-a-dec="{$currencies_all[$currency['iso_code']]['decimal_mark']}" {if ($currencies_all[$currency['iso_code']]['symbol_first'] == true)} data-p-sign="p" {else} data-p-sign="s" {/if}
                                                            {/if}>{$currency['iso_code']}</option>
                                                {/foreach}


                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>{$_L['Budget']}</label>
                                            <input class="form-control" name="budget" id="budget">
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label for="content">{$_L['Details']}</label>
                                    <textarea id="content" class="form-control" name="description" rows="10">{if $project}{$project->description}{/if}</textarea>
                                </div>





                                <div class="form-group">

                                    {if $project}
                                        <input type="hidden" name="id" value="{$project->id}">
                                    {else}
                                        <input type="hidden" name="id" value="">
                                    {/if}

                                    <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                                </div>

                            </form>
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

            var form = document.getElementById("mainForm");
            var pristine = new Pristine(form);

            $('#content').redactor(
                {
                    minHeight: 200, // pixels
                    plugins: ['fontcolor']
                }
            );

            $("#contact_id").select2({
                    language: {
                        noResults: function () {
                            return $("#_lan_no_results_found").val();
                        }
                    }
                }
            );

            $("#project_manager_id").select2({
                    language: {
                        noResults: function () {
                            return $("#_lan_no_results_found").val();
                        }
                    }
                }
            );

            $('#team_members').select2();

            $('[data-toggle="datepicker"]').datepicker();

            $("#mainForm").submit(function (e) {

                e.preventDefault();

                if(pristine.validate())
                {
                    $('#clx_form_box').block({ message:block_msg });

                    $.post('{$_url}projects/project-save', $( "#mainForm" ).serialize())
                        .done(function (data) {
                            window.location = '{$_url}projects';
                        }).fail(function(data) {
                        $('#clx_form_box').unblock();
                        spNotify(data.responseText,'error');
                    });
                }

            });



        });

    </script>
{/block}
