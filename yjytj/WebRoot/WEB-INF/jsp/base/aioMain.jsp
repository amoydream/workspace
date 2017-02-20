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

#box{position:relative;width:100%;height:100%;overflow:hidden;}
#top{float:left}
#bottom{float:right}
#line{cursor:w-resize;}

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

.b_l_phone{ width:33px; height:33px; position:absolute; z-index:100; left:10px; bottom:1px;}
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
	var oLine = document.getElementById("line");
	if($(".body_center").prev().width()!=0){
		$(".body_center").next().width(document.body.offsetWidth-c_neibutton-oLine.offsetWidth);
		$(".body_center").prev().width('0px');
	}else{
		$(".body_center").next().width(document.body.offsetWidth-c_neiLeft-c_neibutton-oLine.offsetWidth);
		$(".body_center").prev().width(c_neiLeft);
	}
}
function leftBodyClick(){
	var oLine = document.getElementById("line");
	if($(".body_center").next().width()!=0){
		$(".body_center").prev().width(document.body.offsetWidth-c_neibutton-oLine.offsetWidth);
		$(".body_center").next().width('0px');
	}else{
		$(".body_center").prev().width(c_neiLeft);
		$(".body_center").next().width(document.body.offsetWidth-c_neiLeft-c_neibutton-oLine.offsetWidth);
	}
}

var win = 0;
function aioSPhone(){
	
	 if(win)
	 {
	     if(!win.closed)
	    	 win.close();
	  }
	
	var url='<%=basePath%>Main/softphoneone/main';                             //转向网页的地址;  
    var iWidth=305;                          //弹出窗口的宽度; 
    var iHeight=610;                         //弹出窗口的高度; 
    //获得窗口的垂直位置 
    var iTop = (window.screen.availHeight - 30 - iHeight) / 2; 
    //获得窗口的水平位置 
    var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; 
    win = window.open(url, 'aioSPhone', 'height=' + iHeight + ',innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=0,titlebar=no'); 
    
  
  <%-- 
   win = window.open("<%=basePath%>Main/softphoneone/main",'aioSPhone'
			,'height=610,width=300,top=0,left=0,toolbar=no,titlebar=no,menubar=no,scrollbars=no,resizable=yes,location=no, status=yes');      --%>
}

window.onload = function() {
    var oBox = document.getElementById("box"), oTop = document.getElementById("top"), oBottom = document.getElementById("bottom"), oLine = document.getElementById("line");
	oLine.onmousedown = function(e) {
		var disX = (e || event).clientX;
		oLine.left = oLine.offsetLeft;
		document.onmousemove = function(e) {  
			var iT = oLine.left + ((e || event).clientX - disX);
            var e=e||window.event,tarnameb=e.target||e.srcElement;
			var maxT = oBox.clientWidth - oLine.offsetWidth;
			oLine.style.margin = 0;
			iT < 0 && (iT = 0);
			iT > maxT && (iT = maxT);
			/* oLine.style.left =  */oTop.style.width = (iT - oLine.offsetWidth)+ "px";
			 oBottom.style.width = (oBox.clientWidth - iT - oLine.offsetWidth-2) + "px";
			return false
		};	
		document.onmouseup = function() {
			document.onmousemove = null;
			document.onmouseup = null;	
			oLine.releaseCapture && oLine.releaseCapture()
		};
		oLine.setCapture && oLine.setCapture();
		return false
	};
};
</script>
</head>
<body>
  <div id="box">
	<div id="top" class="body_left fl clearfix">
	<iframe name="aiomain" src="<%=basePath %>Main" height="100%" width="100%" frameborder="0"></iframe>
	<div class="b_l_phone">
		<a href="javascript:void(0);" onclick="aioSPhone()"><img src="../images/login/phone_gree.png" /></a>
	</div><!--phone-->
	</div><!--body_left-->
	
	<div id="line" class="body_center fl clearfix">
	<div class="body_c_nei">
	<div class="body_c_nei_button">
	<a href="javascript:void(0);" onclick="rightBodyClick()"><img src="../images/daohang/c_n1.png" /></a>
	<a href="javascript:void(0);" onclick="leftBodyClick()"><img src="../images/daohang/c_n2.png" /></a>
	</div>
	</div>
	</div><!--body_center-->
	
	<div id="bottom" class="body_right fr clearfix">
	<div id="GISMap_aio" style="height: 100%;">
	</div>
	</div><!--body_right-->
 </div>	
</body>

</html>
