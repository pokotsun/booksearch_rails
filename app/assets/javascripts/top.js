// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$arrows = $('#arrows');
var slider_array = ['.ranking', '.never-read', '.ever-read'];


$(function(){
  $.each(slider_array, function(index, elem) {
    console.log(elem);

    var $slider = $(elem + '-slider').slick({
      // dots:true,
      appendArrows: $arrows,
      infinite: true,
      autoplay: true,
      autoplaySpeed:3500,
      arrows: true,
      slidesToShow:5,
      slidesToScroll:1,
      responsive: [{
        breakpoint: 768,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2,
        }
      },{
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        }
      }
    ]
  });
  $(elem + '-slider-next').on('click', function () {
    $slider.slick("slickNext");
  });
  $(elem + '-slider-prev').on('click', function () {
    $slider.slick("slickPrev");
  });
});
});
