{extends file="hostbilling/layouts/new_base/base.tpl"}

{block name="new_content"}
<section class="last-main-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="last-first-part">
                    <div class="last-inner-section d-flex">
                    <img src="{{APP_URL}}/ui/theme/default/assets/img/icone contact.svg" alt="">
                    <h1>CONTACT</h1>
                    
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="contact">
                    <div class="message-box">
                        <form id="contact-form" style="display:contents">
                            <input type="text" id="title" placeholder="NOM COMPLET" name="title" required> 
                            <input type="email" id="email" placeholder="ADRESSE MAIL" name="email" required>
                            <input type="tel" id="phone" placeholder="TELEPHONE" name="phone" required>
                            <textarea id="contents" placeholder="VOTRE MESSAGE" cols="30" rows="10" name="contents" required></textarea>
                            <button type="submit">ENVOYER</button>
                        </form>
                    </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="info-box">
                <div class="info-img">
                <img src="{{APP_URL}}/ui/theme/default/assets/img/image contact.png" alt="">
                </div>
                <div class="main-info">
                <img src="{{APP_URL}}/ui/theme/default/assets/img/logo aleph heberge.png" alt="">
                <ul>
                    <li>• 4 RUE DE LA REPUBLIQUE 69001 LYON </li>
                    <li>• Tél.: 01 77 47 27 08 </li>
                    <li>• Mail:  contact@aleph-heberge.fr</li>
                </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row justify-content-center text-center">
        <div class="col-lg-12 ">
            <div class="map">
                <img src="{{APP_URL}}/ui/theme/default/assets/img/map contact.png" alt="">
            </div>
        </div>
    </div>
</section>
{/block}
{block name=script}
<script>
    $(function () {
        $('form#contact-form').submit(function(e){
            e.preventDefault();
            $.post( "{$_url}client/contact-form-post/", {
                title: $('#title').val(),
                email: $('#email').val(),
                phone: $('#phone').val(),
                contents: $('#contents').val(),
            })
                .done(function( res ) {
                    console.log(res);
                    toastr.success('success');    
                }).fail(function(data) {
                    toastr.error(data.responseText);
            });
        })
    });
</script>
{/block}