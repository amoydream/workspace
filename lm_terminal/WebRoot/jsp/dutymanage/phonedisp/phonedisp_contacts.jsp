<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>电话调度</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp" />
</head>
<body>
	<div class="container-fluid" style="margin-top: 10px; padding-left: 0px;">
		<div class="row-fluid">
			<jsp:include page="/jsp/common/contact/contact_search.jsp">
				<jsp:param name="operationType" value="callout" />
			</jsp:include>
		</div>
	</div>
</body>
</html>