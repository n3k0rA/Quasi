var clicked = 0
function selectAll(){
	if(clicked==0){
 		$("input:checkbox").each(function(){	
  		$(this).attr('checked', true);
 		});
		clicked=1;
 		return false;
	}
	else {
		$("input:checkbox").each(function(){	
  		$(this).attr('checked', false);
 		});
		clicked=0;
 		return false;
	}
}

