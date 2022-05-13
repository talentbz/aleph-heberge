{extends file="$layouts_client"}

{block name="content"}

    <!-- row -->
    <div class="row">
        <div class="col-md-12" id="create_ticket">

            <h3>{$d->subject}</h3>


            <ul class="timeline">
                <li class="time-label">
                  <span>
                    {date( $config['df'], strtotime($d->created_at))}
                  </span>
                </li>

                <li>

                    {if $user['img'] eq 'gravatar'}
                        <img src="http://www.gravatar.com/avatar/{($user['email'])|md5}?s=30" class="img-time-line" alt="{$user['fullname']}">
                    {elseif $user['img'] eq ''}
                        <img class="img-time-line" src="{$app_url}ui/lib/img/default-user-avatar.png" alt="">
                    {else}
                        <img src="{APP_URL}/{$user['img']}" class="img-time-line" alt="{$user['account']}">
                    {/if}

                    <div class="timeline-item">

                        <h3 class="timeline-header"><a href="javascript:void(0)">{$d->account}</a></h3>

                        <div class="timeline-body">
                            {$d->message}
                        </div>

                        {if ($d->attachments) neq ''}
                            <div class="timeline-footer">
                                {Tickets::gen_link_attachments($d->attachments)}
                            </div>
                        {/if}


                    </div>
                </li>

                {foreach $replies as $reply}
                    <li class="time-label">
                  <span>
                    {date( $config['df'], strtotime($reply['created_at']))}
                  </span>
                    </li>
                    <li>
                        <i class="fal fa-envelope bg-blue"></i>

                        <div class="timeline-item">


                            <h3 class="timeline-header"><a href="javascript:void(0)">{$reply['replied_by']}</a></h3>

                            <div class="timeline-body">
                                {$reply['message']}
                            </div>

                            {if ($reply['attachments']) neq ''}
                                <div class="timeline-footer">
                                    {Tickets::gen_link_attachments($reply['attachments'])}
                                </div>
                            {/if}


                        </div>
                    </li>
                {/foreach}

                <!-- END timeline item -->
                <!-- timeline item -->
                <li class="time-label">
                  <span>
                   {$_L['Add Reply']}
                  </span>
                </li>
                <li>
                    {if $user['img'] eq 'gravatar'}
                        <img src="http://www.gravatar.com/avatar/{($user['email'])|md5}?s=30" class="img-time-line" alt="{$user['fullname']}">
                    {elseif $user['img'] eq ''}
                        <img class="img-time-line" src="{$app_url}ui/lib/img/default-user-avatar.png" alt="">
                    {else}
                        <img src="{APP_URL}/{$user['img']}" class="img-time-line" alt="{$user['account']}">
                    {/if}

                    <div class="timeline-item">



                        <div class="timeline-body">
                            <form id="create_ticket" class="form-horizontal push-10-t push-10" method="post">






                                <div class="form-group">
                                    <div class="col-xs-12">

                                        <textarea id="content"  class="form-control" name="content"></textarea>
                                        <div class="help-block"><a data-toggle="modal" href="#modal_add_item"><i class="fal fa-paperclip"></i> {$_L['Attach File']}</a> </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-xs-12">

                                        <input type="hidden" name="attachments" id="attachments" value="">
                                        <input type="hidden" name="f_tid" id="f_tid" value="{$d->id}">

                                        <button class="btn btn-primary" id="ib_form_submit" type="submit"><i class="fal fa-send push-5-r"></i> {$_L['Submit']}</button>
                                    </div>
                                </div>
                            </form>
                        </div>

                    </div>
                </li>

                <li>
                    <i class="fal fa-life-ring bg-gray"></i>
                </li>
            </ul>
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->


    <div id="modal_add_item" class="modal fade" tabindex="-1" data-width="600" style="display: none;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title">{__('Add File')}</h4>
        </div>
        <div class="modal-body">
            <div class="row">



                <div class="col-md-12">
                    <form action="" class="dropzone" id="upload_container">

                        <div class="dz-message">
                            <h3> <i class="fal fa-cloud-upload"></i>  Drop File Here</h3>
                            <br />
                            <span class="note">{__('Or Click to Upload')}</span>
                        </div>

                    </form>


                </div>




            </div>
        </div>
        <div class="modal-footer">

            <button type="button" data-dismiss="modal" class="btn btn-danger">Close</button>

        </div>
    </div>

{/block}
{block name="script"}
    <script>
        Dropzone.autoDiscover = false;
        $(function () {

            $( ".mmnt" ).each(function() {
                var ut = $( this ).html();
                $( this ).html(moment.unix(ut).fromNow());
            });

            var _url = base_url;

            var $ib_form_submit = $("#ib_form_submit");

            var $create_ticket = $("#create_ticket");


            $('#content').redactor({
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
                $create_ticket.block({ message: block_msg });
                $.post( _url + "client/tickets/add_reply/", {  message: $('#content').val(), attachments: $("#attachments").val(), f_tid: $("#f_tid").val()} )
                    .done(function( data ) {

                        if(data.success == "Yes"){
                            location.reload();
                        }

                        else {
                            $create_ticket.unblock();
                            toastr.error(data.msg);
                        }

                    });


            });

        });
    </script>
{/block}
