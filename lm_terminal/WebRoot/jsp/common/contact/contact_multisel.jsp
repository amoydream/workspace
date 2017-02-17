<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>选择机构人员</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
	<div class="container-fluid" style="margin-top: 10px; padding-left: 0px;">
		<div class="row-fluid">
			<jsp:include page="contact_search.jsp">
				<jsp:param name="operationType" value="multisel" />
			</jsp:include>
		</div>
	</div>
</body>
</html>
