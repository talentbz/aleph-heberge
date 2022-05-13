{extends file="layouts/base.tpl"}

{block name="head"}

    <style>
        @media (min-width: 992px){
            .clx-fixed-navigation:not(.clx-navigation-type-top):not(.nav-function-hidden):not(.nav-function-minify) .page-content-wrapper {
                padding-left: 0;
            }
        }
    </style>
{/block}

{block name="content_body"}
    <div class="page-content-wrapper bg-transparent m-0">
        <div class="height-10 w-100 shadow-sm px-4 bg-brand-gradient">
            <div class="d-flex align-items-center container p-0">
                <div class="page-logo width-mobile-auto m-0 align-items-center justify-content-center p-0 bg-transparent bg-img-none shadow-0 height-9 border-0">
                    <a href="{APP_URL}" class="page-logo-link press-scale-down d-flex align-items-center">
                        {if isset($config['logo_square'])}
                            <img src="{{APP_URL}}/storage/system/{{$config['logo_square']}}" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                        {else}
                            <img src="{{APP_URL}}/storage/system/logo-512x512.png?v=2" alt="{{$config['CompanyName']}}" aria-roledescription="logo">
                        {/if}
                        {if isset($config['logo_text'])}
                            <span class="page-logo-text mr-1">{$config['logo_text']}</span>
                        {else}
                            <span class="page-logo-text mr-1">CloudOnex</span>
                        {/if}
                    </a>
                </div>



            </div>
        </div>
        <div class="flex-1">
            <div class="container py-4 py-lg-5 my-lg-5 px-4 px-sm-0">

                <div class="mx-auto" style="max-width: 600px;">
                    <div class="card p-4">

                        <h1 class="mb-3 text-center">
                            {$_L['Update']}
                        </h1>

                        {if isset($notify)}
                            {$notify}
                        {/if}


                        {if !isset($config['purchase_key']) || $config['purchase_key'] == ''}

                            <form id="form_save_purchase_key">

                                <p style="font-size: 16px;">The update requires your purchase key. You will find your purchase key by visiting the Licenses page in your CloudOnex profile.</p>

                                <div class="form-group">
                                    <label for="purchase_key">Purchase key</label>
                                    <input class="form-control" id="purchase_key" name="purchase_key" value="{$config['purchase_key']}">
                                </div>

                                <div class="form-group">
                                    <button class="btn btn-primary" id="btn_save_purchase_key" type="submit">{$_L['Save']}</button>
                                </div>

                            </form>

                            {else}

                            <textarea class="form-control" id="result_area">Please wait...</textarea>


                        {/if}


                    </div>
                </div>


                <div class="position-absolute pos-bottom pos-left pos-right p-3 text-center">
                    &copy; {date('Y')} {$config['CompanyName']}
                </div>
            </div>
        </div>
    </div>
{/block}

