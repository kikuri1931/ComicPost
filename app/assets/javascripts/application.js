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
  // rooms/:idの時は下からスクロールそれ以外は上からスクロール
  if(document.URL.match('/rooms/*')) {
    $(window).scrollTop(document.body.scrollHeight);
  }
  else{
    $('html,body').animate({ scrollTop: 0 }, 0.1);
  }
  // rooms/:idの時は下からスクロールそれ以外は上からスクロール

  // タブメニュー
  $('#tab-contents .tab[id != "paid"]').hide();

  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
  // タブメニュー

  // 「無料会員」というタブを押したときの処理
  $('.free-link').click(function(event) {
    $("#paid-forms .tab").hide();
    var paid = document.getElementById('user_status_有料会員')
    paid.setAttribute("disabled","disabled");
    var free = document.getElementById('user_status_無料会員')
    free.removeAttribute("disabled","disabled");
    var postal_code = document.getElementById('user_postal_code')
    postal_code.removeAttribute("required","required");
    var address = document.getElementById('user_address')
    address.removeAttribute("required","required");
    var telephone_number = document.getElementById('user_telephone_number')
    telephone_number.removeAttribute("required","required");
  });
  // 「無料会員」というタブを押したときの処理

  // 「有料会員」というタブを押したときの処理
  $('.paid-link').click(function(event) {
    $("#paid-forms .tab").show();
    var paid = document.getElementById('user_status_有料会員')
    paid.removeAttribute("disabled","disabled");
    var free = document.getElementById('user_status_無料会員')
    free.setAttribute("disabled","disabled");
    var postal_code = document.getElementById('user_postal_code')
    postal_code.setAttribute("required","required");
    var address = document.getElementById('user_address')
    address.setAttribute("required","required");
    var telephone_number = document.getElementById('user_telephone_number')
    telephone_number.setAttribute("required","required");
  });
  // 「有料会員」というタブを押したときの処理

  // スライダー
  $('#slider').slick({
    dots: true,
    rtl: true, 
    autoplaySpeed: 4000, 
  });
  // スライダー

  // ハンバーガーメニュー
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
  // ハンバーガーメニュー

  // 画像投稿プレビュー
  $('#picture_picture_images_images').on('change', function (e) {
    let images_count = $(".upload_image").length ;
    let uploaded_image_count =$(".uploaded_image").length;
    for (let i =0; i < images_count; i++){
      $(".upload_image").first().remove();
    };
    for(let i =0; i < e.target.files.length; i++){
       var reader = new FileReader();
       reader.onload = function(e){
         $("#preview").append(`<img class='upload_image' src=${e.target.result}>`);
       }
       reader.readAsDataURL(e.target.files[i]);
    }
    if (e.target.files.length == 0){
      $(".uploaded_image").each(function(index,element){
        $(element).show();
      });
    }else{
      $(".uploaded_image").each(function(index,element){
        $(element).hide();
      });
    }
  });
  // 画像投稿プレビュー

  //  iosの場合、selectのoptionが長いとき、省略されることを防ぐ。
  $(function() {
    $('select').append('<optgroup label=""></optgroup>');
  });
  //  iosの場合、selectのoptionが長いとき、省略されることを防ぐ。
});
