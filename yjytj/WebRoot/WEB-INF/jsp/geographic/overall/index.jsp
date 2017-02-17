<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/customicon/icon.css"/>
<script src="<%=basePath %>plugins/gis/plugins/flowplayer/flowplayer.min.js"></script>
 

<iframe name="overviewgis" src="<%=basePath %>Main/geographic/overall/main" height="99%" width="100%" frameborder="0"></iframe>
