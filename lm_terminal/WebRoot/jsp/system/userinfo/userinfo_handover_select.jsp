<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>用户管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
function topage(page){
	var form = document.forms[1];
	form.page.value=page;
	form.submit();
}
function selectUsers(index, window){
	var sulist = $("input[name='users_selected']:checked").val().split(",");
	window.$("#us_Overid").val(sulist[0]);
	window.$("#us_OverName").val(sulist[1]);
	window.$('#handover_addform').data('bootstrapValidator').updateStatus('us_OverName', 'NOT_VALIDATED', null);
	parent.layer.close(index);
}
</script>
</head>
<body>
<div style="margin-top: 15px;">
<div style="margin-bottom: 10px;">
<form class="form-inline" action="system/userinfo/handoverList" method="post">
<input type="hidden" name="query" value="true"/>
  <div class="form-group">
    <label for="us_Name">姓名</label>
    <input type="text" name="us_Name" class="form-control" id="us_Name" value="${userInfoVo.us_Name }" placeholder="输入姓名">
  </div>
  <div class="form-group">
    <label for="us_Mophone">手机</label>
    <input type="email" name="us_Mophone" class="form-control" id="us_Mophone" value="${userInfoVo.us_Mophone }" placeholder="输入手机号">
  </div>
  <button type="submit" class="btn btn-default">搜索</button>
  
  <lauvanpt:permission privilege="userAdd">
  <button type="button" class="btn btn-primary" onclick="user_addUI();">添加</button>
  </lauvanpt:permission>
</form>
</div>
<form id="eventsForm" action="system/userinfo/handoverList" method="post">
<input type="hidden" name="page" value="${page }"/>
<input type="hidden" name="query" value="${query }"/>
<input type="hidden" name="us_Name" value="${userInfoVo.us_Name }"/>
<input type="hidden" name="us_Mophone" value="${userInfoVo.us_Mophone }"/>
		<table class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th style="text-align:center">用户名</th>
				<th style="text-align:center">姓名</th>
				<th style="text-align:center">性别</th>
				<th style="text-align:center">坐席</th>
				<th style="text-align:center">状态</th>
				<th style="text-align:center">操作</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
			<c:choose>
			<c:when test="${statu.index % 2 ==0}">
			<tr style="background-color: #ebf8ff;"  id="remove_user${entry.us_Id}">
					<td style="text-align:center">${entry.us_Code}</td>
					<td style="text-align:center">${entry.us_Name}</td>
					<td style="text-align:center">
					<c:if test="${entry.us_Sex=='M' }">男</c:if>
					<c:if test="${entry.us_Sex=='F' }">女</c:if>
					</td>
					<td style="text-align:center">${entry.voice}</td>
					<td style="text-align:center">
					<c:if test="${entry.us_State=='1' }">启用</c:if>
					<c:if test="${entry.us_State=='0' }">停用</c:if>
					</td>
					<td style="text-align:center">
					<input type="radio" name="users_selected" value="${entry.us_Id},${entry.us_Name}"/>
					</td>
				</tr>
			</c:when>
			<c:otherwise>
			<tr id="remove_user${entry.us_Id}">
					<td style="text-align:center">${entry.us_Code}</td>
					<td style="text-align:center">${entry.us_Name}</td>
					<td style="text-align:center">
					<c:if test="${entry.us_Sex=='M' }">男</c:if>
					<c:if test="${entry.us_Sex=='F' }">女</c:if>
					</td>
					<td style="text-align:center">${entry.voice}</td>
					<td style="text-align:center">
					<c:if test="${entry.us_State=='1' }">启用</c:if>
					<c:if test="${entry.us_State=='0' }">停用</c:if>
					</td>
					<td style="text-align:center">
					<input type="radio" name="users_selected" value="${entry.us_Id},${entry.us_Name}"/>
					</td>
				</tr>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<tr><th scope="col" colspan="7">
    	<%@ include file="/include/fenye2.jsp" %>
   </th></tr>
		</table>
	</form>
</div>
</body>
</html>