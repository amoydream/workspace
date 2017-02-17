<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="common/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String ip = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>惠州应急值守平台</title>
<link href="<%=basePath %>css/style_file.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath %>js/pagination.js"></script>
</head>
<body>
<div style="width:100%; height:103px; background:url(<%=basePath %>images/web/headbg.jpg) repeat-x;">
<div style="margin:0 auto; width:1000px; height:103px;"><img src="<%=basePath %>images/web/head.jpg" width="1000" height="103"/></div>
</div>
