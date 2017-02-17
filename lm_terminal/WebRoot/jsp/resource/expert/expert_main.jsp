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
<title>专家信息管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script src="js/bootstrap-tabs.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<div class="row" style="margin: 25px 10px 0 0;">
		<div class="col-md-3">
			<div id="experttreeview"></div>
		</div>
		<div class="col-md-9">
			<div class="row" style="margin-bottom: 10px;">
				<form id="searchExpertForm" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="ex_Name">名称</label> <input type="text" name="ex_Name"
							class="form-control" id="ex_Name" placeholder="输入专家姓名">
					</div>
					<button type="button" class="btn btn-default"
						onclick="searchExpert()"><i class="icon-search"></i>搜索</button>
					<lauvanpt:permission privilege="expertAddip">
					<a href="javascript:void(0);" class="btn btn-primary"
						tab_id="expertAddTab"
						url="jsp/resource/expert/expert_add.jsp?typeId='$('#pid').val()'"
						onclick="expert_addUI(this);" title="专家添加" class='thumbnail'>添加</a>
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
				<div style="overflow:scroll; height:640px; OVERFLOW-X:hidden;">
					<table class="table table-bordered table-striped table-hover table-condensed">
						<tr class="info">
							<th style="text-align:center">专家姓名</th>
							<th style="text-align:center">所属单位</th>
							<th style="text-align:center">联系地址</th>
							<th style="text-align:center">操作</th>
						</tr>
						<tbody id="expert_data">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.post('resource/expert/list', function(j) {
				datas(j);
			});

			$.post('resource/experttype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#experttreeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#pid").val(node.href);
							$.post('resource/expert/list', {
								ex_Typeid : node.href
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
			$("#expert_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				if(i% 2 == 0){
					str += "<tr style='background-color: #ebf8ff;'>";
					str += "<td style='text-align:center'>" + j[i].ex_Name
							+ "</td>";
					str += "<td style='text-align:center'>"
							+ j[i].ex_Deptid.or_name + "</td>";
					str += "<td style='text-align:center'>"
							+ j[i].ex_Linkaddress + "</td>";
					str += "<td style='text-align:center'>";
					str += "<lauvanpt:permission privilege='expertEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' addtabs='parentAddtabs' url='resource/expert/editip?id="+j[i].ex_Id+"' title='专家信息编辑' class='thumbnail'>编辑</a></lauvanpt:permission>";
					str += "<lauvanpt:permission privilege='expertDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='expert_delete("
							+ j[i].ex_Id + ")'>删除</a></lauvanpt:permission>";
					str += "</td></tr>";
				}else{
					str += "<tr>";
					str += "<td style='text-align:center'>" + j[i].ex_Name
							+ "</td>";
					str += "<td style='text-align:center'>"
							+ j[i].ex_Deptid.or_name + "</td>";
					str += "<td style='text-align:center'>"
							+ j[i].ex_Linkaddress + "</td>";
					str += "<td style='text-align:center'>";
					str += "<lauvanpt:permission privilege='expertEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' addtabs='parentAddtabs' url='resource/expert/editip?id="+j[i].ex_Id+"' title='专家信息编辑' class='thumbnail'>编辑</a></lauvanpt:permission>";
					str += "<lauvanpt:permission privilege='expertDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='expert_delete("
							+ j[i].ex_Id + ")'>删除</a></lauvanpt:permission>";
					str += "</td></tr>";
				}
			}
			$("#expert_data").append(str);
			tabs_init2("main_tabs");
		}
		function postChild(id) {
			$.post('resource/expert/list', {
				ex_Typeid : id
			}, function(j) {
				datas(j);
			});
		}

		function expert_addUI(the) {
			parent.tabs_open(the);
		}

		function expert_edit(id) {
			parent.layer.open({
				type : 2,
				title : '编辑物资信息',
				area : [ '800px', '500px' ],
				scrollbar : false,
				content : [ 'resource/expert/editip?id=' + id, 'no' ],
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow
							.expertEditSubmitForm(index, window);
				}
			});
		}
		function expert_delete(id) {
			parent.layer.confirm('您确定要删除么？', function(index) {
				$.post('resource/expert/delete', {
					exId : id
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

		function searchExpert() {
			$.post('resource/expert/list', $('#searchExpertForm').serialize(),
					function(j) {
						datas(j);
					});
		}
		
		function excelOut(){
			window.open('<%=basePath%>'+"resource/expert/excelOut");
		}
		
		function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/resource/expert/import.jsp',
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