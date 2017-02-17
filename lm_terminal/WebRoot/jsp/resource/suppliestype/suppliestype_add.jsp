<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>物资类型管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<div class="modal-body">
<form id="typeAddForm" class="form-horizontal" role="form">
<input type="hidden" name="ty_Pid" value="${param.pid }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ty_Code"><span style="color:red">* </span>类型编码</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ty_Code" name="ty_Code" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="ty_Name"><span style="color:red">* </span>类型名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ty_Name" name="ty_Name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ty_Remark">备注</label>
				<div class="col-sm-4">
						<input class="form-control" id="ty_Remark" name="ty_Remark" type="text"/>
				</div>
			</div>
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="jsp/resource/suppliestype/js/suppliestype_cu.js"></script>
</body>
</html>