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
 <link rel="stylesheet" type="text/css" href="<%=basePath %>css/buttoncss.css" />
 <link rel="stylesheet" href="<%=basePath %>plugins/gis/css/base.css"/>
 <link rel="stylesheet" href="<%=basePath %>plugins/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
 <style>
 .ztree li span{color:white;}
 .ztree li a.curSelectedNode{background-color: #565147;}
 .ztree.legend li span{color:black;}
 .ztree.legend li a.curSelectedNode{background-color: #FFE6B0;}
 </style>
 <script src="<%=basePath %>plugins/ccms/ccms.js" type="text/javascript"></script>
<script src="<%=basePath %>plugins/ccms/ccms_console.js" type="text/javascript"></script>
<script src="<%=basePath %>plugins/ccms/lauvan_ccms.js" type="text/javascript"></script>
<script src="<%=basePath %>plugins/ccms/lauvan_call.js" type="text/javascript"></script>
<script src="<%=basePath %>plugins/ccms/lauvan_fax.js" type="text/javascript"></script>
 <script src="<%=basePath %>plugins/gis/core/jquery.js"></script>
 <script src="<%=basePath %>plugins/easyui/jquery.easyui.min.js"></script>
 <script src="<%=basePath %>plugins/ztree/js/jquery.ztree.all-3.5.min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/bigcolorpicker.js"></script>
 <script src="<%=basePath %>plugins/gis/frame/base2.js"></script>
 
 <link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/themes/default/easyui.css"/>

 <script src="<%=basePath %>plugins/gis/core/baidu.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/RectangleZoom_min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/RectangleClear.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/DistanceTool_min.js"></script>
 <script src="<%=basePath %>plugins/gis/plugins/extra/DrawingManager.js"></script>
 <script src="<%=basePath %>plugins/gis/main_bd.js"></script>
 
 <script>
   var gisPath="<%=basePath%>plugins/gis";
	
	window.onload = function(){new init("<%=basePath%>","map",${lng},${lat},${zoom});}; 
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
