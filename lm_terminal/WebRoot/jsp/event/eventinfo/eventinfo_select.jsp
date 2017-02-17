<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>事件管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<style type="text/css">
    .table th, .table td {
        text-align: center;
    }
</style>
<script type="text/javascript">
function topage(page){
	var form = document.forms[1];
	form.page.value=page;
	form.submit();
}

function selectEvent(index, window){
	var evlist = $("input[name='select']:checked").val().split(",");
	window.$("#eventId").val(evlist[0]);
	window.$("#eventName").val(evlist[1]);
	parent.layer.close(index);
}
</script>
</head>
<body>
<div class="row" style="margin:10px 0">
<form class="form-inline" action="event/eventinfo/selectList" method="post">
<input type="hidden" name="query" value="true"/>
  <div class="form-group">
    <label for="ev_name" >事件名称</label>
    
    <input type="text" name="ev_name" class="form-control" id="us_Name" placeholder="输入事件名称">
</div>
<div class="form-group">
    <label for="us_Mophone" >事件类型</label><input type="hidden" id="eventTypeid" name="eventTypeId"/>
  
    <input class="form-control" id="eventTypeName" name="eventTypeName" type="text"
						placeholder="输入事件类型" onclick="select_eventType();"/>
    </div>
  <button type="submit" class="btn btn-default">搜索</button>
</form>
</div>

<form id="eventsForm" action="event/eventinfo/selectList" method="post">
<input type="hidden" name="page" value="${page }"/>
<input type="hidden" name="query" value="${query }"/>
<input type="hidden" name="ev_name" value="${eventInfoVo.ev_name }"/>
<input type="hidden" name="eventTypeId" value="${eventInfoVo.eventTypeId }"/>
		<table class="table table-bordered">
			<tr>
			    <th></th>
				<th>事件名称</th>
				<th>事件类型</th>
				<th>事件级别</th>
				<th>事发时间</th>
				<th>事件状态</th>
				<th>记录时间</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry">
				<tr id="remove_eventinfo${entry.ev_id}">
				    <td><input type='radio' name='select' value="${entry.ev_id},${entry.ev_name}"/></td>;
					<td>${entry.ev_name}</td>
					<td>${entry.eventType.et_name}</td>
					<td>
					<c:if test="${entry.ev_level=='1' }">Ⅰ级事件(特别重大)</c:if>
					<c:if test="${entry.ev_level=='2' }">Ⅱ级事件(重大)</c:if>
					<c:if test="${entry.ev_level=='3' }">Ⅲ级事件(较大)</c:if>
					<c:if test="${entry.ev_level=='4' }">Ⅳ级事件(一般)</c:if>
					<c:if test="${entry.ev_level=='5' }">Ⅳ级以下事件</c:if>
					</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.ev_date }" /></td>
					<td>
					<c:if test="${entry.ev_status=='1' }">新登记</c:if>
					<c:if test="${entry.ev_status=='2' }">处置中</c:if>
					<c:if test="${entry.ev_status=='3' }">启动预案</c:if>
					<c:if test="${entry.ev_status=='4' }">完成</c:if>
					</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.ev_createDate}" /></td>
					<td>
				</tr>
			</c:forEach>
			<tr><th scope="col" colspan="7">
    	<%@ include file="/include/fenye2.jsp" %>
   </th></tr>
		</table>
	</form>
</body>
</html>