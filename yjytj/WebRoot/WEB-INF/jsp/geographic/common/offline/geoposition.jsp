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
require(["<%=basePath%>plugins/gis/frame/arcgisFrame.js"],function(AGis){
	
	var lng=${lng},lat=${lat},apiUrl="${apiUrl}",gisUrl="${gisUrl}",display=${display},zoom=${zoom};
	var map=new AGis("map",lng,lat,gisUrl,apiUrl,zoom);

	if(display){
		map.addEvent("load",function(){
			var mapPoint=map.getPoint(lng,lat);
			point.lng=lng;
			point.lat=lat;
			map.drawPicture("<%=basePath%>plugins/gis/css/img/donghua.gif",32,32,mapPoint);
		});
	}
	map.addEvent("click",function(pt){
		map.clearAllLayers();
		layer=map.drawPicture("<%=basePath%>plugins/gis/css/img/donghua.gif",32,32,pt);
		point.lng=pt.x.toFixed(6);
		point.lat=pt.y.toFixed(6);
	});
	
	var findDlg=$.fn.customDialog.createDialog("findDlg","查找","magnifier",$("#posdlg"));
	findDlg.open();

	var mainFrame=findDlg.getMainFrame(),graphicLayer;
	if(mainFrame.html()==""){
		var i,len;
		var firstRow=$("<p style=\"font-weight:bold;display:inline-block;\">输入查找名称(支持模糊查询)：</p>");
		var secondRow=$("<div style=\"margin:6px;\"></div>");
		var textInput=$("<input type=\"text\" style=\"width:270px;\"/>"),findBtn=$("<input type=\"button\" value=\"查询\"/>"),clearBtn=$("<input style=\"margin-left:4px;\" type=\"button\" value=\"清空\"/>");
		var thirdRow=$("<div  style=\"margin:18px 0;text-align:center;\"></div>");

		secondRow.append(textInput);
		thirdRow.append(findBtn).append(clearBtn);
		mainFrame.append(firstRow).append(secondRow).append(thirdRow);

		graphicLayer=map.addGraphicLayer(findDlg,"findLayer");
		

		findBtn.on("click",function(){
			var text=$.trim(textInput.val());
			if(text==""){
				alert("请输入查找名称！");
				return;
			}
			findBtn.prop("disabled",true).val("加载中..");
			map.findInfo(text,graphicLayer,function(){
				findBtn.prop("disabled",false).val("查找");
			});
		});

		clearBtn.on("click",function(){
			graphicLayer.clear();
			textInput.val("");
		});
		
	}
	$("div.specil_table").css({"width":"103px","margin":0});
	$("a.specil_title").css({"width":"100px"});
	findDlg.open();
});
</script>
<div style="width:100%;height:100%;position:relative;">
<div style="position:absolute;z-index:9999;background:#EDF4FF; font-size:14px;color:red;line-height:20px;margin:5px 10px;padding:5px;">温馨提示：在地图上鼠标左键单击即可获取点坐标，滚动滚轮可放大缩小地图</div>
<div id="map" style="width:100%;height:99%;overflow: hidden;"></div>

<div id="posdlg" class="treeee2" ">
</div>
</div>