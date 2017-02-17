<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>政府综合应急平台</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="">
	
	<%@ include file="/include/header.jsp"%>
	<style type="text/css">
		.tree-node{
			height:28px;
		}
		.tree-node span{
			margin:5px auto;
		}
	</style>
	<script>
	$(function() {
		$('#loginDialog').show().dialog({
			modal : false,
			closable : false,
			iconCls : 'icon-lockopen',
			onOpen : function() {
				$('form :input:first').focus();
				$('form :input').keyup(function(event) {
					if (event.keyCode == 13) {
						if(validate)
							$("#loginForm").submit();
					}
				});
			}
		});
	});

	function validate(){
		return $("#loginForm").form('enableValidation').form('validate');
	}

	 <c:if test="${!empty loginAgain}">
	 	alert("${loginAgain}");
	 	if(window.parent){
	 		window.parent.location='<%=basePath%>Login';
	 	}else
		 	window.location='<%=basePath%>Login';
	 </c:if>
	</script>
  </head>
  
 <body>
  <div class="easyui-layout"  data-options="fit:true">
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
</div>
</body>
</html>
