{extends file="$layouts_admin"}

{block name="head"}
    <style>
        .grid-item {
            width: 250px;
            padding-right: 20px;


        }

        .grid-item--width3 { width: 750px; }

        .product-imitation{
            padding: 25px;
        }
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
        .text-warning{
            color: #FB6340!important;
        }
        .text-primary{
            color: #10CDEF!important;
        }

    </style>
{/block}


{block name="content"}
    <div class="row">

        <div class="col-md-12">

            <div class="panel" id="uploading_inside">
                <div class="panel-container">
                    <div class="panel-content">
                        <form action="{$_url}settings/plugin_upload/" class="dropzone" id="upload_container">

                            <div class="dz-message">
                                <h3> <i class="fal fa-cloud-upload"></i>  {$_L['plugin_drop_help']}</h3>
                                <br />
                                <span class="note">{$_L['plugin_upload_help']}</span>
                            </div>

                        </form>
                    </div>

                </div>
            </div>


            <div class="row">
                <div class="col-md-12">
                    <div class="panel">
                        <div class="panel-hdr">
                            <h2>{$_L['Plugins']}</h2>

                        </div>
                        <div class="panel-container">
                            <div class="panel-content">
                                <div class="project-list mt-md">
                                    <div id="progressbar">
                                    </div>

                                    <div id="application_ajaxrender">
                                        <table class="table table-striped">
                                            <tbody>

                                            {foreach $plugins as $key => $value}
                                                <tr>
                                                    <td>
                                                        <img class="img-thumbnail" style="max-height: 64px;" src="{$value['icon_url']}">
                                                    </td>
                                                    <td>


                                                        <h5>{$value['name']}</h5>

                                                        {if !empty($value['description'])}

                                                            <div class="mb-3">
                                                                {$value['description']}
                                                            </div>

                                                        {/if}

                                                        {if $value['status'] === 'Active'}
                                                            <span class="badge badge-success">Active</span>
                                                        {/if}



                                                        <div>

                                                            <div class="hr-line-dashed"></div>


                                                            {if !empty($value['buttons'])}

                                                                {foreach $value['buttons'] as $button}
                                                                    <a href="{$base_url}{$button['link']}"
                                                                       {if !empty($button['class'])}
                                                                           class="{$button['class']}"
                                                                           {else}
                                                                           class="mr-1 btn btn-primary"
                                                                       {/if}


                                                                    >
                                                                        {if !empty($button['icon'])}
                                                                            <i class="{$button['icon']}"></i>
                                                                            {elseif (!empty($button['text']))}
                                                                            {$button['text']}
                                                                        {/if}

                                                                    </a>
                                                                {/foreach}


                                                            {/if}

                                                            {if $value['status'] === 'Not Installed'}
                                                                <a href="{$base_url}settings/plugin_install/{$key}/" class="btn btn-primary mr-2">Install</a>
                                                                <a href="{$base_url}settings/plugin_delete/{$key}/" class="btn btn-danger mr-2">{__('Delete')}</a>
                                                            {elseif $value['status'] === 'Active'}
                                                                <a href="{$base_url}settings/plugin_deactivate/{$key}/" class="btn btn-warning mr-2">Deactivate</a>
                                                                {elseif $value['status'] === 'Inactive'}
                                                                <a href="{$base_url}settings/plugin_activate/{$key}/" class="btn btn-success mr-2">Activate</a>
                                                                <a href="{$base_url}settings/plugin_uninstall/{$key}/" class="btn btn-danger mr-2">Uninstall</a>
                                                            {/if}



                                                            {if !empty($value['url'])}
                                                                <a href="{$value['url']}" target="_blank" class="btn btn-primary btn-icon waves-effect waves-themed">
                                                                    <i class="fal fa-external-link"></i>
                                                                </a>
                                                            {/if}

                                                        </div>

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
            </div>

        </div>




    </div>




    <input type="hidden" id="_msg_unzipping" value="{$_L['Unzipping']} ...">
    <input type="hidden" id="_msg_are_you_sure" value="{$_L['are_you_sure']}">

{/block}

{block name="script"}

    <script>
        Dropzone.autoDiscover = false;
        $(function() {
            var _url = $("#_url").val();
            var ib_file = new Dropzone("#upload_container",
                {
                    url: _url + "settings/plugin_upload/",
                    maxFiles: 1,
                    acceptedFiles: ".zip"
                }
            );

            //ib_file.on("addedfile", function(file) {
            //
            //});

            ib_file.on("success", function(file) {

                var _msg_unzipping = $('#_msg_unzipping').val();
                $('#uploading_inside').block({
                    message: "<h3>" + _msg_unzipping +"</h3>" ,
                    css: {
                        padding:        0,
                        margin:         0,
                        width:          '30%',
                        top:            '40%',
                        left:           '35%',
                        textAlign:      'center',
                        color:          '#FFFFFF',
                        border:         '0',
                        backgroundColor:'transparent',
                        cursor:         'wait'
                    }
                });
                //   $('#uploading_inside').block({ message: null });

                var _url = $("#_url").val();
                $.post(_url + 'settings/plugin_unzip/', {

                    name: file.name

                })
                    .done(function (data) {

                        setTimeout(function () {
                            location.reload();
                        }, 2000);
                    });
            });



            $(".c_uninstall").click(function (e) {
                e.preventDefault();
                var _msg_are_you_sure = $('#_msg_are_you_sure').val();
                var to_url = this.href;
                bootbox.confirm(_msg_are_you_sure, function(result) {
                    if(result == true){
                        window.location = to_url;
                    }
                });



            });



        });
    </script>

{/block}
