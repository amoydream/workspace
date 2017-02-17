<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="lauvanpt"
	uri="http://java.lauvan.com/lauvan/permission"%>
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
				<form class="form-inline" action="resource/assets/uptown" method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="up_Name">名称</label> <input type="text" name="up_Name"
							class="form-control" id="up_Name" placeholder="输入社区名称">
					</div>
					<button type="submit" class="btn btn-default">
						<i class="icon-search"></i>搜索
					</button>
						<button type="button" class="btn btn-primary"
							onclick="resAdd();">添加</button>
				</form>
			</div>

			<!-- 庇护场所表格 -->
			<form id="uptownForm" action="resource/assets/uptown" method="post">
				<input type="hidden" name="page" /> <input type="hidden"
					name="query" />
				<table
					class="table table-bordered table-striped table-hover table-condensed">
					<tr class="info">
						<th style="text-align:center">名称</th>
						<th style="text-align:center">居住人数</th>
						<th style="text-align:center">面积</th>
						<th style="text-align:center">联系人</th>
						<th style="text-align:center">联系人电话</th>
						<th style="text-align:center">操作</th>
					</tr>

					<c:forEach items="${pageView.records}" var="entry"
						varStatus="statu">
						<c:choose>
							<c:when test="${statu.index % 2 ==0}">
								<tr id="mapRes${entry.up_Id}"
									style="background-color: #ebf8ff;"
									onclick="trMapAnimation(${entry.up_Id},${entry.up_Longitude},${entry.up_Latitude})">
									<input type="hidden" name="resId" value="${entry.up_Id}">
									<input type="hidden" name="resName" value="${entry.up_Name}">
									<input type="hidden" name="resAddress"
										value="${entry.up_Address}">
									<input type="hidden" name="up_Longitude"
										value="${entry.up_Longitude}">
									<input type="hidden" name="up_Latitude"
										value="${entry.up_Latitude}">
									<td style="text-align:center">${entry.up_Name}</td>
									<td style="text-align:center">${entry.up_Galleryful}</td>
									<td style="text-align:center">${entry.up_Area}</td>
									<td style="text-align:center">${entry.up_Linkman}</td>
									<td style="text-align:center">${entry.up_Linkmantel}</td>
									<td style="text-align:center">
											<a href="javascript:void(0);" class="btn btn-primary btn-xs"
												onclick="resEdit(${entry.up_Id})">编辑</a>
											<a href="javascript:void(0);" class="btn btn-danger btn-xs"
												onclick="resDelete(${entry.up_Id})">删除</a>
										</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr id="mapRes${entry.up_Id}"
									onclick="trMapAnimation(${entry.up_Id},${entry.up_Longitude},${entry.up_Latitude})">
									<input type="hidden" name="resId" value="${entry.up_Id}">
									<input type="hidden" name="resName" value="${entry.up_Name}">
									<input type="hidden" name="resAddress"
										value="${entry.up_Address}">
									<input type="hidden" name="up_Longitude"
										value="${entry.up_Longitude}">
									<input type="hidden" name="up_Latitude"
										value="${entry.up_Latitude}">
									<td style="text-align:center">${entry.up_Name}</td>
									<td style="text-align:center">${entry.up_Galleryful}</td>
									<td style="text-align:center">${entry.up_Area}</td>
									<td style="text-align:center">${entry.up_Linkman}</td>
									<td style="text-align:center">${entry.up_Linkmantel}</td>
									<td style="text-align:center">
											<a href="javascript:void(0);" class="btn btn-primary btn-xs"
												onclick="resEdit(${entry.up_Id})">编辑</a>
											<a href="javascript:void(0);" class="btn btn-danger btn-xs"
												onclick="resDelete(${entry.up_Id})">删除</a>
										</td>
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
		var resId = [];
		var resName = [];
		var resAddress = [];
		var longitude = [];
		var latitude = [];
		$("input[name^='resId']").each(function(i, o) {
			resId[i] = $(o).val();
		});
		$("input[name^='resName']").each(function(i, o) {
			resName[i] = $(o).val();
		});
		$("input[name^='resAddress']").each(function(i, o) {
			resAddress[i] = $(o).val();
		});
		$("input[name^='up_Longitude']").each(function(i, o) {
			longitude[i] = $(o).val();
		});
		$("input[name^='up_Latitude']").each(function(i, o) {
			latitude[i] = $(o).val();
		});

		var map = new BMap.Map("container", {});
		map.centerAndZoom(new BMap.Point(114.184251, 23.708991),12); 
		map.enableScrollWheelZoom(); //启用滚轮放大缩小，默认禁用
		map.enableContinuousZoom(); //启用滚轮放大缩小
		var points = [];
		var markers = [];
		for (var i = 0; i < resId.length; i++) {
			points[i] = new BMap.Point(longitude[i], latitude[i]);
			markers[i] = new BMap.Marker(points[i]);
			var id = resId[i];
			var content = "名称:" + resName[i] + "<br>地址:" + resAddress[i];
			map.addOverlay(markers[i]);
			addClickHandler(id, content, markers[i]);
		}

		var prev = 0, prevMarker = '';
		function addClickHandler(id, content, marker) {
			var infoWindow = new BMap.InfoWindow(content, opts);
			marker.addEventListener("mouseover", function() {
				this.openInfoWindow(infoWindow);
			});
			marker.addEventListener("click", function(e) {
				$("#mapRes" + prev).css("background-color", "#ebf8ff");
				if (prevMarker != '') {
					prevMarker.setAnimation(null);
				}

				prev = id;
				prevMarker = marker;

				$("#mapRes" + id).css("background-color", "#00FFFF");
				marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			});
		}

		function trMapAnimation(id, longitude, latitude) {
			$("#mapRes" + prev).css("background-color", "#ebf8ff");
			if (prevMarker != '') {
				prevMarker.setAnimation(null);
			}
			prev = id;
			for (var i = 0, h = markers.length; i < h; i++) {
				if (markers[i].point.lng == longitude
						&& markers[i].point.lat == latitude) {
					$("#mapRes" + id).css("background-color", "#00FFFF");
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

		function resAdd() {
			parent.parent.layer.open({
				type : 2,
				title : '添加社区',
				area : [ '800px', '640px' ],
				content : 'resource/assets/addip?type=6',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow.uptownAdd(
							index, window);
				},
			});
		}

		function resEdit(resId) {
			parent.parent.layer.open({
				type : 2,
				title : '编辑社区',
				area : [ '800px', '640px' ],
				content : 'resource/assets/editip?type=6&id=' + resId,
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow
							.uptownEdit(index, window);
				},
			});
		}

		function resDelete(resId) {
			layer.msg('确定删除该条社区信息？', {
				time : 0 //不自动关闭
				,
				btn : [ '确认', '取消' ],
				yes : function(index) {
					layer.close(index);
					$.post('resource/assets/delete?type=6&resId=' + resId, function(j) {
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