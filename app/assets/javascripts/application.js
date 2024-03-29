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
//= require activestorage
//= require underscore
//= require gmaps/google
//= require turbolinks
//= require chartkick
//= require Chart.bundle
//= require jquery
//= require bootstrap
//= require rails-ujs

//プレビュー
function PostPreview() {
  var preview = document.querySelector('.img-preview');
  var file    = document.querySelector('#img').files[0];
  var reader  = new FileReader();
  reader.addEventListener("load", function () {
    preview.src = reader.result;
  }, false);

  if (file) {
    reader.readAsDataURL(file);
  }
}


function previewFile() {
  var preview = document.querySelector('.img-preview');
  var file    = document.querySelector('#profile').files[0];
  var reader  = new FileReader();
  reader.addEventListener("load", function () {
    preview.src = reader.result;
  }, false);

  if (file) {
    reader.readAsDataURL(file);
  }
}

function previewFile2() {
  var preview2 = document.querySelector('.img-preview2');
  var file    = document.querySelector('#bg').files[0];
  var reader  = new FileReader();

  reader.addEventListener("load", function () {
    preview2.src = reader.result;
  }, false);

  if (file) {
    reader.readAsDataURL(file);
  }
}


//フラッシュ

 $(function() {
 var h = $(window).height();
   $('#contents').css('display','none');
   $('#loading').height(h).css('display','block');
 });
 
 $(window).load(function () {
    $('#loading').delay(0).fadeOut(0);
    $('#contents').delay(0).queue(function(){
     $(this).css('display', 'block');
 });
 });
 $(function(){
   setTimeout('stopload()',500);
 });
 

//トップページのアニメーション
$(function(){
    $(window).scroll(function (){
        $('.fadein').each(function(){
            var position = $(this).offset().top;
            var scroll = $(window).scrollTop();
            var windowHeight = $(window).height();
            if (scroll > position - windowHeight + 200){
              $(this).addClass('active');
            }
        });
    });
});

$(function(){
    $(window).scroll(function (){
        $('.fadein-left').each(function(){
            var position = $(this).offset().top;
            var scroll = $(window).scrollTop();
            var windowHeight = $(window).height();
            if (scroll > position - windowHeight + 200){
              $(this).addClass('active');
            }
        });
    });
});


$(function(){
  var pagetop = $('#pagetop');
  // ボタン非表示
  pagetop.hide();

  // 100px スクロールしたらボタン表示
  $(window).scroll(function () {
     if ($(this).scrollTop() > 100) {
          pagetop.fadeIn();
     } else {
          pagetop.fadeOut();
     }
  });
  pagetop.click(function () {
     $('body, html').animate({ scrollTop: 0 }, 500);
     return false;
  });
});