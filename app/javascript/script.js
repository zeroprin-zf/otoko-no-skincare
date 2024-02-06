document.addEventListener("turbolinks:load", function(){
  showSlides();
});

let slideIndex = 0;
function showSlides() {
  const slides = document.querySelectorAll(".slide.fade");

  if (slides.length > 0) {
    slideIndex++;

    if(slideIndex > slides.length){
      slideIndex = 1;
    }

    slides[slideIndex - 1].style.opacity = "1";

    slides[slideIndex - 2 < 0 ? slides.length - 1 : slideIndex - 2].style.opacity = "0";

    setTimeout(showSlides, 6000);
  }
}

$(function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});