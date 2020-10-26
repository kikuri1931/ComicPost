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
//= require bootstrap-sprockets
//= require_tree .

$(document).ready( function(){
  if(document.URL.match('/rooms/*')) {
    $(window).scrollTop(document.body.scrollHeight);
  }
  else{
    $('html,body').animate({ scrollTop: 0 }, 0.1);
  }

  $('#tab-contents .tab[id != "paid"]').hide();

  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });

  $('.free-link').click(function(event) {
    $("#paid-forms .tab").hide();
    var postal_code = document.getElementById('user_postal_code')
    postal_code.removeAttribute("required","required");
    var address = document.getElementById('user_address')
    address.removeAttribute("required","required");
    var telephone_number = document.getElementById('user_telephone_number')
    telephone_number.removeAttribute("required","required");
  });

  $('.paid-link').click(function(event) {
    $("#paid-forms .tab").show();
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
