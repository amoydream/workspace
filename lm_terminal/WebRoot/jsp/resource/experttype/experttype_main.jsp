<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<div class="col-md-3">
			<div id="type_treeview"></div>
		</div>
		<div class="col-md-9">
			<div class="row" style="margin-bottom: 10px;">
				<form id="searchTypeForm" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="ext_Code">编号</label> <input type="text"
							name="ext_Code" class="form-control" id="ext_Code"
							placeholder="输入类型编号">
					</div>
					<div class="form-group">
						<label for="ext_Name">名称</label> <input type="text"
							name="ext_Name" class="form-control" id="ext_Name"
							placeholder="输入类型名称">
					</div>
					<button type="button" class="btn btn-default"
						onclick="searchType()"><i class="icon-search"></i>搜索</button>
					<lauvanpt:permission privilege="expertTypeAdd">
					<button type="button" class="btn btn-primary" onclick="type_add();">添加</button>
					</lauvanpt:permission>
				</form>
			</div>
			<div class="row">
				<input type="hidden" id="pid" value="${pid }" />
				<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
						<th style="text-align:center">类型名称</th>
						<th style="text-align:center">类型编码</th>
						<th style="text-align:center">备注</th>
						<th style="text-align:center">操作</th>
					</tr>
					<tbody id="type_data">

					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.post('resource/experttype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#type_treeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#pid").val(node.href);
							$.post('resource/experttype/list', {
								id : node.href
							}, function(j) {
								datas(j);
							});
						},
						onNodeUnselected : function(event, node) {
						}
					});
				};
				var $selectableTree = initSelectableTree();
			});
			$.post('resource/experttype/list', {}, function(j) {
				datas(j);
			});
		});
		function datas(j) {
			$("#type_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				if (i % 2 == 0) {
					str += "<tr style='background-color: #ebf8ff;'>";
					str += "<td style='text-align:center'>" + j[i].ext_Name
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].ext_Code
							+ "</td>";
					if (j[i].ext_Remark == undefined || j[i].ext_Remark == '') {
						str += "<td style='text-align:center'></td>";
					} else {
						str += "<td style='text-align:center'>"
								+ j[i].ext_Remark + "</td>";
					}
					str += "<td style='text-align:center'><lauvanpt:permission privilege='expertTypeEditip'><button type='button' class='btn btn-primary btn-xs' onclick='type_edit("
							+ j[i].ext_Id
							+ ");'>编辑</button></lauvanpt:permission><lauvanpt:permission privilege='expertTypeDelete'><button type='button' class='btn btn-danger btn-xs' onclick='type_delete("
							+ j[i].ext_Id + ");'>删除</button></lauvanpt:permission></td>";
					str += "</tr>";
				} else {
					str += "<tr>";
					str += "<td style='text-align:center'>" + j[i].ext_Name
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].ext_Code
							+ "</td>";
					if (j[i].ext_Remark == undefined || j[i].ext_Remark == '') {
						str += "<td style='text-align:center'></td>";
					} else {
						str += "<td style='text-align:center'>"
								+ j[i].ext_Remark + "</td>";
					}
					str += "<td style='text-align:center'><lauvanpt:permission privilege='expertTypeEditip'><button type='button' class='btn btn-primary btn-xs' onclick='type_edit("
							+ j[i].ext_Id
							+ ");'>编辑</button></lauvanpt:permission><lauvanpt:permission privilege='expertTypeDelete'><button type='button' class='btn btn-danger btn-xs' onclick='type_delete("
							+ j[i].ext_Id + ");'>删除</button></lauvanpt:permission></td>";
					str += "</tr>";
				}
			}
			$("#type_data").append(str);
		}
		function postChild(id) {
			$.post('resource/experttype/list', {
				id : id
			}, function(j) {
				datas(j);
			});
		}

		function type_add() {
			var pid = $("#pid").val();
			parent.layer
					.open({
						type : 2,
						title : '添加专家类型',
						area : [ '800px', '500px' ],
						scrollbar : false,
						content : [
								'jsp/resource/experttype/experttype_add.jsp?pid='
										+ pid, 'no' ],
						btn : [ '确认', '取消' ],
						yes : function(index, layero) {
							layero.find('iframe')[0].contentWindow
									.typeAddSubmitForm(index, window);
						}
					});
		}
		function type_edit(id) {
			parent.layer.open({
				type : 2,
				title : '编辑专家类型',
				area : [ '800px', '500px' ],
				scrollbar : false,
				content : [ 'resource/experttype/editip?id=' + id, 'no' ],
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.typeEditSubmitForm(
							index, window);
				}
			});
		}
		function type_delete(id) {
			parent.layer.confirm('您确定要删除么？', function(index) {
				$.post('resource/experttype/delete', {
					id : id
				}, function(j) {
					if (j.success) {
						parent.layer.close(index);
						postChild($("#pid").val());
					} else {
						parent.layer.tips(j.msg, '.layui-layer-btn0', {
							tips : 1
						});
					}
				}, 'json');
			});
		}
		function searchType() {
			$.post('resource/experttype/list',
					$('#searchTypeForm').serialize(), function(j) {
						datas(j);
					});
		}
	</script>
</body>
</html>