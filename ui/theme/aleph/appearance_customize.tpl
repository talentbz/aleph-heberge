{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">

        <div class="col-md-6">

            <div class="panel">

                <div class="panel-hdr">
                    <h2>{$_L['Text Logo']}</h2>
                </div>

                <div class="panel-container">
                    <div class="panel-content">
                        <form role="form" name="logo" method="post"
                              action="{$_url}settings/logo-text/">
                            <div class="form-group">
                                <input class="form-control" name="logo_text" value="{if empty($config['logo_text'])}CloudOnex{else}{$config['logo_text']}{/if}">

                            </div>

                            <div class="form-group">
                                <label>Show</label>
                                <select class="custom-select" name="header_show_logo_as">
                                    <option value="">Square Logo + Text</option>
                                    <option value="default_logo"
                                    {if !empty($config['header_show_logo_as'])  && $config['header_show_logo_as'] == 'default_logo'}
                                        selected
                                    {/if}
                                    >Default Logo</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </form>
                    </div>
                </div>





            </div>


            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Logo']}</h2>


                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <img class="logo" src="{$app_url}storage/system/{$config['logo_default']}" style="max-height: 40px;" alt="Logo">
                        <br><br>
                        <form role="form" name="logo" enctype="multipart/form-data" method="post"
                              action="{$_url}settings/logo-post/">
                            <div class="form-group">
                                <label for="file">{$_L['File']}</label>
                                <input type="file" id="file" name="file">

                                <p class="help-block">{$_L['This will replace existing logo']}</p>
                            </div>
                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </form>
                    </div>






                </div>
            </div>


            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Logo for dark background']} [ {$_L['Optional']} ]</h2>


                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <img class="logo" src="{$app_url}storage/system/{$config['logo_inverse']}" alt="Logo"  style="max-height: 40px; background: #2196F3">
                        <br><br>

                        <form role="form" name="logo" enctype="multipart/form-data" method="post"
                              action="{$_url}settings/logo-inverse-post/">
                            <div class="form-group">
                                <label for="file">{$_L['File']}</label>
                                <input type="file" id="file" name="file">

                                <p class="help-block">{$_L['Upload Transparent png image']}.</p>
                            </div>
                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </form>
                    </div>




                </div>
            </div>


            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Icon']}</h2>


                </div>
                <div class="panel-container">
                    <div class="panel-content">

                       <div class="text-center">
                           {if isset($config['logo_square'])}
                               <img class="img-fluid" src="{$app_url}storage/system/{$config['logo_square']}">
                           {else}
                               <img class="img-fluid" src="{$app_url}storage/system/logo-512x512.png">
                           {/if}
                       </div>

                        <br><br>

                        <form role="form" name="logo" enctype="multipart/form-data" method="post"
                              action="{$_url}settings/logo-square-post">
                            <div class="form-group">
                                <label for="file">{$_L['File']}</label>
                                <input type="file" id="file" name="file">
                            </div>
                            <p>512x512(png)</p>
                            <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                        </form>
                    </div>




                </div>
            </div>





            {if empty($config['disable_client_portal'])}

                <div class="panel">
                    <div class="panel-hdr">
                        <h5>{$_L['Client Portal Custom Scripts']}</h5>


                    </div>



                    <div class="panel-container">
                        <div class="panel-content">
                            <form role="form" name="logo" method="post"
                                  action="{$_url}settings/custom_scripts/">
                                <div class="form-group">
                                    <label for="header_scripts">{$_L['Header Scripts']}</label>

                                    <textarea class="form-control" id="header_scripts" name="header_scripts"
                                              rows="4">{$config['header_scripts']}</textarea>

                                </div>
                                <div class="form-group">
                                    <label for="footer_scripts">{$_L['Footer Scripts']}</label>

                                    <textarea class="form-control" id="footer_scripts" name="footer_scripts"
                                              rows="4">{$config['footer_scripts']}</textarea>

                                </div>
                                <button type="submit" class="btn btn-primary">{$_L['Save']}</button>
                            </form>
                        </div>





                    </div>




                </div>

            {/if}




        </div>

        {if !empty($config['invoicing']) }

            <div class="col-md-6">

                <div class="panel">
                    <div class="panel-hdr">
                        <h2>{$_L['Settings']}</h2>


                    </div>
                    <div class="panel-container">
                        <div class="panel-content">
                            <table class="table table-hover">
                                <tbody>



                                <tr>
                                    <td width="80%"><label for="config_invoice_show_watermark">{$_L['Show Watermark']} </label></td>
                                    <td> <input type="checkbox" {if get_option('invoice_show_watermark') eq '1'}checked{/if} data-toggle="toggle" data-size="small" data-on="{$_L['Yes']}" data-off="{$_L['No']}" id="config_invoice_show_watermark"></td>
                                </tr>


                                <tr>
                                    <td width="80%"><label for="config_invoice_client_can_attach_signature">{$_L['Enable Signature']} </label></td>
                                    <td> <input type="checkbox" {if get_option('invoice_client_can_attach_signature') eq '1'}checked{/if} data-toggle="toggle" data-size="small" data-on="{$_L['Yes']}" data-off="{$_L['No']}" id="config_invoice_client_can_attach_signature"></td>
                                </tr>


                                </tbody>
                            </table>
                        </div>





                    </div>
                </div>


            </div>


        {/if}


    </div>


{/block}

{block name="script"}


    <script>

        $(function () {

            $('#config_invoice_show_watermark').change(function() {

                if($(this).prop('checked')){

                    $.post( base_url+'settings/update_option/', { opt: "invoice_show_watermark", val: "1" })
                        .done(function( data ) {

                            toastr.success('Saved.');
                           // location.reload();
                        });

                }
                else{
                    $.post( base_url+'settings/update_option/', { opt: "invoice_show_watermark", val: "0" })
                        .done(function( data ) {

                            toastr.success('Saved.');
                        });
                }
            });


            $('#config_invoice_client_can_attach_signature').change(function() {

                if($(this).prop('checked')){

                    $.post( base_url+'settings/update_option/', { opt: "invoice_client_can_attach_signature", val: "1" })
                        .done(function( data ) {

                            toastr.success('Saved.');
                            // location.reload();
                        });

                }
                else{
                    $.post( base_url+'settings/update_option/', { opt: "invoice_client_can_attach_signature", val: "0" })
                        .done(function( data ) {

                            toastr.success('Saved.');
                        });
                }
            });

        })

    </script>

{/block}
