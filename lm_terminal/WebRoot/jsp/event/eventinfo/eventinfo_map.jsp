<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>所有POI的查询-地址解析</title>

<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=LEcDcElRR6zFXoaG6jtANQYW"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/MarkerTool/1.2/src/MarkerTool_min.js"></script>
<jsp:include page="/include/pub.jsp"></jsp:include>
</head>
<body>
	<div class="container-fluid" style="margin-top: 25px;">
		<div class="row-fluid" style="height:600px;margin-top: 20px">
			<input type="hidden" name="centerLongitude" value="${longitude }" />
			<input type="hidden" name="centerLatitude" value="${latitude }" />
			<input type="hidden" name="eventTypeId" value="${eventTypeId }" />

			<!-- 检索条件区 -->
			<div class="col-md-3 col-md-offset-1 " style="margin-left: 30px">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">检索条件</h3>
					</div>
					<div class="panel-body">
					<div class="input-group">
					<input type="text" class="form-control" id="radii" name="radii" placeholder="输入范围半径">
					<span class="input-group-addon">m(米)</span>
					</div>
						<div class="input-group">
							<button class="btn btn-default "
								style="padborder-left-width 10px" onclick="teamDisplay();">附近队伍</button>
						</div>
						<div class="input-group">
							<input type="hidden" id="piId"> <input type="text"
								id="piName" class="btn btn-default" onclick="selectEmeplan();"
								placeholder="预案选择" />
							<button class="btn btn-default " type="button"
								onclick="suppliesList()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</div>
					</div>
				</div>
				

				<div class="panel panel-primary" style="height:490px">
					<div class="panel-heading">
						<h3 class="panel-title">物资选择</h3>
					</div>
					<div class="panel-body suppliesList">
					</div>
				</div>
			</div>


			<!-- 地图区-->
			<div class="col-md-8">
				<div class="panel panel-danger">
					<div class="panel-heading">
						<h3 class="panel-title">地图窗口</h3>
					</div>
					<div class="panel-body">
						<div id="container" style="height:580px"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	function suppliesList(){
		var piId = $('#piId').val();
		$.post('emeplan/supplies/checkList',{piId:piId},function(j){
			var str = ''
			for (var i = 0; i < j.length; i++) {
			str +=	"<label class='checkbox-inline'> <input type='checkbox' name='inlineCheckbox' value="+j[i].suppliy.su_Id+"> "+j[i].suppliy.su_Name+"</label>"; 
			}
			str +=	"<button class='btn btn-default' type='button' onclick='suppliesDisplay()'>提交</button>";
			$(".suppliesList").html(str);
		})
		
	}
	
	   function selectEmeplan(){
		   parent.layer.open({
			    type: 2,
			    title:'选择相关预案',
			    area:['800px','500px'],
			    scrollbar: false,
			    content: 'jsp/event/eventinfo/eventinfo_selectemeplan.jsp?eventTypeId='+${eventTypeId},
			    btn:['确认','取消'],
			    yes:function(index,layero){
			    	 layero.find('iframe')[0].contentWindow.selectPlanBack(index,window);
			    }
			}); 
	   }

		function suppliesDisplay() {
			var r=document.getElementsByName("inlineCheckbox"); 
			   var checkedIds= r[0].value;
			    for(var i=1;i<r.length;i++){
			         if(r[i].checked){
			         checkedIds += ","+r[i].value
			       }}
			
			var suppliesMarker = new Array();
			var suppliesIds = checkedIds;
			var radii = $('#radii').val();
			$.post('resource/suppliesstore/search2', {
				longitude : ${longitude},
				latitude : ${latitude},
				ids : suppliesIds,
				radii : radii
			}, function(data) {
				for (i = 0; i < data.length; i++) {
					suppliesMarker[i] = new Array();
					suppliesMarker[i][0] = data[i].st_Longitude;
					suppliesMarker[i][1] = data[i].st_Latitude;
					suppliesMarker[i][2] = data[i].st_Suppliesid.su_Name;
					suppliesMarker[i][3] = data[i].st_Count;
					suppliesMarker[i][4] = 0;
					suppliesMarker[i][5] = data[i].st_Id;
				}
				suppliesMarkerInit(suppliesMarker, data.length, radii);
			});
		}

		function suppliesMarkerInit(suppliesMarker, minum2, radii) {
			var map = new BMap.Map("container");
			var sPoint = new BMap.Point(${longitude}, ${latitude});
			map.centerAndZoom(sPoint, 13);
			map.enableScrollWheelZoom();

			var smarker = new BMap.Marker(sPoint); // 创建标注，为要查询的地方对应的经纬度
			var icon = BMapLib.MarkerTool.SYS_ICONS[14]; //设置工具样式，使用系统提供的样式BMapLib.MarkerTool.SYS_ICONS[0] -- BMapLib.MarkerTool.SYS_ICONS[23]
			smarker.setIcon(icon);
			map.addOverlay(smarker);

			for (i = 0; i < minum2; ++i) {
				var p1 = new BMap.Point(suppliesMarker[i][0],
						suppliesMarker[i][1]);
				suppliesMarker[i].num = (map.getDistance(sPoint, p1))
						.toFixed(2);
			}

			suppliesMarker.sort(function(a, b) {
				return a.num - b.num
			});
			if (minum2 > 10) {
				minum2 = 10;
			}

			var spoint = new Array(); //存放标注点经纬信息的数组  
			var smarker = new Array(); //存放标注点对象的数组 

			var smyGeo = new BMap.Geocoder();

			map.addOverlay(new BMap.Circle(sPoint, radii)); //添加一个圆形覆盖物
			smyGeo.getLocation(sPoint, function sCallback(rs) {
				for (i = 0; i < minum2; i++) {
					spoint[i] = new BMap.Point(suppliesMarker[i][0],
							suppliesMarker[i][1]); //循环生成新的地图点  
					smarker[i] = new BMap.Marker(spoint[i]); //按照地图点坐标生成标记  
					map.addOverlay(smarker[i]);
					var content = "物资名称:" + suppliesMarker[i][2] + "<br>库存:"
							+ suppliesMarker[i][3];
					addClickHandler(map, content, smarker[i]);
				}
			})
		}

		function addClickHandler(map, content, smarker) {
			smarker.addEventListener("click", function(e) {
				openInfo(map, content, e)
			});
		}

		function openInfo(map, content, e) {
			var p = e.target;
			var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
			var infoWindow = new BMap.InfoWindow(content, opts); // 创建信息窗口对象 
			map.openInfoWindow(infoWindow, point);
		}

		/* 附近队伍查找 */
		var teamMarker = new Array(new Array(), new Array());
		function teamDisplay() {
			$.post('resource/team/search', {
				longitude : ${longitude},
				latitude : ${latitude}
			}, function(data) {

				for (i = 0; i < data.length; ++i) {
					teamMarker[i][0] = data[i].te_Longitude;
					teamMarker[i][1] = data[i].te_Latitude;
					teamMarker[i][2] = data[i].te_Name;
					teamMarker[i][3] = data[i].te_Linkman;
					teamMarker[i][4] = 0;
					teamMarker[i][5] = data[i].te_Id;
					teamMarker[i][6] = data[i].te_Linkmanphone;
				}
			});
			teamMarkerInit();
		}

		function teamMarkerInit() {
			var minum = teamMarker.length;

			var map = new BMap.Map("container");
			var mPoint = new BMap.Point(${longitude}, ${latitude});
			map.centerAndZoom(mPoint, 13);
			map.enableScrollWheelZoom();

			var marker = new BMap.Marker(mPoint); // 创建标注，为要查询的地方对应的经纬度
			var icon = BMapLib.MarkerTool.SYS_ICONS[14]; //设置工具样式，使用系统提供的样式BMapLib.MarkerTool.SYS_ICONS[0] -- BMapLib.MarkerTool.SYS_ICONS[23]
			marker.setIcon(icon);
			map.addOverlay(marker);

			for (i = 0; i < minum; ++i) {
				var p1 = new BMap.Point(teamMarker[i].te_longitude,
						teamMarker[i].te_latitude);
				teamMarker[i].num = (map.getDistance(mPoint, p1)).toFixed(2);
			}

			teamMarker.sort(function(a, b) {
				return a.num - b.num
			});
			if (minum > 10) {
				minum = 10;
			}

			var point = new Array(); //存放标注点经纬信息的数组  
			var marker = new Array(); //存放标注点对象的数组 

			var myGeo = new BMap.Geocoder();

			map.addOverlay(new BMap.Circle(mPoint, 5000)); //添加一个圆形覆盖物
			myGeo.getLocation(mPoint, function mCallback(rs) {
				for (i = 0; i < minum; ++i) {
					point[i] = new BMap.Point(teamMarker[i][0],
							teamMarker[i][1]); //循环生成新的地图点  
					marker[i] = new BMap.Marker(point[i]); //按照地图点坐标生成标记  
					map.addOverlay(marker[i]);

					var content = "队伍名称:" + teamMarker[i][2] + "<br>联系人:"
							+ teamMarker[i][3] + "<br>电话:" + teamMarker[i][6];
					marker[i].addEventListener("click", function(e) {
						var p = e.target;
						var point = new BMap.Point(p.getPosition().lng, p
								.getPosition().lat);
						var infoWindow = new BMap.InfoWindow(content, opts); // 创建信息窗口对象 
						map.openInfoWindow(infoWindow, point);
					} //开启信息窗口
					);
				}
			})
		}

		var opts = {
			width : 250, // 信息窗口宽度
			height : 80, // 信息窗口高度
			title : "标注点详情", // 信息窗口标题
			enableMessage : true
		//设置允许信息窗发送短息
		};
	</script>
</body>