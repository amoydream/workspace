<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>用户管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<body>
<div class="modal-body">
<form id="user_editform" class="form-horizontal" role="form">
<input type=hidden name="us_Id" value="${user.us_Id }">
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Code">用户名</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Code" name="us_Code" value="${user.us_Code }" type="text"
						placeholder="输入用户名" readonly="readonly"/>
				</div>
				<label class="col-sm-2 control-label" for="us_Pass">密码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Pass" name="us_Pass" value="${user.us_Pass }" readonly="readonly" type="password"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Name"><span style="color: red;">* </span>姓名</label>
				<div class="col-sm-4 input-message">
						<input class="form-control" id="us_Name" name="us_Name" value="${user.us_Name }" type="text"
						data-bv-trigger="keyup" required="required" placeholder="输入姓名"/>
				</div>
				<label class="col-sm-2 control-label" for="us_State">状态</label>
				<div class="col-sm-4 input-message">
						<input type="radio" name="us_State" value="0" <c:if test="${user.us_State=='0' }">checked="checked"</c:if>/>停用
				        <input type="radio" name="us_State" value="1" <c:if test="${user.us_State=='1' }">checked="checked"</c:if>/>启用
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Age">年龄</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Age" name="us_Age"
						type="text" value="${user.us_Age }" placeholder="输入年龄"/>
				</div>
				<label class="col-sm-2 control-label" for="us_Sex">性别</label>
				<div class="col-sm-4">
					<input type="radio" name="us_Sex" value="M" <c:if test="${user.us_Sex=='M' }">checked="checked"</c:if> />男
				    <input type="radio" name="us_Sex" value="F" <c:if test="${user.us_Sex=='F' }">checked="checked"</c:if>/>女
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="us_Mophone">手机号码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Mophone" name="us_Mophone"
						type="text" value="${user.us_Mophone}" placeholder="输入手机号码" pattern="^(13|15|18)\d{9}$" data-bv-regexp-message="手机格式不正确"/>
				</div>
				<label class="col-sm-2 control-label" for="us_Offphone">办公号码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="us_Offphone" name="us_Offphone"
						type="text" value="${user.us_Offphone }" placeholder="输入办公号码" pattern="(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)" data-bv-regexp-message="电话号码格式不正确"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="voice">坐席</label>
				<div class="col-sm-4">
					<input class="form-control" id="voice" name="voice" value="${user.voice}" type="text" placeholder="输入终端机电话号"/>
				</div>
				<label class="col-sm-2 control-label" for="us_Remark">备注</label>
				<div class="col-sm-4">
					<input class="form-control" id="us_Remark" name="us_Remark"
						type="text" value="${user.us_Remark}" placeholder="输入备注" />
				</div>
			</div>

			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">住址</label>
				<div class="col-sm-10">
					<input class="form-control" id="us_Address"
						name="us_Address" value="${user.us_Address }" type="text" placeholder="输入住址" />
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>

<script type="text/javascript" src="jsp/system/userinfo/js/userinfo_cu.js"></script>
</body>
</html>