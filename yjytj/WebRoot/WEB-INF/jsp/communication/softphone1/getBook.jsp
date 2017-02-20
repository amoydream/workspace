<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%@ include file="/include/softphone.jsp"%> 
<%@ include file="/WEB-INF/jsp/communication/softphone1/include/include.jsp"%> 
<script type="text/javascript">
 function sureNumber(){
	 window.opener.sureNumber($("#input-select").val());
 }
</script>
</head>
<body>
    <div id="the-left">
			<div id="left-data">
			<div style="margin: 8px 13px;">
				<select id="input-select" class="input-select">
				</select>
				<button type="button" class="btn btn-success" onclick="sureNumber();">确定</button>
			</div>
			<div>
				<iframe src="Main/softphoneone/getBook" width="100%" height="500px"
					frameborder="0" scrolling="auto"></iframe>
			</div>
			</div>
	</div>
			<!--  <ul id="results_list"><li id="result_default">Memory is Empty</li></ul>
     <a id="result_clear" href="#">Wipe</a> -->
     
    <script type="text/javascript" src="<%=basePath%>plugins/softphone/js/phone1.js"></script>
</body> 