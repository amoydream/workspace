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
<title>选择机构人员</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript">
	$(function() {
		$.post('work/organ/tree', {}, function(treeData) {
			var initSelectableTree = function() {
				return $('#person_treeview').treeview({
					data : treeData,
					multiSelect : $('#chk-select-multi').is(':checked'),
					onNodeSelected : function(event, node) {
						$("#orid").val(node.href);
						$.post('work/person/list', {
							orId : node.href
						}, function(persons) {
							show(persons);
						});
					}
				});
			};
			var $selectableTree = initSelectableTree();
		});
	});

	function search() {
		$.post('work/person/search', $('#searchForm').serialize(),
				function(j) {
			if(j.success){
				show(j.obj.records);
			}
		});
	}

	function show(persons) {
		$("#person_data").empty();
		var str = '';
		for (var i = 0; i < persons.length && i < 8; i++) {
			str += "<tr onclick='selectPerson(" + persons[i].pe_id + ");'>";
			str += "<td>" + persons[i].pe_name + "</td>";
			str += "<td>" + persons[i].pe_jobs + "</td>";
			if (persons[i].pe_mobilephone == undefined) {
				str += "<td></td>";
			} else {
				str += "<td>" + persons[i].pe_mobilephone + "</td>";
			}
			str += "<td><input type='button' class='btn btn-primary' value='选择' onclick='selectPerson("
					+ ${teId} + "," + persons[i].pe_id + ");'>";
			str += "</tr>";
		}
		$("#person_data").append(str);
	}

	var index = -1, win = null;

	function setLayer(i, window) {
		index = i;
		win = window;
	}

	function selectPerson(teId, peId) {
		$.post('resource/teamperson/add', {
			peId : peId,
			teId : teId
		}, function(j) {
			if (j.success) {
				parent.layer.msg("添加成功");
				parent.layer.close(index);
				win.location.reload();
			}
			parent.layer.tips(j.msg, '.layui-layer-btn0', {
				tips : 1
			});
		}, 'json');
	}
</script>
</head>
<body>
	<div class="container-fluid"
		style="margin-top: 15px; padding-left: 0px;">
		<div class="row-fluid">
			<div class="col-xs-4">
				<div id="person_treeview"></div>
			</div>
			<div id="page-wrapper" class="col-xs-8" style="padding-left: 0px;">
				<input type="hidden" id="orid" />
				<div style="margin-bottom: 15px;">
					<form id="searchForm" class="form-inline"
						action="work/person/search" method="post">
						<div class="form-group">
							<label for="pe_name">姓名</label> <input type="text" id="pe_name"
								name="pe_name" class="form-control" placeholder="机构人员名称"
								value="${organPersonVo.pe_name}">
						</div>
						<div class="form-group">
							<label for="pe_mobilephone">电话号码</label> <input type="tel"
								id="pe_mobilephone" name="pe_mobilephone" class="form-control"
								placeholder="电话号码" value="${organPersonVo.pe_mobilephone}">
						</div>
						<input type="button" class="btn btn-default" value="搜索"
							onclick="search();">
					</form>
				</div>
				<table class="table table-bordered">
					<tr>
						<th>姓名</th>
						<th>岗位</th>
						<th>电话</th>
						<th>操作</th>
					</tr>
					<tbody id="person_data">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>