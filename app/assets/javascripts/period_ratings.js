$(function() {
	$('.datepicker').datepicker({format: 'dd/mm/yyyy'});

	$('.datepicker').on('changeDate', function(ev){
    $(this).datepicker('hide');
	});

	allowKeyInput($(".datepicker"), /[0-9\/]/);
	allowKeyInput($(".period-rating-code"), /[0-9]/);

});