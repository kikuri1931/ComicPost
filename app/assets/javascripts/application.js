// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

document.addEventListener("turbolinks:load", function(){
  $('html,body').animate({ scrollTop: 0 }, 0.1);
  $('#tab-contents .tab[id != "tab1"]').hide();

  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });

  $('.tab-link2').click(function(event) {
    $("#forms .tab").hide();
    var postal_code = document.getElementById('user_postal_code')
    postal_code.removeAttribute("required","required");
    var address = document.getElementById('user_address')
    address.removeAttribute("required","required");
    var telephone_number = document.getElementById('user_telephone_number')
    telephone_number.removeAttribute("required","required");
  });

  $('.tab-link1').click(function(event) {
    $("#forms .tab").show();
    var postal_code = document.getElementById('user_postal_code')
    postal_code.setAttribute("required","required");
    var address = document.getElementById('user_address')
    address.setAttribute("required","required");
    var telephone_number = document.getElementById('user_telephone_number')
    telephone_number.setAttribute("required","required");
  });
  
  $('#slider').slick({
        dots: true,
        rtl: true, 
      autoplaySpeed: 4000, 
    });
     $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});

