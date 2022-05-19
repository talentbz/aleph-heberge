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
                    <input type="text" placeholder="NOM COMPLET"> 
                    <input type="email" placeholder="ADRESSE MAIL">
                    <input type="tel" placeholder="TELEPHONE">
                    <textarea placeholder="VOTRE MESSAGE" cols="30" rows="10"></textarea>
                    <button>ENVOYER</button>
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
                    <li>• 1 rue Rogozine Ashdod - Israël </li>
                    <li>• Tél.: 01 77 47 27 08 </li>
                    <li>• Mail: contact@aleph-hosting.com</li>
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
