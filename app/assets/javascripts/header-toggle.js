function hamburger(){
  document.getElementById('nav').classList.toggle('nav-in');
}

document.addEventListener("turbolinks:load",function(){
  document.getElementById('hamburger-icon').addEventListener('click', function(){
    hamburger();
  });
});
