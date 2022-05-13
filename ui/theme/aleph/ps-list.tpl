{extends file="$layouts_admin"}

{block name="content"}
    <div class="row">
        <div class="col-md-12">
            <div class="panel">
                <div class="panel-hdr">
                    <h2>{$_L['List']} {if $type eq 'Product'} {$_L['Products']} {else} {$_L['Services']} {/if}</h2>
                    <div class="panel-toolbar">
                        <div class="btn-group">
                            <a href="{$_url}ps/p-new" class="btn btn-primary"><i class="fal fa-plus"></i> {$_L['Add Product']}</a>
                            <a href="{$_url}ps/s-new" class="btn btn-success"><i class="fal fa-plus"></i> {$_L['Add Service']}</a>
                        </div>
                    </div>
                </div>
                <div class="panel-container" id="ibox_form">
                    <div class="panel-content">
                        <div class="input-group"><input type="text" placeholder="{$_L['Search']}" id="txtsearch" class="input-sm form-control"> <span class="input-group-btn">
                                        <button type="button" id="search" class="btn btn-primary"> {$_L['Search']}</button> </span></div>
                        <input type="hidden" id="stype" value="{$type}">
                        <div class="project-list mt-md">
                            <div id="progressbar">
                            </div>

                            <div id="application_ajaxrender">


                            </div>


                        </div>

                    </div>




                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="_lan_are_you_sure" value="{$_L['are_you_sure']}">
{/block}


{block name="script"}
    <script>
        Dropzone.autoDiscover = false;

        $(document).ready(function () {




            var upload_resp;



            function updateDiv(){
                //   $("#application_ajaxrender").html('Loading...');
                $('#ibox_form').block({ message: null });




                var btnsearch = $("#search");

                //btnsearch.html(_L['Searching']);
                //btnsearch.addClass("btn-danger");
                var _url = $("#_url").val();
                $.post(_url + 'search/ps/', {

                    txtsearch: $('#txtsearch').val(),
                    stype: $('#stype').val()

                })
                    .done(function (data) {
                        var sbutton = $("#search");
                        var result =  $("#application_ajaxrender");
                        //sbutton.html('Search');
                        //sbutton.removeClass("btn-danger");

                        $('#ibox_form').unblock();
                        result.html(data);
                        result.show();
                    });

            }

            updateDiv();

            $("#search").click(function (e) {
                e.preventDefault();
                updateDiv();
            });
            var $modal = $('#cloudonex_body');
            var sysrender = $('#application_ajaxrender');
            sysrender.on('click', '.cdelete', function(e){
                e.preventDefault();
                var id = this.id;
                var lan_msg = $("#_lan_are_you_sure").val();
                bootbox.confirm(lan_msg, function(result) {
                    if(result){
                        var _url = $("#_url").val();
                        window.location.href = _url + "delete/ps/" + id + '/';
                    }
                });
            });

            sysrender.on('click', '.cedit', function(e){
                e.preventDefault();
                var vid = this.id;
                var id = vid.replace("e", "");
                id = id.replace("t", "");


                $.fancybox.open({
                    src  :  base_url + 'ps/edit-form/' + id,
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('.amount').autoNumeric('init', {

                                aSign: '{$config['currency_code']}',
                                dGroup: {$config['thousand_separator_placement']},
                                aPad: {$config['currency_decimal_digits']},
                                pSign: '{$config['currency_symbol_position']}',
                                aDec: '{$config['dec_point']}',
                                aSep: '{$config['thousands_sep']}',
                                vMax: '9999999999999999.00',
                                vMin: '-9999999999999999.00',

                                {if isset($config['decimal_places_products_and_services'])}
                                mDec: $config['decimal_places_products_and_services'],
                                {/if}

                            });

                            $('#description').redactor(
                                {
                                    minHeight: 200 // pixels
                                }
                            );

                          //  new Clipboard('.ib_btn_copy');

                            var $file_link = $("#file_link");
                            var ib_submit = $("#update");

                            var ib_file = new Dropzone("#upload_container",
                                {
                                    url: base_url + "ps/upload/",
                                    maxFiles: 1
                                }
                            );


                            ib_file.on("sending", function() {

                                ib_submit.prop('disabled', true);

                            });

                            ib_file.on("success", function(file,response) {

                                ib_submit.prop('disabled', false);

                                upload_resp = response;

                                if(upload_resp.success == 'Yes'){

                                    toastr.success(upload_resp.msg);
                                    // $file_link.val(upload_resp.file);
                                    $('#file_link_image').val(upload_resp.file);


                                }
                                else{
                                    toastr.error(upload_resp.msg);
                                }


                            });

                        },
                        touch: false,
                        autoFocus: false,
                    },
                });

            });

            $modal.on('click', '#update', function(event){
                event.preventDefault();
                var _url = $("#_url").val();
                $.post(_url + 'ps/edit-post/', $('#edit_form').serialize(), function(data){

                    var _url = $("#_url").val();
                    if ($.isNumeric(data)) {

                        location.reload();
                    }
                    else {

                        // $modal
                        //     .modal('loading')
                        //     .find('.modal-body')
                        //     .prepend('<div class="alert alert-danger fade in">' + data +
                        //
                        //         '</div>');

                        toastr.error(data);

                    }

                });

            });





        });
    </script>
{/block}
