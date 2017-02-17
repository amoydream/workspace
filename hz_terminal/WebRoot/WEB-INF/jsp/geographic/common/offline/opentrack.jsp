<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
<script src="<%=basePath %>plugins/gis/frame/base2.js"></script>


<script type="text/javascript">
var gisPath="<%=basePath%>plugins/gis";
var point={};
require(["<%=basePath%>plugins/gis/frame/arcgisFrame.js","esri/symbols/Font","esri/symbols/TextSymbol","esri/Color",
         "esri/graphic","esri/geometry/Polyline","esri/symbols/SimpleLineSymbol","esri/symbols/PictureMarkerSymbol"],
		function(AGis,Font,TextSymbol,Color,Graphic,Polyline,SimpleLineSymbol,PictureMarkerSymbol){
	
	var lng=${lng},lat=${lat},apiUrl="${apiUrl}",gisUrl="${gisUrl}";
	var list=${list};
	var map=new AGis("map",lng,lat,gisUrl,apiUrl);


	map.addEvent("load",function(){
		var paths=[],point,graphicsList=[];
		var result;
		var pictureSymbol,lineSymbol=new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID, Color.fromString("red"),4),
			font=new Font("14",Font.STYLE_NORMAL,Font.VARIANT_NORMAL,Font.WEIGHT_BOLD,"宋体");
		for(var i=0,len=list.length;i<len;i++){
			result=map.bdToArcgisForPoint(list[i].POSX, list[i].POSY);
			if(i==0 || i==len-1){
				point=map.getPoint(result.lat,result.lng);

				pictureSymbol= new PictureMarkerSymbol(gisPath+"/css/icon/"+(i==0?"start":"end")+".png", 25,40);
				pictureSymbol.setOffset(0, 20);
				graphic=new Graphic(point,pictureSymbol);
				graphicsList.push(graphic);
			}
			paths.push([result.lat,result.lng]);
			if(i==0)
				map.map.centerAt(point);
		}
		
		var polyline=new Polyline(paths);
		graphic=new Graphic(polyline,lineSymbol);
		map.map.graphics.add(graphic);

		for(var i=0,len=graphicsList.length;i<len;i++)
			map.map.graphics.add(graphicsList[i]);
	});

});
</script>
<div id="map" style="width:100%;height:99%;overflow: hidden;"></div>
