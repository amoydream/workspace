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
<title>类型管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<div class="row" style="margin: 25px 10px 0 0;">
		<div class="row" style="margin-bottom: 10px;">
			<form id="searchEmeplanForm" class="form-inline" method="post">
				<input type="hidden" name="query" value="true" />
				<div class="form-group">
					<label for="pi_name">名称</label> <input type="text" name="piName"
						class="form-control" id="piName" placeholder="输入预案名称">
				</div>
				<button type="button" class="btn btn-default"
					onclick="searchEmeplan()">搜索</button>
			</form>
		</div>
		<div class="row">
			<table class="table table-bordered table-hover">
				<tr>
					<th style="text-align:center"></th>
					<th style="text-align:center">名称</th>
					<th style="text-align:center">层级</th>
					<th style="text-align:center">版本号</th>
					<th style="text-align:center">发布日期</th>
				</tr>
				<tbody id="plan_data"></tbody>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.post('emeplan/planType/select', {
				planTypeId : ${param.planTypeId}
			}, function(j) {
				datas(j);
			})
		})

		function datas(j) {
			$("#plan_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				str += "<tr>";
				str += "<td style='text-align:center'><input type='radio' name='select' value='"+j[i].pi_id+"," + j[i].pi_name + "'/></td>";
				str += "<td style='text-align:center'>" + j[i].pi_name
						+ "</td>";
				str += "<td style='text-align:center'>" + j[i].pi_level
						+ "</td>";
				str += "<td style='text-align:center'>" + j[i].pi_no
						+ "</td>";
				str += "<td style='text-align:center'>"
						+ j[i].pi_createDate + "</td>";
				str += "</tr>";
			}
			$("#plan_data").append(str);
		}

		function searchEmeplan() {
			$.post('emeplan/planType/select', $('#searchEmeplanForm')
					.serialize(), function(j) {
				datas(j);
			});
		}

		function selectPlanBack(index, window) {
			var pilist = $("input[name='select']:checked").val().split(",");
			window.$("#piId").val(pilist[0]);
			window.$("#piName").val(pilist[1]);
			parent.layer.close(index);
		}
	</script>
</body>
</html>