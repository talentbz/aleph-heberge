{extends file="hostbilling/layouts/client.tpl"}
{block name="head"}

    <style>
        @media (min-width: 992px){
            .clx-fixed-navigation:not(.clx-navigation-type-top):not(.nav-function-hidden):not(.nav-function-minify) .page-content-wrapper {
                padding-left: 0;
            }
        }
    </style>


    {if $config['recaptcha'] eq '1' && !empty($config['recaptcha_sitekey'])}
        <script src="https://www.google.com/recaptcha/api.js?render={$config['recaptcha_sitekey']}"></script>
    {/if}

{/block}


{block name="new_content"}
    <div class="flex-1">
        <div class="container">

            {if $type eq 'client_auth'}

                <div class="mx-auto" style="max-width: 440px;">
                    <div class="card p-4 mt-5" style="box-shadow: 1px 0 20px rgba(0, 0, 0, .08);">

                        <h1 class="fw-300 mb-3 text-center">
                            {$_L['Login']}
                        </h1>

                        {if isset($notify)}
                            {$notify}
                        {/if}

                        <form method="post" class="mt-3" id="form_client_auth" action="{$_url}client/auth/">
                            <div class="form-group">
                                <label class="form-label" for="username">{$_L['Email Address']}</label>
                                <input id="username" name="username" class="form-control form-control-lg" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="password">{$_L['Password']}</label>
                                <input type="password" id="password" name="password" class="form-control form-control-lg" required>
                            </div>


                            <div class="form-group">
                                <button type="submit" id="btn_client_auth" class="btn btn-primary btn-block btn-lg">{$_L['Login']}</button>
                            </div>

                            {if $config['allow_customer_registration'] eq '1'}
                                <div class="form-group mb-0">
                                    <div class="col-sm-12 text-center">
                                        {$_L['Dont have an account']} <a href="{$_url}client/register/" class="text-info m-l-5"><b>{$_L['Register']}</b></a>
                                    </div>
                                </div>
                            {/if}

                            <div class="text-center">
                                <a href="{$_url}client/forgot_pw/" id="to-recover" class="text-info">{$_L['Forgot password']}</a>
                            </div>



                        </form>




                    </div>
                </div>


            {elseif $type eq 'client_password_reset'}
                <div class="mx-auto" style="max-width: 440px;">
                    <div class="card p-4">

                        <h1 class="fw-300 mb-3 text-center">
                            {__('Password Reset')}
                        </h1>

                        {if isset($notify)}
                            {$notify}
                        {/if}

                        <form method="post" class="mt-3" action="{$_url}client/forgot_pw_post/">
                            <div class="form-group">
                                <label class="form-label" for="username">{$_L['Email Address']}</label>
                                <input id="username" name="username" class="form-control form-control-lg" required>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn btn-primary btn-block btn-lg">{$_L['Reset Password']}</button>
                            </div>
                        </form>

                        {if $config['allow_customer_registration'] eq '1'}
                            <div class="form-group mt-3">
                                <div class="col-sm-12 text-center">
                                    {$_L['Dont have an account']} <a href="{$_url}client/register/" class="text-info m-l-5"><b>{$_L['Register']}</b></a>
                                </div>
                            </div>
                        {/if}




                    </div>
                </div>

            {elseif $type eq 'client_register'}

                <div class="mx-auto" style="max-width: 440px;">
                    <div class="card p-4">

                        <h1 class="fw-300 mb-3 text-center">
                            {__('Register')}
                        </h1>

                        {if isset($notify)}
                            {$notify}
                        {/if}

                        <form method="post" id="form_client_register" class="mt-3" action="{$_url}client/register_post/">

                            <div class="form-group">
                                <label class="form-label" for="fullname">{$_L['Full_Name']}</label>
                                <input id="fullname" name="fullname" class="form-control form-control-lg" required>
                            </div>


                            <div class="form-group">
                                <label class="form-label" for="email">{$_L['Email Address']}</label>
                                <input id="email" name="email" class="form-control form-control-lg" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="password">{$_L['Password']}</label>
                                <input type="password" id="password" name="password" class="form-control form-control-lg" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="password2">{$_L['Confirm_Password']}</label>
                                <input type="password" id="password2" name="password2" class="form-control form-control-lg" required>
                            </div>

                            {foreach $extra_fields as $field}

                                <div class="form-group">
                                    <label for="field_{$field['id']}" class="form-label">{$field['label']}</label>
                                    <input type="text" class="form-control form-control-lg" id="field_{$field['id']}" name="{$field['name']}">
                                </div>



                            {/foreach}

                            <div class="form-group">
                                <button type="submit" id="btn_client_register" class="btn btn-primary btn-block btn-lg">{$_L['Register']}</button>
                            </div>
                        </form>

                        <div class="form-group mt-3">
                            <div class="col-sm-12 text-center">
                                {$_L['Already registered']}  <a href="{$_url}client/login/" class="text-info m-l-5"><b>{$_L['Login']}</b></a>
                            </div>
                        </div>




                    </div>
                </div>

            {/if}


            <div class="position-absolute pos-bottom pos-left pos-right p-3 text-center">
                &copy; {date('Y')} {$config['CompanyName']}
            </div>
        </div>
    </div>
{/block}

