<div style="overflow: auto;">

    <div style="min-width: 1545px; max-width: 1545px;">


        <div class="panel kanban-col">
            <div class="panel-hdr bg-danger-600">

                <h2>{$_L['Not Started']}</h2>

            </div>

            <div class="panel-body">
                <div id="not_started" class="kanban-centered kanban-droppable-area">
                    {foreach $tasks_not_started as $tns}
                        <article class="kanban-entry cursor-move" id="item_{$tns['id']}" draggable="true">
                            <div class="kanban-entry-inner">
                                <div class="kanban-label">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <a href="javascript:void(0)" id="v_{$tns['id']}" class="v_item">{$tns['title']}</a>
                                            <hr>
                                        </div>
                                        <div class="col-md-12">

                                            {if $tns['cid'] != 0 && $tns['cid'] != '' && isset($contacts[$tns['cid']][0]->account)}
                                                <div style="margin-bottom: 15px;">
                                                    {$contacts[$tns['cid']][0]->account}
                                                </div>

                                            {/if}

                                            {if $tns['tid'] != 0 && $tns['tid'] != '' && isset($tickets[$tns['tid']][0]->tid)}
                                                <div style="margin-bottom: 15px;">
                                                    Ticket: {$tickets[$tns['tid']][0]->tid}
                                                </div>

                                            {/if}



                                            <img src="{getAdminImage($tns['aid'])}" class="img-circle" style="max-width: 30px; margin-bottom: 5px;" alt="{$tns['created_by']}"> {$tns['created_by']}


                                        </div>


                                        <div class="col-md-12">

                                            <small>{$_L['Created']}: <span class="mmnt">{strtotime({$tns['created_at']})}</span></small> <br>
                                            <small>{$_L['Due Date']}: {date( $config['df'], strtotime($tns['due_date']))}</small>

                                            {if isset($tns['priority'])}
                                                <br>
                                                {if strtolower($tns['priority']) == 'critical' || strtolower($tns['priority']) == 'high'}
                                                    <span class="label label-danger">
                                                        {if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                            {else}
                                                            {$tns['priority']}
                                                        {/if}
                                                    </span>
                                                {else}
                                                    <span class="label label-info">{if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                            {else}
                                                            {$tns['priority']}
                                                        {/if}</span>
                                                {/if}

                                            {/if}
                                            {*<br>*}
                                            {*<a href="javascript:void(0)" class="c_delete" id="d_{$tns['id']}"><i class="fal fa-trash"></i> </a>*}
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </article>

                    {/foreach}
                </div>
            </div>


        </div>

        <div class="panel kanban-col">
            <div class="panel-hdr bg-primary-600">

                <h2>{$_L['In Progress']}</h2>

            </div>
            <div class="panel-body">
                <div id="in_progress" class="kanban-centered kanban-droppable-area">


                    {foreach $tasks_in_progress as $tns}
                        <article class="kanban-entry cursor-move" id="item_{$tns['id']}" draggable="true">
                            <div class="kanban-entry-inner">
                                <div class="kanban-label">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <a href="javascript:void(0)" id="v_{$tns['id']}" class="v_item">{$tns['title']}</a>
                                            <hr>
                                        </div>
                                        <div class="col-md-12">
                                            {if $tns['cid'] != 0 && $tns['cid'] != '' && isset($contacts[$tns['cid']][0]->account)}
                                                <div style="margin-bottom: 15px;">
                                                    {$contacts[$tns['cid']][0]->account}
                                                </div>

                                            {/if}

                                            {if $tns['tid'] != 0 && $tns['tid'] != '' && isset($tickets[$tns['tid']][0]->tid)}
                                                <div style="margin-bottom: 15px;">
                                                    {$_L['Ticket']}: {$tickets[$tns['tid']][0]->tid}
                                                </div>

                                            {/if}
                                            <img src="{getAdminImage($tns['aid'])}" class="img-circle" style="max-width: 30px; margin-bottom: 5px;" alt="{$tns['created_by']}"> {$tns['created_by']}


                                        </div>


                                        <div class="col-md-12">

                                            <small>{$_L['Created']}: <span class="mmnt">{strtotime({$tns['created_at']})}</span></small> <br>
                                            <small>{$_L['Due Date']}: {date( $config['df'], strtotime($tns['due_date']))}</small>

                                            {if isset($tns['priority'])}
                                                <br>
                                                {if strtolower($tns['priority']) == 'critical' || strtolower($tns['priority']) == 'high'}
                                                    <span class="label label-danger">
                                                        {if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                        {else}
                                                            {$tns['priority']}
                                                        {/if}
                                                    </span>
                                                {else}
                                                    <span class="label label-info">{if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                            {else}
                                                            {$tns['priority']}
                                                        {/if}</span>
                                                {/if}

                                            {/if}

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </article>

                    {/foreach}


                </div>
            </div>

        </div>

        <div class="panel kanban-col">
            <div class="panel-hdr bg-success-600">

                <h2>{$_L['Completed']}</h2>

            </div>
            <div class="panel-body">
                <div id="completed" class="kanban-centered kanban-droppable-area">


                    {foreach $tasks_completed as $tns}
                        <article class="kanban-entry cursor-move" id="item_{$tns['id']}" draggable="true">
                            <div class="kanban-entry-inner">
                                <div class="kanban-label">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <a href="javascript:void(0)" id="v_{$tns['id']}" class="v_item">{$tns['title']}</a>
                                            <hr>
                                        </div>
                                        <div class="col-md-12">
                                            {if $tns['cid'] != 0 && $tns['cid'] != '' && isset($contacts[$tns['cid']][0]->account)}
                                                <div style="margin-bottom: 15px;">
                                                    {$contacts[$tns['cid']][0]->account}
                                                </div>

                                            {/if}

                                            {if $tns['tid'] != 0 && $tns['tid'] != '' && isset($tickets[$tns['tid']][0]->tid)}
                                                <div style="margin-bottom: 15px;">
                                                    {$_L['Ticket']}: {$tickets[$tns['tid']][0]->tid}
                                                </div>

                                            {/if}
                                            <img src="{getAdminImage($tns['aid'])}" class="img-circle" style="max-width: 30px; margin-bottom: 5px;" alt="{$tns['created_by']}"> {$tns['created_by']}


                                        </div>


                                        <div class="col-md-12">

                                            <small>{$_L['Created']}: <span class="mmnt">{strtotime({$tns['created_at']})}</span></small> <br>
                                            <small>{$_L['Due Date']}: {date( $config['df'], strtotime($tns['due_date']))}</small>

                                            {if isset($tns['priority'])}
                                                <br>
                                                {if isset($tns['priority'])}
                                                    <br>
                                                    {if strtolower($tns['priority']) == 'critical' || strtolower($tns['priority']) == 'high'}
                                                        <span class="label label-danger">
                                                        {if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                        {else}
                                                            {$tns['priority']}
                                                        {/if}
                                                    </span>
                                                    {else}
                                                        <span class="label label-info">{if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                            {else}
                                                            {$tns['priority']}
                                                        {/if}</span>
                                                    {/if}

                                                {/if}

                                            {/if}
                                            {*<br>*}
                                            {*<a href="javascript:void(0)" class="c_delete" id="d_{$tns['id']}"><i class="fal fa-trash"></i> </a>*}
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </article>

                    {/foreach}


                </div>
            </div>

        </div>

        <div class="panel kanban-col">
            <div class="panel-hdr bg-dark">

                <h2 class="text-white">{$_L['Deferred']}</h2>

            </div>
            <div class="panel-body">
                <div id="deferred" class="kanban-centered kanban-droppable-area">


                    {foreach $tasks_deferred as $tns}
                        <article class="kanban-entry cursor-move" id="item_{$tns['id']}" draggable="true">
                            <div class="kanban-entry-inner">
                                <div class="kanban-label">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <a href="javascript:void(0)" id="v_{$tns['id']}" class="v_item">{$tns['title']}</a>
                                            <hr>
                                        </div>
                                        <div class="col-md-12">
                                            {if $tns['cid'] != 0 && $tns['cid'] != '' && isset($contacts[$tns['cid']][0]->account)}
                                                <div style="margin-bottom: 15px;">
                                                    {$contacts[$tns['cid']][0]->account}
                                                </div>

                                            {/if}

                                            {if $tns['tid'] != 0 && $tns['tid'] != '' && isset($tickets[$tns['tid']][0]->tid)}
                                                <div style="margin-bottom: 15px;">
                                                    {$_L['Ticket']}: {$tickets[$tns['tid']][0]->tid}
                                                </div>

                                            {/if}
                                            <img src="{getAdminImage($tns['aid'])}" class="img-circle" style="max-width: 30px; margin-bottom: 5px;" alt="{$tns['created_by']}"> {$tns['created_by']}


                                        </div>


                                        <div class="col-md-12">

                                            <small>{$_L['Created']}: <span class="mmnt">{strtotime({$tns['created_at']})}</span></small> <br>
                                            <small>{$_L['Due Date']}: {date( $config['df'], strtotime($tns['due_date']))}</small>

                                            {if isset($tns['priority'])}
                                                <br>
                                                {if strtolower($tns['priority']) == 'critical' || strtolower($tns['priority']) == 'high'}
                                                    <span class="label label-danger">
                                                        {if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                        {else}
                                                            {$tns['priority']}
                                                        {/if}
                                                    </span>
                                                {else}
                                                    <span class="label label-info">{if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                            {else}
                                                            {$tns['priority']}
                                                        {/if}</span>
                                                {/if}

                                            {/if}
                                            {*<br>*}
                                            {*<a href="javascript:void(0)" class="c_delete" id="d_{$tns['id']}"><i class="fal fa-trash"></i> </a>*}
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </article>

                    {/foreach}


                </div>
            </div>

        </div>

        <div class="panel kanban-col" style="border-right: 1px solid #ffffff;">
            <div class="panel-hdr bg-gray-900">

                <h2 class="text-white">{$_L['Waiting on someone else']}</h2>

            </div>
            <div class="panel-body">
                <div id="waiting_on_someone" class="kanban-centered kanban-droppable-area">


                    {foreach $tasks_waiting as $tns}
                        <article class="kanban-entry cursor-move" id="item_{$tns['id']}" draggable="true">
                            <div class="kanban-entry-inner">
                                <div class="kanban-label">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <a href="javascript:void(0)" id="v_{$tns['id']}" class="v_item">{$tns['title']}</a>
                                            <hr>
                                        </div>
                                        <div class="col-md-12">
                                            {if $tns['cid'] != 0 && $tns['cid'] != '' && isset($contacts[$tns['cid']][0]->account)}
                                                <div style="margin-bottom: 15px;">
                                                    {$contacts[$tns['cid']][0]->account}
                                                </div>

                                            {/if}

                                            {if $tns['tid'] != 0 && $tns['tid'] != '' && isset($tickets[$tns['tid']][0]->tid)}
                                                <div style="margin-bottom: 15px;">
                                                    {$_L['Ticket']}: {$tickets[$tns['tid']][0]->tid}
                                                </div>

                                            {/if}
                                            <img src="{getAdminImage($tns['aid'])}" class="img-circle" style="max-width: 30px; margin-bottom: 5px;" alt="{$tns['created_by']}"> {$tns['created_by']}


                                        </div>


                                        <div class="col-md-12">

                                            <small>{$_L['Created']}: <span class="mmnt">{strtotime({$tns['created_at']})}</span></small> <br>
                                            <small>{$_L['Due Date']}: {date( $config['df'], strtotime($tns['due_date']))}</small>

                                            {if isset($tns['priority'])}
                                                <br>
                                                {if strtolower($tns['priority']) == 'critical' || strtolower($tns['priority']) == 'high'}
                                                    <span class="label label-danger">
                                                        {if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                        {else}
                                                            {$tns['priority']}
                                                        {/if}
                                                    </span>
                                                {else}
                                                    <span class="label label-info">{if isset($_L[$tns['priority']])}
                                                            {$_L[$tns['priority']]}
                                                            {else}
                                                            {$tns['priority']}
                                                        {/if}</span>
                                                {/if}

                                            {/if}
                                            {*<br>*}
                                            {*<a href="javascript:void(0)" class="c_delete" id="d_{$tns['id']}"><i class="fal fa-trash"></i> </a>*}
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </article>

                    {/foreach}


                </div>
            </div>

        </div>

    </div>
</div>

