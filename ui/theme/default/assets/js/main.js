$(document).ready(function(){
    $('.col-lg-4').addClass("responsive")
    // $('.dropdown').on('click', function(){
    //     // alert(0)
    //     $(this).find('.dropdown-menu').toggleClass('show');
    //     // console.log($(this).find('.dropdown-menu'));
    // })

    // $('.dropdown-toggle').on('click', function(){
    //     let that = $(this);
    //     that.closest('.dropdown').find('.dropdown-menu');
    //     console.log(that.closest('.dropdown').find('.dropdown-menu'))
    // })
   
});

$(function() { // Dropdown toggle
    $('.dropdown-toggle').click(function() { 
        $(this).next('.dropdown-menu').slideToggle();
        // $('.navbar-toggler').click(function() { $(this).next('.navbar-collapse').slideToggle();
    });
    
    $('.navbar-toggler').click(function() { 
        $(this).next('.navbar-collapse').slideToggle();
        // $('.navbar-toggler').click(function() { $(this).next('.navbar-collapse').slideToggle();
    });

    $(document).click(function(e) { 
        var target = e.target; 
        if (!$(target).is('.dropdown-toggle') && !$(target).parents().is('.dropdown-toggle')) { 
            $('.dropdown-menu').slideUp(); 
        }
    });
});