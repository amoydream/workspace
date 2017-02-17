<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head><base href="<%=basePath%>">
<title>物资添加</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
<div class="modal-body">
<form id="suppliesAddForm" class="form-horizontal" role="form">
<input type="hidden" name="typeid" value="${typeid }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="su_Code"><span style="color:red">* </span>物资编号</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="su_Code" name="su_Code" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="su_Name"><span style="color:red">* </span>物资名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="su_Name" name="su_Name" type="text"
						placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="su_Type">物资型号</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="su_Type" name="su_Type" type="text"/>
				</div>
				<label class="col-sm-2 control-label" for="su_Size">物资规格</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="su_Size" name="su_Size" type="text"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="su_Measureunit">计量单位</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="su_Measureunit" name="su_Measureunit" type="text"/>
				</div>
				<label class="col-sm-2 control-label" for="su_Safetystock">安全库存</label>
				<div class="col-sm-4">
					<input class="form-control" id="su_Safetystock" name="su_Safetystock" type="text"
						/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="su_Remark">备注</label>
				<div class="col-sm-4">
					<input class="form-control" id="su_Remark" name="su_Remark" type="text"
						/>
				</div>
			</div>
			
		</fieldset>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</form>
	</div>
	<script type="text/javascript" src="jsp/resource/supplies/js/supplies_cu.js"></script>
</body>
</html>