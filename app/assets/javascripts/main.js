$(document).ready( function(){
  'use strict';
  $('nav[role="navigation"]').on('shown.bs.collapse',function(){
    $('#dropdownMenu1').trigger('click');
  });

  $('.modal').on('show.bs.modal', function() {
    $('.flash-messages .alert').alert('close');
  });
  $(document).on('focus','.dropdown input',function(){
  	if($(this).parent().hasClass('open')){
  		$(this).parent().removeClass('open');
  	}
  	else{
  		$(this).parent().addClass('open');	
  	}
  });
  	$('body').on('click', function (e) {
	    if (!$('div.dropdown').is(e.target) 
	        && $('div.dropdown').has(e.target).length === 0 
	        && $('div.open').has(e.target).length === 0
	    ) {
	        $('div.dropdown').removeClass('open');
	    }
	});
});