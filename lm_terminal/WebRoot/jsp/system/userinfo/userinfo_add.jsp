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
<div class="modal-body">
	<form id="user_addform" class="form-horizontal" role="form">
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Code"><span style="color: red;">* </span>用户名</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Code" name="us_Code" type="text"
						placeholder="输入用户名" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="us_Pass"><span style="color: red;">* </span>密码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Pass" name="us_Pass" type="password"
						placeholder="输入密码" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Name"><span style="color: red;">* </span>姓名</label>
				<div class="col-sm-4 input-message">
						<input class="form-control" id="us_Name" name="us_Name" type="text"
						data-bv-trigger="keyup" required="required" placeholder="输入姓名"/>
				</div>
				<label class="col-sm-2 control-label" for="us_State">状态</label>
				<div class="col-sm-4 input-message">
						<input type="radio" id="us_State" name="us_State" value="0" />停用 <input
					type="radio" name="us_State" value="1" checked="checked" />启用
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Age">年龄</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Age" name="us_Age"
						type="text" placeholder="输入年龄" />
				</div>
				<label class="col-sm-2 control-label" for="us_Sex">性别</label>
				<div class="col-sm-4">
					<input type="radio" id="us_Sex" name="us_Sex" value="M"
					checked="checked" />男 <input type="radio" name="us_Sex" value="F" />女
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Mophone">手机号码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Mophone" name="us_Mophone"
						type="text" placeholder="输入手机号码" pattern="^(13|15|18)\d{9}$"/>
				</div>
				<label class="col-sm-2 control-label" for="us_Offphone">办公号码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Offphone" name="us_Offphone"
						type="text" placeholder="输入办公号码" pattern="(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="voice">坐席</label>
				<div class="col-sm-4">
					<input class="form-control" id="voice" name="voice"
						type="text" placeholder="输入终端机电话号"/>
				</div>
				<label class="col-sm-2 control-label" for="us_Remark">备注</label>
				<div class="col-sm-4">
					<input class="form-control" id="us_Remark" name="us_Remark"
						type="text" placeholder="输入备注" />
				</div>
			</div>

			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">住址</label>
				<div class="col-sm-10">
					<input class="form-control" id="us_Address"
						name="us_Address" type="text" placeholder="输入住址" />
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>

	<script type="text/javascript"
		src="jsp/system/userinfo/js/userinfo_cu.js"></script>
</body>
</html>