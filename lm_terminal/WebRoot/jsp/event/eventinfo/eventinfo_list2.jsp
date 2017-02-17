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
</head>
<body>
<div class="container-fluid">
	<div class="row-fluid">
 <button type="button" class="btn btn-primary" onclick="baseevent_addUI();">新事件</button>
 来电号码：${param.ev_reportPhone }|姓名：${name }|部门：${dep }
		<table class="table table-bordered">
			<tr>
				<th>事件名称</th>
				<th>事件类型</th>
				<th>事件级别</th>
				<th>事发时间</th>
				<th>事件状态</th>
				<th>记录时间</th>
				<th>报告人电话 </th>
				<th>操作</th>
			</tr>
            <c:forEach items="${baseEvents}" var="entry">
                 <tr>
					<td>${entry.be_name}</td>
					<td>${entry.eventType.et_name}</td>
					<td></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.be_date }" /></td>
					<td>
					<c:if test="${entry.be_status=='1' }">新登记</c:if>
					<c:if test="${entry.be_status=='2' }">处置中</c:if>
					<c:if test="${entry.be_status=='4' }">完成</c:if>
					</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${entry.be_createDate}" /></td>
					<td>${entry.be_reportPhone}</td>
					<td>
<a href="javascript:void(0);" class="btn btn-primary" onclick="baseevent_editUI(${entry.be_id});" title="事件修改" class='thumbnail'>进入</a></td>
				</tr>
            </c:forEach>

			<c:forEach items="${eventInfos}" var="entry">
				<tr id="remove_eventinfo${entry.ev_id}">
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
					<td>${entry.ev_reportPhone}</td>
					<td>
<a href="javascript:void(0);" class="btn btn-primary" tab_id="eventinfoEdit" url="event/eventinfo/editip?id=${entry.ev_id}&CallID=${CallID}" onclick="eventInfo_editUI(this);" title="事件修改" class='thumbnail'>进入</a></td>
				</tr>
			</c:forEach>
		</table>
	</form>
<script type="text/javascript">
function eventInfo_addUI(the){
	var index = parent.layer.getFrameIndex(window.name);
	parent.tabs_open(the);
	parent.layer_close(index);
}
function eventInfo_editUI(the){
	var index = parent.layer.getFrameIndex(window.name);
	console.info(the);
	parent.tabs_open(the);
	parent.layer.close(index);
}

function baseevent_addUI() {
	
	parent.layer.open({
		type : 2,
		title : '添加日常事件',
		area : [ '800px', '500px' ],
		scrollbar : false,
		content : [ 'jsp/event/baseevent/baseevent_add.jsp?ev_reportPhone=${param.ev_reportPhone }&ev_reportDate=${ev_reportDate }&CallID=${CallID}&name=${name}', 'no' ],
		btn : [ '提交', '取消' ,'突发事件'],
		success: function(layero, index){
			//var index = parent.layer.getFrameIndex(window.name);
			//parent.layer.close(parent.call_check);
	    },
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow
					.baseeventAdd_submitForm(index, window);
		},cancel: function(index){
	        //按钮【按钮二】的回调
	    },btn3: function(index, layero){
	    	var iframeWin = layero.find('iframe')[0].contentWindow.eventinfoAdd_submitForm(index, window);
			//console.info(parent);
			//parent.tabs_open2('eventinfoAdd','事件添加','jsp/event/eventinfo/eventinfo_add.jsp?ev_reportPhone=${param.ev_reportPhone }&ev_reportDate=${ev_reportDate }&CallID=${CallID}&name=${name}','');
			parent.layer.closeAll();
	    }
	});
	
	
}
function baseevent_editUI(id) {
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
}
</script>
</body>
</html>