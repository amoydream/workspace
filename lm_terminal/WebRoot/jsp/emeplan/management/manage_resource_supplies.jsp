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
<title>预案综合管理-应急资源配置--应急物资</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
</head>
<body>
	<div class="container-fluid"
		style="margin-top: 15px; padding-left: 0px;">
		<div class="row-fluid"
			style="overflow:scroll; height:500px; OVERFLOW-X:hidden;">
			<table
				class="table table-bordered table-striped table-hover table-condensed">
				<tr class="info">
					<th>资源名称
						<button type="button" class="btn btn-primary btn-sm"
							onclick="manage_resource_supplies_select(${pi_id });">添加</button>
					</th>
					<th>资源型号</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${eSupplies}" var="entry" varStatus="statu">
					<input type="hidden" name="su_Ids" value="${entry.suppliy.su_Id}" />
					<c:choose>
						<c:when test="${statu.index % 2 ==0}">
							<tr id="emeSupply${entry.suppliy.su_Id}"
								style="background-color: #ebf8ff;">
								<td>${entry.suppliy.su_Name}</td>
								<td>${entry.suppliy.su_Type}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-danger btn-xs'
									onclick='emeSupply_delete(${entry.suppliy.su_Id})'>删除</a></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr id="emeSupply${entry.suppliy.su_Id}">
								<td>${entry.suppliy.su_Name}</td>
								<td>${entry.suppliy.su_Type}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-danger btn-xs'
									onclick='emeSupply_delete(${entry.suppliy.su_Id})'>删除</a></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<tbody id="selected_spps">

				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		function manage_resource_supplies_select(pi_id) {
			var ids = $("input[name='su_Ids']");
			parent.parent.parent.parent.layer
					.open({
						type : 2,
						title : '选择物资信息',
						area : [ '800px', '500px' ],
						scrollbar : false,
						content : [
								'jsp/resource/supplies/supplies_select.jsp',
								'no' ],
						btn : [ '确认', '取消' ],
						yes : function(index, layero) {
							layero.find('iframe')[0].contentWindow
									.select_Supplies(index, window, pi_id, ids);
						}
					});
		}
		function emeSupply_delete(id) {
			parent.parent.parent.parent.layer.confirm('您确定要删除么？', function(
					index) {
				$.post('emeplan/planSupplies/delete', {
					id : id,
					pi_id : ${pi_id }
				}, function(j) {
					if (j.success) {
						$("#emeSupply" + id).remove();
						parent.parent.parent.parent.layer.close(index);
					}
					parent.parent.parent.parent.layer.msg(j.msg, {
						offset : 0,
						shift : 6
					});
				}, 'json');
			});
		}
	</script>
</body>
</html>