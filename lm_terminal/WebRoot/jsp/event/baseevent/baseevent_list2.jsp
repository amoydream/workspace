<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>日常事件管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
<div class="container-fluid">
	<div class="row-fluid">
<button type="button" class="btn btn-primary" onclick="baseevent_addUI();">添加</button>

<table class="table table-bordered">
			<tr>
				<th>事件名称</th>
				<th>事件类型</th>
				<th>事发时间</th>
				<th>报告人姓名</th>
				<th>报告人电话</th>
				<th>记录时间</th>
				<th>选择</th>
			</tr>

			<c:forEach items="${baseEvents}" var="entry">
				<tr id="remove_baseevent${entry.be_id}">
					<td>${entry.be_name}</td>
					<td>${entry.eventType.et_name}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
							value="${entry.be_date }" /></td>
					<td>${entry.be_reportName}</td>
					<td>${entry.be_reportPhone}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
							value="${entry.be_createDate}" /></td>
					<td>
						<input type="radio" name="check_events" value="${entry.be_id}"/>
					</td>
				</tr>
			</c:forEach>
		</table>
</div></div>
<script type="text/javascript">
function baseevent_addUI() {
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.open({
		type : 2,
		title : '添加日常事件',
		area : [ '800px', '500px' ],
		scrollbar : false,
		content : [ 'jsp/event/baseevent/baseevent_add.jsp?be_reportPhone=${be_reportPhone}', 'no' ],
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow
					.baseeventAdd_submitForm(index, window);
		}
	});
	parent.layer_close(index);
}
function checkEvents(index, window){
	var id = $("input[name='check_events']:checked").val();
	parent.layer.open({
		type : 2,
		title : '修改日常事件',
		area : [ '800px', '500px' ],
		scrollbar : false,
		content : [ 'event/baseevent/editip?id=' + id, 'no' ],
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow
					.baseeventEdit_submitForm(index, window);
		}
	});
	parent.layer.close(index);
}
</script>

</body>
</html>