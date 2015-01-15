$(function() {
  $('.alert-success').delay(5000).fadeOut();
  $('.alert-danger').delay(5000).fadeOut();

  $('.required-icon').tooltip({
    placement: 'left',
    title: 'Required field'
  });
});