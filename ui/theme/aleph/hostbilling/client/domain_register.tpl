{extends file="hostbilling/layouts/client.tpl"}

{block name="head"}
    <style>
        .input-domain-search{
            padding: 20px 12px 20px 12px;
            width: 85%;
            float: left;
            display: table-cell;
            border-radius: 10px 0 0 10px;
            -moz-border-radius: 10px 0 0 10px;
            -webkit-border-radius: 10px 0 0 10px;
            border-color: #EBEBEB;
            background: #EBEBEB;
            height: 56px;
            font-size: 1.25rem;
        }
        .input-domain-search-extension{
            height: 56px;
            font-size: 20px;
            border-color: #EBEBEB;


        }
        .btn-domain-search{
            font-size: 20px;
            height: 56px;
            border: none;
            width: 80px;
        }
    </style>
{/block}

{block name="content"}


    <div class="container">


        <div class="mx-auto" style="max-width: 800px; width: 100%; ">

            <div class="row">
                <div class="col-md-12">
                    <h1 class="text-center my-3" style="font-size: 30px">{$_L['Start your domain name search']}</h1>
                </div>
            </div>


                <div class="row mt-3">
                    <div class="col-md-12">

                        <form id="form_domain_search" action="{$base_url}client/whois-post/">

                            <div class="input-group mb-3">
                                <input type="text" class="form-control input-domain-search" name="domain_name" placeholder="{$_L['Enter domain name...']}">
                                <div class="input-group-append">
                                    <select class="custom-select input-domain-search-extension" name="extension">
                                        {foreach $domain_extensions as $domain_extension}
                                            <option value="{$domain_extension->extension}">{$domain_extension->extension}</option>
                                        {/foreach}
                                    </select>
                                    <button class="btn btn-primary btn-domain-search" id="btn_domain_submit" type="submit"><i class="fal fa-search"></i></button>
                                </div>
                            </div>

                        </form>

                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12" id="domain_search_result" style="display: none;">

                    </div>
                </div>


        </div>


    </div>

{/block}

{block name=script}

    <script>

        $(function () {

            let $form_domain_search = $('#form_domain_search');
            let $domain_search_result = $('#domain_search_result');
            let $btn_domain_submit = $('#btn_domain_submit');
            let $cloudonex_body = $('#cloudonex_body');
            $form_domain_search.on('submit',function (event) {
                event.preventDefault();
                $btn_domain_submit.prop('disabled',true);
                axios.post(base_url + 'client/domain-register-post',$form_domain_search.serialize()).then(function (response) {
                    $btn_domain_submit.prop('disabled',false);
                    $domain_search_result.show();
                    $domain_search_result.html('<div class="card"><div class="card-body">' + response.data + '</div></div>');
                }).catch(function (error) {

                    $btn_domain_submit.prop('disabled',false);

                    $.each(error.response.data, function(key, value) {
                        toastr.error(value);
                    });

                });

            });



        });

    </script>


{/block}
