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
				<form class="form-inline" action="resource/assets/square"
					method="post">
					<input type="hidden" name="query" value="true" />
					<div class="form-group">
						<label for="sq_Name">名称</label> <input type="text" name="sq_Name"
							class="form-control" id="sq_Name" placeholder="输入广场名称">
					</div>
					<button type="submit" class="btn btn-default">
						<i class="icon-search"></i>搜索
					</button>
					<button type="button" class="btn btn-primary" onclick="resAdd();">添加</button>
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

			<!-- 庇护场所表格 -->
			<form id="squareForm" action="resource/assets/square" method="post">
				<input type="hidden" name="page" /> <input type="hidden"
					name="query" />
					<table
						class="table table-bordered table-striped table-hover table-condensed">
						<tr class="info">
							<th style="text-align:center">名称</th>
							<th style="text-align:center">所属单位</th>
							<th style="text-align:center">联系人</th>
							<th style="text-align:center">联系人电话</th>
							<th style="text-align:center">操作</th>
						</tr>

						<c:forEach items="${pageView.records}" var="entry"
							varStatus="statu">
							<c:choose>
								<c:when test="${statu.index % 2 ==0}">
									<tr id="mapRes${entry.sq_Id}"
										style="background-color: #ebf8ff;"
										onclick="trMapAnimation(${entry.sq_Id},${entry.sq_Longitude},${entry.sq_Latitude})">
										<input type="hidden" name="resId" value="${entry.sq_Id}">
										<input type="hidden" name="resName" value="${entry.sq_Name}">
										<input type="hidden" name="resAddress"
											value="${entry.sq_Address}">
										<input type="hidden" name="sq_Longitude"
											value="${entry.sq_Longitude}">
										<input type="hidden" name="sq_Latitude"
											value="${entry.sq_Latitude}">
										<td style="text-align:center">${entry.sq_Name}</td>
										<td style="text-align:center">${entry.sq_Dept}</td>
										<td style="text-align:center">${entry.sq_Linkman}</td>
										<td style="text-align:center">${entry.sq_Linkmantel}</td>
										<td style="text-align:center"><a
											href="javascript:void(0);" class="btn btn-primary btn-xs"
											onclick="resEdit(${entry.sq_Id})">编辑</a> <a
											href="javascript:void(0);" class="btn btn-danger btn-xs"
											onclick="resDelete(${entry.sq_Id})">删除</a></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr id="mapRes${entry.sq_Id}"
										onclick="trMapAnimation(${entry.sq_Id},${entry.sq_Longitude},${entry.sq_Latitude})">
										<input type="hidden" name="resId" value="${entry.sq_Id}">
										<input type="hidden" name="resName" value="${entry.sq_Name}">
										<input type="hidden" name="resAddress"
											value="${entry.sq_Address}">
										<input type="hidden" name="sq_Longitude"
											value="${entry.sq_Longitude}">
										<input type="hidden" name="sq_Latitude"
											value="${entry.sq_Latitude}">
										<td style="text-align:center">${entry.sq_Name}</td>
										<td style="text-align:center">${entry.sq_Dept}</td>
										<td style="text-align:center">${entry.sq_Linkman}</td>
										<td style="text-align:center">${entry.sq_Linkmantel}</td>
										<td style="text-align:center"><a
											href="javascript:void(0);" class="btn btn-primary btn-xs"
											onclick="resEdit(${entry.sq_Id})">编辑</a> <a
											href="javascript:void(0);" class="btn btn-danger btn-xs"
											onclick="resDelete(${entry.sq_Id})">删除</a></td>
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
		$("input[name^='sq_Longitude']").each(function(i, o) {
			longitude[i] = $(o).val();
		});
		$("input[name^='sq_Latitude']").each(function(i, o) {
			latitude[i] = $(o).val();
		});

		var map = new BMap.Map("container", {});
		map.centerAndZoom(new BMap.Point(114.184251, 23.708991), 12);
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
				title : '添加广场',
				area : [ '800px', '640px' ],
				content : 'resource/assets/addip?type=10',
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow
							.squareAdd(index, window);
				},
			});
		}

		function resEdit(resId) {
			parent.parent.layer.open({
				type : 2,
				title : '编辑广场',
				area : [ '800px', '640px' ],
				content : 'resource/assets/editip?type=10&id=' + resId,
				btn : [ '确认', '取消' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow
							.squareEdit(index, window);
				},
			});
		}

		function resDelete(resId) {
			layer.msg('确定删除该条广场信息？', {
				time : 0 //不自动关闭
				,
				btn : [ '确认', '取消' ],
				yes : function(index) {
					layer.close(index);
					$.post('resource/assets/delete?type=10&resId=' + resId,
							function(j) {
								if (j.success) {
									window.location.reload();
								}
							}, 'json');
				}
			});
		}
		
		function excelOut(){                             
			window.open('<%=basePath%>'+"resource/assets/squareExcelOut");
		}
		
		function excelIn() {
			parent.layer.open({
				type : 2,
				title : '上传excel文件并导入',
				area : [ '500px', '250px' ],
				scrollbar : false,
				content : 'jsp/resource/assets/import.jsp',
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