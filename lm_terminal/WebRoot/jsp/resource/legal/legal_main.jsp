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
<title>法律法规管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
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
			<div id="legaltreeview"></div>
		</div>
		<div class="col-md-9">
			<div class="row" style="margin-bottom: 10px;">
				<form id="searchLegalForm" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="le_Name">名称</label> <input type="text" name="le_Name"
							class="form-control" id="le_Name" placeholder="输入法律名称">
					</div>
					<button type="button" class="btn btn-default"
						onclick="searchLegal()"><i class="icon-search"></i>搜索</button>
					<lauvanpt:permission privilege="legalAddip">
					<button type="button" class="btn btn-primary"
						onclick="legalAdd()"><i class="icon-search"></i>添加</button>
					</lauvanpt:permission>
					<button style="float: right; margin-left: 5px;" type="button"
						class="btn btn-primary" onclick="excelIn();">
						<span class="glyphicon glyphicon-import"></span> 导入excel
					</button>
				</form>
			</div>
			<div class="row">
				<input type="hidden" id="pid" value="${pid }" />
				<div style="overflow:scroll; height:600px; OVERFLOW-X:hidden;">
					<table
						class="table table-bordered table-striped table-hover table-condensed">
						<tr class="info">
							<th style="text-align:center">编号</th>
							<th style="text-align:center">标题</th>
							<th style="text-align:center">操作</th>
						</tr>
						<tbody id="legal_data">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			$.post('resource/legal/list', function(j) {
				datas(j);
			});

			$.post('resource/legaltype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#legaltreeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#pid").val(node.href);
							$.post('resource/legal/list', {
								le_Typeid : node.href
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
		
		function legalInfo_showUI(le_Id){
			window.open('<%=basePath%>'+"resource/legal/infoshow?le_Id="+le_Id);			
		}
		
		function viewDoc(le_Id){
			window.open("resource/legal/viewdoc?leId="+le_Id);			
		}
		
		function datas(j) {
			$("#legal_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				if (i % 2 == 0) {
					str += "<tr style='background-color: #ebf8ff;'>";
					str += "<td style='text-align:center'>" + j[i].le_Code
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].le_Name
							+ "</td>";
					str += "<td style='text-align:center'><lauvanpt:permission privilege='legalEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' addtabs='parentAddtabs' tab_id='legalEditTab' url='resource/legal/editip?id="
							+ j[i].le_Id
							+ "' title='编辑信息' class='thumbnail'>编辑</a></lauvanpt:permission>";
					str += "<lauvanpt:permission privilege='legalDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='legal_delete("
							+ j[i].le_Id + ")'>删除</a></lauvanpt:permission>";
					str +=  "<button type='button' class='btn btn-success btn-xs'"
							+"onclick='upload("+j[i].le_Id+")'>上传 </button>";
				    if(j[i].le_Filename!== undefined&&j[i].le_Filename.length!=0){
				    	str +=  "<button type='button' class='btn btn-warning btn-xs'"
						     +"onclick='viewDoc("+j[i].le_Id+")'>查看  </button>";			
				    } 
					str += "</td></tr>";
				} else {
					str += "<tr>";
					str += "<td style='text-align:center'>" + j[i].le_Code
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].le_Name
							+ "</td>";
					str += "<td style='text-align:center'><lauvanpt:permission privilege='legalEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs main_tabs' addtabs='parentAddtabs' tab_id='legalEditTab' url='resource/legal/editip?id="
							+ j[i].le_Id
							+ "' title='编辑信息' class='thumbnail'>编辑</a></lauvanpt:permission>";
					str += "<lauvanpt:permission privilege='legalDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='legal_delete("
							+ j[i].le_Id + ")'>删除</a></lauvanpt:permission>";
					str +=  "<button type='button' class='btn btn-success btn-xs'"
							+"onclick='upload("+j[i].le_Id+")'>上传 </button>";
					if(j[i].le_Filename !== undefined&&j[i].le_Filename.length!=0){
					    	str +=  "<button type='button' class='btn btn-warning btn-xs'"
							     +"onclick='viewDoc("+j[i].le_Id+")'>查看  </button>";			
					    } 
					str += "</td></tr>";
				}
			}
			$("#legal_data").append(str);
			tabs_init2("main_tabs");
		}
		function postChild(id) {
			$.post('resource/legal/list', {
				le_Typeid : id
			}, function(j) {
				datas(j);
			});
		}
		
		function legal_addUI(the) {
			parent.tabs_open(the);
		}

		function legal_delete(id) {
			parent.layer.confirm('您确定要删除么？', function(index) {
				$.post('resource/legal/delete', {
					leId : id
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

		function searchLegal() {
			$.post('resource/legal/list', $('#searchLegalForm').serialize(),
					function(j) {
						datas(j);
					});
		}
		
		function legalAdd(){
			var pid = $("#pid").val();
			if (pid == null || pid == '') {
				parent.layer.msg("未选择分类，无法添加");
			} else {
				parent.tabs_open2("tab_legalAddTab_iframe","添加法律信息","resource/legal/addip",pid);
			}
		}
		
		function upload(leId) {
			parent.layer.open({
				type : 2,
				title : '选择法律原件上传',
				area : [ '500px', '300px' ],
				scrollbar : false,
				content : 'jsp/resource/legal/legal_upload.jsp?leId='+leId,
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.fileUpload(index,
							window);
				}
			});
		}
		
		function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/resource/legal/import.jsp',
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