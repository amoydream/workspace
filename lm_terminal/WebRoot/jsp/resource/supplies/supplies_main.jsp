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
			<div id="suppliestreeview"></div>
		</div>
		<div class="col-md-9">
			<div class="row" style="margin-bottom: 10px;">
				<form id="searchSuppliesForm" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="su_Code">编号</label> <input type="text" name="su_Code"
							class="form-control" id="su_Code" placeholder="输入物资编号">
					</div>
					<div class="form-group">
						<label for="su_Name">名称</label> <input type="text" name="su_Name"
							class="form-control" id="su_Name" placeholder="输入物资名称">
					</div>
					<button type="button" class="btn btn-default"
						onclick="searchSupplies()"><i class="icon-search"></i>搜索</button>
					<lauvanpt:permission privilege="suppliesAddip">
					<button type="button" class="btn btn-primary"
						onclick="supplies_add();">添加</button>
					</lauvanpt:permission>
					<button style="float: right; margin-left: 5px;" type="button"
						class="btn btn-primary" onclick="excelIn();">
						<span class="glyphicon glyphicon-import"></span> 导入excel
					</button>
					<button style="float: right; margin-left: 5px;" type="button"
						class="btn btn-primary" onclick="excelOut();">
						<span class="glyphicon glyphicon-export"></span> 导出excel
					</button>
				</form>
			</div>
			<div class="row">
				<input type="hidden" id="pid" value="${pid }" />
				<div style="overflow:scroll; height:600px; OVERFLOW-X:hidden;">
					<table
						class="table table-bordered table-striped table-hover table-condensed">
						<tr class="info">
							<th style="text-align:center">物资编号</th>
							<th style="text-align:center">物资名称</th>
							<th style="text-align:center">型号</th>
							<th style="text-align:center">规格</th>
							<th style="text-align:center">操作</th>
						</tr>
						<tbody id="supplies_data">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.post('resource/supplies/list', function(j) {
				datas(j);
			});

			$.post('resource/suppliestype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#suppliestreeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#pid").val(node.href);
							$.post('resource/supplies/list', {
								su_Typeid : node.href
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

		});
		function datas(j) {
			$("#supplies_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				if (i % 2 == 0) {
					str += "<tr style='background-color: #ebf8ff;'>";
					str += "<td style='text-align:center'>" + j[i].su_Code
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].su_Name
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].su_Type
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].su_Size
							+ "</td>";
					str += "<td style='text-align:center'><lauvanpt:permission privilege='suppliesEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs' onclick='supplies_edit("
							+ j[i].su_Id
							+ ")'>编辑</a></lauvanpt:permission><lauvanpt:permission privilege='suppliesDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='supplies_delete("
							+ j[i].su_Id + ")'>删除</a></lauvanpt:permission></td>";
					str += "</tr>";
				} else {
					str += "<tr>";
					str += "<td style='text-align:center'>" + j[i].su_Code
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].su_Name
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].su_Type
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].su_Size
							+ "</td>";
					str += "<td style='text-align:center'><lauvanpt:permission privilege='suppliesEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs' onclick='supplies_edit("
							+ j[i].su_Id
							+ ")'>编辑</a></lauvanpt:permission><lauvanpt:permission privilege='suppliesDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='supplies_delete("
							+ j[i].su_Id + ")'>删除</a></lauvanpt:permission></td>";
					str += "</tr>";
				}
			}
			$("#supplies_data").append(str);
		}
		function postChild(id) {
			$.post('resource/supplies/list', {
				su_Typeid : id
			}, function(j) {
				datas(j);
			});
		}

		function supplies_add() {
			var pid = $("#pid").val();
			if (pid == null || pid == '') {
				parent.layer.msg("未选择分类，无法添加");
			} else {
				parent.layer
						.open({
							type : 2,
							title : '添加物资信息',
							area : [ '800px', '500px' ],
							scrollbar : false,
							content : [
									'resource/supplies/addip?typeid=' + pid,
									'no' ],
							btn : [ '确认', '取消' ],
							yes : function(index, layero) {
								layero.find('iframe')[0].contentWindow
										.suppliesAddSubmitForm(index, window);
							}
						});
			}
		}

		function supplies_edit(id) {
			parent.layer.open({
				type : 2,
				title : '编辑物资信息',
				area : [ '800px', '500px' ],
				scrollbar : false,
				content : [ 'resource/supplies/editip?id=' + id, 'no' ],
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow
							.suppliesEditSubmitForm(index, window);
				}
			});
		}
		function supplies_delete(id) {
			parent.layer.confirm('您确定要删除么？', function(index) {
				$.post('resource/supplies/delete', {
					suId : id
				}, function(j) {
					if (j.success) {
						parent.layer.msg("删除成功");
						postChild($("#pid").val());
					} else {
						parent.layer.msg("删除失败");
					}
				}, 'json');
			});
		}

		function searchSupplies() {
			$.post('resource/supplies/list', $('#searchSuppliesForm')
					.serialize(), function(j) {
				datas(j);
			});
		}
		
		function excelOut(){
			window.open('<%=basePath%>'+"resource/supplies/excelOut");
		}
		
		function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/resource/supplies/import.jsp',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.fileUpload(index,
							window);
				}
			});
		}
	</script>
</body>
</html>