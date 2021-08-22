/* global $*/

// クリックで表示
$(document).on('turbolinks:load', function(){
  $('#slideL').on('click',function(){
    if($('#slideL').hasClass('off')){
      $('#mask').removeClass('hidden');
      $('#slideL').removeClass('off');
      $('.template-task-container').animate({'marginLeft':'38rem'},300).addClass('on');
    }else{
      $('#slideL').addClass('off');
      $('#mask').addClass('hidden');
      $('.template-task-container').animate({'marginLeft':'0rem'},300);
    }
  });
});

// マスクをクリックしても閉じられる
$(document).on('turbolinks:load', function(){
  $('#mask').on('click',function(){
    $('#mask').addClass('hidden');
    $('#slideL').addClass('off');
    $('.template-task-container').animate({'marginLeft':'0rem'},300);
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

// コンテンツ内のテンプレ引用リンククリックでコンテンツを閉じる
$(document).on('turbolinks:load', function(){
  $('.t-task-card__link').on('click', function(){
    $('#mask').addClass('hidden');
    $('#slideL').addClass('off');
    $('.template-task-container').animate({'marginLeft':'0rem'},300);
  });
});