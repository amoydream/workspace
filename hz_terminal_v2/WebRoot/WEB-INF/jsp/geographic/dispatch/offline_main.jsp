<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
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
  <title>指挥调度</title>
 <link rel="stylesheet" href="${apiUrl }/dijit/themes/tundra/tundra.css"/>
 <link rel="stylesheet" href="${apiUrl }/esri/css/esri.css"/>
 <link rel="stylesheet" href="<%=basePath %>plugins/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/icon.css"/>
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/customicon/icon.css"/>
 <style>
 .ztree li span{color:white;}
  #effectList_tree.ztree li span{color:black;}
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
 <script src="<%=basePath %>plugins/easyui/locale/easyui-lang-zh_CN.js"></script>
  <script src="<%=basePath %>js/easyui-justifyposition.js"></script>
 <script src="<%=basePath %>plugins/ztree/js/jquery.ztree.all-3.5.min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/bigcolorpicker.js"></script>
 <script src="<%=basePath %>plugins/gis/frame/base2.js"></script>
 <script src="<%=basePath %>js/session.js"></script>
 <script src="<%=basePath %>js/main.js"></script>
 <script src="<%=basePath %>js/jsloader.js"></script>
 <script src="<%=basePath %>js/extendUI.js"></script>
 <script src="<%=basePath %>js/datagrid-detailview.js"></script>
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/icon.css"/>
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/default/easyui.css"/>
 <link rel="stylesheet" type="text/css" href="<%=basePath %>css/buttoncss.css"/>
<style>
		
		/*空白页样式，放在页面里不需要*/
