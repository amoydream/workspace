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
<title>日常事件管理</title>
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
	$(function() {
		$("#be_date_begin").datetimepicker({
			language : 'zh-CN',
			format : 'yyyy-mm-dd hh:ii:ss',
			autoclose : true
		});
		$("#be_date_end").datetimepicker({
			language : 'zh-CN',
			format : 'yyyy-mm-dd hh:ii:ss',
			autoclose : true
		});
	});
	function topage(page) {
		var form = document.forms[1];
		form.page.value = page;
		form.submit();
	}
	function baseevent_addUI() {
		parent.layer.open({
			type : 2,
			title : '添加日常事件',
			area : [ '800px', '500px' ],
			scrollbar : false,
			content : [ 'jsp/event/baseevent/baseevent_add.jsp', 'no' ],
			btn : [ '确认', '取消' ],
			yes : function(index, layero) {
				var iframeWin = layero.find('iframe')[0].contentWindow
						.baseeventAdd_submitForm(index, window);
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
	function baseevent_delete(id) {
		parent.layer.confirm('您确定要删除么？', function(index) {
			$.post('event/baseevent/delup', {
				id : id
			}, function(j) {
				if (j.success) {
					$("#remove_baseevent" + id).remove();
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
	
	function baseevent_show(be_id){		
		window.open('<%=basePath%>'+"event/baseevent/infoshow?be_id="+be_id);
	}
	
</script>
</head>
<body>
	<div class="row" style="margin:10px 0">
		<form class="form-inline" action="event/baseevent/list" method="post">
			<input type="hidden" name="query" value="true" />
			<div class="form-group">
				<label for="be_name">事件名称</label> <input type="text" name="be_name"
					class="form-control" id="be_name" value="${baseEventVo.be_name }"
					placeholder="输入事件名称">
			</div>
			<div class="form-group">
				<label for="us_Mophone">事件类型</label><input type="hidden"
					id="eventTypeid" name="eventTypeId"
					value="${baseEventVo.eventTypeId }" /> <input class="form-control"
					id="eventTypeName" name="eventTypeName"
					value="${baseEventVo.eventTypeName }" type="text"
					placeholder="输入事件类型" onclick="select_eventType();" />
			</div>
			<div class="form-group">
				<label for="us_Mophone">事发时间</label> 从：<input class="form-control"
					id="be_date_begin" name="be_dateBegin" type="text"
					value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${baseEventVo.be_dateBegin }" />" data-bv-trigger="keyup"
					placeholder="输入事发时间" /> 到：<input class="form-control"
					data-bv-trigger="keyup" id="be_date_end" name="be_dateEnd"
					type="text" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${baseEventVo.be_dateEnd }" />" placeholder="输入事发时间" />
			</div>
			<button type="submit" class="btn btn-default"><i class="icon-search"></i>搜索</button>
			<lauvanpt:permission privilege="baseEventAdd">
			<button type="button" class="btn btn-primary"
				onclick="baseevent_addUI();">添加</button>
			</lauvanpt:permission>

		</form>
	</div>

	<form id="eventsForm" action="event/baseevent/list" method="post">
		<input type="hidden" name="page" value="${page }" /> <input
			type="hidden" name="query" value="${query }" /> <input type="hidden"
			name="be_name" value="${baseEventVo.be_name }" /> <input
			type="hidden" name="eventTypeId" value="${baseEventVo.eventTypeId }" />
		<input type="hidden" name="be_dateBegin"
			value="${baseEventVo.be_dateBegin }" /> <input type="hidden"
			name="be_dateEnd" value="${baseEventVo.be_dateEnd }" />
		<table
			class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th>事件名称</th>
				<th>事件类型</th>
				<th>事发时间</th>
				<th>报告人姓名</th>
				<th>报告人电话</th>
				<th>记录时间</th>
				<th>操作</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
				<c:choose>
					<c:when test="${statu.index % 2 ==0}">
						<tr id="remove_baseevent${entry.be_id}"
							style="background-color: #ebf8ff;">
							<td>${entry.be_name}</td>
							<td>${entry.eventType.et_name}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${entry.be_date }" /></td>
							<td>${entry.be_reportName}</td>
							<td>${entry.be_reportPhone}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${entry.be_createDate}" /></td>
							<td>
								<lauvanpt:permission privilege="baseEventEditip"><button type="button" class="btn btn-primary btn-sm"
									onclick="baseevent_editUI(${entry.be_id});">编辑</button></lauvanpt:permission>
								<lauvanpt:permission privilege="baseEventDelup"><button type="button" class="btn btn-danger btn-sm"
									onclick="baseevent_delete(${entry.be_id});">删除</button></lauvanpt:permission>
									<button type="button" class="btn btn-success btn-sm"
									onclick="baseevent_show(${entry.be_id});">查看</button>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
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
								<lauvanpt:permission privilege="baseEventEditip"><button type="button" class="btn btn-primary btn-sm"
									onclick="baseevent_editUI(${entry.be_id});">编辑</button></lauvanpt:permission>
								<lauvanpt:permission privilege="baseEventDelup"><button type="button" class="btn btn-danger btn-sm"
									onclick="baseevent_delete(${entry.be_id});">删除</button></lauvanpt:permission>
								<button type="button" class="btn btn-success btn-sm"
									onclick="baseevent_show(${entry.be_id});">查看</button>	
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