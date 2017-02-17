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
	<div>
	 <div class='right-number-book'>
	<img id='right-book' style='margin-right:10px;border:none;' height='20px' width='20px' src='plugins/softphone/images/contacts_book.png'/>
	 <span style='font-weight: bold;'>通讯录</span>
	 <a class='a-text' href='javascript:;'>号码总数<span id='mobilecounts' class='span-badge'>0</span></a>
	 </div>
	 <div class='right-number-area'>
	 <ul id='results_number'>
	 </ul>
	 </div>
	 <div style='margin:6px 2px;'>
	 <input id='rightsms-input-add' class='input-text' type='text' placeholder='添加发送号码...'></input>
	 <button type='button' class='btn btn-success' onclick='addNumber();'>添加</button>
     </div>
	 <div style='margin:6px 2px;'>
	 <button id='rightsms-btn-delete' class='btn btn-warming' onclick='deleteSelect();'>删除选定</button>
	 <button class='btn btn-danger' onclick='clearAllNumber();'>清空</button>
	 </div>
	 </div>
	 <div>
	 <textarea id='rightsms-textarea' class='textarea-text' rows='10'></textarea>
	 <div style='margin:6px 2px;'>
	 <button class='btn btn-warming' onclick='clearMsg();'>清空</button>
	 <button type='button' class='btn btn-success' onclick='sendSms();'>发送</button>
    </div>
	</div>			
   </div>
   </div>
    <script type="text/javascript" src="<%=basePath%>plugins/softphone/js/phone1.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugins/softphone/js/right1.js"></script>
</body>