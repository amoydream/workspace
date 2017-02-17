<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>用户管理</title>

<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	function topage(page) {
		var form = document.forms[0];
		form.page.value = page;
		form.submit();
	}
	function role_addUI() {
		parent.layer.open({
			type : 2,
			title : '添加角色',
			area : [ '800px', '500px' ],
			scrollbar : false,
			content : 'jsp/system/roleinfo/role_add.jsp',
			btn : [ '确认', '取消' ],
			yes : function(index, layero) {
				var iframeWin = layero.find('iframe')[0].contentWindow
						.roleAdd_submitForm(index, window);
			}
		});
	}
	function role_editUI(id) {
		parent.layer.open({
			type : 2,
			title : '修改角色',
			area : [ '800px', '500px' ],
			scrollbar : false,
			content : 'system/roleinfo/editip?id=' + id,
			btn : [ '确认', '取消' ],
			yes : function(index, layero) {
				var iframeWin = layero.find('iframe')[0].contentWindow
						.roleEdit_submitForm(index, window);
			}
		});
	}
	function role_delete(id) {
		parent.layer.confirm('您确定要删除么？', function(index) {
			$.post('system/roleinfo/delete', {
				id : id
			}, function(j) {
				if (j.success) {
					$("#remove_role" + id).remove();
					parent.layer.close(index);
				}
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}, 'json');
		});
	}
</script>
</head>
<body>
	<div style="margin-top: 15px;">
	<lauvanpt:permission privilege="roleAddip">
		<button type="button" class="btn btn-primary" onclick="role_addUI();">添加</button>
	</lauvanpt:permission>
		<form id="eventsForm" action="system/roleinfo/main" method="post">
			<input type="hidden" name="page" value="${page }" /> <input
				type="hidden" name="query" value="${query }" />
			<table
				class="table table-bordered table-striped table-hover table-condensed">
				<tr class="info">
					<th style="text-align:center">角色编码</th>
					<th style="text-align:center">名称</th>
					<th style="text-align:center">备注</th>
					<th style="text-align:center">操作</th>
				</tr>

				<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
					<c:choose>
						<c:when test="${statu.index % 2 ==0}">
							<tr id="remove_role${entry.ro_Id}"
								style="background-color: #ebf8ff;">
								<td style="text-align:center">${entry.ro_Code}</td>
								<td style="text-align:center">${entry.ro_Name}</td>
								<td style="text-align:center">${entry.ro_Remark }</td>
								<td style="text-align:center">
								    <lauvanpt:permission privilege="roleEditip">
								    <button type="button"
										class="btn btn-primary btn-sm"
										onclick="role_editUI(${entry.ro_Id});">编辑</button>
									</lauvanpt:permission><lauvanpt:permission privilege="roleDelete">
									<button type="button" class="btn btn-danger btn-sm"
										onclick="role_delete(${entry.ro_Id});">删除</button>
									</lauvanpt:permission></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr id="remove_role${entry.ro_Id}">
								<td style="text-align:center">${entry.ro_Code}</td>
								<td style="text-align:center">${entry.ro_Name}</td>
								<td style="text-align:center">${entry.ro_Remark }</td>
								<td style="text-align:center">
								<lauvanpt:permission privilege="roleEditip">
								    <button type="button"
										class="btn btn-primary btn-sm"
										onclick="role_editUI(${entry.ro_Id});">编辑</button>
									</lauvanpt:permission><lauvanpt:permission privilege="roleDelete">
									<button type="button" class="btn btn-danger btn-sm"
										onclick="role_delete(${entry.ro_Id});">删除</button>
									</lauvanpt:permission></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<tr>
					<th scope="col" colspan="9"><%@ include
							file="/include/fenye2.jsp"%></th>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>