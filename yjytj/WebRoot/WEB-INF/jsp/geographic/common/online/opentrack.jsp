<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
<script src="<%=basePath %>plugins/gis/frame/base2.js"></script>


<script type="text/javascript">
var gisPath="<%=basePath%>plugins/gis";

$(function(){
	var lng=${lng},lat=${lat};
	var list=${list};
	var defaultPoint=new BMap.Point(lng,lat),zoomLevel=${zoom}+1;
	var map = new BMap.Map("map");    // 创建Map实例
	map.centerAndZoom(defaultPoint,zoomLevel);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

	var pathList=[],point;
	for(var i=0,len=list.length;i<len;i++){
		point =new BMap.Point(list[i].POSX, list[i].POSY);
		pathList.push(point);
	}

	 var polyline = new BMap.Polyline(pathList,{strokeColor:"green", strokeWeight:6, strokeOpacity:0.8});
	 map.addOverlay(polyline);

	 var addPic=function(picSrc,width,height,lat,lng,iconOpts){
			var point=new BMap.Point(lng,lat),
				icon=new BMap.Icon(picSrc,new BMap.Size(width,height),iconOpts),
				marker=new BMap.Marker(point,{icon:icon});

			map.addOverlay(marker);
			return marker;
		}

	if(pathList.length>0)
		addPic(gisPath+"/css/icon/start.png",25,40,pathList[0].lat,pathList[0].lng,{anchor:new BMap.Size(13,40)});
	if(pathList.length>1)
		addPic(gisPath+"/css/icon/end.png",25,40,pathList[pathList.length-1].lat,pathList[pathList.length-1].lng,{anchor:new BMap.Size(13,40)});

	if(pathList.length>0)
		map.setCenter(pathList[0]);
});

</script>
<div id="map" style="width:100%;height:99%;overflow: hidden;"></div>
