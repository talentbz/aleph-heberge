$(document).ready(function(){
    $('.col-lg-4').addClass("responsive")
   
    //add class in header section
    var path = window.location.pathname.split("/").pop();
    console.log(path);
    if(path !== 'home'){
        $('header').addClass('third-header');
    }

});

$(function() { // Dropdown toggle
    $('.dropdown-toggle').click(function() { 
        $(this).next('.dropdown-menu').slideToggle();
    });
    
    $('.navbar-toggler').click(function() { 
        $(this).next('.navbar-collapse').slideToggle();
    });

    $(document).click(function(e) { 
        var target = e.target; 
        if (!$(target).is('.dropdown-toggle') && !$(target).parents().is('.dropdown-toggle')) { 
            $('.dropdown-menu').slideUp(); 
        }
    });
});