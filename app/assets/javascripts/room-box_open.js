/* global $*/

$(document).on('turbolinks:load', function(){
  $('.main-top__room-unit__head').on('click',function(){
    $('.room-box').slideToggle();
  });
});
