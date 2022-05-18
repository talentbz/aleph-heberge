<!DOCTYPE html>
<html lang="zxx">
<head>
  <title>{$_title}</title>
  <meta charset="utf-8">
  <link rel="icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-32','icon-32x32.png')}" sizes="32x32" />
  <link rel="icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-192','icon-192x192.png')}" sizes="192x192" />
  <link rel="apple-touch-icon" href="{{APP_URL}}/storage/system/{get_or_default($config,'icon-180','icon-180x180.png')}" />
  <meta name="msapplication-TileImage" content="{{APP_URL}}/storage/system/{get_or_default($config,'icon-270','icon-270x270.png')}" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script>
      const cloudonex_csrf_token = '{csrf_token()}';
  </script>
  <!-- owl carousel css --> 
  <link rel="stylesheet" href="{{APP_URL}}/ui/theme/default/assets/css/owl.carousel.min.css"> 
  <!-- font awesome icons --> 
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
  <!-- bootstrap css --> 
  <link rel="stylesheet" href="{{APP_URL}}/ui/theme/default/assets/css/bootstrap.min.css"> 
  <!-- main css -->
  <link rel="stylesheet" href="{{APP_URL}}/ui/theme/default/assets/css/style.css">
  <link rel="stylesheet" href="{{APP_URL}}/ui/theme/default/assets/css/responsive_fixed.css">
  <!-- add old script -->
  <script>
    var base_url = '{$_url}';
    var block_msg = '<div class="md-preloader text-center"><svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="32" width="32" viewbox="0 0 75 75"><circle cx="37.5" cy="37.5" r="33.5" stroke-width="6"/></svg></div>';
  </script>
  <script>
      window.clx = {
          base_url: '{$_url}',
          i18n: {
              yes: '{$_L['Yes']}',
              no: '{$_L['No']}',
              are_you_sure: '{$_L['are_you_sure']}'
          },
          theme_options: false,
      };
      var _L = [];
      _L['Save'] = '{$_L['Save']}';
      _L['Submit'] = '{$_L['Submit']}';
      _L['Loading'] = '{$_L['Loading']}';
      _L['OK'] = '{$_L['OK']}';
      _L['Cancel'] = '{$_L['Cancel']}';
      _L['Close'] = '{$_L['Close']}';
      _L['are_you_sure'] = '{$_L['are_you_sure']}';
      _L['Saved Successfully'] = '{$_L['Saved Successfully']}';
      _L['Empty'] = '{$_L['Empty']}';
  </script>
</head>
<body >
<header>
  <nav class="navbar navbar-expand-lg">
    <div class="container">
      <a class="navbar-brand" href="{$_url}client/"><img src="{{APP_URL}}/ui/theme/default/assets/img/logo footer.png" alt=""></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"> <i class="fas fa-bars"></i></span>
    </button>
  
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav primary-menu">
        <li class="nav-item active">
          <a class="nav-link" href="{$_url}client/">Accueil <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Nos services</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="{$_url}client/domain-register/">Réservez votre domaine</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="javscript:void(0)" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            WHOIS
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown" id="extra-color">
            <a class="dropdown-item" href="{$_url}client/whois/">WHOIS</a>
            <a class="dropdown-item" href="13th.html">VOTRE NOM DE DOMAINE</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="{$_url}client/kb/">Astuces</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/contact">Contact</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            ESPACE CLIENT
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown" id="extra-color"> 
            <a class="dropdown-item" href="{$_url}client/login/">ESPACE CLIENT</a>
            <a class="dropdown-item" href="{$_url}client/login/">Login</a>
            <a class="dropdown-item" href="{$_url}client/register/">Inscription</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="{$_url}client/login/"><img src="https://test.aleph-heberge.fr/ui/theme/default/assets/img/icone LOGIN.png" alt=""></a>
        </li>
        
        <li class="nav-item">
          {if $shopping_cart && $shopping_cart->items_count}
          <a class="nav-link" href="{$base_url}client/checkout/">
            <img style="width: 40px;" src="https://test.aleph-heberge.fr/ui/theme/default/assets/img/icone_panier.svg" alt="">
            <span class="badge badge-icon custom-badge">{$shopping_cart->items_count}</span>
          </a>
          {/if}
        </li>
      </ul>
      
    </div>
    </div>
  </nav>
  {block name="head"}{/block}
</header>

  {block name="new_content"}{/block}
