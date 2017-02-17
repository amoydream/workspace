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

$(function(){
	var lng=${lng},lat=${lat},display=${display};
	var defaultPoint=new BMap.Point(lng,lat),zoomLevel=${zoom};
	var map = new BMap.Map("map");    // 创建Map实例
	map.centerAndZoom(defaultPoint,zoomLevel);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放


	function addPic(point){
		map.clearOverlays();
		icon=new BMap.Icon("<%=basePath%>plugins/gis/css/img/donghua.gif",new BMap.Size(32,32)),
		marker=new BMap.Marker(point,{icon:icon});

		map.addOverlay(marker);
	}

	if(display){
		var pt=new BMap.Point(lng,lat);
		addPic(pt);
		point=pt;
	}
	
	map.addEventListener("click",function(e){
		addPic(e.point);
		point=e.point;
	});
	
	var findDlg=$.fn.customDialog.createDialog("findDlg","查找","magnifier");
	findDlg.appendToolBar("toolbar_table","查询结果",function(){
		findDlg.getAllFrame().hide();
		findDlg.getFrame("find").show();
	});
	findDlg.appendToolBar("toolbar_find","查询",function(){
		findDlg.getAllFrame().hide();
		findDlg.getMainFrame().show();
	});
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
		
		var addFrame=findDlg.getFrame("find");
		if(addFrame.length==0){
			var addFrame=$("<div>");
			var ul=$("<ul id=\"f-result\" style=\"color:black;\">");
			ul.appendTo(addFrame);
			findDlg.appendFrame("find",addFrame);
			addFrame.hide();
		}

		var local,cacheText="";
		var searchPlace=function(text){
			local = new BMap.LocalSearch(map, {
				renderOptions: {map: map, panel: "f-result"}
			});
			local.search(text);
			
			findDlg.getAllFrame().hide();
			findDlg.getFrame("find").show();
		}
		
		findDlg.addCloseEvent("layerHide_find",function(){
			if(local){
				cacheText=$.trim(textInput.val());
				clearBtn.click();
			}
		});
		findDlg.addOpenEvent("layerShow_find",function(){
			if(cacheText!=""){
				textInput.val(cacheText);
				findBtn.click();
			}
		});
		
		findBtn.on("click",function(){
			var text=$.trim(textInput.val());
			if(text==""){
				alert("请输入查找名称！");
				return;
			}
			searchPlace(text);
		});

		clearBtn.on("click",function(){
			if(local){
				local.clearResults();
			}
			textInput.val("");
		});
		
	}
	$("div.specil_table").css({"width":"103px","margin":0});
	$("a.specil_title").css({"width":"100px"});
	findDlg.open();
	
});

</script>
<div style="position:absolute;top:25px;left:0;z-index:9999;background:#EDF4FF; font-size:14px;color:red;line-height:20px;margin:5px 10px;padding:5px;">温馨提示：在地图上鼠标左键单击即可获取点坐标，滚动滚轮可放大缩小地图</div>
<div id="map" style="width:100%;height:99%;overflow: hidden;"></div>

<div class="treeee2" style="top:32px;right:8px;">
</div>