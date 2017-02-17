<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>类型管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<div class="modal-body">
<form id="typeEditForm" class="form-horizontal" role="form">
<input name="lt_Id" type="hidden" value="${type.lt_Id }">
<input type=hidden id="lt_Pid" name="lt_Pid" value="${type.lt_Pid }">
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lt_Code"><span style="color:red">* </span>类型编号</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="lt_Code" name="lt_Code" value="${type.lt_Code }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="lt_Name"><span style="color:red">* </span>类型名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="lt_Name" name="lt_Name" value="${type.lt_Name }" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="lt_Remark">备注</label>
				<div class="col-sm-4">
						<input class="form-control" id="lt_Remark" name="lt_Remark" value="${type.lt_Remark }" type="text"/>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="jsp/resource/legaltype/js/legaltype_cu.js"></script>
</body>
</html>