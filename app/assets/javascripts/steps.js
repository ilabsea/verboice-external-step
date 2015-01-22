$(function() {
  $('.prefix-setting .btn-collapse').on('click', function(e) {
    var $this = $(this);
    var $collapse = $this.closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');
    $('html, body').animate({
        scrollTop: $("#prefix-setting").offset().top
    }, 1000);
	});

  allowKeyInput($(".prefix-number"), /[0-9\,]/);

});
