<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
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
<form id="module_editform" class="form-horizontal" role="form">
<input name="mo_Id" type="hidden" value="${module.mo_Id }">
<input type=hidden id="mo_Pid" name="mo_Pid" value="${module.mo_Pid }">
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Code"><span style="color: red;">*</span>功能编码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="mo_Code" name="mo_Code" value="${module.mo_Code }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="mo_Name"><span style="color: red;">*</span>模块名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="mo_Name" name="mo_Name" value="${module.mo_Name }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Url">URL</label>
				<div class="col-sm-10">
					<input class="form-control" id="mo_Url" name="mo_Url" value="${module.mo_Url }" type="text"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Index">排序</label>
				<div class="col-sm-10 input-message">
						<input class="form-control" id="mo_Index" name="mo_Index" value="${module.mo_Index }" type="text" pattern="^[0-9]*[1-9][0-9]*$" placeholder="请输入整数"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="mo_Step"><span style="color: red;">* </span>级别</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="mo_Step" name="mo_Step"
						type="text" value="${module.mo_Step }" placeholder="必填项，整数" pattern="^[0-9]*[1-9][0-9]*$" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="mo_State">状态</label>
				<div class="col-sm-4">
					<input type="radio" name="mo_State" value="1" <c:if test="${module.mo_State=='1' }">checked="checked"</c:if>/>启用
				    <input type="radio" name="mo_State" value="0" <c:if test="${module.mo_State=='0' }">checked="checked"</c:if>/>禁用
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">图标</label>
				<div class="col-sm-10">
				    <input type="radio" name="mo_Icon" value="fa-users" <c:if test="${module.mo_Icon=='fa-users' }">checked="checked"</c:if>/><i class="fa fa-users"></i>
				    <input type="radio" name="mo_Icon" value="fa-user" <c:if test="${module.mo_Icon=='fa-user' }">checked="checked"</c:if>/><i class="fa fa-user"></i>
				    <input type="radio" name="mo_Icon" value="fa-book" <c:if test="${module.mo_Icon=='fa-book' }">checked="checked"</c:if>/><i class="fa fa-book"></i>
				    <input type="radio" name="mo_Icon" value="fa-sitemap" <c:if test="${module.mo_Icon=='fa-sitemap' }">checked="checked"</c:if>/><i class="fa fa-sitemap"></i>
				    <input type="radio" name="mo_Icon" value="fa-file" <c:if test="${module.mo_Icon=='fa-file' }">checked="checked"</c:if>/><i class="fa fa-file"></i>
				    <input type="radio" name="mo_Icon" value="fa-phone" <c:if test="${module.mo_Icon=='fa-phone' }">checked="checked"</c:if>/><i class="fa fa-phone"></i>
				    <input type="radio" name="mo_Icon" value="fa-envelope" <c:if test="${module.mo_Icon=='fa-envelope' }">checked="checked"</c:if>/><i class="fa fa-envelope"></i>
				    <input type="radio" name="mo_Icon" value="fa-fax" <c:if test="${module.mo_Icon=='fa-fax' }">checked="checked"</c:if>/><i class="fa fa-fax"></i>
				    <input type="radio" name="mo_Icon" value="fa-user-secret" <c:if test="${module.mo_Icon=='fa-user-secret' }">checked="checked"</c:if>/><i class="fa fa-user-secret"></i>
				    <input type="radio" name="mo_Icon" value="fa-bar-chart" <c:if test="${module.mo_Icon=='fa-bar-chart' }">checked="checked"</c:if>/><i class="fa fa-bar-chart"></i>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">样式颜色</label>
				<div class="col-sm-10">
				    <input type="radio" name="mo_Class" value="module1" <c:if test="${module.mo_Class=='module1' }">checked="checked"</c:if>/><i style="background: #83b6c8;">颜色</i>
				    <input type="radio" name="mo_Class" value="module2" <c:if test="${module.mo_Class=='module2' }">checked="checked"</c:if>/><i style="background: #c09759;">颜色</i>
				    <input type="radio" name="mo_Class" value="module3" <c:if test="${module.mo_Class=='module3' }">checked="checked"</c:if>/><i style="background: #618cbb;">颜色</i>
				    <input type="radio" name="mo_Class" value="module4" <c:if test="${module.mo_Class=='module4' }">checked="checked"</c:if>/><i style="background: #62c774;">颜色</i>
				    <input type="radio" name="mo_Class" value="module5" <c:if test="${module.mo_Class=='module5' }">checked="checked"</c:if>/><i style="background: #77a3dd;">颜色</i>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-10">
				    <textarea class="form-control" rows="3" id="mo_Remark" name="mo_Remark">${module.mo_Remark}</textarea>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="jsp/system/moduleinfo/js/module_cu.js"></script>
</body>
</html>