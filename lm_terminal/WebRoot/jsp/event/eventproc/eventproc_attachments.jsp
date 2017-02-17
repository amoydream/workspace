<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>相关附件</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 10px;">
			<table class="table table-bordered">
				<tr>
					<th>原始文件名</th>
					<th>附件描述</th>
					<th>操作</th>
				</tr>
				<tbody id="attach_data">
					<c:forEach items="" var="entry">
					
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>