<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=LEcDcElRR6zFXoaG6jtANQYW"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/MarkerTool/1.2/src/MarkerTool_min.js"></script>
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
<script type="text/javascript">
	function topage(page) {
		var form = document.forms[1];
		form.page.value = page;
		form.submit();
	}
</script>
</head>

<body>
	<div class="row" style="margin: 25px 10px 0 0;">
		<div class="col-md-7">
			<div style="margin-bottom: 10px;">
				<form class="form-inline" action="resource/suppliesstore/main"
					method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="suCode">物资编号</label> <input type="text" name="suCode"
							class="form-control" id="st_Code" placeholder="输入物资编号">
					</div>
					<div class="form-group">
						<label for="suName">物资名称</label> <input type="text" name="suName"
							class="form-control" id="st_Name" placeholder="输入物资名称">
					</div>
					<button type="submit" class="btn btn-default"><i class="icon-search"></i>搜索</button>
					<lauvanpt:permission privilege="storeAddip">
					<button type="button" class="btn btn-primary" onclick="storeAdd();">添加</button>
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

			<form id="storeForm" action="resource/suppliesstore/main"
				method="post">
				<input type="hidden" name="page" /> <input type="hidden"
					name="query" />
				<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
						<th style="text-align:center">物资名称</th>
						<th style="text-align:center">存放数量</th>
						<th style="text-align:center">管理单位</th>
						<th style="text-align:center">负责人</th>
						<th style="text-align:center">负责人电话</th>
						<th style="text-align:center">操作</th>
					</tr>

					<c:forEach items="${pageView.records}" var="entry"
						varStatus="statu">
						<c:choose>
							<c:when test="${statu.index % 2 ==0}">
								<tr id="mapSuppliesstore${entry.st_Id}" style="background-color: #ebf8ff;" onclick="trMapAnimation(${entry.st_Id},${entry.st_Longitude},${entry.st_Latitude})">
									<input type="hidden" name="st_Id" value="${entry.st_Id}">
									<input type="hidden" name="stAddress"
										value="${entry.st_Address}">
									<input type="hidden" name="stName"
										value="${entry.st_Suppliesid.su_Name}">
									<input type="hidden" name="stCount" value="${entry.st_Count}">
									<input type="hidden" name="st_Longitude"
										value="${entry.st_Longitude}">
									<input type="hidden" name="st_Latitude"
										value="${entry.st_Latitude}">
									<td style="text-align:center">${entry.st_Suppliesid.su_Name}</td>
									<td style="text-align:center">${entry.st_Count}</td>
									<td style="text-align:center">${entry.st_Managedept}</td>
									<td style="text-align:center">${entry.st_Manageman}</td>
									<td style="text-align:center">${entry.st_Managemantel}</td>
									<td style="text-align:center"><lauvanpt:permission privilege="storeEditip"><a
										href="javascript:void(0);" class="btn btn-primary btn-xs"
										onclick="storeEdit(${entry.st_Id})">编辑</a></lauvanpt:permission> <lauvanpt:permission privilege="storeDelete"><a
										href="javascript:void(0);" class="btn btn-danger btn-xs"
										onclick="storeDelete(${entry.st_Id})">删除</a></lauvanpt:permission></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr id="mapSuppliesstore${entry.st_Id}" onclick="trMapAnimation(${entry.st_Id},${entry.st_Longitude},${entry.st_Latitude})">
									<input type="hidden" name="st_Id" value="${entry.st_Id}">
									<input type="hidden" name="stName"
										value="${entry.st_Suppliesid.su_Name}">
									<input type="hidden" name="stAddress"
										value="${entry.st_Address}">
									<input type="hidden" name="stCount" value="${entry.st_Count}">
									<input type="hidden" name="st_Longitude"
										value="${entry.st_Longitude}">
									<input type="hidden" name="st_Latitude"
										value="${entry.st_Latitude}">
									<td style="text-align:center">${entry.st_Suppliesid.su_Name}</td>
									<td style="text-align:center">${entry.st_Count}</td>
									<td style="text-align:center">${entry.st_Managedept}</td>
									<td style="text-align:center">${entry.st_Manageman}</td>
									<td style="text-align:center">${entry.st_Managemantel}</td>
									<td style="text-align:center"><lauvanpt:permission privilege="storeEditip"><a
										href="javascript:void(0);" class="btn btn-primary btn-xs"
										onclick="storeEdit(${entry.st_Id})">编辑</a></lauvanpt:permission> <lauvanpt:permission privilege="storeDelete"><a
										href="javascript:void(0);" class="btn btn-danger btn-xs"
										onclick="storeDelete(${entry.st_Id})">删除</a></lauvanpt:permission></td>
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
		<div id="container" class="col-md-5" style="height:660px"></div>
	</div>

	<script>
		var stId = [];
		var stName = [];
		var stAddress = [];
		var stCount = [];
		var longitude = [];
		var latitude = [];
		$("input[name^='st_Id']").each(function(i, o) {
			stId[i] = $(o).val();
		});
		$("input[name^='stName']").each(function(i, o) {
			stName[i] = $(o).val();
		});
		$("input[name^='stAddress']").each(function(i, o) {
			stAddress[i] = $(o).val();
		});
		$("input[name^='stCount']").each(function(i, o) {
			stCount[i] = $(o).val();
		});
		$("input[name^='st_Longitude']").each(function(i, o) {
			longitude[i] = $(o).val();
		});
		$("input[name^='st_Latitude']").each(function(i, o) {
			latitude[i] = $(o).val();
		});

		var map = new BMap.Map("container", {});
		map.centerAndZoom(new BMap.Point(114.184251, 23.708991),12); 
		map.enableScrollWheelZoom(); //启用滚轮放大缩小，默认禁用
		map.enableContinuousZoom(); //启用滚轮放大缩小
		var points = [];
		var markers = [];
		for (var i = 0; i < stId.length; i++) {
			points[i] = new BMap.Point(longitude[i], latitude[i]);
			markers[i] = new BMap.Marker(points[i]);
			var id = stId[i];
			var content = "名称:" + stName[i] + "<br>存放数量:" + stCount[i]
					+ "<br>地址:" + stAddress[i];
			map.addOverlay(markers[i]);
			addClickHandler(id, content, markers[i]);
		}
		var prev=0,prevMarker = '';
		function addClickHandler(id, content, marker) {
			var infoWindow = new BMap.InfoWindow(content, opts);
			marker.addEventListener("mouseover", function() {
				this.openInfoWindow(infoWindow);
			});
			
			marker.addEventListener("click", function(e) {
				$("#mapSuppliesstore"+prev).css("background-color","#ebf8ff");
				if(prevMarker !=''){
					prevMarker.setAnimation(null);
				}
				
				prev = id;
				prevMarker = marker;
				
				$("#mapSuppliesstore"+id).css("background-color","#00FFFF");
				marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			});
		}

		function trMapAnimation(id,longitude,latitude){
			$("#mapSuppliesstore"+prev).css("background-color","#ebf8ff");
			if(prevMarker !=''){
				prevMarker.setAnimation(null);
			}
			prev = id;
			for (var i = 0,h=markers.length; i < h; i++) {
				if(markers[i].point.lng == longitude && markers[i].point.lat == latitude){
					$("#mapSuppliesstore"+id).css("background-color","#00FFFF");
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

		function storeAdd() {
			parent.layer.open({
				type : 2,
				title : '添加物资存储信息',
				area : [ '800px', '450px' ],
				content : 'resource/suppliesstore/addip',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow.add(
							index, window);
				},
			});
		}

		function storeEdit(stId) {
			parent.layer.open({
				type : 2,
				title : '编辑物资存储信息',
				area : [ '800px', '450px' ],
				content : 'resource/suppliesstore/editip?id=' + stId,
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow
							.edit(index, window);
				},
			});
		}

		function storeDelete(shId) {
			layer.msg('确定删除该条物资存储信息？', {
				time : 0 //不自动关闭
				,
				btn : [ '确认', '取消' ],
				yes : function(index) {
					$.post('resource/suppliesstore/delete?shId=' + shId,
							function(j) {
								if (j.success) {
									parent.layer.msg("删除成功");
									window.location.reload();
								}
								parent.layer.tips(j.msg, '.layui-layer-btn0', {
									tips : 1
								});
							}, 'json');
				}
			});
		}
		
		function excelOut(){
			window.open('<%=basePath%>'+"resource/suppliesstore/excelOut");
		}
		
		function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/resource/suppliesstore/import.jsp',
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