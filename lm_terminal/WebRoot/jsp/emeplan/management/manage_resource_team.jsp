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
<title>预案综合管理-应急资源配置--应急队伍</title>
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
					<th>队伍名称
						<button type="button" class="btn btn-primary btn-sm"
							onclick="manage_resource_team_select(${pi_id });">添加</button>
					</th>
					<th>说明</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${etTeams}" var="entry" varStatus="statu">
					<input type="hidden" name="te_Ids" value="${entry.team.te_Id}" />
					<c:choose>
						<c:when test="${statu.index % 2 ==0}">
							<tr id="emeTeam${entry.team.te_Id}"
								style="background-color: #ebf8ff;">
								<td>${entry.team.te_Name}</td>
								<td>${entry.team.te_Remark}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-danger btn-xs'
									onclick='emeTeam_delete(${entry.team.te_Id})'>删除</a></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr id="emeTeam${entry.team.te_Id}">
								<td>${entry.team.te_Name}</td>
								<td>${entry.team.te_Remark}</td>
								<td><a href='javascript:void(0);'
									class='btn btn-danger btn-xs'
									onclick='emeTeam_delete(${entry.team.te_Id})'>删除</a></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<tbody id="selected_teams">

				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		function manage_resource_team_select(pi_id) {
			var ids = $("input[name='te_Ids']");
			parent.parent.parent.parent.layer.open({
				type : 2,
				title : '选择应急队伍',
				area : [ '800px', '500px' ],
				scrollbar : false,
				content : [ 'resource/team/list', 'no' ],
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.select_Teams(index,
							window, pi_id, ids);
				}
			});
		}

		function emeTeam_delete(id) {
			parent.parent.parent.parent.layer.confirm('您确定要删除么？', function(
					index) {
				$.post('emeplan/planTeam/delete', {
					id : id,
					pi_id : ${param.pi_id }
				}, function(j) {
					if (j.success) {
						$("#emeTeam" + id).remove();
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