html,body{ width:100%; height:100%; overflow-x:hidden; overflow-y:auto;}
body {font-size:12px; color:#3c3c3c;margin:0; padding:0;  font-size:12px; font:12px tahoma,arial,'Hiragino Sans GB',\5b8b\4f53,sans-serif;}
*{ margin:0; padding:0; font-family:"Arial","宋体"; }
ul,li{ list-style-type:none;margin:0px; padding:0; border:0;}
a,a:hover{ list-style-type:none; text-decoration: none;}
a{ color:#3c3c3c;}
a:hover{color:#C00;}
.clear {clear:both;}
img{border:none;}
input {
    outline: none;
}

/*实际需要用到样式*/
.map_sp{ width:83.3%; height:100%; float:left; overflow:hidden; position:relative;}
.operation{ width:15.9%; height:100%; float:right;position:relative; border-left:1px solid #666666;}

.op1{ padding-bottom:10px; margin:0 5px; border-bottom:1px solid #dfdfdf; overflow:auto;}
.op1 span{ display:block; width:100%; height:25px; line-height:25px; }
.op1_buttom{ float:right;}
.op1_buttom li{ float:left; width:25px; height:25px; margin:0 5px;}
.op2 h2{ text-indent:5px;}
.op1 h2,.op2 h2{ line-height:40px; font-size:14px;}

.first_menu li{ width:100%; height:34px; border-top:1px solid #AFE7FF;border-bottom:1px solid #FFFFFF; position:relative;}
.first_menu li a{ display:block; width:100%; height:24px; line-height:24px; padding:5px 0; text-align: center; color:#333333;
background-color: #B2EAFF;
  background: -webkit-linear-gradient(top,#E4FFFF 0,#B2EAFF 100%);
  background: -moz-linear-gradient(top,#E4FFFF 0,#B2EAFF 100%);
  background: -o-linear-gradient(top,#E4FFFF 0,#B2EAFF 100%);
  background: linear-gradient(to bottom,#E4FFFF 0,#B2EAFF 100%);
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#E4FFFF,endColorstr=#B2EAFF,GradientType=0);
}

.first_menu li a:hover{
	cursor:pointer;
	background-color: #ffffff;
  background: -webkit-linear-gradient(top,#ffffff 0,#efefef 100%);
  background: -moz-linear-gradient(top,#ffffff 0,#efefef 100%);
  background: -o-linear-gradient(top,#ffffff 0,#efefef 100%);
  background: linear-gradient(to bottom,#ffffff 0,#efefef 100%);
  background-repeat: repeat-x;
}
.first_menu li:hover ul{
	display:block;
}

.second_menu{ position:absolute; z-index:9999; width:200px; left:-200px;top:-1px; background:#333;display:none;}
.second_menu li{ width:100%; height:34px; border-top:1px solid #dfdfdf;border-bottom:1px solid #FFFFFF; position:relative;}
.second_menu li a{ display:block; width:100%; height:24px; line-height:24px; padding:5px 0; text-align: center; color:#333333;
background-color: #B2EAFF;
  background: -webkit-linear-gradient(top,#E4FFFF 0,#B2EAFF 100%);
  background: -moz-linear-gradient(top,#E4FFFF 0,#B2EAFF 100%);
  background: -o-linear-gradient(top,#E4FFFF 0,#B2EAFF 100%);
  background: linear-gradient(to bottom,#E4FFFF 0,#B2EAFF 100%);
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#ffffff,endColorstr=#efefef,GradientType=0);
}

.op3{position:absolute;bottom:150px;text-align:center; width:100%; height:36px;}
.op3 a{line-height:24px; height:24px; padding:5px 20px; margin:0 5px; color:#FFF; border:1px solid #3C5267;
background-color: #06F;
  background: -webkit-linear-gradient(top,#64a3ff 0,#0e6ffc 100%);
  background: -moz-linear-gradient(top,#64a3ff 0,#0e6ffc 100%);
  background: -o-linear-gradient(top,#64a3ff 0,#0e6ffc 100%);
  background: linear-gradient(to bottom,#64a3ff 0,#0e6ffc 100%);
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#64a3ff,endColorstr=#0e6ffc,GradientType=0);
}
.op4{position:absolute;bottom:0px; left:0; width:100%; height:130px;}
.op4_info{ width:100%; margin:0 auto}
.op4_info p{ text-indent:20px; line-height:22px;}
.op4_time{text-align:center;z-index: 10; border-bottom: #cccccc 1px solid; position: absolute; width: 100%;height: 50px; left:0; bottom: 0px; background: #eee;  overflow: auto; border-top: #cccccc 1px solid; line-height:25px;}

#timestr{ display:block; width:90px; height:25px; line-height:25px; margin:0 auto; text-align:left; text-indent:30px; background:url(<%=basePath%>plugins/gis/css/img/clock.png) no-repeat;}
.zoom_sp{ position:absolute; left:83.3%; top:0px; width:0.7%; height:100%; background:#dfdfdf;}
.zoom_sp_button{ position:absolute; left:0;top:50%; width:100%; height:100px; margin-top:-50px; background:#f5f5f5; border-bottom:1px solid #aaaaaa; border-top:1px solid #aaaaaa;}
.zoom_sp_button a{ display:block; width:100%; height:100%; background:url(<%=basePath%>plugins/gis/css/img/rightarrow.png) no-repeat center;}

.pBtn2{
		width:60px;
		height:21px;
		line-height:21px;
		background:grey;
		display:block;
		text-align:center;
		border:1px solid white;
		border-radius:5px;
		color:white;
		text-decoration:none;
		margin-left:15px;
		float:left;
	}
 </style>
 <script>
	var basePath = '<%=basePath%>';
  	var gisPath="<%=basePath%>plugins/gis";
  	var gisUrl="${gisUrl}";
	var curEventId="${event.id}";
	$.basePath = '<%=basePath%>';
	var map = null;
	var cmdposLayer = null;
  	$.messager.defaults = { ok: "确定",cancel: "取消",minimizable:false,maximizable:false,modal:true,width:300,height:160};
  	
require(["<%=basePath%>plugins/gis/main.js","esri/dijit/InfoWindow","esri/geometry/webMercatorUtils","esri/dijit/Print","esri/tasks/PrintTask","esri/tasks/PrintParameters","esri/tasks/PrintTemplate"],
		function(customMap,InfoWindow,webMercatorUtils,Print,PrintTask,PrintParameters,PrintTemplate){
		
		map = new customMap("commandmap",${lng},${lat},${zoom},gisUrl,"<%=basePath%>");
		var graphicLayer=map.addGraphicLayer("effectLayer");
		var picLayer=map.addGraphicLayer("effectPicLayer");

		var pathLayer=map.addGraphicLayer("pathLayer");
		var signLayer=map.addGraphicLayer("signLayer");

		$("#signA").on("click",function(){
			var keys="rest/services";
			var index=gisUrl.indexOf(keys);
			//alert(gisUrl.substr(0,index+keys.length));
			 
			 var printTask = new PrintTask("http://192.168.0.180:6080/arcgis/rest/services/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task");  
             var template = new PrintTemplate();  
             //var dpi = document.getElementById("dpi").value ;  
             template.exportOptions = {  
                 width: 800,  
                 height: 600,  
                 dpi: 96 
             };  
             template.format = "jpg";  
             template.layout = "MAP_ONLY";  
             template.preserveScale = false;  
             var params = new PrintParameters();  
             params.map = map.map;  
             params.template = template;  alert('');
             printTask.execute(params, function(evt){
                 alert(evt.url);
                 window.open(evt.url,"_blank");  
             }); 
		});

		$("#effectDlg .horizon li").on("click",function(){
			map.drawGraphical($(this).find("img").attr("data-type").toUpperCase(),"blue",3,graphicLayer,true);
		});

		$("#situationDlg .horizon li").on("click",function(){
			if(!$("#sitpath_chk").is(":checked")){
				$("#sitpath_chk").click();
			}
			map.drawGraphical($(this).find("img").attr("data-type").toUpperCase(),"red",5,pathLayer,true);
		});

		$(".zoom_sp_button a").on("click",function(){
			if($(".operation:eq(0)").is(":hidden")){
				$(".operation:eq(0)").show();
				$(".zoom_sp").css({left:"83.3%"});
				$(".map_sp").css("width","83.3%");
				$(this).css("background-image","url(<%=basePath%>plugins/gis/css/img/rightarrow.png)");
			}
			else{
				$(".operation:eq(0)").hide();
				$(".zoom_sp").css({left:"99.3%"});
				$(".map_sp").css("width","99.3%");
				$(this).css("background-image","url(<%=basePath%>plugins/gis/css/img/leftarrow.png)");
			}
		});
		
		$("#effect_chk").on("change",function(){
			if($(this).is(":checked")){
				picLayer.show();
				graphicLayer.show();
			}else{
				picLayer.hide();
				graphicLayer.hide();
			}
		});

		$("#sitpath_chk").on("change",function(){
			$(this).is(":checked")?pathLayer.show():pathLayer.hide();
		});
		
		$("#effect_search").on("click",function(){
			var point,infoTemplate,graphicsList=[],finish=[],finishLen=2;
			if(graphicLayer.graphics.length==0){
				alert("请在地图上标绘影响范围，再进行搜索！");
				return;
			}
			$(this).linkbutton("disable");
			picLayer.clear();
			debugger;
			var building=[{lng:114.377368,lat:23.064744},{lng:114.380808,lat:23.065484}];
			for(var temp in building){
				var point=map.getPoint(building[temp].lng,building[temp].lat);
				map.drawPicture("<%=basePath%>plugins/gis/css/img/house/h1.gif",25,25,point,null,null,picLayer);
			}
			function onClick(event, treeId, treeNode){
				
				for(var i=0,len=picLayer.graphics.length;i<len;i++){
					if(treeNode.lng==picLayer.graphics[i].geometry.getLongitude() &&
					   treeNode.lat==picLayer.graphics[i].geometry.getLatitude()){
						if(!$("#effect_chk").is(":checked")){
							$("#effect_chk").trigger("click");
						}
						map.map.infoWindow.setFeatures([picLayer.graphics[i]]);
						map.map.infoWindow.show(picLayer.graphics[i].geometry,InfoWindow.ANCHOR_UPPERRIGHT);
						map.map.centerAt(picLayer.graphics[i].geometry);
						return;
					}
				}
			}
			var setting= {
				data: {
				   simpleData: {
				   enable: true
				   }
				},
				callback: {
				  onClick: onClick
				}
			},nodesList=[],rootNodes={};

			
			
			$.post("<%=basePath%>Main/protectobj/getContent",null,function(result){
				var rootId="0001";
				rootNodes[rootId]={"id":rootId,"pId":0,"name":"保护目标","count":0};
				for(var i=0,len=result.length;i<len;i++){
					if(result[i].LONGITUDE!=null && result[i].LATITUDE!=null){
						point=map.getPoint(result[i].LONGITUDE,result[i].LATITUDE);
						point.picSrc="<%=basePath%>plugins/gis/css/icon/house.png";
						point.infoTemplate=map.getNewInfoTemplate("明细","<b>名称: </b>\${DEFOBJNAME}<br>"
				                + "<b>地址: </b>\${DISTRICTCODE_NAME}\${ADDRESS}<br>"
				                + "<b>负责人: </b>\${RESPPER}<br>"
				                + "<b>负责人办公电话: </b>\${RESPOTEL}<br>"
				                + "<b>主管单位: </b>\${CHARGEDEPT}<br>"
				                + "<b>主管单位地址: </b>\${CDEPTADDRESS}<br>"
				                + "<b>面积: </b>\${AREA}<br>"
				                + "<b>人数: </b>\${PERSONNUM}<br>"
				                + "<b>应急通信方式: </b>\${COMMTYPE}<br>"
				                + "<b>监测方式: </b>\${MONITMODE}<br>"
				                + "<b>基本情况: </b>\${DESCRIPTION}");
		                point.ztreeData={"id":rootId+"_"+i,"pId":rootId,"name":result[i].DEFOBJNAME,"lng":result[i].LONGITUDE,"lat":result[i].LATITUDE};
			            point.attrs=result[i];
						graphicsList.push(point);
					}
				}
				finish.push(true);
			});

			$.post("<%=basePath%>Main/danger/getContent",null,function(result){
				var rootId="0002";
				rootNodes[rootId]={"id":rootId,"pId":0,"name":"危险源","count":0};
				for(var i=0,len=result.length;i<len;i++){
					if(result[i].LONGITUDE!=null && result[i].LATITUDE!=null){
						point=map.getPoint(result[i].LONGITUDE,result[i].LATITUDE);
						point.picSrc="<%=basePath%>plugins/gis/css/icon/redglass.png";
						point.infoTemplate=map.getNewInfoTemplate("明细","<b>名称: </b>\${DANGERNAME}<br>"
				                + "<b>地址: </b>\${DISTRICTCODE_NAME}\${ADDRESS}<br>"
				                + "<b>负责人: </b>\${RESPPER}<br>"
				                + "<b>负责人办公电话: </b>\${RESPOTEL}<br>"
				                + "<b>主管单位: </b>\${CHARGEDEPT}<br>"
				                + "<b>主管单位地址: </b>\${CDEPTADDRESS}<br>"
				                + "<b>面积: </b>\${AREA}<br>"
				                + "<b>人数: </b>\${PERSONNUM}<br>"
				                + "<b>应急通信方式: </b>\${COMMTYPE}<br>"
				                + "<b>基本情况: </b>\${DESCRIPTION}");
		                point.ztreeData={"id":rootId+"_"+i,"pId":rootId,"name":result[i].DANGERNAME,"lng":result[i].LONGITUDE,"lat":result[i].LATITUDE};
		                point.attrs=result[i];
						graphicsList.push(point);
					}
				}
				finish.push(true);
			});

			var timer=window.setInterval(function(){
				if(finish.length==finishLen){
					window.clearInterval(timer);
					for(var i=0,len=graphicLayer.graphics.length;i<len;i++){
						for(var j=0,count=graphicsList.length;j<count;j++){
							if(graphicLayer.graphics[i].geometry.contains(graphicsList[j])){
								graphicsList[j].drawn=true;
							}
						}
					}
					
					for(var i=0,len=graphicsList.length;i<len;i++){
						var graphic=graphicsList[i];
						if(graphic.drawn){
							var graphicObj=map.drawPicture(graphic.picSrc,25,25,graphic,graphic.attrs,graphic.infoTemplate,picLayer);
							
							nodesList.push(graphic.ztreeData);
							rootNodes[graphic.ztreeData.pId].count++;
						}
					}
					/*
					if($("#effect_chk").is(":checked")){
						picLayer.show();
						graphicLayer.show();
					}else{
						picLayer.hide();
						graphicLayer.hide();
					}*/

					for(var temp in rootNodes){
						rootNodes[temp].name+="("+rootNodes[temp].count+")";
						nodesList.push(rootNodes[temp]);
					}
					var tree=$.fn.zTree.init($("#effectList_tree"), setting, nodesList);
					$("#effect_search").linkbutton("enable");
				}
			},300);
		});

		$("#effect_a").on("click",function(){
			$('#effectDlg').dialog("move",{left:$("#commandmap").width()-350,top:$("#commandmap").height()-250});  
			$("#effectDlg").dialog("open"); 
		});

		$("#situation_a").on("click",function(){
			$('#situationDlg').dialog("move",{left:$("#commandmap").width()-350,top:$("#commandmap").height()-250});  
			$("#situationDlg").dialog("open"); 
		});

		$("#effect_clear").on("click",function(){
			graphicLayer.clear();
			picLayer.clear();
			$.fn.zTree.destroy("effectList_tree");
		});

		$("#sitpath_clear").on("click",function(){
			pathLayer.clear();
		});

		$("#sitsign_clear").on("click",function(){signLayer.clear();});

		$("#effect_del").on("click",function(){

			if(confirm("您确定删除保存的地图标识吗？")){
				$.post("<%=basePath%>Main/geographic/dispatch/graphicSignDel",{flag:1,eventid:curEventId},function(result){
					if(result.success){
						$("#effect_clear").click();
						alert("删除成功！");
					}else{
						alert(result.msg);
					}
				});
			}
		});

		$("#sitpath_del").on("click",function(){

			if(confirm("您确定删除保存的撤离路径吗？")){
				$.post("<%=basePath%>Main/geographic/dispatch/graphicSignDel",{flag:2,eventid:curEventId},function(result){
					if(result.success){
						$("#sitpath_clear").click();
						alert("删除成功！");
					}else{
						alert(result.msg);
					}
				});
			}
		});

		$("#sitsign_del").on("click",function(){

			if(confirm("您确定删除保存的地图标识吗？")){
				$.post("<%=basePath%>Main/geographic/dispatch/graphicSignDel",{flag:3,eventid:curEventId},function(result){
					if(result.success){
						$("#sitpath_clear").click();
						alert("删除成功！");
					}else{
						alert(result.msg);
					}
				});
			}
		});
		
		$("#effect_save").on("click",function(){
			if(graphicLayer.graphics.length==0){
				alert("请在地图上标绘影响范围后，再保存！");
				return;
			}

			var data=generateXML(graphicLayer);
			$.post("<%=basePath%>Main/geographic/dispatch/graphicSignSave",{flag:1,eventid:curEventId,data:data},function(result){
				if(result.success){
					alert("保存成功!");
				}else{
					alert("保存失败："+result.msg);
				}
			});
		});

		$("#sitpath_save").on("click",function(){

			if(pathLayer.graphics.length==0){
				alert("请在地图上标绘撤离路线后，再保存！");
				return;
			}
			var data=generateXML(pathLayer);
			$.post("<%=basePath%>Main/geographic/dispatch/graphicSignSave",{flag:2,eventid:curEventId,data:data},function(result){
				if(result.success){
					alert("保存成功!");
				}else{
					alert("保存失败："+result.msg);
				}
			});
		});

		$("#sitsign_save").on("click",function(){
			if(signLayer.graphics.length==0){
				alert("请在地图上标绘标识后，再保存！");
				return;
			}
			var data=generateXML(signLayer);
			$.post("<%=basePath%>Main/geographic/dispatch/graphicSignSave",{flag:3,eventid:curEventId,data:data},function(result){
				if(result.success){
					alert("保存成功!");
				}else{
					alert("保存失败："+result.msg);
				}
			});
		});


		function generateXML(graphicLayer){
			var root=document.createElement("geometry");
			for(var i=0,len=graphicLayer.graphics.length;i<len;i++){
				var geometry=graphicLayer.graphics[i].geometry;
				var list,rings,paths,obj,value,temp;
				switch(geometry.type){
					case "point":
						if(graphicLayer.graphics[i].symbol.type=='picturemarkersymbol'){
							obj=document.createElement("picture");
							temp=document.createElement("url");
							var url=graphicLayer.graphics[i].symbol.url;
							url=url.replace(basePath,"");
							temp.innerText=url;

							obj.appendChild(temp);
							temp=document.createElement("width");
							temp.innerText=graphicLayer.graphics[i].symbol.width;
							obj.appendChild(temp);
							temp=document.createElement("height");
							temp.innerText=graphicLayer.graphics[i].symbol.height;
							obj.appendChild(temp);
							temp=document.createElement("angle");
							temp.innerText=graphicLayer.graphics[i].symbol.angle || 0;
							obj.appendChild(temp);
							temp=document.createElement("x");
							temp.innerText=geometry.x;
							obj.appendChild(temp);
							temp=document.createElement("y");
							temp.innerText=geometry.y;
							obj.appendChild(temp);
							
						}else if(graphicLayer.graphics[i].symbol.type=='textsymbol'){
							obj=document.createElement("text");

							temp=document.createElement("x");
							temp.innerText=geometry.x;
							obj.appendChild(temp);
							temp=document.createElement("y");
							temp.innerText=geometry.y;
							obj.appendChild(temp);

							temp=document.createElement("value");
							temp.innerText=graphicLayer.graphics[i].symbol.text;
							obj.appendChild(temp);
							temp=document.createElement("fontsize");
							temp.innerText=13;
							obj.appendChild(temp);
							
						}
						break;
					case "polygon":
						obj=document.createElement("polygon");
						rings=document.createElement("rings");
						for(var j=0,count=geometry.rings.length;j<count;j++){
							list=document.createElement("list");
							for(var k=0,index=geometry.rings[j].length;k<index;k++){
								value=document.createElement("value");
								value.innerHTML=geometry.rings[j][k].join(",");
								list.appendChild(value);
							}
							rings.appendChild(list);
						}
						obj.appendChild(rings);
						break;
					case "extent":
						obj=document.createElement("extent");
						var attrs=["xmin","xmax","ymax","ymin"];
						for(var j=0,count=attrs.length;j<count;j++){
							value=document.createElement(attrs[j]);
							value.innerText=geometry[attrs[j]];
							obj.appendChild(value);
						}
						break;
					case "polyline":
						obj=document.createElement("polyline");
						paths=document.createElement("paths");
						for(var j=0,count=geometry.paths.length;j<count;j++){
							list=document.createElement("list");
							for(var k=0,index=geometry.paths[j].length;k<index;k++){
								value=document.createElement("value");
								value.innerHTML=geometry.paths[j][k].join(",");
								list.appendChild(value);
							}
							paths.appendChild(list);
						}
						obj.appendChild(paths);
						break;
				}
				root.appendChild(obj);
			}
			return root.outerHTML;
		}

		var _drawGraphicFromJson=function(json,layer,color){
			var geometry,list=json;
			for(var i=0,len=list.length;i<len;i++){
				geometry=map.newGeometry(list[i]);
				map.drawGeometry(geometry,layer,color);
			}
		}
		
		var _xmlToGraphicJson=function(xml){
			var root=$(xml);
			var list=[],obj={};
			for(var i=0,children=root.children(),len=children.length;i<len;i++){
				var tagName=children[i].nodeName.toLowerCase();
				obj={};
				obj.type=tagName;
				switch(tagName){

					case "picture":
						var attrs=["url","width","height","x","y","angle"];
						for(var j=0,count=attrs.length;j<count;j++)
							obj[attrs[j]]=children.eq(i).find(attrs[j])[0].innerText;
						list.push(obj);
						break;
					case "text":
						var attrs=["x","y","value","fontsize"];
						for(var j=0,count=attrs.length;j<count;j++)
							obj[attrs[j]]=children.eq(i).find(attrs[j])[0].innerText;
						list.push(obj);
						break;
					case "extent":
						var attrs=["xmin","xmax","ymax","ymin"];
						for(var j=0,count=attrs.length;j<count;j++){
							obj[attrs[j]]=children.eq(i).find(attrs[j])[0].innerText;
						}
						list.push(obj);
						break;
					case "polygon":
						var rings=[],node_list=children.eq(i).find("list");
						for(var j=0,count=node_list.length;j<count;j++){
							var node_value=node_list.eq(j).children();
							var listArray=[];
							for(var k=0,index=node_value.length;k<index;k++){
								var valueArray=node_value[k].innerText.split(",");
								valueArray[0]=parseFloat(valueArray[0]);
								valueArray[1]=parseFloat(valueArray[1]);
								listArray.push(valueArray);
							}
							rings.push(listArray);
						}
						obj.rings=rings;
						list.push(obj);
						break;
					case "polyline":
						var paths=[],node_list=children.eq(i).find("list");
						for(var j=0,count=node_list.length;j<count;j++){
							var node_value=node_list.eq(j).children();
							var listArray=[];
							for(var k=0,index=node_value.length;k<index;k++){
								var valueArray=node_value[k].innerText.split(",");
								valueArray[0]=parseFloat(valueArray[0]);
								valueArray[1]=parseFloat(valueArray[1]);
								listArray.push(valueArray);
							}
							paths.push(listArray);
						}
						obj.paths=paths;
						list.push(obj);
						break;
				}
			}
			return list;
		}

		$("#effectDlg").dialog({
			onClose:function(){
				//graphicLayer.hide();
				//picLayer.hide();
			},
			onOpen:function(){
				
				if(graphicLayer.graphics.length==0){
					$.post("<%=basePath%>Main/geographic/dispatch/getGrahpicSign",{eventid:curEventId,flag:1},function(result){
						if(result.success){
							if(result.data!=null && result.data!=""){
								var list=_xmlToGraphicJson(result.data);
								_drawGraphicFromJson(list,graphicLayer,"blue");
								$("#effect_search").click();
								$("#effect_chk").click();
							}
						}else{
							alert(result.msg);
						}
						
					});
				}
				//graphicLayer.show();
				//picLayer.show();
				
			}
		});

		$("#situationDlg").dialog({
			onOpen:function(){
				_initSignPic();

				if(pathLayer.graphics.length==0){
					$.post("<%=basePath%>Main/geographic/dispatch/getGrahpicSign",{eventid:curEventId,flag:2},function(result){
						if(result.success){
							if(result.data!=null){
								var list=_xmlToGraphicJson(result.data);
								_drawGraphicFromJson(list,pathLayer,"red");
							}
						}else{
							alert(result.msg);
						}
						
					});
				}

				if(signLayer.graphics.length==0){
					$.post("<%=basePath%>Main/geographic/dispatch/getGrahpicSign",{eventid:curEventId,flag:3},function(result){
						
						if(result.success){
							if(result.data!=null){
								var list=_xmlToGraphicJson(result.data);
								_drawGraphicFromJson(list,signLayer,"red");
							}
						}else{
							alert(result.msg);
						}
					});
				}
				
				//signLayer.show();
				
			}
		});

		//初始化标识图片
		var _initSignPic=function(){
			if($("#sittabs").tabs("tabs")[1][0].innerHTML.trim()==""){
				
				function selChange(){
					var me=$(this),value=me.val(),option=me.find(":selected"),count=option.attr("count"),list=option.attr("listname").split(","),ul=frame.find("ul"),firstL=value.substring(0,1);
					ul.empty();
					count=count?count:list.length;
					for(var i=0,listlen=list.length;i<count;i++){
						ul.append($('<li><a href="#"><img src="'+gisPath+'/css/img/'+value+'/'+firstL+i+'.gif" title="'+(listlen==1?list[0]:list[i])+'" data-type="point"></a></li>'));
					}
					ul.find("li").on("click",function(){
						var src=$(this).find("img").attr("src");
						$(this).parent().find("a.select").removeClass("select");
						$(this).children().eq(0).addClass("select");
						var eventLis=map.map.on("click",function(event){
							$.messager.prompt('输入信息', '请输入标识信息：', function(r){
								map.drawPicture(src,32,32,event.mapPoint,null,null,signLayer);
								if (r){
									map.drawText(r,13,"red",event.mapPoint,{x:15,y:15},signLayer);
								}
							});
						});
						map.replaceEventHandler("Map.click",eventLis);
						map.cancelDraw();
					});
				}
				
				var frame=$($("#sittabs").tabs("tabs")[1][0]);
				var rowContainer=$("<div>").addClass("rowcontainer"),left=$("<span style='width:100px;float: left; text-align: right;'></span>"),right=$("<div style='width:180px;float: left;'>"),sel=$("<select>"),option,
				data=[{"text":"车辆类","value":"car","listname":["工程车","轿车","警车","救护车","卡车","通讯车","消防车","巡逻船","指挥车","装甲车"]},
					  {"text":"人员类","value":"person","listname":["专家","医生","陆军","海军","空军","消防员","警察","指挥员","交警","城管"]},
					  {"text":"物资类","value":"resource","listname":["避难场所","粮食","石料","危险源","衣服","油料"]},
					  {"text":"场所类","value":"house","listname":["公园","求助站","体育馆","停车场","指挥部"]},
					  {"text":"建筑类","value":"build","listname":"围墙","count":5},
					  {"text":"箭头","value":"arrow","listname":"箭头","count":24}];
				rowContainer.append(left.text("请选择图片类型："));
				rowContainer.css({"position":"relative","height":"30px","line-height": "30px"});
				for(var i=0,len=data.length;i<len;i++){
					option=$("<option value='"+data[i].value+"' count="+(data[i].count?data[i].count:data[i].listname.length)+" listname="+(typeof data[i].listname=="array"? data[i].listname.join(","):data[i].listname)+">"+data[i].text+"</option>");
					sel.append(option);
				}
				rowContainer.append(right.append(sel));
				frame.append(rowContainer).append($("<ul class='horizon'></ul>"));
				frame.append($("<input type='hidden' id='imageHidden'/>"));
				sel.on("change",selChange);

				sel.trigger("change");

				span=$("<span style=\"float:left;width:100px;text-align:right;\">是否显示标识：</span>");
				var div=$("<div style=\"float:left;width:80px;\">"),chk=$("<input type=\"checkbox\"/>");
				div.append(chk);
				frame.append(span).append(div);

				chk.on("click",function(){
					$(this).is(":checked")?signLayer.show():signLayer.hide();
				});
			}
		}


		//标注事件
		if('${flag}'){
			map.addEvent("load", function(){
				pathLayer.hide();
				signLayer.hide();
				var baseUrl = basePath+"plugins/gis/css/icon/";
				var expertpic = baseUrl+"expert.png";
				var teampic =baseUrl+"home.png";
				var equimentpic = baseUrl+"equiment.gif";
				var wzpic = baseUrl+"pen.png";
				var localpic = baseUrl+"location.png";
				var point = map.getPoint('${event.ev_longitude}', '${event.ev_latitude}');
				map.drawPicture(localpic, 25,25,point, null, null, null); //标注事件
				//定位事件位置
				map.map.centerAt(point);
				if('${planid}'){
					//获取事件关联预案的应急资源
					$.get(basePath+"Main/geographic/dispatch/getResourceList?planid=${planid}", null, function(data){
						if(data.length>0){
							var _2080template = map.getNewInfoTemplate("应急专家", "<b>姓名：</b>\${NAME}<br>" +
									"<b>电话：</b><br>" +
									"<b>性别：</b>\${SEX}<br>" +
									"<b>从事：</b>\${TYPENAME}<br>");
							var _3010template = map.getNewInfoTemplate("应急队伍", "<b>名称：</b>\${NAME}<br>" +
									"<b>联系人：</b>\${LINKMAN}<br>" + 
									"<b>联系人电话：</b>\${LINKMANTEL}<br>");
							var _3020template = map.getNewInfoTemplate("应急物资", "<b>名称：</b>\${MN_NAME}<br>");
							var _3030template = map.getNewInfoTemplate("应急装备", "<b>名称：</b>\${EQN_NAME}<br>");
							for(var i=0; i<data.length; i++){
								var item = data[i];
								if(item.PLANITEMCODE == '2080'){//应急专家
									if(item.LATITUDE && item.LONGITUDE){
										item.SEX = item.SEX=='1'?"女":"男";
										var point = map.getPoint(item.LONGITUDE, item.LATITUDE);
										map.drawPicture(expertpic, 25, 25, point, item, _2080template, null);
									}
									
								}
								if(item.PLANITEMCODE == '3010'){//应急队伍
									if(item.TEA_LONGITUDE && item.TEA_LATITUDE){
										var point = map.getPoint(item.TEA_LONGITUDE, item.TEA_LATITUDE);
										map.drawPicture(teampic, 25, 25, point, item, _3010template, null);
									}
									
								}
								if(item.PLANITEMCODE == '3020'){ //应急物资
									if(item.LONGITUDE && item.LATITUDE){
										var point = map.getPoint(item.LONGITUDE, item.LATITUDE);
										map.drawPicture(wzpic, 25, 25, point, item, _3020template, null);
									}
								}
								if(item.PLANITEMCODE == '3030'){ //应急装备
									if(item.LONGITUDE && item.LATITUDE){
										var point = map.getPoint(item.LONGITUDE, item.LATITUDE);
										map.drawPicture(equimentpic, 25, 25, point, item, _3030template, null);
									}
								}
							
							}
						}
	
					});

					//获取现场指挥地点经纬度
					$.get(basePath + "Main/geographic/dispatch/getCmdPos", {eventid: curEventId}, function(data){
						if(data.LNG && data.LAT){
							cmdposLayer = map.addGraphicLayer("cmdposLayer");
							var pic = baseUrl + "flag.png";
							var point = map.getPoint(data.LNG, data.LAT);
							map.drawPicture(pic, 25, 25, point, null, null, cmdposLayer);
						}
					});
				}
			});
		}else{
			map.addEvent("load",function(){
				$.get(basePath+"Main/geographic/dispatch/getEventList", null, function(data){
					if(data.length>0){
						var template = map.getNewInfoTemplate("事件详情", "<b>事件名称：</b>\${EV_NAME}<br>" +
								"<b>事件类型：</b>\${EVTYPE_NAME}<br>" +
								"<b>事件级别：</b>\${EVLEVEL_NAME}<br>" +
								"<b><a href='javascript:eventDetail(\${ID}, \${NUM});'>显示详情</a></b><br>");
						var eventLayer = map.addGraphicLayer("eventLayer");
						for(var i=0; i<data.length; i++){
							var e = data[i];
							if(e.EV_LONGITUDE!=null && e.EV_LATITUDE!=null){
								var point = map.getPoint(e.EV_LONGITUDE,e.EV_LATITUDE);
								var pic = basePath+"plugins/gis/css/icon/house.png";
								map.drawPicture(pic, 25, 25, point, e, template, eventLayer);
							}
							
						}
					}	
				});
			});
		}
   });
	

	//显示隐藏弹窗
	$(function(){
		
		$(".aBtn").on("click", function(){
			if($(this).hasClass("show")){
				var param ={
					title:'应急指挥调度程序',
					width:200,
					height:460,
					left:50,
					top:40,
					maximizable:false,
					modal: false,
					buttons:[],
					href:basePath+'Main/geographic/dispatch/handleProc/${event.id}-${trainflag}-${planid}-${instid}'
				};
				$.lauvan.openCustomDialog("handleDialog", param, null, "handleform");
			}else{
				$("#handleDialog").dialog('close');
			}
			
		});
		$(".aBtn.show").click();
		$("#eventRB_a").on("click", function(){
			var param = {
					title:"事件回放",
					width:600,
					height:400,
					left:$("#commandmap").width()-600,
					top:$("#commandmap").height()-400,
					modal: false,
					buttons:[],
					href:basePath+'Main/eventSearch/processView/'+curEventId +'-${trainflag}'
			};
			$.lauvan.openCustomDialog("eventRBDialog", param, null, "eventRBform");


			});

		$("#rtel").on("click", function(){
			parent.$("#ccms_console").dialog("open");
			parent.$("#ccms_console").dialog("expand");

		});


		$("#telMeet").on("click", function(){
			parent.video_play();
		});

		$("#eventinstBtn").on("click", function(){
			var param = {
					title:"启动预案事件列表",
					width:600,
					height:400,
					left:$("#commandmap").width()-600,
					top:$("#commandmap").height()-400,
					modal: false,
					buttons:[],
					href:basePath+'Main/geographic/dispatch/getListForEventInst'
			};
			$.lauvan.openCustomDialog("eventinstDialog", param, null, "eventinstform");

		});

		//获取天气预报
		$.get(basePath+'Main/geographic/dispatch/getWeather', null, function(data){
				if(data.length>0){
					var obj = $("#weatherbox");
					for(var i=0; i<data.length; i++){
						obj.append("<p>" +data[i]+"</p>");
					}
				}
			});
	});

	//时间显示
	var arr = ["天", "一", "二", "三", "四", "五", "六"];
	//var dateStr = '${date}';
	var date = new Date();
	refreshTime();
	setInterval('refreshTime()', 1000); //更新时间显示
	

	function refreshTime(){
		var week = date.getDay();
		var sec = date.getSeconds();
		var str = date.toLocaleDateString() + " 星期"+ arr[week];
		$("#daystr").text(str);
		var sec = date.getSeconds();
		var minu = date.getMinutes();
		var secStr = "";
		var minuStr = "";
		secStr = sec<10?"0"+sec:sec;
		minuStr = minu<10? "0"+minu:minu;
		$("#timestr").text(date.getHours()+":"+minuStr+":"+secStr);
		date.setSeconds(sec+1);
	}

	//事件基本信息
	function eventInfo(id){
		var param = {
			title:'事件详细信息',
			width:600,
			height:500,
			left:$("#commandmap").width()-600,
			top:$("#commandmap").height()-500,
			modal: false,
			buttons:[],
			href:'<%=basePath%>Main/geographic/dispatch/eventInfo/'+id+"-${trainflag}"
		};
		$.lauvan.openCustomDialog("eventinfoDialog", param, null, "eventform");
	}

	//事件资源配置
	function resouceInfo(preschid){
		if(preschid){
			var param = {
					title:'事件资源配置',
					width:600,
					height:400,
					left:$("#commandmap").width()-600,
					top:$("#commandmap").height()-400,
					modal: false,
					buttons:[],
					href:'<%=basePath%>Main/geographic/dispatch/resource/'+preschid
			};
			$.lauvan.openCustomDialog("resourceDialog", param, null, "resourceform");
		}else{
			alert("未启动预案！");
		}
	}

	//辅助决策
	function asstDecs(eventid, preschid){
		if(preschid){
			var param = {
					title:'辅助决策方案',
					width:690,
					height:400,
					left:$("#commandmap").width()-690,
					top:$("#commandmap").height()-400,
					modal: false,
					buttons:[],
					href:'<%=basePath%>Main/geographic/dispatch/asstDecs/'+eventid+"-"+preschid+"-${trainflag}-${instid}"
			};
			$.lauvan.openCustomDialog("asstDecsDialog", param, null, "asstDecsform");
		}else{
			alert("未启动预案！");
		}
	}

	//事件案例
	function eventList(){
		var param = {
				title:'事件案例',
				width:600,
				height:400,
				left:$("#commandmap").width()-600,
				top:$("#commandmap").height()-400,
				modal: false,
				buttons:[],
				href:'<%=basePath%>Main/geographic/dispatch/eventList'
		};
		$.lauvan.openCustomDialog("eventlistDialog", param, null, "eventlistform");
	}

	function showImg(flag, title){
		var param = {
				title:title,
				width:650,
				height:450,
				left:$("#commandmap").width()-650,
				top:$("#commandmap").height()-450,
				modal: false,
				buttons:[],
				href:'<%=basePath%>Main/geographic/dispatch/monit/'+flag
		};
		$.lauvan.openCustomDialog("monitDialog", param, null, "monitform");

	}

	//进入事件指挥调度
	function eventDetail(eventid, num){
		goEventPlan(eventid, num);
		//parent.$("#gisiframe").attr("src", "<%=basePath%>Main/geographic/dispatch/main?eventid="+eventid)
		
	}

	function goEventPlan(eventid, num){
		if(num>1){
			//弹出事件关联的预案
			var param = {
				title: '关联预案列表',
				width:500,
				height:300,
				buttons:[],
				href:basePath+"Main/geographic/dispatch/getEventPlan?eventid="+eventid
			};
			$.lauvan.openCustomDialog("eventinstdialog2", param, null, "eventinstform2");

		}else{
			$("#eventinstDialog").dialog('destroy');
			parent.$("#gisiframe").attr("src", basePath+"Main/geographic/dispatch/main?eventid=" + eventid);
		}

	}
  </script>       
     
    </head>
    <body class="easyui-layout">

		<div class="map_sp">
			 <div id="commandmap" style="width:100%;height:100%;">
			</div>
			<div id="toolbar">
				
			</div>
			<div class="treeee2">
			</div>
			
			<div id="effectDlg" class="easyui-dialog" title="影响范围标绘" data-options="iconCls:'icon-transmit',closed:true,collapsible:true,width:350,height:250">
			<div class="easyui-tabs" data-options="fit:true">
		        <div title="范围标绘" data-options="footer:'#effectTab1_footer'">
		           <ul class="horizon">
		           <li><a href="#"><img src="<%=basePath %>plugins/gis/css/img/circle.png" title="画圆" data-type="circle"></a></li>
		           <li><a href="#"><img src="<%=basePath %>plugins/gis/css/img/poly.png" title="多边形" data-type="POLYGON"></a></li>
		           <li><a href="#"><img src="<%=basePath %>plugins/gis/css/img/freepoly.png" title="任意多边形" data-type="freehand_polygon"></a></li>
		           <li><a href="#"><img src="<%=basePath %>plugins/gis/css/img/rectangle.png" title="矩形" data-type="EXTENT"></a></li>
		           </ul>
		           <div style="clear:both;position:relative;height:30px;line-height:30px;">
		           <span style="float:left;width:130px;text-align:right;">是否显示影响对象：</span>
		           	<div style="float:left;width:80px;">
		           	<input type="checkbox" id="effect_chk"/>
		           	</div>
		           	</div>
		           <div id="effectTab1_footer" style="padding:5px;text-align:center;">
				          <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" id="effect_search" style="width:60px">搜索</a>
				         <a href="javascript:void(0);" class="easyui-linkbutton" title="清除地图上的标识" data-options="iconCls:'icon-paintbrush'" id="effect_clear" style="width:80px">清除标绘</a>
				   		 <a href="javascript:void(0);" class="easyui-linkbutton" title="删除保存的标识信息" data-options="iconCls:'icon-pagedelete'" id="effect_del" style="width:60px">删除</a>
				   		 <a href="javascript:void(0);" class="easyui-linkbutton" title="保存地图上影响范围标识信息" data-options="iconCls:'icon-save'" id="effect_save" style="width:60px">保存</a>
				   
				    </div>
		        </div>
		        <div title="影响对象列表" >
		           	<ul id="effectList_tree" class="ztree"></ul>
		        </div>
	    	</div>
	    	
	    	<div id="situationDlg" class="easyui-dialog" title="应急态势标绘" data-options="iconCls:'icon-feed',closed:true,width:350,height:250">
	    		<div class="easyui-tabs" id="sittabs" data-options="fit:true">
	    			<div title="撤离路线标绘" data-options="footer:'#situationTab1_footer'">
	    				 <ul class="horizon">
				           <li><a href="#"><img src="<%=basePath %>plugins/gis/css/img/freeline.png" title="画直线" data-type="FREEHAND_POLYLINE_ARROW"></a></li>
				           <li><a href="#"><img src="<%=basePath %>plugins/gis/css/img/line.png" title="画曲线" data-type="POLYLINE_ARROW"></a></li>
				           </ul>
				    <div style="clear:both;position:relative;height:30px;line-height:30px;">
		           <span style="float:left;width:130px;text-align:right;">是否显示撤离路线：</span>
		           	<div style="float:left;width:80px;">
		           	<input type="checkbox" id="sitpath_chk"/>
		           	</div>
		           	</div>
				      <div id="situationTab1_footer" style="padding:5px;text-align:center;">
				         <a href="javascript:void(0);" class="easyui-linkbutton" title="清除地图上的标识" data-options="iconCls:'icon-paintbrush'" id="sitpath_clear" style="width:80px">清除标绘</a>
				   		 <a href="javascript:void(0);" class="easyui-linkbutton" title="删除保存的标识信息" data-options="iconCls:'icon-pagedelete'" id="sitpath_del" style="width:60px">删除</a>
				   		 <a href="javascript:void(0);" class="easyui-linkbutton" title="保存地图上影响范围标识信息" data-options="iconCls:'icon-save'" id="sitpath_save" style="width:60px">保存</a>
				    </div>
	    			</div>
	    			<div title="应急态势标绘" data-options="footer:'#situationTab2_footer'">
	    				
	    				<div id="situationTab2_footer" style="padding:5px;text-align:center;">
					         <a href="javascript:void(0);" class="easyui-linkbutton" title="清除地图上的标识" data-options="iconCls:'icon-paintbrush'" id="sitsign_clear" style="width:80px">清除标绘</a>
					   		 <a href="javascript:void(0);" class="easyui-linkbutton" title="删除保存的标识信息" data-options="iconCls:'icon-pagedelete'" id="sitsign_del" style="width:60px">删除</a>
					   		 <a href="javascript:void(0);" class="easyui-linkbutton" title="保存地图上影响范围标识信息" data-options="iconCls:'icon-save'" id="sitsign_save" style="width:60px">保存</a>
				   
				    	</div>
	    			</div>
	    		</div>
	    	</div>
		</div>
	</div>
	<div class="zoom_sp">
	<div class="zoom_sp_button"><a href="#"></a></div>
	</div>
	<div class="operation">
	<div class="op1">
	<h2>当前应急处理事故</h2>
	<span>${event.ev_name}</span>
	<ul class="op1_buttom">
		<li><a href="#" title="标记" id="signA"><img src="<%=basePath %>plugins/gis/css/icon/w_location.png" /></a></li>
		<li><a href="javascript:void(0);" title="列表" id="eventinstBtn"><img src="<%=basePath %>plugins/gis/css/icon/w_search.png" /></a></li>
	</ul>
	</div><!--op1-->
	<c:if test="${flag == true}">
		<div class="op2">
		<h2>应急处置信息</h2>
			<ul class="first_menu">
				<li>
					<a href="#">事件信息</a>
						<ul class="second_menu">
							<li><a href="javascript:eventInfo('${event.id}');">事件详细信息</a></li>
							<li><a href="javascript:eventInfo('${event.id}');">事件信息记录</a></li>
							<li><a href="javascript:void(0);" id="effect_a">影响范围标绘</a></li>
							<li><a href="javascript:void(0);" id="situation_a">应急态势标绘</a></li>
							<li><a href="javascript:void(0);" id="eventRB_a">事件回放</a></li>
						</ul>
				</li>
				<li><a href="#">应急资源信息</a>
					<ul class="second_menu">
						<li><a href="javascript:resouceInfo('${planid}');">应急资源信息</a></li>
						<li><a href="javascript:eventList();">事件案例信息</a></li>
					</ul>
				</li>
				<li>
					<a href="#">监测参数信息</a>
					<ul  class="second_menu">
						<li><a href="javascript:showImg('qx', '气象信息');">气象信息</a></li>
						<li><a href="javascript:showImg('qxyj', '气象预警');">气象预警</a></li>
						<li><a href="javascript:showImg('qxyt', '卫星云图');">卫星云图</a></li>
						<li><a href="javascript:showImg('jsqwt', '降水气温图');">降水气温图</a></li>
						<li><a href="javascript:showImg('fxskt', '分县实况图');">分县实况图</a></li>
						<li><a href="javascript:showImg('tf', '台风');">台风</a></li>
					</ul>
				</li>
				<li>
					<a href="#">综合通信信息</a>
					<ul  class="second_menu">
						<li><a id="rtel" href="javascript:void(0);">电话会议</a></li>
						<li><a id="telMeet" href="javascript:void(0);">视频会商</a></li>
					</ul>
				</li>
				<li>
					<a href="javascript:asstDecs('${event.id}', '${planid}');" style="text-decoration: none;">辅助决策方案</a>
				</li>
			</ul>
		</div><!--op2-->
		<div class="op3">
			<a href="#" class="aBtn show">显示</a>
			<a href="#" class="aBtn">隐藏</a>
		</div><!--op3-->
	</c:if>
	<div class="op4">
        <div class="op4_info" id="weatherbox"><%--
			<p>温度：23</p>
			<p>相对湿度：38%</p>
			<p>风速：1级</p>
			<p>风向：东南风</p>
		--%></div>
	
		<div class="op4_time">
			<span id="daystr"></span><br/>
			<span id="timestr"></span>
		</div>
	
	</div><!--op4-->
	
	</div><!--operation-->


    </body>
</html>