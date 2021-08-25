/*global $*/

$(document).on('turbolinks:load', function(){
  $('.monsters-container__title--slide').on('click', function(){
    $('#new-monster-form').slideToggle();
  });
});