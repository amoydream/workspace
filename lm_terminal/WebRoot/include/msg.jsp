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
<meta http-equiv="X-UA-Compatible" content="IE=9">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<body>

<script type="text/javascript" charset="utf-8">

parent.layer.msg('${msg}', {
    offset: 0,
    shift: 6
});
parent.layer.closeAll('iframe');
</script>
</body>
</head>
</html>