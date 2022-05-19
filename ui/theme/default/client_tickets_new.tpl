{extends file="hostbilling/layouts/new_base/base.tpl"}
{block name="new_content"}

<main id="clx-page-content" role="main" class="page-content">

    <div class="panel mx-auto" style="width: 100%; max-width: 800px;">

        <div class="panel-container">
            <div class="panel-content">
                <section id="ib_box">
                    <div>
                        {if isset($notify)}
                            {$notify}
                        {/if}




                        <form method="post" action="{$_url}client/tickets/create_post/" id="iform" name="iform">



                            <div class="form-group">
                                <label for="account">{$_L['Full_Name']}</label>
                                <input type="text" class="form-control" id="account" name="account" value="{$user->account}" disabled>
                            </div>

                            <div class="form-group">
                                <label for="email">{$_L['Email']}</label>
                                <input type="email" class="form-control" id="email" name="email" value="{$user->email}" disabled>
                            </div>



                            <div class="form-group">
                                <label for="subject">{$_L['Subject']}</label>
                                <input type="text" class="form-control" id="subject" name="subject">
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="department">{$_L['Department']}</label>
                                        <select class="custom-select" id="department" name="department" size="1">

                                            {foreach $deps as $dep}
                                                <option value="{$dep['id']}">{$dep['dname']}</option>
                                                {foreachelse}
                                                <option value="0">{$_L['None']}</option>
                                            {/foreach}

                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">

                                        <label for="urgency">{$_L['Priority']}</label>
                                        <select class="custom-select" id="urgency" name="urgency" size="1">
                                            <option value="High">{$_L['High']}</option>
                                            <option value="Medium" selected>{$_L['Medium']}</option>
                                            <option value="Low">{$_L['Low']}</option>

                                        </select>

                                    </div>
                                </div>
                            </div>

                            <div class="form-group mt-3">
                                <label for="message">{$_L['Description']}</label>
                                <textarea id="message" class="form-control sysedit" name="message"></textarea>
                                <div class="help-block"><a data-toggle="modal" href="#modal_add_item"><i class="fal fa-paperclip"></i> {$_L['Attach File']}</a> </div>
                            </div>



                            <input type="hidden" name="attachments" id="attachments" value="">
                            <button type="submit" id="ib_form_submit" class="btn btn-primary">{$_L['Submit']}</button>
                        </form>


                    </div>
                </section>
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
{*            <h4 class="modal-title">{$_L['Attach File']}</h4>*}
{*        </div>*}
{*        <div class="modal-body">*}
{*            <div class="row">*}



{*                <div class="col-md-12">*}
{*                    <form action="" class="dropzone" id="upload_container">*}

{*                        <div class="dz-message">*}
{*                            <h3> <i class="fal fa-upload"></i>  {$_L['Drop File Here']}</h3>*}
{*                            <br />*}
{*                            <span class="note">{$_L['Click to Upload']}</span>*}
{*                        </div>*}

{*                    </form>*}


{*                </div>*}




{*            </div>*}
{*        </div>*}
{*        <div class="modal-footer">*}

{*            <button type="button" data-dismiss="modal" class="btn btn-danger">Close</button>*}

{*        </div>*}
{*    </div>*}

</main>
{/block}

{block name="script"}
    <script>
        Dropzone.autoDiscover = false;
        $(function() {

            var _url = $("#_url").val();

            var $ib_form_submit = $("#ib_form_submit");

            var $create_ticket = $("#create_ticket");
            var $ib_box = $("#ib_box");


            $('.sysedit').redactor({
                buttonsHide: ['html'],
            });


            var upload_resp;


            var ib_file = new Dropzone("#upload_container",
                {
                    url: _url + "client/tickets/upload_file/",
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
                $.post( _url + "client/tickets/add_post/", { subject: $("#subject").val(), department: $("#department").val(), urgency: $("#urgency").val(), message: $('#message').val(), attachments: $("#attachments").val()} )
                    .done(function( data ) {

                        if(data.success == "Yes"){
                            window.location.href = _url + "client/tickets/view/" + data.tid + "/";
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
