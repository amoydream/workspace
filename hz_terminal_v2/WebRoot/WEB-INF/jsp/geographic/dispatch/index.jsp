<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<link rel="stylesheet" type="text/css" href="<%=basePath %>plugins/easyui/customicon/icon.css"/>
<script src="<%=basePath %>plugins/gis/plugins/flowplayer/flowplayer.min.js"></script>
 

<iframe id="gisiframe" src="<%=basePath %>Main/geographic/dispatch/main?eventid=${eventid}&flag=${flag}" height="99%" width="100%" frameborder="0"></iframe>
