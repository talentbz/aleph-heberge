{extends file="hostbilling/layouts/new_base/base.tpl"}
{block name="head"}
    <section class="banner-part">
        <div class="container">
          <div class="row">
            <div class="col-lg-5">
              <div class="banner-heading">
                <h1>La meilleure team à votre service</h1>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
              </div>
            </div>
            <div class="col-lg-7">
              <div class="banner-img">
                <img src="{{APP_URL}}/ui/theme/default/assets/img/Groupe_1.png" alt="">
              </div>
            </div>
          </div>
        </div>
    </section>
{/block}

{block name="new_content"}
    <section class="service-section" >
      <div class="container">
        <div class="row align-item-center">
          <div class="col-lg-4">
            <h1 class="service-heading">Nos services</h1>
          </div>
          <div class="col-lg-8">
            <p class="service-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut</p>
          </div>
        </div>
        <div class="row">
          <div class="service-list">
            <ul>
              <li>
                <img src="{{APP_URL}}/ui/theme/default/assets/img/iconeVPS_SSD.png" alt="">
                <p>VPS SSD</p>
              </li>
              <li><img src="{{APP_URL}}/ui/theme/default/assets/img/Ione_HEBERGEMENT.png" alt="">
                <p>HÉBERGEMENT MUTUALISÉ</p></li>
              <li><img src="{{APP_URL}}/ui/theme/default/assets/img/Icone-Infogerence.png" alt="">
                <p>INFOGÉRANCE SERVEUR</p></li>
              <li><img src="{{APP_URL}}/ui/theme/default/assets/img/Groupicone_serveur_dВdiВ_e5.png" alt="">
                <p>SERVEURS DÉDIÉS</p></li>
              <li ><img src="{{APP_URL}}/ui/theme/default/assets/img/iconeVPS_SSD.png" alt="">
                <p>VPS DISQUES HAUTES CAPACITÉS (SSD BOOST))</p></li>
              <li>
                <img src="{{APP_URL}}/ui/theme/default/assets/img/iocne maintenance.png" alt="">
                <p>MAINTENCE</p>
              </li>
              <li ><img src="{{APP_URL}}/ui/theme/default/assets/img/icone bureau a distance.png" alt="">
                <p>BUREAU WINDOWS VIRTUEL À DISTANCE</p></li>
              <li><img src="{{APP_URL}}/ui/theme/default/assets/img/icone backup.png" alt="">
                <p>BACKUP PLAN</p></li>
                <li><img src="{{APP_URL}}/ui/theme/default/assets/img/icone vo ip.png" alt="">
                  <p>V0 IP</p></li>
            </ul>
          </div>
        </div>
      </div>
    </section>


    <section class="domain">
      <div class="container">
       <div class="row justify-content-center">
        <div class="domain-text">
          <div class="domain-first-heading text-center">
            <p>ENREGISTRER VOTRE NOM DE DOMAINE</p>
          </div>
          <div class="domain-second-heading">
            <h1>Enregistrez votre nom de domaine en 5 minutes</h1>
          </div>
        </div>
        <div class="domain-form">
          <form >
            <input type="text" placeholder="Votre domaine">
            <select>
                {foreach $domain_extensions as $domain_extension}
                    <option value="{$domain_extension->extension}">{$domain_extension->extension}</option>
                {/foreach}
            </select>
            <button>VÉRIFIER LA DISPONIBILITÉ</button>
          </form>
        </div>
       </div>
      </div>
    </section>
    <section class="fourth-section">
      <div class="container">
        <div class="row">
          <div class="col-lg-6">
            <div class="section-info">
              <span>TEMOIGNAGES</span>
              <h1>Ce qu’ils pensent de nos services</h1>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco l</p>
              <p><b>Paul Chart</b>  <span style="color: #33333380; margin-left: 20px ;">SUPCLIENT</span></p>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="about-img">
              <img src="{{APP_URL}}/ui/theme/default/assets/img/image home.png" alt="">
            </div>
          </div>
        </div>
      </div>
    </section>
{/block}