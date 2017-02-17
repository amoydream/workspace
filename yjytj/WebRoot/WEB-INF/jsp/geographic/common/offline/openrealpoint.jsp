<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
<script src="<%=basePath %>plugins/gis/frame/base2.js"></script>


<script type="text/javascript">
var gisPath="<%=basePath%>plugins/gis";
var _realPointTimer;
require(["<%=basePath%>plugins/gis/frame/arcgisFrame.js","esri/symbols/Font","esri/symbols/TextSymbol","esri/Color",
         "esri/graphic","esri/geometry/Polyline","esri/symbols/SimpleLineSymbol","esri/symbols/PictureMarkerSymbol"],
		function(AGis,Font,TextSymbol,Color,Graphic,Polyline,SimpleLineSymbol,PictureMarkerSymbol){
	
	var lng=${lng},lat=${lat},apiUrl="${apiUrl}",gisUrl="${gisUrl}",zoom=${zoom};
	var map=new AGis("map",lng,lat,gisUrl,apiUrl,zoom);


	map.addEvent("load",function(){

		var getRealPoint=function(){
			var point,graphic,textSymbol;
			var pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/img/donghua.gif", 20,20);
			var color2=Color.fromString("red");
			var font=new Font(14,Font.STYLE_NORMAL,Font.VARIANT_NORMAL,Font.WEIGHT_BOLD,"宋体");
			
			$.post("<%=basePath%>Main/geographic/common/getRealTimePoint",{uids:"${uids}"},function(result){
				
				map.map.graphics.clear();
				for(var i=0,len=result.length;i<len;i++){
					point=map.bdToArcgisForPoint(result[i].POSX, result[i].POSY);
					point=map.getPoint(point.lat,point.lng);
					graphic=new Graphic(point,pictureSymbol);
					map.map.graphics.add(graphic);

					textSymbol=new TextSymbol(result[i].REALNAME,font,color2);
					textSymbol.setOffset(30,0);
					graphic=new Graphic(point,textSymbol);
					map.map.graphics.add(graphic);

					if(i==0)
						map.map.centerAt(point);
				}
			});
		}

		getRealPoint();

		_realPointTimer=window.setInterval(getRealPoint,10000);
	});
});

function clearRealPointTimer(){
	window.clearInterval(_realPointTimer);
}
</script>
<div id="map" style="width:100%;height:99%;overflow: hidden;"></div>
