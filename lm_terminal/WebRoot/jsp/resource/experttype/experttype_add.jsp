<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>专家类型管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<div class="modal-body">
<form id="typeAddForm" class="form-horizontal" role="form">
<input type="hidden" name="ext_Pid" value="${param.pid }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ext_Code"><span style="color:red">* </span>类型编码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ext_Code" name="ext_Code" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="ext_Name"><span style="color:red">* </span>类型名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ext_Name" name="ext_Name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>  
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ext_Remark">备注</label>
				<div class="col-sm-4">
						<input class="form-control" id="ext_Remark" name="ext_Remark" type="text"/>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="jsp/resource/experttype/js/experttype_cu.js"></script>
</body>
</html>