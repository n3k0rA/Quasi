$(function () {
  $('#alert').click(function () {
    alert('Hello, world!');
    return false;
  })
});

$(function() {
	$('#tabs').tabs({
		event: "mouseover"
	});
});

$(function() {
		var availableTags = [
		"ActionScript",
		"AppleScript",
		"Asp",
		"BASIC",
		"C",
		"C++",
		"Clojure",
		"COBOL",
		"ColdFusion",
		"Erlang",
		"Fortran",
		"Groovy",
		"Haskell",
		"Java",
		"JavaScript",
		"Lisp",
		"Perl",
		"PHP",
		"Python",
		"Ruby",
		"Scala",
		"Scheme"
	];
	$( "#search_where" ).autocomplete({
		source: availableTags
	});
});