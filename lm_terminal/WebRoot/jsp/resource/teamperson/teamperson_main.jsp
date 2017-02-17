<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<meta name="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css"
	type="text/css"></link>
<link rel="stylesheet"
	href="lauvanUI/bootstrap/css/font-awesome.min.css" type="text/css"></link>
<link href='css/buttons.css' rel='stylesheet' />
<script src="js/jquery.min.js"></script>
<script src="lauvanUI/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	function topage(page) {
		var form = document.forms[0];
		form.page.value = page;
		form.submit();
	}
</script>
</head>

<body>

	<div style="margin: 10px;">
		<form class="form-inline" action="resource/teamperson/main"
			method="post">
			<input type="hidden" name="query" value="true" />
			<button type="button" class="btn btn-primary"
				onclick="memberSelect(${teId});">添加</button>
		</form>
	</div>

	<!-- 队伍信息表格 -->
	<form id="memberForm" action="resource/teammember/main" method="post">
		<input type="hidden" name="page" /> <input type="hidden" name="query" />
		<table
			class="table table-bordered table-striped table-hover table-condensed">
			<tr class="info">
				<th style="text-align:center">姓名</th>
				<th style="text-align:center">性别</th>
				<th style="text-align:center">所属单位</th>
				<th style="text-align:center">手机号码</th>
				<th style="text-align:center">籍贯</th>
				<th style="text-align:center">操作</th>
			</tr>

			<c:forEach items="${pageView.records}" var="entry" varStatus="statu">
				<c:choose>
					<c:when test="${statu.index % 2 ==0}">
						<tr style="background-color: #ebf8ff;">
							<td style="text-align:center">${entry.id.pe_Id.pe_name}</td>
							<c:if test="${entry.id.pe_Id.pe_sex=='F'}"><td style="text-align:center">男</td></c:if>
							<c:if test="${entry.id.pe_Id.pe_sex=='M'}"><td style="text-align:center">男</td></c:if>
							<td style="text-align:center">${entry.id.pe_Id.organ.or_name}</td>
							<td style="text-align:center">${entry.id.pe_Id.pe_mobilephone}</td>
							<td style="text-align:center">${entry.id.pe_Id.pe_nativeplace}</td>
							<td style="text-align:center"><a href="javascript:void(0);"
								class="btn btn-danger btn-xs "
								onclick="memberDelete(${entry.id.pe_Id.pe_id},${entry.id.te_Id.te_Id })">删除</a>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<td style="text-align:center">${entry.id.pe_Id.pe_name}</td>
							<c:if test="${entry.id.pe_Id.pe_sex=='F'}"><td style="text-align:center">男</td></c:if>
							<c:if test="${entry.id.pe_Id.pe_sex=='M'}"><td style="text-align:center">男</td></c:if>
							<td style="text-align:center">${entry.id.pe_Id.organ.or_name}</td>
							<td style="text-align:center">${entry.id.pe_Id.pe_mobilephone}</td>
							<td style="text-align:center">${entry.id.pe_Id.pe_nativeplace}</td>
							<td style="text-align:center"><a href="javascript:void(0);"
								class="btn btn-danger btn-xs "
								onclick="memberDelete(${entry.id.pe_Id.pe_id},${entry.id.te_Id.te_Id })">删除</a>
							</td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<tr>
				<th scope="col" colspan="9"><%@ include
						file="/include/fenye2.jsp"%></th>
			</tr>
		</table>
	</form>

	<script>
		function memberSelect(teId) {
			parent.layer.open({
				type : 2,
				title : '添加队伍人员信息',
				area : [ '900px', '600px' ],
				content : 'resource/teamperson/selectip?teId=' + teId,
				success : function(layero, index) {
					var iframeWin = layero.find('iframe')[0].contentWindow
							.setLayer(index, window);
				},
			});
		}

		function memberDelete(peId, teId) {
			layer.msg('确定删除该成员信息？', {
				time : 0 //不自动关闭
				,
				btn : [ '确认', '取消' ],
				yes : function(index) {
					layer.close(index);
					$.post('resource/teamperson/delete?peId=' + peId + '&teId='
							+ teId, function(j) {
						if (j.success) {
							window.location.reload();
						}
					}, 'json');
				}
			});
		}
	</script>

</body>
</html>