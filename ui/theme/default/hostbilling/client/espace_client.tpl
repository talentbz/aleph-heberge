{extends file="hostbilling/layouts/new_base/base.tpl"}

{block name="new_content"}
<section class="whois">
      <div class="container">
          <div class="row">
              <div class="col-lg-6">
                <div class="fiftin-inner-section d-flex">
                    <img src="{{APP_URL}}/ui/theme/default/assets/img/icone_espace_client.svg" alt="">
                    <h1>ESPACE CLIENT</h1>
                    
                  </div>
                  <div class="fiftin-inner-text">
                   <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
                     Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                  </div>
                  <div class="col-lg-6">
                    <div class="input-box">
                        <form method="post" class="mt-3" id="form_client_auth" action="{$_url}client/auth/">
                            <h2 class="input-heading">CONNEXION</h2>
                            <input type="email" id="username" name="username" placeholder="ADRESSE MAIL" required>
                            <br>
                            <input type="password" placeholder="MOT DE PASSE" id="password" name="password" required>
                            <br>
                            <button class="btn" type="submit" id="btn_client_auth">CONNECTION</button>
                            <a href="{$_url}client/register">Mot de passe oublié ?</a>
                        </form>
                      </div>
                      
                    </div>
              </div>
              <div class="col-lg-6">
                <div class="input-box-2">
                    <form method="post" id="form_client_register" class="mt-3" action="{$_url}client/register_post/">
                        <h2 class="input-heading-2">INSCRIPTION</h2>
                        <br>
                        <input type="text" id="fullname" name="fullname" placeholder="NOM COMPLET" required>
                        <br>
                        <input type="email" id="email" name="email" placeholder="ADRESSE MAIL" required>
                        <br>
                        <input type="password" id="password1" name="password" placeholder="{$_L['Password']}" required>
                        <br>
                        <input type="password" id="password2" name="password2" placeholder="CONFIRMER LE MOT DE PASSE" required>
                        <br>
                        <button type="submit" id="btn_client_register" class="btn">INSCRIPTION</button>
                    </form>
                </div>
            </div>
          </div>
      </div>
  </section>
{/block}
{block name="script"}
    <script>
        $(function () {
            
            //login section
            let $form_client_auth = $('#form_client_auth');
            let $btn_client_auth = $('#btn_client_auth');

            $form_client_auth.on('submit',function (e) {
                e.preventDefault();

                $btn_client_auth.disabled = true;

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
            });

            //register section
            let $form_client_register = $('#form_client_register');
            let $btn_client_register = $('#btn_client_register');

            $form_client_register.on('submit',function (e) {
                e.preventDefault();
                console.log()
                $btn_client_register.disabled = true;
                $.post( "{$_url}client/register_post/", {
                    fullname: $('#fullname').val(),
                    email: $('#email').val(),
                    password: $('#password1').val(),
                    password2: $('#password2').val(),
                })
                    .done(function( data ) {
                        window.location = data.redirect_url;
                    }).fail(function(data) {
                    $btn_client_register.disabled = false;
                    toastr.error(data.responseText);
                });

            });

        });
    </script>
{/block}