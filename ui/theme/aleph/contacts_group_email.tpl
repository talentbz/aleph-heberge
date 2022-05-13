{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel"  id="iform">
                <div class="panel-hdr">
                    <h5>{$_L['Send Email']}</h5>

                </div>
                <div class="panel-container">
                    <div class="panel-content">
                        <form class="form-horizontal" method="post">

                            <div class="mail-box">


                                <div class="mail-body">


                                    <div class="form-group"><label for="emails">{$_L['To']}:</label>

                                        <select class="form-control" id="emails" multiple="multiple">

                                            {foreach $ds as $d}
                                                <option value="{$d['email']}" selected>{$d['email']}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    {*<div class="form-group"><label for="cc">{$_L['Cc']}:</label>*}

                                    {*<div class="col-sm-10"><input type="text" id="cc" name="cc" class="form-control" value=""></div>*}
                                    {*</div>*}

                                    {*<div class="form-group"><label for="bcc">{$_L['Bcc']}:</label>*}

                                    {*<div class="col-sm-10"><input type="text" id="bcc" name="bcc" class="form-control" value=""></div>*}
                                    {*</div>*}

                                    <div class="form-group"><label for="subject">{$_L['Subject']}:</label>
                                        <input type="text" id="subject" name="subject" class="form-control mb-3" value="">

                                        <textarea id="content"  class="form-control sysedit" name="content"></textarea>

                                    </div>




                                </div>


                                <div class="mail-body text-right">

                                    <button type="submit" id="send_email"  class="btn btn-sm btn-primary"><i class="fal fa-paper-plane-o"></i> {$_L['Send']}</button>
                                </div>
                                <div class="clearfix"></div>



                            </div>

                        </form>
                    </div>



                </div>
            </div>



        </div>



    </div>
{/block}

{block name="script"}

    <script>
        $(function () {

            var form = document.getElementById("mainForm");


            $('#content').redactor(
                {
                    minHeight: 200, // pixels
                    plugins: ['fontcolor']
                }
            );

            $("#emails").select2({
                    language: {
                        noResults: function () {
                            return $("#_lan_no_results_found").val();
                        }
                    }
                }
            );







            // $("#mainForm").submit(function (e) {
            //
            //     e.preventDefault();
            //
            //     if(pristine.validate())
            //     {
            //         $('#clx_form_box').block({ message:block_msg });
            //
            //         $.post('https://demo.cloudonex.com/projects/project-save', $( "#mainForm" ).serialize())
            //             .done(function (data) {
            //                 window.location = 'https://demo.cloudonex.com/projects';
            //             }).fail(function(data) {
            //             $('#clx_form_box').unblock();
            //             spNotify(data.responseText,'error');
            //         });
            //     }
            //
            // });



        });

    </script>
{/block}
