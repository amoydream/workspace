<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>  
<html>  
<head>  
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>定位地图</title>  

</head>
 
<body>
<style type="text/css">  
html{height:100%}  
body{height:100%;margin:0px;padding:0px}  
#container{height:100%}

.mark{
  float: left;
  height: 21px;
  width: 21px;
  border-right: 1px solid #ecedef;
  background-image: url(../../images/icon/icon.gif);
  background-repeat: no-repeat;
  cursor: pointer;
  background-position: 0px 0px;
}
</style>
<div id="container" ></div>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=LEcDcElRR6zFXoaG6jtANQYW"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerTool/1.2/src/MarkerTool_min.js"></script>
<script type="text/javascript">
var map = new BMap.Map("container");
var myCity = new BMap.LocalCity();
myCity.get(myFun);
function myFun(result){
	map.centerAndZoom(result.name, 12);
}

map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用


//定义一个输入框控件类
function InputBox(){
  // 默认停靠位置和偏移量
  this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
  this.defaultOffset = new BMap.Size(10, 10);
}
//通过JavaScript的prototype属性继承于BMap.Control
InputBox.prototype = new BMap.Control();
//自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
InputBox.prototype.initialize = function(map){
  // 创建一个DOM元素
  var div = document.createElement('div');
  var e1 = document.createElement('input');
  e1.type = 'text';
  e1.placeholder = '输入完按回车即刻搜索';
  e1.onfocus=function(){
	  mkrTool.close();
  }
  e1.onkeydown=function(e){
	  var ev= window.event||e;
	  if(ev.keyCode==13){
		  //alert(e1.value);
		  if(e1.value!=null && e1.value.trim()!=""){
			  searchByStationName(e1.value);
		  }
	  }
  }
  div.appendChild(e1);
  div.style.cursor = "text";
  div.style.border = "1px solid gray";
  div.style.backgroundColor = "white";
  
  map.getContainer().appendChild(div);
  // 将DOM元素返回
  return div;
}

//定义一个标记控件类
function PointBox(){
  this.defaultAnchor = BMAP_ANCHOR_TOP_RIGHT;
  this.defaultOffset = new BMap.Size(10, 10);
}
PointBox.prototype = new BMap.Control();
PointBox.prototype.initialize = function(map){
  var div = document.createElement('div');
  var e2 = document.createElement('span');
  e2.className = "mark";
  e2.onclick = function(){
	  mkrTool.open();
  }
  
  div.appendChild(e2);
  div.style.cursor = "pointer";
  div.style.border = "1px solid gray";
  div.style.backgroundColor = "white";
  
  map.getContainer().appendChild(div);
  // 将DOM元素返回
  return div;
}
//创建控件
var myInputBox = new InputBox();
var myInputBox1 = new PointBox();
// 添加到地图当中
map.addControl(myInputBox);
map.addControl(myInputBox1);


//var gc = new BMap.Geocoder();//地址解析类

//开启标记
var mkrTool = new BMapLib.MarkerTool(map, {autoClose: true,followText: "在你找到的位置上点击"});
var tolongitude;
var tolatitude;
mkrTool.addEventListener("markend", function(e){
	tolongitude = e.marker.point.lng
	tolatitude = e.marker.point.lat
	//$('#latitude').val(e.marker.point.lat);
	//parent.mapDialog.dialog('destroy'); 
});
//mkrTool.open();
var icon = BMapLib.MarkerTool.SYS_ICONS[0]; //设置工具样式，使用系统提供的样式BMapLib.MarkerTool.SYS_ICONS[0] -- BMapLib.MarkerTool.SYS_ICONS[23]
mkrTool.setIcon(icon);



	var localSearch = new BMap.LocalSearch(map);
	localSearch.enableAutoViewport(); //允许自动调节窗体大小
	function searchByStationName(keyword) {
		
		localSearch.setSearchCompleteCallback(function(searchResult) {
			var poi = searchResult.getPoi(0);
			if(poi != undefined){
				map.clearOverlays();//清空原来的标注
				map.centerAndZoom(poi.point, 13);
				var marker = new BMap.Marker(new BMap.Point(poi.point.lng,poi.point.lat)); // 创建标注，为要查询的地方对应的经纬度
				map.addOverlay(marker);
				var content = keyword
						+ "<br/><br/>经度：" + poi.point.lng + "<br/>纬度："
						+ poi.point.lat;
				var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>"
						+ content + "</p>");
				marker.addEventListener("click", function() {
					this.openInfoWindow(infoWindow);
				});
			}else{
				alert("没有获取到这个地址");
			}
		});
		localSearch.search(keyword);
	}
	
	function getResult(index,window){
		window.$('#longitude').val(tolongitude);
		window.$('#latitude').val(tolatitude);
		
		window.$('#eventinfo_addform').data('bootstrapValidator').updateStatus('ev_longitude', 'NOT_VALIDATED', null);
		window.$('#eventinfo_addform').data('bootstrapValidator').updateStatus('ev_latitude', 'NOT_VALIDATED', null);
		parent.layer.close(index);
		
	}
	function getResultEdit(index,window){
		window.$('#longitude').val(tolongitude);
		window.$('#latitude').val(tolatitude);
		
		window.$('#eventinfo_editform').data('bootstrapValidator').updateStatus('ev_longitude', 'NOT_VALIDATED', null);
		window.$('#eventinfo_editform').data('bootstrapValidator').updateStatus('ev_latitude', 'NOT_VALIDATED', null);
		parent.layer.close(index);
		
	}
</script>

</body>  
</html>