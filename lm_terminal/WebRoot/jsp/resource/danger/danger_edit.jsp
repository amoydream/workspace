<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>物资添加</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
</head>
<body>
<div id="container"></div>
	<div class="modal-body">
		<form id="dangerEditForm" class="form-horizontal" role="form">
			<input type="hidden" name="da_Id" value="${danger.da_Id }"/>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="da_Name"><span style="color:red">* </span>危险源名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="da_Name" name="da_Name" value="${danger.da_Name }" type="text"
						placeholder="必填项"  />
				</div>
				<label class="col-sm-2 control-label" for="da_Dept">所属单位</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="da_Dept" name="da_Dept" value="${danger.da_Dept }" 
						type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="da_Longitude">经度</label>
				<div class="col-sm-4 input-message">
					<div class="input-group">
						<span class="input-group-btn ">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="da_Longitude" value="${danger.da_Longitude }"
							type="text" placeholder="经度"  />
					</div>
				</div>
				<label class="col-sm-2 control-label" for="da_Latitude">纬度</label>
				<div class="col-sm-4 input-message">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="da_Latitude" value="${danger.da_Latitude }"
							type="text" placeholder="纬度"  />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="da_Patrolman">巡查人</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="da_Patrolman" name="da_Patrolman" value="${danger.da_Patrolman }" 
						type="text" />
				</div>
				<label class="col-sm-2 control-label" for="da_Patrolmantel">巡查人电话</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="da_Patrolmantel"
						name="da_Patrolmantel" value="${danger.da_Patrolmantel }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="da_Level">危险程度</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="da_Level" name="da_Level" value="${danger.da_Level }" 
						type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="da_Address"><span style="color:red">* </span>隐患点地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="da_Address" name="da_Address" value="${danger.da_Address }" 
						type="text" placeholder="必填项"  />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="da_Remark">备注</label>
				<div class="col-sm-10">
					<input class="form-control" id="da_Remark" name="da_Remark" value="${danger.da_Remark }" 
						type="text" />
				</div>
			</div>

		</form>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</div>
	<script type="text/javascript"
		src="jsp/resource/danger/js/danger_cu.js"></script>
</body>
</html>