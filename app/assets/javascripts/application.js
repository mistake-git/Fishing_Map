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
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require underscore
//= require gmaps/google
//= require chartkick
//= require Chart.bundle
//= require chartkick
//= require Chart.bundle
//= require jquery
//= require jquery_ujs
//= require bootstrap

function previewFile() {
  var preview = document.querySelector('.img-preview');
  var file    = document.querySelector('input[type=file]').files[0];
  var reader  = new FileReader();

  reader.addEventListener("load", function () {
    preview.src = reader.result;
  }, false);

  if (file) {
    reader.readAsDataURL(file);
  }
}

$(function() {
  var h = $(window).height();
  $('.contents').css('display','none');
  $('#loading').height(h).css('display','block');
});
  
$(window).on('load',function () {
  $('#loading').css('display','none');
  $('#contens').css('display', 'block');
});
  
$(function(){
  setTimeout('stopload()',8000);
});
function stopload(){ 
  $('#contens').css('display','block');
  $('#loading').css('display','none');
}

 $(function(){
  setTimeout("$('.flash').fadeOut('slow')", 10000) 
 })
