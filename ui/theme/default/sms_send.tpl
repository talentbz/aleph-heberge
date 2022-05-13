{extends file="$layouts_admin"}

{block name="content"}

    <div class="mx-auto" style="width: 100%; max-width: 600px;">
        <div class="panel panel-default">

            <div class="panel-hdr">
                <h2>{$_L['Send SMS']}</h2>
            </div>

            <div class="panel-container">
                <div class="panel-content">

                    <div id="result"></div>

                    <form action="{$_url}sms/init/send_post/" method="post" id="iform">

                        <div class="form-group">
                            <label for="from">{$_L['From']} </label>
                            <input type="text" name="from" id="from" class="form-control " value="{$config['sms_sender_name']}">
                        </div>

                        <div class="form-group"><label for="sms_to">{$_L['To']} </label>
                            <input type="text" name="sms_to" id="sms_to" class="form-control ">

                            <span class="help-block"><a data-toggle="modal" href="#modal_find_contact">| Or Choose from Contact</a> </span>
                        </div>


                        <div class="form-group"><label for="sms_type">{$_L['Type']} </label>
                            <select class="form-control" name="sms_type" id="sms_type">
                                <option value="text">Plain Text</option>
                                <option value="flash">Flash Message</option>
                                <option value="unicode" selected>Unicode</option>
                                <option value="wap">Wap Push</option>
                                <option value="vcal">vcal / vcard</option>
                                <option value="binary">Binary</option>
                            </select>
                        </div>


                        {if $config['sms_api_handler'] eq 'Msg91'}

                            <div class="form-group"><label for="sms_route">Route</label>
                                <select class="form-control" name="sms_route" id="sms_route">
                                    <option value="4">Transactional</option>
                                    <option value="1">Promotional</option>
                                </select>
                            </div>

                        {/if}


                        <div class="form-group"><label for="message">{$_L['SMS']} </label>
                            <textarea class="form-control" name="message" id="message" rows="4"></textarea>

                            <p class="help-block" id="sms-counter">
                                {$_L['Remaining']}: <span class="remaining"></span> | {$_L['Length']}: <span class="length"></span> | {$_L['Messages']}: <span class="messages"></span>
                            </p>
                        </div>


                        <div class="form-group">
                            <button class="btn btn-primary" type="submit" id="send">{$_L['Send']}</button>
                        </div>
                    </form>

                </div>
            </div>

        </div>
    </div>


    <div class="modal fade" id="modal_find_contact" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">
                        {$_L['Contact']}
                    </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">

                    <select id="cid" name="cid" class="form-control">
                        <option value="">{$_L['Search Contact']}...</option>
                        {foreach $c as $cs}
                            <option value="{$cs['phone']}">{$cs['account']} - {$cs['phone']}  {if $cs['email'] neq ''} [ {$cs['email']} ]{/if}</option>
                        {/foreach}

                    </select>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$_L['Close']}</button>
                </div>
            </div>
        </div>
    </div>





{/block}
{block name="script"}
    <script>
        $(function () {
            var _url = $("#_url").val();

            var send = $("#send");

            var result = $("#result");

            var iform = $( "#iform" );

            $('#message').countSms('#sms-counter');

            var $modal = $('#ajax-modal');

            var $modal_find_contact = $("#modal_find_contact");


            var $cid = $('#cid');

            var $sms_to = $("#sms_to");


            function ib_s2() {

                return  $cid.select2({

                });



            }

            ib_s2();


            $modal_find_contact.on('shown.bs.modal', function() {


                ib_s2().select2('open');





            });


            $cid.on("change", function() {



                $sms_to.val($cid.val());

                $modal_find_contact.modal('hide');

            });






            send.on('click', function(e) {


                e.preventDefault();

                iform.block({ message: null });


                $.post( _url + "sms/init/send_post/", iform.serialize())
                    .done(function (data) {

                        iform.unblock();

                        result.html(data);

                    });


            });

        });
    </script>
{/block}
