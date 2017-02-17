<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<div class="container-fluid" style="margin-top: 15px; padding-left: 0px;">
		<div class="row-fluid">
			<jsp:include page="person_searchform.jsp">
				<jsp:param name="operationType" value="multiSel" />
			</jsp:include>
		</div>
	</div>
</body>
</html>
