<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>角色管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<link rel="stylesheet" href="lauvanUI/zTree/metroStyle/metroStyle.css" type="text/css"></link>

</head>

<body>
<div class="modal-body">
<form id="role_addform" class="form-horizontal" role="form">
		<fieldset>
			<div class="form-group" style="margin-left: 0px; margin-right: 0px;">
				<label class="col-sm-2 control-label" for="ro_Code">编码</label>
				<div class="col-sm-4">
					<input class="form-control" id="ro_Code" name="ro_Code" type="text" placeholder="输入编码"/>
				</div>
				<label class="col-sm-2 control-label" for="ro_Name"><span style="color: red;">* </span>角色名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ro_Name" name="ro_Name" type="text"
						placeholder="输入角色名称" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>

			<div class="form-group" style="margin-left: 0px; margin-right: 0px;">
				<label for="disabledSelect" class="col-sm-2 control-label">备注</label>
				<div class="col-sm-10">
					<input class="form-control" id="ro_Remark"
						name="ro_Remark" type="text" placeholder="输入备注" />
				</div>
			</div>
		</fieldset>
		
		<fieldset>
		<legend>权限选择</legend>
		<input type="hidden" id="moduleids" name="moids"/>
		<div class="form-group" style="margin-left: 0px; margin-right: 0px;">
		<div class="col-sm-10">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
		</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="lauvanUI/zTree/jquery.ztree.min.js"></script>
	<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
	<script type="text/javascript" src="jsp/system/roleinfo/js/role_cu.js"></script>
</body>
</html>