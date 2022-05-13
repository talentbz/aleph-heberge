{extends file="layouts/$extend.tpl"}
{block name="content"}

    {if !$embed}
        <div class="flex-1">
        <div class="container py-4 py-lg-5 my-lg-5 px-4 px-sm-0">



        <div class="mx-auto" style="max-width: 800px;">
        <div class="card">
        <div class="card-body">
    {/if}


                        <form id="main_form" method="post" style="width: 100%">

                            {foreach $form_data as $data}

                                {if $data->type === 'paragraph'}
                                    <p>{$data->label}</p>
                                {elseif $data->type === 'header'}
                                    <h2>{$data->label}</h2>
                                {elseif $data->type === 'text'}
                                    <div class="form-group">
                                        <label for="{$data->name}">{$data->label}</label>
                                        <input type="{$data->subtype}"
                                                {if $data->required}
                                                    data-pristine-required
                                                {/if}
                                               class="{$data->className}" id="{$data->name}" name="{$data->name}"  >
                                    </div>
                                {elseif $data->type === 'select'}
                                    <div class="form-group">
                                        <label for="{$data->name}">{$data->label}</label>
                                        <select class="{$data->className}" name="{$data->name}" id="{$data->name}" aria-label="">
                                            {if $data->required}
                                                data-pristine-required
                                            {/if}

                                            {foreach $data->values as $country}
                                                <option value="{$country->value}">{$country->label}</option>
                                            {/foreach}

                                        </select>

                                    </div>
                                {elseif $data->type === 'textarea'}
                                    <div class="form-group">
                                        <label for="{$data->name}">{$data->label}</label>
                                        <textarea id="{$data->name}" class="form-control" name="{$data->name}" {if $data->required}
                                                data-pristine-required
                                            {/if}></textarea>
                                    </div>
                                {/if}

                            {/foreach}

                            <div class="form-group">
                                <input type="hidden" name="form_id" value="{$lead_form->uuid}">

                                {if !empty($embed)}
                                    <input type="hidden" name="embed" value="yes">
                                {/if}

                                <button class="btn btn-primary" id="btn_submit"  type="submit">{$lead_form->submit_button_name}</button>
                            </div>



                        </form>


    {if !$embed}

        </div>
        </div>
        </div>

        </div>
        </div>
    {/if}


{/block}


{block name=script}

    <script>

        $(function () {

            var form = document.getElementById("main_form");
            var pristine = new Pristine(form);

            let $main_form = $('#main_form');
            let $btn_submit = $('#btn_submit');

            $main_form.on('submit',function (e) {
                e.preventDefault();

                if(pristine.validate())
                {
                    $btn_submit.prop('disabled',true);

                    $.post( base_url + 'client/save-form', $main_form.serialize())
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

