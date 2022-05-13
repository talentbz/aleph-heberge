{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel" id="ib_panel">


                <div class="panel-container">
                    <div class="panel-content">
                        <input type="hidden" name="did" id="did" value="{$doc->id}">
                        <h3 style="color: #2f96f3;">{$doc->title}</h3>
                        <hr>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" id="is_global" name="is_global" {if $doc->is_global eq '1'}checked{/if}> {$_L['Available for all Customers']}
                            </label>
                        </div>

                        <hr>
                        <a href="{$_url}client/dl/{$doc->id}_{$doc->file_dl_token}" class="btn btn-primary "><i class="fal fa-download"></i>  {$_L['Download']} </a>

                        {if has_access($user->roleid,'documents','delete')}
                            <a href="{$_url}delete/document/{$doc->id}/" class="btn btn-danger"><i class="fal fa-trash"></i>  {$_L['Delete']} </a>
                        {/if}


                        <hr>

                        {if $ext eq 'jpg' || $ext eq 'png' || $ext eq 'gif'}
                            <img src="{$app_url}storage/docs/{$doc->file_path}" class="img-responsive" alt="{$doc->title}">
                        {/if}



                    </div>











                </div>
            </div>
        </div>



    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            $(document).ready(function () {

                var _url = $("#_url").val();

                var ib_panel = $("#ib_panel");

                var did = $("#did").val();


                $('#is_global').change(function() {

                    ib_panel.block({ message: block_msg });


                    if($(this).prop('checked')){

                        $.post( _url+'documents/set_global/', { did: did, val: "1" })
                            .done(function( data ) {
                                ib_panel.unblock();
                                location.reload();
                            });

                    }
                    else{
                        $.post( _url+'documents/set_global/', { did: did, val: "0" })
                            .done(function( data ) {
                                ib_panel.unblock();
                                location.reload();
                            });
                    }
                });






            });
        });
    </script>
{/block}
