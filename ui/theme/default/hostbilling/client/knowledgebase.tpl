{extends file="hostbilling/layouts/new_base/base.tpl"}
{block name="new_content"}
<section class="whois">
      <div class="container">
          <div class="row">
              <div class="col-lg-12">
                <div class="eleven-banner-main-info d-flex">
                    <div class="eleven-bannaer-img">
                        <img src="{{APP_URL}}/ui/theme/default/assets/img/image astuce (1).svg" alt="">
                      </div>
                      <div class="eleven-bannner-heading">
                        <h1>ASTUCES</h1>
                      </div>
                  </div>
              </div>
          </div>
      </div>
  </section>
  
  <section class="code-section">
    <div class="container">
     <div class="row">
         <div class="col-lg-12">
            <div class="code-inner">
               <div class="card mx-auto" style="width: 800px; background:transparent; border:none; box-shadow:none">
                    <div class="card-body">

                        <h1 class="text-center"> {$_L['Articles']} </h1>

                        {foreach $knowledgebases_group_relations as $key => $value}

                            {if !empty($knowledgebases_groups[$key])}
                                <h2 class="my-3">{$knowledgebases_groups[$key]->gname}</h2>

                                {foreach $value as $kb_relation}
                                    {if !empty($knowledgebases[$kb_relation->kbid])}
                                        <p>
                                            <a href="{$base_url}client/view-article/{$kb_relation->kbid}/"><strong>{$knowledgebases[$kb_relation->kbid]->title}</strong></a>
                                        </p>
                                    {/if}
                                {/foreach}

                            {/if}

                        {/foreach}
                    </div>
                </div>
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
<!-- <main id="clx-page-content" role="main" class="page-content">
    <div class="card mx-auto" style="width: 800px">


        <div class="card-body">

            <h1 class="text-center"> {$_L['Articles']} </h1>

            {foreach $knowledgebases_group_relations as $key => $value}

                {if !empty($knowledgebases_groups[$key])}
                    <h2 class="my-3">{$knowledgebases_groups[$key]->gname}</h2>

                    {foreach $value as $kb_relation}
                        {if !empty($knowledgebases[$kb_relation->kbid])}
                            <p>
                                <a href="{$base_url}client/view-article/{$kb_relation->kbid}/"><strong>{$knowledgebases[$kb_relation->kbid]->title}</strong></a>
                            </p>
                        {/if}
                    {/foreach}

                {/if}

            {/foreach}





        </div>
    </div>
</main> -->

{/block}

