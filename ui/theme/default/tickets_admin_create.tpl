{extends file="$layouts_admin"}



{block name="content"}

    <div class="row">

        <div class="col-md-12">
            <div class="panel" id="ib_box">
                <div class="panel-hdr">


                    <h2>{$_L['Open Ticket']}</h2>


                </div>

                <div class="panel-container">
                    <div class="panel-content">


                        <form id="create_ticket" class="form-horizontal push-10-t push-10" method="post">

                            <div class="form-group">
                                <div class="col-xs-12">
                                    <label for="cid">{$_L['Customer']}</label>

                                    <select id="cid" name="cid" class="form-control">
                                        <option value="">{$_L['Customer']}...</option>
                                        {foreach $customers as $cs}
                                            <option value="{$cs['id']}"
                                                    {if $p_cid eq ($cs['id'])}selected="selected" {/if}>{$cs['account']} {if $cs['email'] neq ''}- {$cs['email']}{/if}</option>
                                        {/foreach}

                                    </select>
                                </div>
                            </div>



                            <div class="form-group">
                                <div class="col-xs-12">
                                    <div class="form-group">
                                        <label for="subject">{$_L['Subject']}</label>
                                        <input class="form-control" type="text" id="subject" name="subject" autofocus>


                                    </div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="department">{$_L['Department']}</label>
                                        <select class="form-control" id="department" name="department" size="1">

                                            {foreach $deps as $dep}
                                                <option value="{$dep['id']}">{$dep['dname']}</option>
                                                {foreachelse}
                                                <option value="0">None</option>
                                            {/foreach}

                                        </select>

                                    </div>
                                </div>

                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="urgency">{$_L['Priority']}</label>
                                        <select class="form-control" id="urgency" name="urgency" size="1">
                                            <option value="High">{$_L['High']}</option>
                                            <option value="Medium" selected>{$_L['Medium']}</option>
                                            <option value="Low">{$_L['Low']}</option>
                                        </select>
                                    </div>
                                </div>
                            </div>


                            <div class="form-group mt-3">
                                <label for="content">{$_L['Message']}</label>
                                <textarea id="content"  class="form-control sysedit" name="content"></textarea>
                                <div class="help-block"><a data-toggle="modal" href="#modal_add_item"><i class="fal fa-paperclip"></i> {$_L['Attach File']}</a> </div>

                            </div>
                            <div class="form-group">
                                <input type="hidden" name="attachments" id="attachments" value="">

                                <button class="btn btn-primary" id="ib_form_submit" type="submit"><i class="fal fa-send push-5-r"></i> {$_L['Save']}</button>
                            </div>
                        </form>



                    </div>
                </div>

            </div>
        </div>

    </div>

    <div class="modal fade" id="modal_add_item" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                        {$_L['Attach File']}
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" class="dropzone" id="upload_container">

                        <div class="dz-message">
                            <h3> <i class="fal fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Click to Upload']}</span>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$_L['Close']}</button>
                </div>
            </div>
        </div>
    </div>

{*    <div id="modal_add_item" class="modal fade" tabindex="-1" data-width="600" style="display: none;">*}
{*        <div class="modal-header">*}
{*            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>*}
{*            <h4 class="modal-title">Add File</h4>*}
{*        </div>*}
{*        <div class="modal-body">*}
{*            <div class="row">*}



{*                <div class="col-md-12">*}
{*                    <form action="" class="dropzone" id="upload_container">*}

{*                        <div class="dz-message">*}
{*                            <h3> <i class="fal fa-cloud-upload"></i>  Drop File Here</h3>*}
{*                            <br />*}
{*                            <span class="note">Or Click to Upload</span>*}
{*                        </div>*}

{*                    </form>*}


{*                </div>*}




{*            </div>*}
{*        </div>*}
{*        <div class="modal-footer">*}

{*            <button type="button" data-dismiss="modal" class="btn btn-danger">Close</button>*}

{*        </div>*}
{*    </div>*}

{/block}

{block name="script"}

    <script type="text/javascript" src="{$app_url}ui/lib/redactor/redactor.min.js"></script>
    <script>

        Dropzone.autoDiscover = false;
        $(function () {
            $('#content').redactor(
                {
                    minHeight: 200 // pixels
                }
            );

            var _url = $("#_url").val();

            var $ib_form_submit = $("#ib_form_submit");

            var $create_ticket = $("#create_ticket");
            var $ib_box = $("#ib_box");




            $("#cid").select2({

                }
            );


            var upload_resp;


            var ib_file = new Dropzone("#upload_container",
                {
                    url: _url + "tickets/admin/upload_file/",
                    maxFiles: 10,
                    acceptedFiles: "image/jpeg,image/png,image/gif"
                }
            );


            ib_file.on("sending", function() {

                $ib_form_submit.prop('disabled', true);

            });

            ib_file.on("success", function(file,response) {

                $ib_form_submit.prop('disabled', false);

                upload_resp = response;

                if(upload_resp.success == 'Yes'){

                    toastr.success(upload_resp.msg);
                    // $file_link.val(upload_resp.file);
                    // files.push(upload_resp.file);
                    //
                    // console.log(files);

                    $('#attachments').val(function(i,val) {
                        return val + (!val ? '' : ',') + upload_resp.file;
                    });


                }
                else{
                    toastr.error(upload_resp.msg);
                }







            });



            $ib_form_submit.on('click', function(e) {
                e.preventDefault();
                $ib_box.block({ message: block_msg });
                $.post( _url + "tickets/admin/add_post/", { cid: $("#cid").val(), subject: $("#subject").val(), department: $("#department").val(), urgency: $("#urgency").val(), message: $('#content').val(), attachments: $("#attachments").val()} )
                    .done(function( data ) {

                        if(data.success == "Yes"){
                            window.location.href = _url + "tickets/admin/view/" + data.id + "/";
                        }

                        else {
                            $ib_box.unblock();
                            toastr.error(data.msg);
                            //  console.log(data);
                        }

                    });


            });
        });
    </script>

{/block}
