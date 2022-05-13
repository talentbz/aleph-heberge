{extends file="$layouts_admin"}

{block name="content"}

    <div style="max-width: 600px; width: 100%;" class="mx-auto">
        <div class="panel">
            <div class="panel-hdr">
                <h2>{$_L['New Form']}</h2>
            </div>
            <div class="panel-container">
                <div class="panel-content">

                    <form id="main_form" method="post">

                        <div class="form-group">
                            <label for="inputName">{$_L['Name']}</label>
                            <input class="form-control" name="name"
                                   {if $selected_form}
                                       value="{{$selected_form->name}}"
                                   {/if}
                                   data-pristine-required id="inputName">
                        </div>

                        <div class="form-group">
                            <label for="source_id">{$_L['Assign to']}</label>
                            <select class="custom-select" name="admin_id" id="admin_id" data-pristine-required>
                                {foreach User::select(['id','fullname','username'])->get() as $assign_to_user}
                                    <option value="{$assign_to_user->id}" {if $selected_form}  {else} {if $user->id == $assign_to_user->id} selected {/if} {/if} >{$assign_to_user->fullname}</option>
                                {/foreach}
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="source_id">{$_L['Source']}</label>
                            <select class="custom-select" name="source_id" id="source_id" data-pristine-required>
                                <option>--</option>
                                {foreach $lead_sources as $lead_source}
                                    <option value="{$lead_source->id}"
                                            {if $selected_form}
                                                {if $selected_form->lead_source_id === $lead_source->id}
                                                    selected {/if}
                                            {/if}
                                    >{$lead_source->sname}</option>
                                {/foreach}
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="submit_button_name">{$_L['Submit button text']}</label>
                            <input class="form-control" name="submit_button_name" {if $selected_form}
                                value="{{$selected_form->submit_button_name}}"
                            {/if} id="submit_button_name" data-pristine-required>
                        </div>

                        <div class="form-group">
                            <label for="success_message">{$_L['Success message']}</label>
                            <textarea class="form-control"

                                      name="success_message" data-pristine-required id="success_message">{if $selected_form}{{$selected_form->success_message}}{/if}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="webhook_url">{$_L['Webhook URL']} <small>({$_L['optional']})</small></label>
                            <input class="form-control" id="webhook_url" name="webhook_url"
                                    {if $selected_form}
                                        value="{{$selected_form->webhook_url}}"
                                    {/if}>
                        </div>

                        {if $selected_form}

                            <input type="hidden" name="form_id" value="{{$selected_form->id}}">

                        {/if}

                        <div class="form-group">
                            <button id="btn_submit" class="btn btn-primary">{$_L['Next']}</button>
                        </div>



                    </form>




                </div>
            </div>
        </div>
    </div>

{/block}

{block name=script}

    <script>

        $(function () {

            $('#success_message').redactor(
                {
                    minHeight: 200 // pixels
                }
            );

            let $main_form = $('#main_form');
            let $btn_submit = $('#btn_submit');

            var form = document.getElementById("main_form");
            var pristine = new Pristine(form);

            $main_form.on('submit',function (e) {
                e.preventDefault();

                if(pristine.validate())
                {
                    $btn_submit.prop('disabled',true);

                    $.post( base_url + 'leads/save-form', $main_form.serialize())
                        .done(function( data ) {

                            window.location = base_url + data.url;

                        }).fail(function (error) {
                        $btn_submit.prop('disabled',false);
                        toastr.error(error.responseText);
                    });
                }


            });

        });

    </script>


{/block}
