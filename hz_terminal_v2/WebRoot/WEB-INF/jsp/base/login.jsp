<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>政府综合应急平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
   background:url(../images/login/bg_0.jpg) top repeat-x #fff;
   font-size:12px;
   color:#383838;  overflow:auto; position:relative;}

.content{ width:100%; height:100%;background:url(../images/login/bg_1.jpg) top center no-repeat;}

#logo{ position:fixed; top:150px; left:50%; margin-left:-210px;
   width:420px;
   height:215px;
   background:url('../images/login/login2.png') no-repeat;
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
   background:url("../images/login/sub1.png") no-repeat;
   border:0px;
   cursor:pointer;
}
input.submit:hover{
   background:url("../images/login/sub2.png") no-repeat;
}

</style>
	
	<%@ include file="/include/header.jsp"%>
	<script>


	function validate(){
		return $("#loginForm").form('enableValidation').form('validate');
	}
	<c:if test="${!empty loginAgain}">
 	alert("${loginAgain}");
 	if(window.parent){
 		window.parent.location='<%=basePath%>/Login';
 	}else
	 	window.location='<%=basePath%>/Login';
 </c:if>
	
	</script>
  </head>
  
 <body>
 <%--  <div class="easyui-layout"  data-options="fit:true">
<div id="loginDialog" title="政府综合应急平台" style="width: 350px; height: 200px; padding: 10px">
		<form method="post" id="loginForm" action="<%=basePath %>Login/doLogin">
			<table class="table" style="width: 100%; height: 80%;font-size:12px;">
				<tr>
					<th width="70">登录名</th>
					<td><input name="loginAccount"  class="easyui-textbox" data-options="required:true" style="width: 210px;" value="${account }"/></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input name="loginPwd"  type="password" class="easyui-textbox" data-options="required:true" style="width: 210px;" /></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="submit" value="登录" style="width: 50px;" onclick="return validate();"/>&nbsp;<input type="reset" value="重置" style="width: 50px;" /></td>
				</tr>
			</table>
			<span style="color: red;font-weight: bold;">${msg}</span>
		</form>
	</div> 
</div>--%>
	<div class="content">
			<div id="logo" class="pngFix">
           <form method="post" id="loginForm" action="<%=basePath %>Login/doLogin">
          
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
