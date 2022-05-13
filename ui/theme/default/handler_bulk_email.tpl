{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">

        <div class="col-md-12">

            <div class="panel panel-default">

                <div class="panel-body">

                    <div class="mail-box">


                        <div class="mail-body">

                            <form class="form-horizontal" method="get">
                                <div class="form-group"><label class="col-sm-2 control-label" for="toemail">{$_L['To']}:</label>

                                    <div class="col-sm-10">
                                    <textarea class="form-control" rows="5" id="emails" name="emails">{foreach $contacts as $contact}{$contact['account']} <{$contact['email']}>
{/foreach}</textarea>
                                    </div>
                                </div>
                                <div class="form-group"><label class="col-sm-2 control-label">{$_L['Subject']}:</label>

                                    <div class="col-sm-10"><input type="text" id="subject" name="subject" class="form-control" value=""></div>
                                </div>
                            </form>

                        </div>

                        <div class="mail-text">

                            <textarea id="content"  class="form-control sysedit" name="content"></textarea>

                            <div class="clearfix"></div>
                        </div>
                        <div class="mail-body">
                            <div class="row">
                                <div class="col-md-10">
                                    <a href="#" class="choose_from_template" id="choose_from_template"><i class="fal fa-file-text"></i> {$_L['Choose from Template']}</a>
                                </div>
                                <div class="col-md-2 text-right">
                                    <button type="submit" id="send_email"  class="btn btn-sm btn-primary"><i class="fal fa-paper-plane-o"></i> {$_L['Send']}</button>
                                </div>
                            </div>
                            {*<button type="submit" id="send_email"  class="btn btn-sm btn-primary"><i class="fal fa-paper-plane-o"></i> {$_L['Send']}</button>*}
                        </div>
                        <div class="clearfix"></div>



                    </div>

                </div>

            </div>

        </div>

    </div>
{/block}

{block name="script"}
    <script>
        $(function () {
            ib_editor('#content',400,false);


            var btn_form_action = $("#send_email");

            var iform = $("#iform");
            var $modal = $('#ajax-modal');

            btn_form_action.on('click', function(e) {
                e.preventDefault();

                iform.block({ message: block_msg });

                var body = $("html, body");
                body.animate({scrollTop:0}, '1000', 'swing');

                var emails = $("#emails").html();
                // var cc = $("#cc").val();
                // var bcc = $("#bcc").val();
                var subject = $("#subject").val();
                var msg = tinyMCE.activeEditor.getContent();

                $.post(  base_url + "handler/bulk_email_post/", { emails: emails, subject: subject, msg: msg })
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            iform.unblock();


                            toastr.success(_L['Email Sent']);

                            btn_form_action.prop('disabled', true);
                        }
                        else {
                            iform.unblock();
                            toastr.error(data);

                        }




                    });

            });




            $(".choose_from_template").on('click',function (e) {

                e.preventDefault();
                $('body').modalmanager('loading');

                $modal.load( base_url + 'handler/view_email_templates/', '', function(){

                    $modal.modal();


                    $('#tbl_email_templates').filterTable({
                        inputSelector: '#ib_search_input',
                        ignoreColumns: [2]
                    })


                });

            });

            $modal.on('click', '.eml_select', function(e) {
                e.preventDefault();

                $('body').modalmanager('loading');

                var eml_id = this.id;

                $.getJSON(base_url + "handler/json_eml_tpl/"+eml_id, function (data) {

                    $("#subject").val(data.subject);

                    tinyMCE.activeEditor.setContent(data.message);

                    $('body').modalmanager('loading');
                    $modal.modal('hide');

                });

            });
        });
    </script>
{/block}
