/* global $*/

// マスクをクリックしても閉じられる
$(document).on('turbolinks:load', function(){
  $('#mask-3').on('click',function(){
    document.getElementById('mask-3').classList.add('hidden');
    document.getElementById('slideL').classList.add('off');
    document.querySelector('.template-task-container').animate({marginLeft: '0rem'}, {duration: 300, fill: 'forwards'}, 300);
  });
});

// 左のコンテンツ用にウィンドウの高さを取得
$(document).ready(function(){
  fit();
  $(window).resize(function(){
    fit();
  })
  function fit(){
    var h = $(window).height();
    $('.slide-inner').css("height",h);
  }
});