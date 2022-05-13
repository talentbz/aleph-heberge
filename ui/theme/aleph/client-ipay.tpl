{extends file="layouts/canvas.tpl"}
{block name="content"}
    <div class="mx-auto" style="width: 600px; max-width: 600px; margin-top: 50px;">
        <div class="card">
            <div class="card-body">
                {if isset($notify)}
                    {$notify}
                {/if}

                <div class="row">
                    <div class="col-sm-6 mt-md">
                        <h2 class="h2 mt-none mb-sm text-dark text-bold">{$_L['INVOICE']}</h2>
                        <h4 class="h4 m-none text-dark text-bold">#{$d['invoicenum']}{if $d['cn'] neq ''} {$d['cn']} {else} {$d['id']} {/if}</h4>
                    </div>
                    <div class="col-sm-6 text-right mt-md mb-md">

                        <h4> {$_L['Invoice Total']}: {ib_money_format($d['total'],$config,$d['currency_symbol'])} </h4>
                        {if ($d['credit']) neq '0.00'}
                            <h2> {$_L['Total Paid']}: {ib_money_format($d['credit'],$config,$d['currency_symbol'])}</h2>
                            <h2> {$_L['Amount Due']}: {ib_money_format($i_due,$config,$d['currency_symbol'])}</h2>
                        {/if}
                    </div>
                </div>

                <div class="row">

                    <div class="col-md-12">
                        {if isset($ins)}
                            {$ins}
                        {/if}
                    </div>


                    {if !isset($_no_proof_of_payment)}
                        <div class="col-md-12">
                            <hr>
                            <a data-toggle="modal" href="#modal_add_item" class="btn btn-primary ml-sm"><i class="fal fa-paperclip"></i> {$_L['Proof Of Payment']}</a>
                        </div>
                    {/if}


                </div>


            </div>
        </div>
    </div>


    <div class="modal fade" id="modal_add_item" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{$_L['Upload']}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fal fa-times"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <form class="mb-3">
                        <div class="form-group">
                            <label for="doc_title">{$_L['Title']}</label>
                            <input type="text" class="form-control" id="doc_title" name="doc_title" value="{$_L['INVOICE']}/{$d['invoicenum']}{if $d['cn'] neq ''} {$d['cn']} {else} {$d['id']}{/if}/{$_L['Proof Of Payment']}">

                        </div>



                    </form>

                    <form action="" class="dropzone" id="upload_container">

                        <div class="dz-message">
                            <h3> <i class="fal fa-cloud-upload"></i>  {$_L['Drop File Here']}</h3>
                            <br />
                            <span class="note">{$_L['Click to Upload']}</span>
                        </div>

                    </form>


                </div>
                <div class="modal-footer">
                    <input type="hidden" name="file_link" id="file_link" value="">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{$_L['Close']}</button>
                    <button type="button" id="btn_add_file" class="btn btn-primary">{$_L['Save']}</button>
                </div>
            </div>
        </div>
    </div>



{/block}

{block name="script"}
    <script>

        {if !isset($_no_proof_of_payment)}
        Dropzone.autoDiscover = false;
        {/if}


        jQuery(document).ready(function() {
            // initiate layout and plugins


            var $modal = $('#ajax-modal');




            {if !isset($_no_proof_of_payment)}



            var $btn_add_file = $("#btn_add_file");

            var $file_link = $("#file_link");

            var upload_resp;

            var ib_file = new Dropzone("#upload_container",
                {
                    url: base_url + "client/upload/{$d->vtoken}/{$d->id}",
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


            $btn_add_file.on('click', function(e) {
                e.preventDefault();


                $.post( base_url + "client/doc_payment_proof", { title: $doc_title.val(), file_link: $file_link.val(), rid: {$d->id}, rtype: 'invoice' })
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            //   location.reload();

                            window.location = base_url + 'client/iview/{$d->id}/{$d->vtoken}';



                        }

                        else {

                            toastr.error(data);
                        }




                    });


            });

            {/if}



        });

    </script>
{/block}
