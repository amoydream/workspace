<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%> 
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>提醒页面</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"
	type="text/css"></link>
<script src="js/jquery.min.js"></script>
<script src="lauvanUI/bootstrap/js/bootstrap.min.js"></script>
<body>

<script type="text/javascript" charset="utf-8">
parent.parent.$('#main-msg-show').html('${msg}');
parent.parent.$('#main_msgModal').modal('show');
parent.parent.$('#main_msgModal').on('hide.bs.modal', function () {
	parent.parent.window.location.reload();
});
</script>
</body>
</head>
</html>