{block name="script"}
    <script>
        $(function () {

            var $modal = $('#cloudonex_body');

            {if $type eq 'admin_auth'}
            let $form_admin_auth = $('#form_admin_auth');
            let $btn_admin_auth = $('#btn_admin_auth');

            $form_admin_auth.on('submit',function (e) {
                e.preventDefault();

                $btn_admin_auth.disabled = true;

                {if $config['recaptcha'] eq '1' && !empty($config['recaptcha_sitekey'])}

                grecaptcha.ready(function() {
                    grecaptcha.execute('{$config['recaptcha_sitekey']}', { action: 'submit' }).then(function(token) {
                        $.post( "{$_url}login/post/{if isset($after)}{$after}/{/if}", {
                            username: $('#username').val(),
                            password: $('#password').val(),
                            token: token,
                        })
                            .done(function( data ) {
                                window.location = data.redirect_url;
                            }).fail(function(data) {
                            $btn_admin_auth.disabled = false;
                            toastr.error(data.responseText);
                        });
                    });
                });

                {else}

                $.post( "{$_url}login/post/{if isset($after)}{$after}/{/if}", {
                    username: $('#username').val(),
                    password: $('#password').val(),
                })
                    .done(function( data ) {
                        window.location = data.redirect_url;
                    }).fail(function(data) {
                    $btn_admin_auth.disabled = false;
                    toastr.error(data.responseText);
                });

                {/if}


            });

            {/if}

            {if $type eq 'client_auth'}

            let $form_client_auth = $('#form_client_auth');
            let $btn_client_auth = $('#btn_client_auth');

            $form_client_auth.on('submit',function (e) {
                e.preventDefault();

                $btn_client_auth.disabled = true;

                {if $config['recaptcha'] eq '1' && !empty($config['recaptcha_sitekey'])}

                grecaptcha.ready(function() {
                    grecaptcha.execute('{$config['recaptcha_sitekey']}', { action: 'submit' }).then(function(token) {
                        $.post( "{$_url}client/auth/", {
                            username: $('#username').val(),
                            password: $('#password').val(),
                            token: token,
                        })
                            .done(function( data ) {
                                window.location = data.redirect_url;
                            }).fail(function(data) {
                            $btn_client_auth.disabled = false;
                            toastr.error(data.responseText);
                        });
                    });
                });

                {else}

                $.post( "{$_url}client/auth/", {
                    username: $('#username').val(),
                    password: $('#password').val(),
                })
                    .done(function( data ) {
                        window.location = data.redirect_url;
                    }).fail(function(data) {
                    $btn_client_auth.disabled = false;
                    toastr.error(data.responseText);
                });

                {/if}


            });

            {if isset($admin) && $admin}

            $('#login_as_admin').on('click',function () {
                window.location = base_url + 'login/';
            });

            $('#btn_edit_content').on('click',function (e) {
                e.preventDefault();

                $.fancybox.open({
                    src  : base_url + 'settings/client-auth-page-widget',
                    type : 'ajax',
                    opts : {
                        afterShow : function( instance, current ) {
                            $('#edit_content').redactor();
                        },
                        modal: true,
                    }
                });

            });

            $modal.on('click', '.modal_submit', function(e){

                e.preventDefault();

                $.post( base_url + "settings/client-auth-page-widget-save/", $("#clx_modal_form").serialize())
                    .done(function( data ) {

                        if ($.isNumeric(data)) {

                            location.reload();

                        }

                        else {
                            toastr.error(data);
                        }

                    });

            });

            {/if}


            {/if}

            {if $type eq 'client_register'}

            let $form_client_register = $('#form_client_register');
            let $btn_client_register = $('#btn_client_register');

            $form_client_register.on('submit',function (e) {
                e.preventDefault();

                $btn_client_register.disabled = true;

                {if $config['recaptcha'] eq '1' && !empty($config['recaptcha_sitekey'])}

                grecaptcha.ready(function() {
                    grecaptcha.execute('{$config['recaptcha_sitekey']}', { action: 'submit' }).then(function(token) {
                        $.post( "{$_url}client/register_post/", {
                            fullname: $('#fullname').val(),
                            email: $('#email').val(),
                            password: $('#password').val(),
                            password2: $('#password2').val(),
                            token: token,
                        })
                            .done(function( data ) {
                                window.location = data.redirect_url;
                            }).fail(function(data) {
                            $btn_client_register.disabled = false;
                            toastr.error(data.responseText);
                        });
                    });
                });

                {else}

                $.post( "{$_url}client/register_post/", {
                    fullname: $('#fullname').val(),
                    email: $('#email').val(),
                    password: $('#password').val(),
                    password2: $('#password2').val(),
                })
                    .done(function( data ) {
                        window.location = data.redirect_url;
                    }).fail(function(data) {
                    $btn_client_register.disabled = false;
                    toastr.error(data.responseText);
                });

                {/if}


            });

            {/if}

        });
    </script>
{/block}
