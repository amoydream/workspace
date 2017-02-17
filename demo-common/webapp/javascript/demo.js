$(function() {
	$("#btnGetTm").on("click", function() {
		alert(new Date());
	});

	$("#btnShow").on("click", function() {
		$("#divBlock").show(200);
	});

	$("#btnHide").on("click", function() {
		$("#divBlock").hide(200);
	});
});