<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lauvanpt" uri="http://java.lauvan.com/lauvan/permission"%>
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
<title>事件管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<style type="text/css">
.table th, .table td {
	text-align: center;
}
</style>
<script type="text/javascript">
	function topage(page) {
		var form = document.forms[1];
		form.page.value = page;
		form.submit();
	}
	function eventInfo_addUI(the) {
		parent.tabs_open(the);
	}
	function eventInfo_editUI(the) {
		parent.tabs_open(the);
	}
	function eventInfo_mapUI(the) {
		parent.tabs_open(the);
	}
	function eventInfo_view(the) {
		parent.tabs_open(the);
	}
	function eventInfo_showUI(ev_id) { 
		window.open('<%=basePath%>'+"event/eventinfo/infoshow?ev_id="+ev_id);
	}
	
	function eventinfo_delete(id) {
		parent.layer.confirm('您确定要删除么？', function(index) {
			$.post('event/eventinfo/delup', {
				id : id
			}, function(j) {
				if (j.success) {
					$("#remove_eventinfo" + id).remove();
					parent.layer.close(index);
				} else {
					parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
				}
			}, 'json');
		});
	}
	function select_eventType() {
		parent.layer.open({
			type : 2,
			title : '添加事件类型',
			area : [ '500px', '500px' ],
			scrollbar : false,
			content : 'jsp/event/eventinfo/eventinfo_type.jsp',
			btn : [ '确认', '取消' ],
			yes : function(index, layero) {
				layero.find('iframe')[0].contentWindow
						.selectType(index, window);
			}
		});
	}
