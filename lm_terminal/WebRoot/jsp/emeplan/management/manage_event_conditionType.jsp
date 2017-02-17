<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>预案综合管理-事件分类分级-状况分类</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>
<body>
	<div class="container-fluid" style="margin-top: 15px;">
		<div class="row-fluid"
			style="overflow:scroll; height:500px; OVERFLOW-X:hidden;">
			<table
				class="table table-bordered table-striped table-hover table-condensed">
				<tr class="info">
					<th>名称
						<button type="button" class="btn btn-primary btn-sm"
							onclick="manage_conditionType_select(${pi_id });">添加</button>
					</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${conditionTypes}" var="entry" varStatus="statu">
					<input type="hidden" name="eventTypeIds" value="${entry.eec_id}" />
					<c:choose>
						<c:when test="${statu.index % 2 ==0}">
							<tr id="emeConditionType${entry.eec_id}"
								style="background-color: #ebf8ff;">
								<td>${entry.eec_name}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-primary btn-xs'
									onclick='emeConditionType_edit(${entry.eec_id})'>编辑</a> <a
									href='javascript:void(0);' class='btn btn-danger btn-xs'
									onclick='emeConditionType_delete(${entry.eec_id})'>删除</a></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr id="emeConditionType${entry.eec_id}">
								<td>${entry.eec_name}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-primary btn-xs'
									onclick='emeConditionType_edit(${entry.eec_id})'>编辑</a> <a
									href='javascript:void(0);' class='btn btn-danger btn-xs'
									onclick='emeConditionType_delete(${entry.eec_id})'>删除</a></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<tbody id="selected_emeConditionTypes">

				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		function manage_conditionType_select(pi_id) {
			var ids = $("input[name='eventTypeIds']");
			parent.parent.parent.parent.layer
					.open({
						type : 2,
						title : '状况分类添加',
						area : [ '800px', '500px' ],
						scrollbar : false,
						content : [
								'jsp/emeplan/emeConditionType/emeConditionType_add.jsp',
								'no' ],
						btn : [ '确认', '取消' ],
						yes : function(index, layero) {
							layero.find('iframe')[0].contentWindow
									.emeConditionTypeAdd_submitForm(index,
											window, pi_id, ids);
						}
					});
		}
		function emeConditionType_edit(id) {
			parent.parent.parent.parent.layer
					.open({
						type : 2,
						title : '状况分类修改',
						area : [ '800px', '500px' ],
						scrollbar : false,
						content : [ 'emeplan/conditionType/editip?id=' + id,
								'no' ],
						btn : [ '确认', '取消' ],
						yes : function(index, layero) {
							layero.find('iframe')[0].contentWindow
									.emeConditionTypeEdit_submitForm(index,
											window, id);
						}
					});
		}

		function emeConditionType_delete(id) {
			parent.parent.parent.parent.layer.confirm('您确定要删除么？', function(
					index) {
				$.post('emeplan/conditionType/delete', {
					id : id
				}, function(j) {
					if (j.success) {
						$("#emeConditionType" + id).remove();
					}
					parent.parent.parent.parent.layer.msg(j.msg, {
						offset : 0,
						shift : 6
					});
					parent.parent.parent.parent.layer.close(index);
				}, 'json');
			});
		}
	</script>
</body>
</html>