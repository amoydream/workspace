<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>日志管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<style type="text/css">
td, th{ text-align:center;}
.mytable {
	table-layout: fixed;
	width: 98% border:0px;
	margin: 0px;
}

.mytable tr td {
	text-overflow: ellipsis; /* for IE */
	-moz-text-overflow: ellipsis; /* for Firefox,mozilla */
	overflow: hidden;
	white-space: nowrap;
	border: 1px solid;
	text-align: left
}
</style>
<script type="text/javascript">
	function topage(page) {
		var form = document.forms[1];
		form.page.value = page;
		form.submit();
	}
</script>

</head>
<body>
	<div style="margin-top: 15px;">
		<form class="form-inline" action="system/sysloginfo/list"
			method="post">
			<input type="hidden" name="query" value="true" />
			<div class="form-group">
				<label for="us_Name">日志选择</label> <input type="radio" name="lo_Type"
					class="form-control" value="0"
					<c:if test="${lo_Type=='0' }">checked="checked"</c:if>>请求 <input
					type="radio" name="lo_Type" class="form-control" value="1"
					<c:if test="${lo_Type=='1' }">checked="checked"</c:if>>异常
			</div>
			<button type="submit" class="btn btn-default"><i class="icon-search"></i>搜索</button>
		</form>

		<form id="eventsForm" action="system/sysloginfo/list" method="post">
			<input type="hidden" name="page" value="${page }" /> <input
				type="hidden" name="query" value="${query }" /> <input type="hidden"
				name="lo_Type" value="${lo_Type }" />
			<table
				class="mytable table table-bordered table-striped table-hover table-condensed">
				<tr class="info">
					<th>操作用户</th>
					<th>操作时间</th>
					<th>事务描述</th>
					<th>类型</th>
					<th>请求方法</th>
					<th>异常代码</th>
					<th>异常信息</th>
				</tr>

				<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
					<c:choose>
						<c:when test="${statu.index % 2 ==0}">
							<tr style="background-color: #ebf8ff;">
								<td>${entry.lo_Username}</td>
								<td>${entry.lo_Uptime}</td>
								<td>${entry.lo_Describe }</td>
								<td>${entry.lo_Type }</td>
								<td title="${entry.lo_Method}">${entry.lo_Method}</td>
								<td title="${entry.lo_Exceptioncode}">${entry.lo_Exceptioncode}</td>
								<td title="${entry.lo_Exceptiondetail}">${entry.lo_Exceptiondetail}</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td>${entry.lo_Username}</td>
								<td>${entry.lo_Uptime}</td>
								<td>${entry.lo_Describe }</td>
								<td>${entry.lo_Type }</td>
								<td title="${entry.lo_Method}">${entry.lo_Method}</td>
								<td title="${entry.lo_Exceptioncode}">${entry.lo_Exceptioncode}</td>
								<td title="${entry.lo_Exceptiondetail}">${entry.lo_Exceptiondetail}</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<tr>
					<th scope="col" colspan="7"><%@ include
							file="/include/fenye2.jsp"%></th>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>