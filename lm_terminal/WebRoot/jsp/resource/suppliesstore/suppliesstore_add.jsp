<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
	<div id="container"></div>
	<div class="modal-body">
		<form id="storeAddForm" class="form-horizontal" role="form">
			<input type="hidden" name="st_Id" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Supplied"><span style="color:red">* </span>物资名称</label>
				<div class="col-sm-4 input-message">
					<input type="hidden" id="suppliesId" name="st_Suppliesid.su_Id" />
					<input class="form-control" id="suppliesName" name="suppliesName"
						type="text" onclick="select_supplies();" placeholder="请点击选择" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="st_Count"><span style="color:red">* </span>存放数量</label>
				<div class='col-sm-4 input-message'>
					<input class="form-control" id="st_Count" name="st_Count"
						type="text" placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Managedept"><span style="color:red">* </span>管理单位</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="st_Managedept" name="st_Managedept"
						type="text" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="st_Storedate">存放日期</label>
				<div class="col-sm-4 ">
					<div class='input-group'>
						<input class="form-control" id="st_Storedate" name="st_Storedate"
							type="text" placeholder="输入存放日期" /><span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Manageman"><span style="color:red">* </span>负责人</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="st_Manageman" name="st_Manageman"
						type="text" data-bv-trigger="keyup" required="required" placeholder="必填项"/>
				</div>
				<label class="col-sm-2 control-label" for="st_Managemantel"><span style="color:red">* </span>负责人电话</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="st_Managemantel"
						name="st_Managemantel" type="text" data-bv-trigger="keyup" required="required" 
						pattern="^(13|15|18)\d{9}$" data-bv-regexp-message="手机格式不正确" placeholder="请正确的输入手机号"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Longitude">经度</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-btn ">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="st_Longitude"
							type="text"
							pattern="^[0-9]+\.{0,1}[0-9]{0,6}$" placeholder="小数点保留六位"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="st_Latitude">纬度</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="st_Latitude"
							type="text"
							pattern="^[0-9]+\.{0,1}[0-9]{0,6}$" placeholder="小数点保留六位"/>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Storetel">存放地电话</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="st_Storetel" name="st_Storetel"
						type="text"
						pattern="(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)" placeholder="请正确输入固话号/手机号"/>
				</div>
			</div>
			<div class="form-group">
			<label class="col-sm-2 control-label" for="st_Address"><span style="color:red">* </span>地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="st_Address" name="st_Address"
						type="text" data-bv-trigger="keyup" required="required" placeholder="必填项"/>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript"
		src="jsp/resource/suppliesstore/js/suppliesstore_cu.js"></script>
</body>
</html>