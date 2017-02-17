<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>用户管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
	<form id="user_pwdform" class="form-horizontal" role="form">
	<input type=hidden name="id" value="${param.userid }">
				<label class="col-sm-2 control-label" for="us_Code">用户名</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'>
					<input class="form-control" id="us_Code" type="text" value="${param.userCode }" readonly="readonly"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="us_Pass"><span style="color: red;">* </span>密码</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="us_Pass" name="pwd" type="password" value=""
						placeholder="输入密码" data-bv-trigger="keyup" required="required" autocomplete="off" />
						</div>
				</div>
	</form>
<script type="text/javascript">
$('#user_pwdform').bootstrapValidator();
function userPwd_submitForm(index,window) {
	$('#user_pwdform').bootstrapValidator('validate');
	if($('#user_pwdform').data('bootstrapValidator').isValid()){
		$.post('system/userinfo/editpwd', $('#user_pwdform').serialize(), function(j) {	
			if(j.success){
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}
</script>
</body>
</html>