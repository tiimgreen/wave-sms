$('.page-scroll').on('click', function(e) {
  e.preventDefault();

  $('html, body').animate({
    scrollTop: $($(this).attr("href")).top
  }, 1500);
})
