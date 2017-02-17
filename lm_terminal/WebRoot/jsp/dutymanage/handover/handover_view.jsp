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
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
</head>
<body>
	<div class="row"
		style="padding-left: 20px; padding-right: 20px; padding-top: 10px; margin-left: 0px; margin-right: 10px;">
		<div style="margin-bottom: 20px;">
			<form class="form-inline" action="dutymanage/smsdisp/read" method="post">
				<div class="form-group">
					<label for="us_Name">交班人</label>
					<input type="text" id="us_Name" name="us_Name" class="form-control" placeholder="交班人"
						value="${sessionScope.userVo.us_Name}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="pe_name">接班人</label>
					<input type="tel" id="pe_name" name="pe_name" class="form-control" placeholder="点击选择接班人"
						value="" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="ho_date">交班日期</label>
					<input type="tel" id="ho_date" name="ho_date" class="form-control" placeholder="交班日期"
						value="2015-12-17">
				</div>
				<p>
				<div class="form-group">
					<label for="ho_remarks">备注</label>
					<textarea rows="5" cols="100" class="form-control" name="ho_remarks" placeholder="交班备注"></textarea>
				</div>
			</form>
		</div>
		<p>
			<b>每日值班情况</b>
		<p>
		<p>市委、市政府值班室 2015年12月02日17时-09月03日12时</p>
		一、接到信息
		<br>
		1、林铁同志联系送件。
		<br>
		2、市委一周行程
		<br>
		3、取文件
		<br>
		4、林铁同志致电未接，回电。
		<br>
		5、粤LHY632预计于今日下午3点半到4点钟进大院见书记，请武警放行。
		<br>
		6、各位领导：接大门传达室报，惠城区海燕制衣厂约50名工人因工资问题在行政中心大门口上访。已通知信访和公安部门到场处置。特此报告。
		<br>
		7、各位领导：接大门传达室报，惠城区海燕制衣厂约50名工人因工资问题在行政中心大门口上访。已通知信访和公安部门到场处置。特此报告。
		<br>
		8、天气报告
		<br>
		二、交接跟踪事项
		<br>
		1、无
		<p></p>
	</div>
</body>
</html>
