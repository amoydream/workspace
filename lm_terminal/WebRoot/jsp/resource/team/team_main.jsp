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
<script type="text/javascript" src="lauvanUI/layer/layer.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=LEcDcElRR6zFXoaG6jtANQYW"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/MarkerTool/1.2/src/MarkerTool_min.js"></script>
<jsp:include page="/include/pub.jsp"></jsp:include>
<script src="js/bootstrap-tabs.js"></script>
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
				<form class="form-inline" action="resource/team/main" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="te_Name">名称</label> <input type="text" name="te_Name"
							class="form-control" id="te_Name" placeholder="输入队伍名称">
					</div>
					<button type="submit" class="btn btn-default"><i class="icon-search"></i>搜索</button>
					<lauvanpt:permission privilege="teamAddip">
					<button type="button" class="btn btn-primary" onclick="teamAdd();">添加</button>
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

			<!-- 队伍信息表格 -->
			<form id="teamForm" action="resource/team/main" method="post">
				<input type="hidden" name="page" /> <input type="hidden"
					name="query" />
				<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
						<th style="text-align:center">队伍名称</th>
						<th style="text-align:center">联系人</th>
						<th style="text-align:center">联系人手机</th>
						<th style="text-align:center">所属单位</th>
						<th style="text-align:center">队伍分类</th>
						<th style="text-align:center">操作</th>
					</tr>

					<c:forEach items="${pageView.records}" var="entry"
						varStatus="statu">
						<c:choose>
							<c:when test="${statu.index % 2 ==0}">
								<tr id="mapTeam${entry.te_Id}"
									style="background-color: #ebf8ff;"
									onclick="trMapAnimation(${entry.te_Id},${entry.te_Longitude},${entry.te_Latitude})">
									<input type="hidden" name="te_Id" value="${entry.te_Id}">
									<input type="hidden" name="teName" value="${entry.te_Name}">
									<input type="hidden" name="tePhone" value="${entry.te_Directorphone}">
									<input type="hidden" name="te_Longitude"
										value="${entry.te_Longitude}">
									<input type="hidden" name="te_Latitude"
										value="${entry.te_Latitude}">
									<td style="text-align:center">${entry.te_Name}</td>
									<td style="text-align:center">${entry.te_Director}</td>
									<td style="text-align:center">${entry.te_Directorphone}</td>
									<td style="text-align:center">${entry.te_Deptid.or_name}</td>
									<td style="text-align:center">${entry.te_Type}</td>
									<td style="text-align:center"><a
										href="javascript:void(0);" class="btn btn-warning btn-xs "
										addtabs="parentAddtabs"
										url="resource/teamperson/main?teId=${entry.te_Id }"
										title="队伍配置" class='thumbnail'>配置</a> <lauvanpt:permission privilege="teamEditip"><a
										href="javascript:void(0);" class="btn btn-primary btn-xs "
										onclick="teamEdit(${entry.te_Id})">编辑</a></lauvanpt:permission> <lauvanpt:permission privilege="teamDelete"><a
										href="javascript:void(0);" class="btn btn-danger btn-xs "
										onclick="teamDelete(${entry.te_Id})">删除</a></lauvanpt:permission></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr id="mapTeam${entry.te_Id}"
									onclick="trMapAnimation(${entry.te_Id},${entry.te_Longitude},${entry.te_Latitude})">
									<input type="hidden" name="te_Id" value="${entry.te_Id}">
									<input type="hidden" name="teName" value="${entry.te_Name}">
									<input type="hidden" name="tePhone" value="${entry.te_Directorphone}">
									<input type="hidden" name="te_Longitude"
										value="${entry.te_Longitude}">
									<input type="hidden" name="te_Latitude"
										value="${entry.te_Latitude}">
									<td style="text-align:center">${entry.te_Name}</td>
									<td style="text-align:center">${entry.te_Director}</td>
									<td style="text-align:center">${entry.te_Directorphone}</td>
									<td style="text-align:center">${entry.te_Deptid.or_name}</td>
									<td style="text-align:center">${entry.te_Type}</td>
									<td style="text-align:center"><a
										href="javascript:void(0);" class="btn btn-warning btn-xs "
										addtabs="parentAddtabs"
										url="resource/teamperson/main?teId=${entry.te_Id }"
										title="队伍配置" class='thumbnail'>配置</a> <lauvanpt:permission privilege="teamEditip"><a
										href="javascript:void(0);" class="btn btn-primary btn-xs "
										onclick="teamEdit(${entry.te_Id})">编辑</a></lauvanpt:permission> <lauvanpt:permission privilege="teamDelete"><a
										href="javascript:void(0);" class="btn btn-danger btn-xs "
										onclick="teamDelete(${entry.te_Id})">删除</a></lauvanpt:permission></td>
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
	
			var teId = [];
			var teName = [];
			var tePhone = [];
			var longitude = [];
			var latitude = [];
			$("input[name^='te_Id']").each(function(i, o) {
				teId[i] = $(o).val();
			});
			$("input[name^='teName']").each(function(i, o) {
				teName[i] = $(o).val();
			});
			$("input[name^='tePhone']").each(function(i, o) {
				tePhone[i] = $(o).val();
			});
			$("input[name^='te_Longitude']").each(function(i, o) {
				longitude[i] = $(o).val();
			});
			$("input[name^='te_Latitude']").each(function(i, o) {
				latitude[i] = $(o).val();
			});
			
			var map = new BMap.Map("container", {});
			map.centerAndZoom(new BMap.Point(114.184251, 23.708991),12); 
			map.enableScrollWheelZoom(); //启用滚轮放大缩小，默认禁用
			map.enableContinuousZoom(); //启用滚轮放大缩小
			
			var points = [];
			var markers = [];
			for (var i = 0; i < teId.length; i++) {
				points[i] = new BMap.Point(longitude[i], latitude[i]);
				markers[i] = new BMap.Marker(points[i]);
				var id = teId[i];
				var content = "名称:" + teName[i] + "<br>联系方式:"
				+ tePhone[i];
				map.addOverlay(markers[i]);
				addClickHandler(id, content, markers[i]);
			}
	
		var prev = 0, prevMarker = '';
		function addClickHandler(id, content, marker) {
			var infoWindow = new BMap.InfoWindow(content, opts);
			marker.addEventListener("mouseover", function(){
				   this.openInfoWindow(infoWindow);
				  });
			marker.addEventListener("click", function(e) {
				$("#mapTeam" + prev).css("background-color", "#ebf8ff");
				if (prevMarker != '') {
					prevMarker.setAnimation(null);
				}

				prev = id;
				prevMarker = marker;

				$("#mapTeam" + id).css("background-color", "#00FFFF");
				marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			});
		}
		
		function trMapAnimation(id, longitude, latitude) {
			$("#mapTeam" + prev).css("background-color", "#ebf8ff");
			if (prevMarker != '') {
				prevMarker.setAnimation(null);
			}
			prev = id;
			for (var i = 0, h = markers.length; i < h; i++) {
				if (markers[i].point.lng == longitude
						&& markers[i].point.lat == latitude) {
					$("#mapTeam" + id).css("background-color", "#00FFFF");
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

		function teamAdd() {
			parent.layer.open({
				type : 2,
				title : '添加救援队伍',
				area : [ '900px', '680px' ],
				content : 'resource/team/addip',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow.add(
							index, window);
				},
			});
		}

		function teamDelete(teId) {
			layer.msg('确定删除该条队伍信息？', {
				time : 0 //不自动关闭
				,
				btn : [ '确认', '取消' ],
				yes : function(index) {
					layer.close(index);
					$.post('resource/team/delete?teId=' + teId, function(j) {
						if (j.success) {
							window.location.reload();
						}
					}, 'json');
				}
			});
		}

		function teamEdit(teId) {
			parent.layer.open({
				type : 2,
				title : '编辑队伍基本信息',
				area : [ '900px', '680px' ],
				content : 'resource/team/editip?teId=' + teId,
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow
							.edit(index, window);
				},
			});
		}
		
		function excelOut(){
			window.open('<%=basePath%>'+"resource/team/excelOut");
		}
		
		function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/resource/team/import.jsp',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					layero.find('iframe')[0].contentWindow.fileUpload(index,
							window);
				}
			});
		}
	</script>
<script type="text/javascript" src="jsp/resource/team/js/team_cu.js"></script>
</body>
</html>