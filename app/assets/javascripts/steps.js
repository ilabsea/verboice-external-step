$(function() {
  $('.prefix-setting .btn-collapse').on('click', function(e) {
    var $this = $(this);
    var $collapse = $this.closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');
    $('html, body').animate({
        scrollTop: $("#prefix-setting").offset().top
    }, 1000);
  });

  $('.global-setting .btn-collapse').on('click', function(e) {
    var $this = $(this);
    var $collapse = $this.closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');
    $('html, body').animate({
        scrollTop: $("#global-setting").offset().top
    }, 1000);
  });

  allowKeyInput($(".prefix-number"), /[0-9\,]/);

  var $projectId = $("#step_project_id");
  projectChanged($projectId);

  $('#project_variable_button').on('click', function() {
    $('.project_variable_form').removeClass('hide');
    $('.project_variable_view').addClass('hide');
  });

});
