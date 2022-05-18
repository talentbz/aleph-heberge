{extends file="hostbilling/layouts/new_base/base.tpl"}

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
        .btn-domain-submit{
            text-align: center;
            font-size: 30px;
            float: left;
            width: 15%;
            background: #4C3CB8;
            color: #ffffff;
            display: table-cell;
            padding: 5px 0 6px 0;
            border-radius: 0 10px 10px 0;
            -moz-border-radius: 0 10px 10px 0;
            -webkit-border-radius: 0 10px 10px 0;
            height: 56px;
        }
        .btn:hover {
            color: #fff;
        }
    </style>
{/block}

{block name="new_content"}

    <div class="container">

        <div class="mx-auto" style="max-width: 800px; width: 100%">

            <div class="row">
                <div class="col-md-12">
                    <h1 class="text-center my-3"> {$_L['Start your domain name search']}</h1>
                </div>
            </div>

            <form id="form_domain_search" action="{$base_url}client/whois-post/">
                <div class="row mt-3">
                    <div class="col-md-12">
                        <input class="form-control input-domain-search" id="domain_name" name="domain_name" placeholder=" {$_L['Find your domain']}" type="text">
                        {csrf_field()}
                        <button class="btn btn-domain-submit" id="btn_domain_submit"><i class="fal fa-search"></i></button>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12" id="domain_search_result" style="display: none;">

                    </div>
                </div>
            </form>

        </div>


    </div>

{/block}

{block name=script}

    <script>

        $(function () {

            let $form_domain_search = $('#form_domain_search');
            let $domain_search_result = $('#domain_search_result');
            let $domain_name = $('#domain_name');
            let $btn_domain_submit = $('#btn_domain_submit');
            $form_domain_search.on('submit',function (event) {
                event.preventDefault();
                $btn_domain_submit.prop('disabled',true);
                axios.post(base_url + 'client/whois-post',$form_domain_search.serialize()).then(function (response) {
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