<script>
    'use strict';

    var classHolder = document.getElementsByTagName("BODY")[0],
        themeSettings = (localStorage.getItem('themeSettings')) ? JSON.parse(localStorage.getItem('themeSettings')) :
            { },
        themeURL = themeSettings.themeURL || '',
        themeOptions = themeSettings.themeOptions || '';
    if (themeSettings.themeOptions)
    {
        classHolder.className = themeSettings.themeOptions;
    }
    else
    {
    }
    var saveSettings = function()
    {
        themeSettings.themeOptions = String(classHolder.className).split(/[^\w-]+/).filter(function(item)
        {
            return /^(nav|header|footer|mod|display)-/i.test(item);
        }).join(' ');
        localStorage.setItem('themeSettings', JSON.stringify(themeSettings));
    }
    var resetSettings = function()
    {
        localStorage.setItem("themeSettings", "");
    }

</script>
<input type="hidden" id="_url" name="_url" value="{$_url}">
<input type="hidden" id="_df" name="_df" value="{$config['df']}">
<footer>
  <div class="container">
    <div class="row justify-content-center">
      <div class="footer-info">
       <div class="col-lg-3">
        <div class="footer-first-item">
          <div class="footer-logo">
            <img src="{{APP_URL}}/ui/theme/default/assets/img/logo footer.png" alt="">
          </div>
          <div class="footer-item">
            <ul>
              <li><a href="#"1 rue rogozine Ashdod - Israël >1 rue rogozine Ashdod - Israël</a></li>
              <li><a href="#">Téléphone: 01 77 47 27 08 </a></li>
              <li><a href="">Mail: contact@aleph-hosting.com</a></li>
            </ul>
    
          </div>
        </div>
       </div>
        <div class="col-lg-3">
          <div class="second-first-item">
            <div class="footer-logo">
              <a href="#">NOS SERVICES</a>
            </div>
            <div class="footer-item">
              <ul>
                {if count($groups)}
                  {foreach $groups as $group}
                    <li><a href="{$base_url}client/items/{$group->slug}/">{$group->name}</a></li>
                  {/foreach}
                {/if}
                <!-- <li><a href="{$_url}/client/items/vps/"> HÉBERGEMENT MUTUALISÉ</a></li>
                <li><a href="{$_url}/client/items/vps/">NFOGÉRANCE</a></li>
                <li><a href="{$_url}/client/items/vps/"> INFOGÉRANCE SERVEUR</a></li>
                <li><a href="{$_url}/client/items/vps/">VPS DISQUES HAUTES BACKUP CAPACITÉS (SSD BOOST)</a></li> -->
              </ul>
       
            </div>
          </div>
        </div>
    
      <div class="col-lg-3">
        <div class="third-first-item">
         
          <div class="footer-item">
            <ul>
              <li><a href="{$_url}/client/items/vps/">MAINTENANCE</a></li>
              <li><a href="{$_url}/client/items/vps/"> BUREAU WINDOWS VIRTUEL À DISTANCE</a></li>
              <li><a href="10th.html">BACKUP PLAN</a></li>
              <li><a href="11th.html">VO IP</a></li>
     
            </ul>
     
          </div>
        </div>
      </div>
    
     <div class="col-lg-3">
      <div class="forth-first-item">
         
        <div class="footer-item">
          <ul class="social-">
            <li><a href="#"><img src="img/icone facebook.svg" alt=""></a></li>
            <li><a href="#"><img src="img/icone twitter.svg" alt=""></a></li>
           
   
          </ul>
   
        </div>
      </div>
     </div>
      
      </div>
     
     <div class="copyright-text">
       <p style="color: #FFFFFF80;">Copyright © 2022 ALEPH HEBERGE - Tous droits réservés</p>
       <p style="color: #FFFFFF;">Conditions générales de ventes | Politique de Remboursement | Site Map</p>
     </div>
    </div>
  </div>
</footer>
<!-- jquery js -->
<script src="{{APP_URL}}/ui/theme/default/assets/js/jquery-3.5.1.min.js"></script>
<script src="{{APP_URL}}/ui/theme/default/assets/js/jquery.min.js"></script>
<!-- bootstrap js -->
<script src="{{APP_URL}}/ui/theme/default/assets/js/bootstrap.min.js"></script>
<script src="{{APP_URL}}/ui/theme/default/assets/js/popper.min.js"></script>

<!-- main js -->
<script src="{{APP_URL}}/ui/theme/default/assets/js/main.js"></script>

<!-- add old script -->
{if APP_STAGE == 'Dev'}
    <script src="{{APP_URL}}/ui/theme/default/js/app.min.js?v={_raid()}"></script>
    <script src="{{APP_URL}}/ui/lib/ray.js?v=3"></script>
{else}
    <script src="{{APP_URL}}/ui/theme/default/js/app.min.js"></script>
{/if}
{if isset($config['footer_scripts'])}
    {$config['footer_scripts']}
{/if}

{block name="script"}{/block}
</body>
</html>
