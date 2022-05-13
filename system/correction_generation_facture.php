<?php

//correction generation des factures payee en auto ou en retard.


//$query = "SELECT * FROM `sys_invoices` where `r` LIKE '+1 month'";
//$result = mysqli_query($mysqli, $query);


function met_a_jour_date_next_due(){
	$today = date("Y-m-d");
        $mois_dernier = date('Y-m-d', strtotime($today. ' - 1 month')); 	
	
	$prochaine_date_facture =$today;
	$id=mysqli_connect("localhost","alepheberge","!4jClj24","alepheberge");
	$requete = "UPDATE sys_invoices set nd ='$prochaine_date_facture' where nd ='$mois_dernier' and  `r` LIKE '+1 month' ";
	echo $requete;
	mysqli_query($id, $requete);
	//execution.
}


met_a_jour_date_next_due();



