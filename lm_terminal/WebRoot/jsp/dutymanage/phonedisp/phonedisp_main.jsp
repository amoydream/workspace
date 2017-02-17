<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 10px;">
			<div>
				<a id="btn-unanswered" class="btn btn-default" href="dutymanage/phonedisp/main/unanswered">未接听电话</a>
				<a id="btn-answered" class="btn btn-default" href="dutymanage/phonedisp/main/answered">已接听电话</a>
				<a id="btn-called" class="btn btn-default" href="dutymanage/phonedisp/main/called">已拨打电话</a>
				<a id="btn-recent" class="btn btn-default" href="dutymanage/phonedisp/main/recent">最近通话记录</a>
				<a id="btn-organcontacts" class="btn btn-default" href="dutymanage/phonedisp/main/organcontacts">机构人员通讯录</a>
			</div>
			<p>
				<jsp:include page="/jsp/dutymanage/phonedisp/phonedisp_${dispatch}.jsp" />
			</p>
		</div>
	</div>
</body>
</html>
<script>
	$(function() {
	    $("#btn-${dispatch}").attr('class', 'btn btn-primary');
    });
</script>