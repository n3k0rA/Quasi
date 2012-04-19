//JQuery tabs + resizing for google maps
$(function() {
		$( "#tabs" ).tabs({
				        fx: { opacity: 'toggle' },
				        select: function(event, ui) {
				                jQuery(this).css('height', jQuery(this).height());
				                jQuery(this).css('overflow', 'hidden');
				        },
				        show: function(event, ui) {
				                jQuery(this).css('height', 'auto');
				                jQuery(this).css('overflow', 'visible');
				        }
								
				});
				$('#tabs').bind('tabsshow', function(event, ui) {
						    if (ui.panel.id == "tabs-4") {
						        google.maps.event.trigger(map, 'resize');
						    }
						});

});