$(function(){ 
	$("#search .pagination a").live("click", function(){   //an ajax call for pagination 
		$.getScript(this.href);
		return false;
	});
	$('#events_search').submit(function () {    // an ajax call for search form
	    $.get(this.action, $(this).serialize(), null, 'script');
	    return false;
	  });

	
});