</script>
</head>
<body>
	<div class="row" style="margin:10px 0">
		<form class="form-inline" action="event/eventinfo/list" method="post">
			<input type="hidden" name="query" value="true" />
			<div class="form-group">
				<label for="ev_name">事件名称</label> <input type="text" name="ev_name"
					class="form-control" id="us_Name" value="${eventInfoVo.ev_name }"
					placeholder="输入事件名称">
			</div>
			<div class="form-group">
				<label for="us_Mophone">事件类型</label> <input type="hidden"
					id="eventTypeid" name="eventTypeId"
					value="${eventInfoVo.eventTypeId }" /> <input class="form-control"
					id="eventTypeName" name="et_name" value="${eventInfoVo.et_name }"
					type="text" placeholder="输入事件类型" onclick="select_eventType();" />
			</div>
			<div class="form-group">
				<label for="us_Mophone">事件级别</label> <select class="form-control"
					id="ev_level" name="ev_level" value="${eventInfoVo.ev_level }"
					placeholder="输入事件级别">
					
					<option value="">请选择</option>
					<option value="1" <c:if test="${eventInfoVo.ev_level =='1' }">selected="selected"</c:if>>Ⅰ级事件(特别重大)</option>
					<option value="2" <c:if test="${eventInfoVo.ev_level =='2' }">selected="selected"</c:if>>Ⅱ级事件(重大)</option>
					<option value="3" <c:if test="${eventInfoVo.ev_level =='3' }">selected="selected"</c:if>>Ⅲ级事件(较大)</option>
					<option value="4" <c:if test="${eventInfoVo.ev_level =='4' }">selected="selected"</c:if>>Ⅳ级事件(一般)</option>
					<option value="5" <c:if test="${eventInfoVo.ev_level =='5' }">selected="selected"</c:if>>Ⅳ级以下事件</option>
				</select>
			</div>
			<div class="form-group">
				<label for="us_Mophone">事件状态</label> <select class="form-control"
					id="ev_status" name="ev_status" value="${eventInfoVo.ev_status }"
					placeholder="输入事件级别">
					<option value="">请选择</option>
					<option value="1" <c:if test="${eventInfoVo.ev_status =='1' }">selected="selected"</c:if>>新登记</option>
					<option value="2" <c:if test="${eventInfoVo.ev_status =='2' }">selected="selected"</c:if>>处置中</option>
					<option value="3" <c:if test="${eventInfoVo.ev_status =='3' }">selected="selected"</c:if>>启动预案</option>
					<option value="4" <c:if test="${eventInfoVo.ev_status =='4' }">selected="selected"</c:if>>完成</option>
				</select>
			</div>
			<button type="submit" class="btn btn-default"><i class="icon-search"></i>搜索</button>
			<lauvanpt:permission privilege="eventAdd">
			<a href="javascript:void(0);" class="btn btn-primary"
				tab_id="eventinfoAdd" url="jsp/event/eventinfo/eventinfo_add.jsp"
				onclick="eventInfo_addUI(this);" title="事件添加" class='thumbnail'>添加</a>
			</lauvanpt:permission>

		</form>
	</div>

	<form id="eventsForm" action="event/eventinfo/list" method="post">
		<input type="hidden" name="page" value="${page }" /> <input
			type="hidden" name="query" value="${query }" /> <input type="hidden"
			name="ev_name" value="${eventInfoVo.ev_name }" /> <input
			type="hidden" name="eventTypeId" value="${eventInfoVo.eventTypeId }" />
		<input type="hidden" name="ev_level" value="${eventInfoVo.ev_level }" />
		<input type="hidden" name="ev_status"
			value="${eventInfoVo.ev_status }" />
		<table
			class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th>事件名称</th>
				<th>事件类型</th>
				<th>事件级别</th>
				<th>事发时间</th>
				<th>事件状态</th>
				<th>记录时间</th>
				<th>操作</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
				<c:choose>
					<c:when test="${statu.index % 2 ==0}">
						<tr id="remove_eventinfo${entry.ev_id}"
							style="background-color: #ebf8ff;">
							<td>${entry.ev_name}</td>
							<td>${entry.eventType.et_name}</td>
							<td><c:if test="${entry.ev_level=='1' }">Ⅰ级事件(特别重大)</c:if> <c:if
									test="${entry.ev_level=='2' }">Ⅱ级事件(重大)</c:if> <c:if
									test="${entry.ev_level=='3' }">Ⅲ级事件(较大)</c:if> <c:if
									test="${entry.ev_level=='4' }">Ⅳ级事件(一般)</c:if> <c:if
									test="${entry.ev_level=='5' }">Ⅳ级以下事件</c:if></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${entry.ev_date }" /></td>
							<td><c:if test="${entry.ev_status=='1' }">新登记</c:if> <c:if
									test="${entry.ev_status=='2' }">处置中</c:if> <c:if
									test="${entry.ev_status=='3' }">启动预案</c:if> <c:if
									test="${entry.ev_status=='4' }">完成</c:if></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${entry.ev_createDate}" /></td>
							<td><a href="javascript:void(0);" class="btn btn-primary btn-sm"
								tab_id="eventinfoEdit"
								url="event/eventinfo/map?longitude=${entry.ev_longitude}&latitude=${entry.ev_latitude}&eventTypeId=${entry.eventType.et_id}"
								title="附近资源检索" onclick="eventInfo_mapUI(this);">地图</a> 
								<lauvanpt:permission privilege="eventEditip"><a
								href="javascript:void(0);" class="btn btn-primary btn-sm"
								tab_id="eventinfoEdit"
								url="event/eventinfo/editip?id=${entry.ev_id}" title="事件修改"
								onclick="eventInfo_editUI(this);">编辑</a></lauvanpt:permission>
								<lauvanpt:permission privilege="eventDelup"><button type="button" class="btn btn-danger btn-sm"
									onclick="eventinfo_delete(${entry.ev_id});">删除</button></lauvanpt:permission>
								<lauvanpt:permission privilege="eventViewip"><a
								href="javascript:void(0);" class="btn btn-warning btn-sm"
								tab_id="eventinfoView"
								url="event/eventinfo/view?id=${entry.ev_id}" title="事件处置"
								onclick="eventInfo_view(this);">处置</a></lauvanpt:permission>
								</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr id="remove_eventinfo${entry.ev_id}">
							<td>${entry.ev_name}</td>
							<td>${entry.eventType.et_name}</td>
							<td><c:if test="${entry.ev_level=='1' }">Ⅰ级事件(特别重大)</c:if> <c:if
									test="${entry.ev_level=='2' }">Ⅱ级事件(重大)</c:if> <c:if
									test="${entry.ev_level=='3' }">Ⅲ级事件(较大)</c:if> <c:if
									test="${entry.ev_level=='4' }">Ⅳ级事件(一般)</c:if> <c:if
									test="${entry.ev_level=='5' }">Ⅳ级以下事件</c:if></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${entry.ev_date }" /></td>
							<td><c:if test="${entry.ev_status=='1' }">新登记</c:if> <c:if
									test="${entry.ev_status=='2' }">处置中</c:if> <c:if
									test="${entry.ev_status=='3' }">启动预案</c:if> <c:if
									test="${entry.ev_status=='4' }">完成</c:if></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${entry.ev_createDate}" /></td>
							<td><a href="javascript:void(0);" class="btn btn-primary btn-sm"
								tab_id="eventinfoEdit"
								url="event/eventinfo/map?longitude=${entry.ev_longitude}&latitude=${entry.ev_latitude}&eventTypeId=${entry.eventType.et_id}"
								title="附近资源检索" onclick="eventInfo_mapUI(this);">地图</a> 
								<lauvanpt:permission privilege="eventEditip"><a
								href="javascript:void(0);" class="btn btn-primary btn-sm"
								tab_id="eventinfoEdit"
								url="event/eventinfo/editip?id=${entry.ev_id}" title="事件修改"
								onclick="eventInfo_editUI(this);">编辑</a></lauvanpt:permission>
								<lauvanpt:permission privilege="eventDelup"><button type="button" class="btn btn-danger btn-sm"
									onclick="eventinfo_delete(${entry.ev_id});">删除</button></lauvanpt:permission>
								<lauvanpt:permission privilege="eventViewip"><a
								href="javascript:void(0);" class="btn btn-warning btn-sm"
								tab_id="eventinfoView"
								url="event/eventinfo/view?id=${entry.ev_id}" title="事件处置"
								onclick="eventInfo_view(this);">处置</a></lauvanpt:permission>
								</td>
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
</body>
</html>