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
<title>预案综合管理-事件分类分级-事件分级</title>
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
					<th>分级名称
						<button type="button" class="btn btn-primary btn-sm"
							onclick="manage_classificationAdd(${pi_id });">添加</button>
					</th>
					<th>事件级别</th>
					<th>描述</th>
					<th>备注</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${classifications}" var="entry" varStatus="statu">
					<c:choose>
						<c:when test="${statu.index % 2 ==0}">
							<tr id="emeClassification${entry.eec_id}"
								style="background-color: #ebf8ff;">
								<td>${entry.eec_name}</td>
								<td><c:if test="${entry.eec_type=='1'}">Ⅰ级事件(特别重大)</c:if> <c:if
										test="${entry.eec_type=='2'}">Ⅱ级事件(重大)</c:if> <c:if
										test="${entry.eec_type=='3'}">Ⅲ级事件(较大)</c:if> <c:if
										test="${entry.eec_type=='4'}">Ⅳ级事件(一般)</c:if> <c:if
										test="${entry.eec_type=='5'}">Ⅳ级以下事件</c:if></td>
								<td>${entry.eec_desc}</td>
								<td>${entry.eec_remark}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-primary btn-xs'
									onclick='emeClassification_edit(${entry.eec_id})'>编辑</a> <a
									href='javascript:void(0);' class='btn btn-danger btn-xs'
									onclick='emeClassification_delete(${entry.eec_id})'>删除</a></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr id="emeClassification${entry.eec_id}">
								<td>${entry.eec_name}</td>
								<td><c:if test="${entry.eec_type=='1'}">Ⅰ级事件(特别重大)</c:if> <c:if
										test="${entry.eec_type=='2'}">Ⅱ级事件(重大)</c:if> <c:if
										test="${entry.eec_type=='3'}">Ⅲ级事件(较大)</c:if> <c:if
										test="${entry.eec_type=='4'}">Ⅳ级事件(一般)</c:if> <c:if
										test="${entry.eec_type=='5'}">Ⅳ级以下事件</c:if></td>
								<td>${entry.eec_desc}</td>
								<td>${entry.eec_remark}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-primary btn-xs'
									onclick='emeClassification_edit(${entry.eec_id})'>编辑</a> <a
									href='javascript:void(0);' class='btn btn-danger btn-xs'
									onclick='emeClassification_delete(${entry.eec_id})'>删除</a></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<tbody id="selected_emeClassifications">
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		function manage_classificationAdd(pi_id) {
			parent.parent.parent.parent.layer
					.open({
						type : 2,
						title : '事件分级添加',
						area : [ '800px', '500px' ],
						scrollbar : false,
						content : [
								'jsp/emeplan/emeClassification/emeClassification_add.jsp',
								'no' ],
						btn : [ '确认', '取消' ],
						yes : function(index, layero) {
							layero.find('iframe')[0].contentWindow
									.emeClassificationAdd_submitForm(index,
											window, pi_id);
						}
					});
		}
		function emeClassification_edit(id) {
			parent.parent.parent.parent.layer
					.open({
						type : 2,
						title : '事件分级修改',
						area : [ '800px', '500px' ],
						scrollbar : false,
						content : [ 'emeplan/classification/editip?id=' + id,
								'no' ],
						btn : [ '确认', '取消' ],
						yes : function(index, layero) {
							layero.find('iframe')[0].contentWindow
									.emeClassificationEdit_submitForm(index,
											window, id);
						}
					});
		}
		function emeClassification_delete(id) {
			parent.parent.parent.parent.layer.confirm('您确定要删除么？', function(
					index) {
				$.post('emeplan/classification/delete', {
					id : id
				}, function(j) {
					if (j.success) {
						$("#emeClassification" + id).remove();
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