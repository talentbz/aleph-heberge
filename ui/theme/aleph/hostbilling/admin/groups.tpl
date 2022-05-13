{extends file="$layouts_admin"}

{block name="content"}

    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h3>{$_L['Group']}</h3>
                    <form id="main_form">

                        <div class="mb-3">
                            <label>{$_L['Group']}</label>
                            <input class="form-control" name="name"
                                   value="{$selected_group->name|default:''}"
                            >
                        </div>

                        <div class="mb-3">
                            <label>{$_L['Type']}</label>
                            <select class="custom-select" name="type">
                                <option value="">--</option>
                                <option value="hosting"
                                {if $selected_group}
                                    {if $selected_group->type === 'hosting'}
                                        selected
                                    {/if}
                                {/if}
                                >{$_L['Hosting']}</option>
                                <option value="other_service"
                                        {if $selected_group}
                                            {if $selected_group->type === 'other_service'}
                                                selected
                                            {/if}
                                        {/if}
                                >{$_L['Other Services']}</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="header_content">{$_L['Header Content']}</label>
                            <textarea class="form-control" id="header_content" name="header_content">{if $selected_group && $selected_group->header_content}{$selected_group->header_content}{/if}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="body_content">{$_L['Body Content']}</label>
                            <textarea class="form-control" id="body_content" name="body_content">{if $selected_group && $selected_group->header_content}{$selected_group->body_content}{/if}</textarea>
                        </div>

                        {if $selected_group}
                            <div class="mb-3">
                                <label for="slug">{$_L['Slug']}</label>
                                <div class="input-group mr-sm-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">{$_L['items/']}</div>
                                    </div>
                                    <input class="form-control" id="slug" name="slug"
                                           value="{$selected_group->slug|default:''}"
                                    >
                                </div>

                            </div>
                        {/if}

                        <div class="mb-3">

                            {if $selected_group}
                                <input type="hidden" name="id" value="{$selected_group->id}">
                            {/if}

                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped table-bordered">

                        <thead>
                        <tr>
                            <th>{$_L['Name']}</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>


                        <tbody>
                        {foreach $groups as $group}



                            <tr>
                                <td>
                                    <h4>{$group->name}</h4>
                                </td>

                                <td>
                                    <a href="{$base_url}hostbilling/groups/{$group->id}" class="btn btn-primary">{$_L['Edit']}</a>
                                    <a href="{$base_url}hostbilling/list-items-by-group/{$group->id}" class="btn btn-primary">{$_L['List Items']}</a>
                                    <a href="#" id="delete_{$group->id}" class="btn btn-danger confirm_before_delete">{$_L['Delete']}</a>
                                </td>
                            </tr>

                        {/foreach}
                        </tbody>




                    </table>
                </div>
            </div>
        </div>
    </div>


{/block}

{block name=script}

    <script>

        $(function () {

            let $main_form = $('#main_form');

            $('#header_content').redactor(
                {
                    minHeight: 200 // pixels
                }
            );

            $('#body_content').redactor(
                {
                    minHeight: 200 // pixels
                }
            );



            $main_form.on('submit',function (event) {
                event.preventDefault();

                axios.post(base_url + 'hostbilling/group',$main_form.serialize()).then(function (response) {

                    location.reload();

                }).catch(function (error) {

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });



            });

            $(".confirm_before_delete").click(function (event) {
                event.preventDefault();
                let id = this.id;
                id = id.replace('delete_','');
                bootbox.confirm(_L['are_you_sure'], function(result) {
                    if(result){
                        window.location.href = base_url + "hostbilling/delete-group/" + id;
                    }
                });
            });


        });

    </script>


{/block}
