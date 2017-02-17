<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/include/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>政府综合应急一体机</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>js/sessionAIO.js"></script>
<style>
html,body{ width:100%; height:100%; overflow:hidden;}
body {font-size:12px; color:#3c3c3c;margin:0; padding:0; font-size:12px; font-family: "Times New Roman", Times, serif}
*{ margin:0; padding:0;}
ul,li{ list-style-type:none;margin:0px; padding:0; border:0;}
a,a:hover{ list-style-type:none; text-decoration: none;}
.clear {clear:both;}
img{border:none;}
input {outline: none;}
.blank{ clear:both; overflow:hidden; display:block; font-size:0; line-height: 0;}


.fl{ float:left;}
.fr{ float:right;}
.clearfix{display:block;}

.body_left{ width:59.5%; height:100%; position:relative;} 
.body_right{ width:40%; height:100%;} 
.body_center{ width:0.5%; height:100%; position:relative; background:#f5f5f5;}
.body_c_nei{border-left:1px solid #dfdfdf;border-right:1px solid #dfdfdf; height:100%; position:relative;}
.body_c_nei_button{position:absolute; z-index:999; width:100%; height:200px; left:0; top:50%; margin-top:-100px; }
.body_c_nei_button a{display: block;width: 100%;height: 88px;margin: 5px 0;border-bottom: 1px solid #95B8E7;border-top: 1px solid #95b8e7;background: #D5F2F9;}
.body_c_nei_button a img{ width:100%; height:100%;}

.b_l_phone{ width:30px; height:30px; position:absolute; z-index:100; left:10px; bottom:3px;}
.b_l_phone a,.b_l_phone a img{ display:block; width:100%; height:100%;}

.n_n_left,.n_n_right{ position:absolute; width:34px; height:29px;}
.n_n_left{ left:0; top:0;}
.n_n_right{ right:0; top:0;}

</style>
<script type="text/javascript">
var c_neiLeft,c_neibutton;
$(document).ready(function(){
	$("#GISMap_aio").load("<%=basePath%>Main/geographic/overall",null,function(){});
	c_neiLeft = $(".body_center").prev().width();
	c_neibutton = $(".body_center").width();
});
function rightBodyClick(){
	if($(".body_center").prev().width()!=0){
		$(".body_center").next().width(document.body.offsetWidth-c_neibutton);
		$(".body_center").prev().width('0px');
	}else{
		$(".body_center").next().width(document.body.offsetWidth-c_neiLeft-c_neibutton);
		$(".body_center").prev().width(c_neiLeft);
	}
}
function leftBodyClick(){
	if($(".body_center").next().width()!=0){
		$(".body_center").prev().width(document.body.offsetWidth-c_neibutton);
		$(".body_center").next().width('0px');
	}else{
		$(".body_center").prev().width(c_neiLeft);
		$(".body_center").next().width(document.body.offsetWidth-c_neiLeft-c_neibutton);
	}
}
function aioSPhone(){
	window.open("<%=basePath%>Main/softphoneone/main",'aioSPhone'
			,'height=700,width=300,top=0,left=0,toolbar=no,titlebar=no,menubar=no,scrollbars=no,resizable=yes,location=no, status=yes');
}
</script>
</head>
<body>
	<div class="body_left fl clearfix">
	<iframe name="aiomain" src="<%=basePath %>Main" height="100%" width="100%" frameborder="0"></iframe>
	<div class="b_l_phone">
		<a href="javascript:void(0);" onclick="aioSPhone()"><img src="../images/login/phone_gree.png" /></a>
	</div><!--phone-->
	</div><!--body_left-->
	
	<div class="body_center fl clearfix">
	<div class="body_c_nei">
	<div class="body_c_nei_button">
	<a href="javascript:void(0);" onclick="rightBodyClick()"><img src="../images/daohang/c_n1.png" /></a>
	<a href="javascript:void(0);" onclick="leftBodyClick()"><img src="../images/daohang/c_n2.png" /></a>
	</div>
	</div>
	</div><!--body_center-->
	
	<div class="body_right fr clearfix">
	<div id="GISMap_aio" style="height: 100%;">
	</div>
	</div><!--body_right-->
</body>

</html>
