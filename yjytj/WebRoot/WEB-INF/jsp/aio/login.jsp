<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>应急平台</title>
  <!--[if IE 6]>
  <script src="images/DD_belatedPNG.js"></script>
   <script>
   DD_belatedPNG.fix(".pngFix");
  </script> 
  <![endif]-->

<style type="text/css">
html, body{overflow: hidden; height:100%;}
*{padding:0px;margin:0px;}
body{
   background:url('<%=basePath%>images/login/bg_0.jpg') top repeat-x #fff;
   font-size:12px;
   color:#383838;  overflow:auto; position:relative;}

.content{ width:100%; height:100%;background:url('<%=basePath%>images/login/bg_1AIO.jpg') top center no-repeat;}

#logo{ position:fixed; top:150px; left:50%; margin-left:-210px;
   width:420px;
   height:215px;
   background:url('<%=basePath%>images/login/login2.png') no-repeat;
}
#logo #form{
   width:355px;
   height:96px;
   padding-left:40px;
   padding-top:106px;
}
#logo #form .left{
   float:left;
   width:260px;
   position: relative;
}




#logo #form .left div{
   height:40px;
   text-align:left;
}
#logo #form .right{
   float:left;
   width:75px;
}

.left-bt{ float: left; width:60px; line-height:32px; text-align:center; color:#999}

input.text{ float:left;
   border:1px #dfdfdf solid;
   padding:0px 5px;
   width:180px;
   height:32px;
   line-height:32px;
    -moz-border-radius: 5px;      /* Gecko browsers */
    -webkit-border-radius: 5px;   /* Webkit browsers */
    border-radius:5px;            /* W3C syntax */
}

input.submit{
   width:75px;
   height:75px;
   background:url("<%=basePath%>images/login/sub1.png") no-repeat;
   border:0px;
   cursor:pointer;
}
input.submit:hover{
   background:url("<%=basePath%>images/login/sub2.png") no-repeat;
}

</style>
	
	<%@ include file="/include/headerAIO.jsp"%>
	<script>


	function validate(){
		return $("#loginForm").form('enableValidation').form('validate');
	}
	<c:if test="${!empty aioPCmsg}">
		alert("${aioPCmsg}");
	</c:if>
	<c:if test="${!empty loginAgain}">
 	alert("${loginAgain}");
 	if(window.parent){
 		window.parent.location='<%=basePath%>/AIOLogin';
 	}else
	 	window.location='<%=basePath%>/AIOLogin';
 </c:if>
	
	</script>
  </head>
  
 <body>
	<div class="content">
			<div id="logo" class="pngFix">
           <form method="post" id="loginForm" action="<%=basePath %>AIOLogin/doLogin">
          
				<div id="form">
					<div class="left">
					 <span style="color: red;font-weight: bold;position:absolute;left:10px;top:-30px;">${msg}</span>
						<div class="user">
							<p class="left-bt">用户名</p><input type="text" class="text" name="loginAccount"/>
						</div>
						<div class="pwd">
							<p class="left-bt">密&nbsp;码</p><input type="password" class="text" name="loginPwd" />
						</div>
					</div>
					<div class="right">
						<input type="submit" class="submit" title="登录"  onclick="return validate();" value=""/>
					</div>
				</div>
				
                </form>
			</div>
</div>
</body>
</html>
