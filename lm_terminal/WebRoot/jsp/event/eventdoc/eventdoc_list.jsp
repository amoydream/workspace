<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>相关附件</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid" style="margin-top: 10px;">
			<table class="table table-bordered">
				<tr>
					<th>文件名</th>
					<th>附件描述</th>
					<th>操作</th>
				</tr>
				<tbody id="attach_data">
					<c:forEach items="${eventdocs }" var="entry">
					<tr id="remove_eventdoc${entry.edoc_id}">
					<td>${entry.edoc_name }</td>
					<td>${entry.edoc_desc }</td>
					<td><button type="button" class="btn btn-primary btn-sm" onclick="eventdoc_editUI(${entry.edoc_id});">编辑</button>
					<button type="button" class="btn btn-danger btn-sm" onclick="eventdoc_delete(${entry.edoc_id});">删除</button>
					<button type="button" class="btn btn-danger btn-sm" onclick="eventdoc_report('${entry.edoc_name}');">查看</button></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
<script type="text/javascript">
function eventdoc_editUI(id) {
	parent.layer.open({
		type : 2,
		title : '修改事件附件',
		area : [ '800px', '500px' ],
		scrollbar : false,
		content : [ 'event/eventdoc/editip?id=' + id, 'no' ],
		btn : [ '确认', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow.eventdocEdit_submitForm(index, window);
		}
	});
}
function eventdoc_delete(id) {
	parent.layer.confirm('您确定要删除么？', function(index) {
		$.post('event/eventdoc/delete', {
			id : id
		}, function(j) {
			if (j.success) {
				$("#remove_eventdoc" + id).remove();
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
function eventdoc_report(docName){
	window.open('<%=basePath%>event/eventdoc/view?docName='+docName);
}
</script>
</body>
</html>