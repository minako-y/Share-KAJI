/* global $*/

$(document).on('turbolinks:load', function(){
  $('.main-container__room-unit__head').on('click',function(){
    $('.room-box').slideToggle();
  });
});
