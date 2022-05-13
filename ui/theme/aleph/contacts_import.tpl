{extends file="$layouts_admin"}

{block name="content"}
    <div class="panel">
        <div class="row">
            <div class="col-md-12 m-b-sm">

                <div class="panel-hdr">
                    <div class="btn-group">
                        <a href="{$_url}contacts/list/" class="btn btn-sm btn-danger"> {$_L['Cancel']}</a>
                        <a href="{$app_url}storage/system/contacts.csv" class="btn btn-sm btn-primary"><i class="fal fa-download"></i> {$_L['Download Sample File']}</a>
                    </div>

                </div>

            </div>

        </div>
    </div>


    <div class="row">
        <div class="col-md-12">

            <div class="panel panel-default" id="uploading_inside">
                <div class="panel-body">
                    <form action="{$_url}contacts/csv_upload/" class="dropzone" id="upload_container">

                        <div class="dz-message">
                            <h3> <i class="fal fa-cloud-upload"></i>  {$_L['Drop CSV File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Or Click to Upload']}</span>
                        </div>

                    </form>

                </div>
            </div>

        </div>

    </div>


    <input type="hidden" id="_msg_importing" value="{$_L['Importing']} ...">
    <input type="hidden" id="_msg_are_you_sure" value="{$_L['are_you_sure']}">

{/block}

{block name="script"}
    <script>
        Dropzone.autoDiscover = false;
        $(function() {
            var _url = $("#_url").val();
            var ib_file = new Dropzone("#upload_container",
                {
                    url: _url + "contacts/csv_upload/",
                    maxFiles: 1,
                    acceptedFiles: ".csv"
                }
            );

            //ib_file.on("addedfile", function(file) {
            //
            //});

            ib_file.on("success", function(file) {

                var _msg_importing = $('#_msg_importing').val();
                $('#uploading_inside').block({
                    message: "<h3>" + _msg_importing +"</h3>" ,
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

                $.post(_url + 'contacts/csv_uploaded/', {

                    name: file.name

                })
                    .done(function (data) {
                        //location.reload();

                        window.location.replace(_url + "contacts/list/");


                    });
            });




        });
    </script>
{/block}
