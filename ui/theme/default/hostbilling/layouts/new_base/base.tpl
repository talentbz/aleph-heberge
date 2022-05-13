<!DOCTYPE html>
<html lang="zxx">
<head>
  <title>Aleph-Heberge</title>
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
</head>
<body >
<header>
  <nav class="navbar navbar-expand-lg">
    <div class="container">
      <a class="navbar-brand" href="index.html"><img src="{{APP_URL}}/ui/theme/default/assets/img/logo footer.png" alt=""></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"> <i class="fas fa-bars"></i></span>
    </button>
  
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav primary-menu">
        <li class="nav-item active">
          <a class="nav-link" href="index1.html">Accueil <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="3rd.html">No services</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="13th.html">Réservez votre domaine</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            WHOIS
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown" id="extra-color">
            <a class="dropdown-item" href="12th.html">WHOIS</a>
            <a class="dropdown-item" href="13th.html">VOTRE NOM DE DOMAINE</a>
            
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="14th.html">Astuces</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="18th.html">Contact</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            ESPACE CLIENT
          </a>
          <div class="dropdown-menu"  aria-labelledby="navbarDropdown" id="extra-color"> 
            <a class="dropdown-item" href="15th.html">ESPACE CLIENT</a>
            <a class="dropdown-item" href="16th.html">ESPACE CLIENT-1</a>
            <a class="dropdown-item" href="17th.html">ESPACE CLIENT-2</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="#"><img src="{{APP_URL}}/ui/theme/default/assets/img/icone LOGIN.png" alt=""></a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="#"><img style="width: 40px;" src="{{APP_URL}}/ui/theme/default/assets/img/icone_panier.svg" alt=""></a>
        </li>
      </ul>
      
    </div>
    </div>
  </nav>

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
            <img src="img/Groupe 1.png" alt="">
          </div>
        </div>
      </div>
    </div>
  </section>
</header>


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
          <li><img src="{{APP_URL}}/ui/theme/default/assets/img/Groupicone_serveur_dВdiВ_e 5.png" alt="">
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
          <option value="0">.com</option>
          <option value="1">.net</option>
          <option value="2">.org</option>
          <option value="2">.xyz</option>
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
                <li><a href="4th.html">VPS SSD</a></li>
                <li><a href="5th.html"> HÉBERGEMENT MUTUALISÉ</a></li>
                <li><a href="#">NFOGÉRANCE</a></li>
                <li><a href="6th.html"> INFOGÉRANCE SERVEUR</a></li>
                <li><a href="7th.html">VPS DISQUES HAUTES BACKUP CAPACITÉS (SSD BOOST)</a></li>
              </ul>
       
            </div>
          </div>
        </div>
    
      <div class="col-lg-3">
        <div class="third-first-item">
         
          <div class="footer-item">
            <ul>
              <li><a href="8th.html">MAINTENANCE</a></li>
              <li><a href="9th.html"> BUREAU WINDOWS VIRTUEL À DISTANCE</a></li>
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
</body>
</html>
