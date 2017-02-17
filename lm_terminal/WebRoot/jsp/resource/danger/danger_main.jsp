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
<title>危险源管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.css"
	type="text/css"></link>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=LEcDcElRR6zFXoaG6jtANQYW"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/MarkerTool/1.2/src/MarkerTool_min.js"></script>
<jsp:include page="/include/pub.jsp"></jsp:include>
<script src="lauvanUI/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<div class="row" style="margin: 25px 10px 0 0;">
		<div class="col-md-2">
			<div id="dangertreeview"></div>
		</div>
		<div class="col-md-5">
			<div class="row" style="margin-bottom: 10px;">
				<form id="searchDangerForm" class="form-inline" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="da_Name">名称</label> <input type="text" name="da_Name"
							class="form-control" id="da_Name" placeholder="输入危险源名称">
					</div>
					<button type="button" class="btn btn-default"
						onclick="searchDanger()"><i class="icon-search"></i>搜索</button>
					<lauvanpt:permission privilege="dangerAddip">
					<button type="button" class="btn btn-primary"
						onclick="danger_add();">添加</button>
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
				<div style="overflow:scroll; height:616px; OVERFLOW-X:hidden;">
					<table class="table table-bordered table-striped table-hover table-condensed">
						<tr class="info">
							<th style="text-align:center">危险源名称</th>
							<th style="text-align:center">所属单位</th>
							<th style="text-align:center">应急联系人</th>
							<th style="text-align:center">应急联系人电话</th>
							<th style="text-align:center">操作</th>
						</tr>
						<tbody id="danger_data">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="container" class="col-md-5" style="height:660px"></div>
	</div>


	<script type="text/javascript">
	var markers = [];
		$(function() {
			$.post('resource/danger/list?da_Type', function(j) {
				datas(j);
			});

			$.post('resource/dangertype/tree', {}, function(j) {
				var initSelectableTree = function() {
					return $('#dangertreeview').treeview({
						data : j,
						multiSelect : $('#chk-select-multi').is(':checked'),
						onNodeSelected : function(event, node) {
							$("#pid").val(node.href);
							$.post('resource/danger/list', {
								da_Typeid : node.href
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
			$("#danger_data").empty();
			var str = '';
			for (var i = 0; i < j.length; i++) {
				if(i% 2 ==0){
					str += "<tr id='mapDanger"+j[i].da_Id+"' style='background-color: #ebf8ff;' onclick='trMapAnimation("+j[i].da_Id+","+j[i].da_Longitude+","+j[i].da_Latitude+")'>";
					str += "<td style='text-align:center'>" + j[i].da_Name
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].da_Dept
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].da_Patrolman
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].da_Patrolmantel
							+ "</td>";	
					str += "<td style='text-align:center'><lauvanpt:permission privilege='dangerEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs' onclick='danger_edit("
							+ j[i].da_Id
							+ ")'>编辑</a></lauvanpt:permission><lauvanpt:permission privilege='dangerDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='danger_delete("
							+ j[i].da_Id + ")'>删除</a></lauvanpt:permission></td>";
					str += "</tr>";
				}else{                                      
					str += "<tr id='mapDanger"+j[i].da_Id+"' onclick='trMapAnimation("+j[i].da_Id+","+j[i].da_Longitude+","+j[i].da_Latitude+")'>";
					str += "<td style='text-align:center'>" + j[i].da_Name
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].da_Dept
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].da_Patrolman
							+ "</td>";
					str += "<td style='text-align:center'>" + j[i].da_Patrolmantel
							+ "</td>";
					str += "<td style='text-align:center'><lauvanpt:permission privilege='dangerEditip'><a href='javascript:void(0);' class='btn btn-primary btn-xs' onclick='danger_edit("
							+ j[i].da_Id
							+ ")'>编辑</a></lauvanpt:permission><lauvanpt:permission privilege='dangerDelete'><a href='javascript:void(0);' class='btn btn-danger btn-xs' onclick='danger_delete("
							+ j[i].da_Id + ")'>删除</a></lauvanpt:permission></td>";
					str += "</tr>";
				}
			}
			$("#danger_data").append(str);
			mapLoad(j);
		}

		function mapLoad(j) {
			var map = new BMap.Map("container", {}); 
			map.centerAndZoom(new BMap.Point(114.184251, 23.708991),12); 
			map.enableScrollWheelZoom(); //启用滚轮放大缩小，默认禁用
			map.enableContinuousZoom();               //启用滚轮放大缩小
			
			var points = [];
			for (var i = 0; i < j.length; i++) {
				points[i] = new BMap.Point(j[i].da_Longitude, j[i].da_Latitude);
				markers[i] = new BMap.Marker(points[i]);
				var dId = j[i].da_Id;
				var content = "名称:" + j[i].da_Name + "<br>地址:"
				+ j[i].da_Address;
				map.addOverlay(markers[i]);
				addClickHandler(dId,content,markers[i]);
		        }
		}
		var prev=0,prevMarker = '';
		function addClickHandler(id,content,marker){
			var infoWindow = new BMap.InfoWindow(content, opts);
			marker.addEventListener("mouseover", function(){
				   this.openInfoWindow(infoWindow);
				  });
			marker.addEventListener("click",function(e){
				$("#mapDanger"+prev).css("background-color","#ebf8ff");
				if(prevMarker !=''){
					prevMarker.setAnimation(null);
				}
				
				prev = id;
				prevMarker = marker;
				
				$("#mapDanger"+id).css("background-color","#00FFFF");
				marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			});
		}
		
		function trMapAnimation(id,longitude,latitude){
			$("#mapDanger"+prev).css("background-color","#ebf8ff");
			if(prevMarker !=''){
				prevMarker.setAnimation(null);
			}
			prev = id;
			for (var i = 0,h=markers.length; i < h; i++) {
				if(markers[i].point.lng == longitude && markers[i].point.lat == latitude){
					$("#mapDanger"+id).css("background-color","#00FFFF");
					markers[i].setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
					prevMarker = markers[i];
				}
			}
		}
		
		var opts = {
				width : 200, // 信息窗口宽度
				height : 60, // 信息窗口高度
				//title : "标注点详情", // 信息窗口标题
				enableMessage : true
			//设置允许信息窗发送短息
			};

		function postChild(id) {
			$.post('resource/danger/list', {
				da_Typeid : id
			}, function(j) {
				datas(j);
			});
		}

		function danger_mapUI(the) {
			parent.tabs_open(the);
		}

		function danger_add() {
			var pid = $("#pid").val();
			if (pid == null || pid == '') {
				parent.layer.msg("未选择分类，无法添加");
			} else {
				parent.layer.open({
					type : 2,
					title : '添加危险源信息',
					area : [ '800px', '650px' ],
					scrollbar : false,
					content : [ 'resource/danger/addip?typeid=' + pid, 'no' ],
					btn : [ '确认', '取消' ],
					yes : function(index, layero) {
						layero.find('iframe')[0].contentWindow
								.dangerAddSubmitForm(index, window);
					}
				});
			}
		}

		function danger_edit(id) {
			parent.layer.open({
				type : 2,
				title : '编辑危险源信息',
				area : [ '800px', '650px' ],
				scrollbar : false,
				content : [ 'resource/danger/editip?id=' + id, 'no' ],
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow
							.dangerEditSubmitForm(index, window);
				}
			});
		}
		function danger_delete(id) {
			parent.layer.confirm('确定要删除？', function(index) {
				$.post('resource/danger/delete', {
					daId : id
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

		function searchDanger() {
			$.post('resource/danger/list', $('#searchDangerForm').serialize(),
					function(j) {
						datas(j);
					});
		}
		
		function excelOut(){
			window.open('<%=basePath%>'+"resource/danger/excelOut");
		}
		
		function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/resource/danger/import.jsp',
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