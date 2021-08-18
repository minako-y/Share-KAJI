/* global $*/

$(function() {
  $('.notice, .alert').hide().fadeIn('slow');
  setTimeout("$('.notice, .alert').fadeOut('slow')", 2000);
});
