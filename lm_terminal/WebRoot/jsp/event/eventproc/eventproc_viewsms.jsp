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
<title>发送短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
	<div class="row"
		style="padding-left: 10px; padding-right: 15px; padding-top: 5px; margin-left: 0px; margin-right: 10px;">
		<div style="margin-bottom: 15px;">
			<form id="smsForm" action="" method="post">
				<div class="form-group">
					<label for="us_Name">接收人</label>
					<span id="sp_pe_id_arr"></span>
					<input type="text" id="us_Name" name="us_Name" class="form-control"
						value="${eventProcess.t_user_info.us_Name}(${eventProcess.t_user_info.us_Mophone})"
						readonly="readonly">
				</div>
				<div class="form-group">
					<label for="pr_content">短信内容</label>
					<textarea rows="10" id="pr_content" name="pr_content" readonly="readonly"
						class="form-control">${eventProcess.pr_content}</textarea>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
