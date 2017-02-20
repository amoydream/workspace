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
<%@ include file="/include/softphone.jsp"%> 
<%@ include file="/WEB-INF/jsp/communication/softphone1/include/include.jsp"%> 

<script>
  $(function(){
	  $.post("Main/softphoneone/getBookXls",{},function(result){
			if(result.success){
				var str = "<div id='right-speed-div' class='right-speed-div'>";
				for(var i=0;i<result.datalist.length;i=i+2){
	                str += "<div class='right-speed-btn-div'>";
					str += "<button class='sbutton blue' data-num='"+result.datalist[i].number+"' onclick='speedDial(this);'>"+result.datalist[i].name+" "+result.datalist[i].number+"</button>";
					if(i+1<result.datalist.length){		
					str += "<button class='sbutton blue' data-num='"+result.datalist[i+1].number+"' onclick='speedDial(this);'>"+result.datalist[i+1].name+" "+result.datalist[i+1].number+"</button>";
					}
					str += "</div>";
				}
				str += "</div>";
				str += "<div class='right-speed-edit-div'>";
				str += "<button type='button' class='btn btn-success' onclick='editSpeedDial();'>编辑</button>";
				str += "</div>";
				$("#right-data").empty();
				$("#right-data").append(str);
			}
		});	   
  });
  
//一键拨打方法
 function speedDial(obj){
 	var number = $(obj).attr("data-num");
 	alert(number);
 	if(number==null||number==''){
 		$.lauvan.MsgShow({msg:'您的号码有误'}); 	
 		return;
 	}
 	callout(number,null);
 }
</script>
</head>
<body>
<div id="the-right">
<div id="right-data">
</div>
</div>
 <script type="text/javascript" src="<%=basePath%>plugins/softphone/js/phone1.js"></script>
 <script type="text/javascript" src="<%=basePath%>plugins/softphone/js/right1.js"></script>
</body>
