{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Roles']}</h2>

                    <div class="panel-toolbar">
                        <a href="{$_url}settings/add_role/" class="btn btn-success" id="add_new_group"><i class="fal fa-plus"></i> {$_L['New Role']}</a>
                    </div>

                </div>

                <div class="panel-container">
                    <div class="panel-content">

                        <div class="table-responsive">
                            <table class="table table-bordered roles no-margin">
                                <thead>
                                <tr>
                                    <th class="bold">{$_L['Name']}</th>
                                    <th class="text-center bold">{$_L['Manage']}</th>
                                </tr>
                                </thead>
                                <tbody>


                                {foreach $roles as $role}
                                    <tr data-id="1">
                                        <td>{$role['rname']}</td>
                                        <td class="text-right">

                                            <a href="{$_url}settings/edit_role/{$role['id']}/" class="btn btn-primary"><i class="fal fa-pencil"></i> {$_L['Edit']}</a>
                                            <a href="{$_url}delete/role/{$role['id']}/" class="btn btn-danger" id="uid118"><i class="fal fa-trash-alt"></i> {$_L['Delete']}</a>
                                        </td>



                                    </tr>
                                {/foreach}






                                </tbody>
                            </table>
                        </div>
                    </div>







                </div>
            </div>
        </div>



    </div>
{/block}
