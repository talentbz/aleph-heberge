{extends file="$layouts_client"}

{block name="content"}


    <div class="row">
        <div class="col-md-12">

            <div class="card border" id="t_options">

                <div class="card-header">
                    <ul class="nav nav-tabs card-header-tabs">
                        <li class="nav-item"><a class="nav-link" href="{$_url}client/downloads"><i class="fal fa-th"></i> {$_L['Downloads']}</a></li>
                        <li class="nav-item"><a class="nav-link active" href="{$_url}client/uploads"><i class="fal fa-tasks"></i> {$_L['Uploads']}</a></li>
                    </ul>
                </div>




                <div class="card-body">




                    <div class="tab-content">
                        <div id="details" class="tab-pane fade show active ib-tab-box">



                            <a data-toggle="modal" href="#modal_add_item" class="btn btn-primary add_document waves-effect waves-light" id="add_document"><i class="fal fa-plus"></i> {$_L['New Document']}</a>

                            <hr>

                            <div class="row">
                                <div class="col-lg-12">

                                    {if count($files) > 0}

                                        {foreach $files as $file}

                                            <div class="file-box">
                                                <div class="file">
                                                    <a href="{$_url}client/dl/{$file->id}_{$file->file_dl_token}/">
                                                        <span class="corner"></span>

                                                        <div class="icon">
                                                            {if $file->file_mime_type eq 'jpg' || $file->file_mime_type eq 'png' || $file->file_mime_type eq 'gif'}
                                                                <i class="fal fa-file-image-o"></i>
                                                            {elseif $file->file_mime_type eq 'pdf'}
                                                                <i class="fal fa-file-pdf-o"></i>
                                                            {elseif $file->file_mime_type eq 'zip'}
                                                                <i class="fal fa-file-archive-o"></i>
                                                            {else}
                                                                <i class="fal fa-file"></i>
                                                            {/if}
                                                        </div>
                                                        <div class="file-name">
                                                            {$file->title}
                                                            <br/>
                                                            <small>
                                                                {if (isset($file->updated_at) && $file->updated_at != '')}
                                                                    {date( $config['df'], strtotime($file->updated_at))}
                                                                {else}
                                                                    {date( $config['df'], strtotime($file->created_at))}
                                                                {/if}

                                                            </small>
                                                        </div>
                                                    </a>
                                                </div>

                                            </div>

                                        {/foreach}

                                    {else}
                                        {$_L['No Data Available']}
                                    {/if}






                                </div>
                            </div>

                        </div>



                    </div>





                </div>

            </div>



        </div>
    </div>


    <div class="modal fade" id="modal_add_item" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{$_L['New Document']}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="doc_title">{$_L['Title']}</label>
                            <input type="text" class="form-control" id="doc_title" name="doc_title">

                        </div>

                    </form>

                    <hr>

                    <form action="" class="dropzone" id="upload_container">

                        <div class="dz-message">
                            <h3> <i class="fal fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Click to Upload']}</span>
                        </div>

                    </form>
                    <hr>

                    <p>{$_L['Upload Maximum Size']}: {$upload_max_size}</p>
                    <p>{$_L['POST Maximum Size']}: {$post_max_size}</p>

                </div>
                <div class="modal-footer">
                    <input type="hidden" name="file_link" id="file_link" value="">
                    <button type="button" data-dismiss="modal" class="btn btn-danger">{$_L['Close']}</button>
                    <button type="button" id="btn_add_file" class="btn btn-primary">{$_L['Submit']}</button>
                </div>
            </div>
        </div>
    </div>





{/block}

{block name="script"}
    <script>
        Dropzone.autoDiscover = false;
        $(function() {

            var _url = base_url;



            var $modal = $('#cloudonex_body');

            $('[data-toggle="tooltip"]').tooltip();

            var $btn_add_file = $("#btn_add_file");

            var $file_link = $("#file_link");

            var upload_resp;




            var ib_file = new Dropzone("#upload_container",
                {
                    url: _url + "client/document_upload/",
                    maxFiles: 1
                }
            );


            ib_file.on("sending", function() {

                $btn_add_file.prop('disabled', true);

            });

            ib_file.on("success", function(file,response) {

                $btn_add_file.prop('disabled', false);

                upload_resp = response;

                if(upload_resp.success == 'Yes'){

                    toastr.success(upload_resp.msg);
                    $file_link.val(upload_resp.file);


                }
                else{
                    toastr.error(upload_resp.msg);
                }


            });




            var $doc_title = $("#doc_title");

            var is_global = '0';


            $btn_add_file.on('click', function(e) {
                e.preventDefault();



                $.post( _url + "client/save_upload/", { title: $doc_title.val(), file_link: $file_link.val() })
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {
                            toastr.error(data);
                        }




                    });


            });




        });
    </script>
{/block}
