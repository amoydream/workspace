<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>综合应急平台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
<%@ include file="/include/header.jsp"%>
<%@ include file="/include/ccms.jsp"%> 
<%@ include file="/WEB-INF/jsp/communication/softphone1/include/include.jsp"%> 
</head>
<body>
<div id="the-right">
   <div id="right-data">
   <iframe src='Main/softphoneone/getYDialRecord' width='100%' height='99.5%' style='overflow-y:scroll;'
    frameborder='0' scrolling='auto'>
    </iframe>
   </div>
</div>
<script type="text/javascript" src="<%=basePath%>plugins/softphone/js/phone1.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/softphone/js/right1.js"></script>
</body>