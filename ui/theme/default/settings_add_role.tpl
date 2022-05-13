{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h5>{$_L['New Role']}</h5>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <form action="{$_url}settings/add_role_post/" method="post" accept-charset="utf-8">
                            <div class="form-group"><label for="rname" class="control-label"> <small class="req text-danger">* </small>Role Name</label><input type="text" id="rname" name="rname" class="form-control" autofocus></div>

                            <p>{$_L['role_all_data_help_text']}</p>

                            <div class="hr-line-dashed"></div>


                            <div class="table-responsive">
                                <div class="table-responsive">
                                    <table class="table table-bordered roles no-margin">
                                        <thead>
                                        <tr>
                                            <th class="bold">{$_L['Permission']}</th>
                                            <th class="text-center bold">{$_L['View']}</th>
                                            <th class="text-center bold">{$_L['Edit']}</th>
                                            <th class="text-center bold">{$_L['Create']}</th>
                                            <th class="text-center text-danger bold">{$_L['Delete']}</th>
                                            <th class="bold">{$_L['All Data']}</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        {foreach $permissions as $permission}

                                            <tr data-id="{$permission['id']}">
                                                <td class="bold">{ib_lan_get_line($permission['pname'])}</td>
                                                <td class="text-center">

                                                    <div class="custom-control custom-switch">
                                                        <input name="{$permission['shortname']}_view" type="checkbox" class="custom-control-input" id="checkbox_{$permission['shortname']}_view">
                                                        <label class="custom-control-label" for="checkbox_{$permission['shortname']}_view">{$_L['View']}</label>
                                                    </div>


                                                </td>
                                                <td class="text-center">
                                                    <div class="custom-control custom-switch">
                                                        <input name="{$permission['shortname']}_edit" type="checkbox" class="custom-control-input" id="checkbox_{$permission['shortname']}_edit">
                                                        <label class="custom-control-label" for="checkbox_{$permission['shortname']}_edit">{$_L['Edit']}</label>
                                                    </div>
                                                </td>
                                                <td class="text-center">

                                                    <div class="custom-control custom-switch">
                                                        <input name="{$permission['shortname']}_create" type="checkbox" class="custom-control-input" id="checkbox_{$permission['shortname']}_create">
                                                        <label class="custom-control-label" for="checkbox_{$permission['shortname']}_create">{$_L['Create']}</label>
                                                    </div>

                                                </td>
                                                <td class="text-center">
                                                    <div class="custom-control custom-switch">
                                                        <input name="{$permission['shortname']}_delete" type="checkbox" class="custom-control-input" id="checkbox_{$permission['shortname']}_delete">
                                                        <label class="custom-control-label" for="checkbox_{$permission['shortname']}_delete">{$_L['Delete']}</label>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="custom-control custom-switch">
                                                        <input name="{$permission['shortname']}_all_data" type="checkbox" class="custom-control-input" id="checkbox_{$permission['shortname']}_all_data">
                                                        <label class="custom-control-label" for="checkbox_{$permission['shortname']}_all_data">{$_L['All Data']}</label>
                                                    </div>
                                                </td>
                                            </tr>

                                        {/foreach}

                                        </tbody>
                                    </table>

                                    <button class="btn btn-primary" type="submit" id="submit"><i class="fal fa-check"></i> {$_L['Save']}</button>                        </div>

                            </div>

                        </form>
                    </div>






                </div>
            </div>
        </div>



    </div>
{/block}
