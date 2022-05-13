{extends file="$layouts_admin"}



{block name="content"}
    <div class="mx-auto" style="max-width: 600px; width: 100%;">
        <div class="panel">
            <div class="panel-hdr">
                <h2>{$_L['SMS Templates']}</h2>
            </div>

            <div class="panel-container">
                <div class="panel-content">
                    <form class="form-horizontal" action="{$_url}sms/init/edit_post/" method="post" id="spForm">


                        <div class="form-group"><label for="message">SMS </label>
                            <textarea class="form-control" name="message" id="message" rows="4">{$template->sms}</textarea>

                            <input type="hidden" name="template_id" id="template_id" value="{$template->id}">

                            <p class="help-block" id="sms-counter">
                                Remaining: <span class="remaining"></span> | Length: <span class="length"></span> | Messages: <span class="messages"></span>
                            </p>
                        </div>


                        <div class="form-group">
                            <button class="btn btn-primary" type="submit" id="save">{$_L['Save']}</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/block}

{block name="script"}



    <script>
        $(function () {




            $('#message').countSms('#sms-counter');

            var $save = $("#save");

            $save.on('click', function (e) {
                e.preventDefault();

                $save.prop('disabled',true);

                $.post(base_url + 'sms/init/edit_post/', $('#spForm').serialize()).done(function (data) {

                    toastr.success(data);
                    $save.prop('disabled',false);


                });

            })
        })
    </script>

{/block}
