{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">


        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['Custom Fields']}</h2>

                </div>

                <div class="panel-container">
                    <div class="panel-content" id="application_ajaxrender">

                        <form id="rform">

                            {foreach $cf as $c}
                                <div style="border-radius: 4px; padding: 20px;" class="bg-subtlelight-fade">
                                    <div class="form-group">
                                        <label for="cf{$c['id']}">{$c['fieldname']}</label>
                                        {if ($c['fieldtype']) eq 'text'}

                                            <input type="text" id="cf{$c['id']}" name="cf{$c['id']}" class="form-control">
                                            {if ($c['description']) neq ''}
                                                <span class="help-block">{$c['description']}</span>
                                            {/if}

                                        {elseif ($c['fieldtype']) eq 'password'}

                                            <input type="password" id="cf{$c['id']}" name="cf{$c['id']}" class="form-control">
                                            {if ($c['description']) neq ''}
                                                <span class="help-block">{$c['description']}</span>
                                            {/if}

                                        {elseif ($c['fieldtype']) eq 'dropdown'}
                                            <select id="cf{$c['id']}" class="form-control">
                                                {foreach explode(',',$c['fieldoptions']) as $fo}
                                                    <option>{$fo}</option>
                                                {/foreach}
                                            </select>
                                            {if ($c['description']) neq ''}
                                                <span class="help-block">{$c['description']}</span>
                                            {/if}


                                        {elseif ($c['fieldtype']) eq 'textarea'}

                                            <textarea id="cf{$c['id']}" name="cf{$c['id']}" class="form-control" rows="3"></textarea>
                                            {if ($c['description']) neq ''}
                                                <span class="help-block">{$c['description']}</span>
                                            {/if}

                                        {else}

                                        {/if}
                                        <div class="btn-group my-3">
                                            <a href="#" class="btn btn-primary sys_edit" id="f{$c['id']}"><i class="fal fa-pencil"></i> {$_L['Edit']}</a>

                                            <a href="#" class="btn btn-danger cdelete" id="d{$c['id']}"><i class="fal fa-trash-alt"></i> {$_L['Delete']}</a>
                                        </div>
                                    </div>
                                </div>
                                {foreachelse}

                                <h4 class="muted text-center mb-3">{$_L['Custom Fields Not Available']}</h4>

                            {/foreach}
                            <p class=" text-center"><a href="" class="btn btn-outline btn-success sys_add"><i class="fal fa-plus"></i> {$_L['Add Custom Field']}</a></p>


                        </form>

                    </div>
                </div>

            </div>



        </div>


    </div>
    <input type="hidden" id="_lan_are_you_sure" value="{$_L['are_you_sure']}">

{/block}

{block name="script"}
    <script>
        $(document).ready(function () {

            var _url = $("#_url").val();
            var sysrender = $('#cloudonex_body');
            sysrender.on('click', '.cdelete', function(e){
                e.preventDefault();
                var id = this.id;
                var lan_msg = $("#_lan_are_you_sure").val();
                bootbox.confirm(lan_msg, function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/customfield/" + id + '/';
                    }
                });
            });



            sysrender.on('click', '.sys_add', function(e){
                e.preventDefault();

                $.fancybox.open({
                    src  : _url + 'settings/customfields-ajax-add/',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {

                        }
                    }
                });

            });


            sysrender.on('click', '#add_submit', function(){

                $.post(base_url + 'settings/customfields-post/', $('#add_form').serialize(), function(data){

                    var _url = $("#_url").val();
                    if ($.isNumeric(data)) {

                        location.reload();
                    }
                    else {

                        sysrender.find('.modal-body')
                            .prepend('<div class="alert alert-danger fade in">' + data +

                                '</div>');

                    }
                });

            });


            sysrender.on('click', '.sys_edit', function(e){
                e.preventDefault();

                var vid = this.id;
                var id = vid.replace("f", "");
                id = vid.replace("d", "");

                $.fancybox.open({
                    src  : base_url + 'settings/customfields-ajax-edit/' + id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {

                        }
                    }
                });



            });


            sysrender.on('click', '#edit_submit', function(){


                var _url = $("#_url").val();
                $.post(_url + 'settings/customfield-edit-post/', $('#edit_form').serialize(), function(data){

                    var _url = $("#_url").val();
                    if ($.isNumeric(data)) {

                        location.reload();
                    }
                    else {

                        sysrender
                            .find('.modal-body')
                            .prepend('<div class="alert alert-danger fade in">' + data +

                                '</div>');

                    }

                });

            });





        });
    </script>
{/block}
