<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>模块管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<div class="modal-body">
<form id="module_addform" class="form-horizontal" role="form">
<input type="hidden" name="mo_Pid" value="${param.pid }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Code"><span style="color: red;">* </span>功能编码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="mo_Code" name="mo_Code" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="mo_Name"><span style="color: red;">* </span>模块名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="mo_Name" name="mo_Name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Url">URL</label>
				<div class="col-sm-10">
					<input class="form-control" id="mo_Url" name="mo_Url" type="text"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Index">排序</label>
				<div class="col-sm-10 input-message">
						<input class="form-control" id="mo_Index" name="mo_Index" type="text" pattern="^[0-9]*[1-9][0-9]*$" placeholder="请输入整数"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Step">级别</label>
				<div class="col-sm-4">
						<input type="radio" name="mo_Step" value="1" checked="checked"/>菜单
				    <input type="radio" name="mo_Step" value="2"/>功能
				</div>
				<label class="col-sm-2 control-label" for="mo_State">状态</label>
				<div class="col-sm-4">
					<input type="radio" name="mo_State" value="1" checked="checked"/>启用
				    <input type="radio" name="mo_State" value="0"/>禁用
				</div>
			</div>

			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">图标</label>
				<div class="col-sm-10">
				    <input type="radio" name="mo_Icon" value="fa-users"/><i class="fa fa-users"></i>
				    <input type="radio" name="mo_Icon" value="fa-user"/><i class="fa fa-user"></i>
				    <input type="radio" name="mo_Icon" value="fa-book"/><i class="fa fa-book"></i>
				    <input type="radio" name="mo_Icon" value="fa-sitemap"/><i class="fa fa-sitemap"></i>
				    <input type="radio" name="mo_Icon" value="fa-file"/><i class="fa fa-file"></i>
				    <input type="radio" name="mo_Icon" value="fa-phone"/><i class="fa fa-phone"></i>
				    <input type="radio" name="mo_Icon" value="fa-envelope"/><i class="fa fa-envelope"></i>
				    <input type="radio" name="mo_Icon" value="fa-fax"/><i class="fa fa-fax"></i>
				    <input type="radio" name="mo_Icon" value="fa-user-secret"/><i class="fa fa-user-secret"></i>
				    <input type="radio" name="mo_Icon" value="fa-bar-chart"/><i class="fa fa-bar-chart"></i>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">样式颜色</label>
				<div class="col-sm-10">
				    <input type="radio" name="mo_Class" value="module1" checked="checked"/><i style="background: #83b6c8;">颜色</i>
				    <input type="radio" name="mo_Class" value="module2"/><i style="background: #c09759;">颜色</i>
				    <input type="radio" name="mo_Class" value="module3"/><i style="background: #618cbb;">颜色</i>
				    <input type="radio" name="mo_Class" value="module4"/><i style="background: #62c774;">颜色</i>
				    <input type="radio" name="mo_Class" value="module5"/><i style="background: #77a3dd;">颜色</i>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-10">
				    <textarea class="form-control" rows="3" id="mo_Remark" name="mo_Remark"></textarea>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="jsp/system/moduleinfo/js/module_cu.js"></script>
</body>
</html>