<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <!--The viewport meta tag is used to improve the presentation and behavior of the samples
    on iOS devices-->
  <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
  <title>地理信息</title>
 <link rel="stylesheet" href="${apiUrl }/dijit/themes/tundra/tundra.css"/>
 <link rel="stylesheet" href="${apiUrl }/esri/css/esri.css"/>
 <link rel="stylesheet" href="<%=basePath %>plugins/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
  <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/customicon/icon.css"/>
 <style>
 html body{margin:0;padding:0;}
 .ztree li span{color:white;}
 .ztree li a.curSelectedNode{background-color: #565147;}
 .ztree.legend li span{color:black;}
 .ztree.legend li a.curSelectedNode{background-color: #FFE6B0;}
 .esriPopup .actionsPane{display:none;}
 
 .esriPopup .contentPane table{border-left:1px solid black;border-top:1px solid black;margin-left:10px;}
 .esriPopup .contentPane td,.esriPopup .contentPane th{padding:2px 5px;border-right:1px solid black;border-bottom:1px solid black;}
 </style>
 <script src="${apiUrl }/init.js"></script>
 <script src="<%=basePath %>plugins/gis/core/jquery.js"></script>
 <script src="<%=basePath %>plugins/easyui/jquery.easyui.min.js"></script>
 <script src="<%=basePath %>plugins/ztree/js/jquery.ztree.all-3.5.min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/bigcolorpicker.js"></script>
  <script src="<%=basePath %>js/main.js"></script>
 <script src="<%=basePath %>plugins/gis/frame/base2.js"></script>
<script src="<%=basePath %>plugins/gis/plugins/flowplayer/flowplayer.min.js"></script>
 
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/default/easyui.css"/>
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/icon.css"/>
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/customicon/icon.css"/>
<script src="<%=basePath %>js/datagrid-detailview.js"></script>
<script src="<%=basePath %>js/session.js"></script>


<script>
  	var gisPath="<%=basePath%>plugins/gis";
  	var gisUrl="${gisUrl}";
  	var basePath="<%=basePath%>";
  	var gisMap;


  	window.onunload=function(){
  	  	if(window.opener)
  	  		window.opener.destroyGISWindowHandler();
  	}
  	
    require(["<%=basePath%>plugins/gis/main.js"],function(customMap){
        if(!$.basePath)
            $.basePath="<%=basePath%>";
        gisMap=new customMap("map",${lng},${lat},${zoom},gisUrl,"<%=basePath%>");
    });

    function drawGisPic(list,layerId,picPath){
		var layer,point,firstPoint,width=25,height=25,type,lng,lat;
		
		layer=gisMap.map.getLayer(layerId);
		if(!layer){
			layer=gisMap.addGraphicLayer(layerId);
			layer.on("click",function(evt){
				if(evt.graphic.data.url || evt.graphic.data.URL)
					_openDlg(evt.graphic.data.url || evt.graphic.data.URL);
			});
		}
		layer.clear();
		picPath=(!picPath)?gisPath+"/css/img/donghua.gif":picPath;
		
		for(var i=0,len=list.length;i<len;i++){
			lng=list[i].lng || list[i].LNG;
			lat=list[i].lat || list[i].LAT;
			if(lng && lat){
				point=gisMap.getPoint(lng,lat);
				if(!firstPoint){
					firstPoint=point;
					gisMap.map.centerAt(firstPoint);
				}
				var graphic=gisMap.drawPicture(picPath,width,height,point,null,null,layer);
				graphic.data=list[i];
			}
		}
    }

    function drawSign(list,layerId){
        var layer,point,firstPoint,picName,width=25,height=25,type,lng,lat;
		
		layer=gisMap.map.getLayer(layerId);
		if(!layer){
			layer=gisMap.addGraphicLayer(layerId);
			layer.on("click",function(evt){
				_openDlg(evt.graphic.data.url || evt.graphic.data.URL);
				
			});
		}
		layer.clear();

		for(var i=0,len=list.length;i<len;i++){
			type=list[i].type || list[i].TYPE;
			switch(type){
				case "yjwz":
					picName="safe.png";break;
				case "yjdw":
					picName="home.png";break;
				case "yjzj":
					picName="expert.png";break;
				case "yjzb":
					picName="equiment.gif";break;
			}
			
			if(picName!=""){
				lng=list[i].lng || list[i].LNG;
				lat=list[i].lat || list[i].LAT;
				point=gisMap.getPoint(lng,lat);
				if(!firstPoint){
					firstPoint=point;
					gisMap.map.centerAt(firstPoint);
				}
				var graphic=gisMap.drawPicture(gisPath+"/css/icon/"+picName,width,height,point,null,null,layer);
				graphic.data=list[i];
			}
		}
    }

    function focusAt(list,layerId){
		var layer,point,firstPoint,picName,width=25,height=25,lat,lng;
		
		layer=gisMap.map.getLayer(layerId);
		if(layer!=null){
			for(var i=0,len=layer.graphics.length;i<len;i++){
				if(layer.graphics[i].sign){
					layer.remove(layer.graphics[i]);
				}
			}
			for(var i=0,len=list.length;i<len;i++){
				lng=list[i].lng || list[i].LNG;
				lat=list[i].lat || list[i].LAT;
				point=gisMap.getPoint(lng,lat);
				var graphic=gisMap.drawPicture(gisPath+"/css/img/donghua.gif",width,height,point,null,null,layer);
				graphic.data=list[i];
				graphic.sign=true;
				if(!firstPoint){
					gisMap.map.centerAt(point);
				}
			}
		}
    }

    
  </script>
</head>
  <body>
    <div id="map" style="width:100%;height:100%;position: absolute; left:0; top:0;">
	</div>
	<div id="toolbar">
		
	</div>
	<div class="treeee2">
	</div>
	
  </body>
</html>
