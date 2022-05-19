{extends file="hostbilling/layouts/new_base/base.tpl"}

{block name="head"}

{/block}

{block name="new_content"}
<section class="whois">
      <div class="container">
          <div class="row">
              <div class="col-lg-12">
                <div class="eleven-banner-main-info d-flex">
                    <div class="eleven-bannaer-img">
                      <img src="{{APP_URL}}/ui/theme/default/assets/img/icone whois.svg" alt="">
                    </div>
                    <div class="eleven-bannner-heading">
                      <h1>WHOIS</h1>
                    </div>
                  </div>
              </div>
          </div>
      </div>
  </section>
  <section class="domain">
      <div class="container">
          <div class="row justify-content-center">
              <div class="col-lg-12">
                  <div class="domain-text">
                      <div class="domain-first-heading text-center">
                        <p>ENREGISTRER VOTRE NOM DE DOMAINE</p>
                      </div>
                      <div class="domain-second-heading">
                        <h1>Découvrez qui possède un site Web</h1>
                      </div>
                    </div>
                    <div class="domain-form">
                        <form id="form_domain_search" action="{$base_url}client/whois-post/">
                            <input class="input-domain-search" id="domain_name" name="domain_name" placeholder=" {$_L['Find your domain']}" type="text">
                            {csrf_field()}
                            <button class="btn-domain-submit" id="btn_domain_submit">CHERCHER</button>
                            <div class="row mt-3">
                                <div class="col-md-12" id="domain_search_result" style="display: none;">

                                </div>
                            </div>
                        </form>
                      <!-- <form >
                        <input type="text" placeholder="Entrez le domaine">
                        
                        <button>CHERCHER</button>
                      </form> -->
                    </div>
              </div>
             </div>
      </div>
  </section>
  <section class="eleven-service-section">
    <div class="container">
        <div class="row">
          <div class="eleven-service-text">
              <h1>Nos Services</h1>
              
            </div>
            <div class="eleven-service-list">
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