{block name="script"}
    <script>
        $(function () {

            $('#form_save_purchase_key').on('submit',function (e) {
                e.preventDefault();
                let $btn_save_purchase_key = $('#btn_save_purchase_key');

                $btn_save_purchase_key.prop('disabled',true);

                axios.post(base_url+ 'updating/save-purchase-key', $('#form_save_purchase_key').serialize())
                    .then(function (response) {
                        if(response.data.valid)
                        {
                            location.reload();
                        }
                        else{
                            toastr.error(response.data.message);
                        }

                        $btn_save_purchase_key.prop('disabled',false);
                    })
                    .catch(function (error) {
                          console.log(error);
                        $btn_save_purchase_key.prop('disabled',false);
                    });


            });


            let $result_area = $('#result_area');
            let show_progress;

            axios.post(base_url+ 'updating/check-for-update')
                .then(function (response) {

                    $result_area.val($result_area.val() + '\n' + response.data.status);

                    if(response.data.continue)
                        {
                            $result_area.val($result_area.val() + '\n' + 'Confirmation for update...');
                            $result_area.autoHeight();
                            bootbox.confirm({
                                message: response.data.status + " Would you like to update now?",
                                buttons: {
                                    confirm: {
                                        label: 'Yes, Update',
                                        className: 'btn-success'
                                    },
                                    cancel: {
                                        label: 'No',
                                        className: 'btn-danger'
                                    }
                                },
                                callback: function (confirmed) {
                                    if(confirmed)
                                        {
                                            $result_area.val($result_area.val() + '\n' + 'Confirmed!');
                                            $result_area.val($result_area.val() + '\n' + 'Getting download url from the remote server...');

                                            $result_area.autoHeight();

                                            axios.post(base_url+ 'updating/get-download-url')
                                                .then(function (response) {

                                                    if(response.data.continue)
                                                    {
                                                        $result_area.val($result_area.val() + '\n' + 'Received signed download url.');
                                                        $result_area.val($result_area.val() + '\n' + response.data.download_url);
                                                        $result_area.val($result_area.val() + '\n' + 'Downloading the latest version...');
                                                        $result_area.val($result_area.val() + '\n' + 'Please do not close your browser...');
                                                        $result_area.val($result_area.val() + '\n' + '........');
                                                        $result_area.val($result_area.val() + '\n' + '..................');
                                                        $result_area.val($result_area.val() + '\n');

                                                        $result_area.autoHeight();

                                                        show_progress = setInterval(function() {
                                                            $result_area.val($result_area.val() + '.');
                                                            //clearInterval( int ); // at some point, clear the setInterval
                                                        }, 100);

                                                        $result_area.autoHeight();
                                                        axios.post(base_url + 'updating/download-latest-version').then(function (response) {

                                                            clearInterval( show_progress );

                                                            $result_area.val($result_area.val() + '\n' + 'Downloaded!');
                                                            $result_area.val($result_area.val() + '\n' + 'Now unzipping....');



                                                            show_progress = setInterval(function() {
                                                                $result_area.val($result_area.val() + '.');
                                                                //clearInterval( int ); // at some point, clear the setInterval
                                                            }, 100);

                                                            $result_area.autoHeight();

                                                            axios.post(base_url + 'updating/unzip-downloaded-file/').then(function (response) {

                                                                clearInterval( show_progress );


                                                                if(response.data.continue)
                                                                {
                                                                    $result_area.val($result_area.val() + '\n' + 'Unzip completed!');

                                                                    $result_area.val($result_area.val() + '\n' + 'Finalizing update....');
                                                                    $result_area.val($result_area.val() + '\n' + 'Updating build number....');
                                                                    $result_area.val($result_area.val() + '\n' + 'Checking if database schema update is required....');
                                                                    $result_area.val($result_area.val() + '\n' + 'Updating database schema....');

                                                                    $result_area.autoHeight();


                                                                    axios.post(base_url + 'updating/finalize-update/').then(function (response) {



                                                                        $result_area.val($result_area.val() + '\n' + response.data.status);
                                                                        $result_area.val($result_area.val() + '\n' + 'Congratulations, you have now the latest version!');
                                                                        $result_area.autoHeight();


                                                                    }).catch(function (error) {
                                                                        console.log(error);
                                                                        clearInterval( show_progress );
                                                                    });

                                                                }
                                                                else{
                                                                    $result_area.val($result_area.val() + '\n' + response.data.status);
                                                                }



                                                            }).catch(function (error) {
                                                                console.log(error);
                                                                clearInterval( show_progress );
                                                            });

                                                        }).catch(function (error) {
                                                            console.log(error);
                                                            clearInterval( show_progress );
                                                        });
                                                    }
                                                    else{
                                                        $result_area.val($result_area.val() + '\n' + response.data.status);
                                                        $result_area.val($result_area.val() + '\n' + 'Stopped.');
                                                        $result_area.autoHeight();
                                                    }



                                                })
                                                .catch(function (error) {
                                                    console.log(error);

                                                });



                                        }
                                    else{
                                        $result_area.val($result_area.val() + '\n' + 'Update cancelled by the user.');
                                        $result_area.autoHeight();
                                    }
                                }
                            });



                        }


                })
                .catch(function (error) {
                    console.log(error);

                });


        });
    </script>
{/block}
