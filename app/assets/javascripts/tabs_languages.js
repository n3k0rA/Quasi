$(function() {
	$( "#tabs" ).tabs({
		event: "mouseover"
	});
});

$(function() {
	$("#message").click(function() {
		alert("Hola!!!");
		return false;
	})
});