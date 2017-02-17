<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>物资编辑</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<link rel="stylesheet"
	href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>
<body>
	
	<div class="modal-body">
		<form id="storeEditForm" class="form-horizontal" role="form">
			<input type="hidden" name="st_Id" value="${store.st_Id }" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Supplied"><span style="color:red">* </span>物资名称</label>
				<div class="col-sm-4 input-message">
					<input type="hidden" id="suppliesId" name="st_Suppliesid"
						value="${store.st_Suppliesid.su_Id }" /> <input
						class="form-control" id="suppliesName" name="suppliesName"
						value="${store.st_Suppliesid.su_Name }" type="text"
						onclick="select_supplies();" data-bv-trigger="keyup" required="required" placeholder="请点击选择"/>
				</div>
				<label class="col-sm-2 control-label" for="st_Count"><span style="color:red">* </span>存放数量</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="st_Count" name="st_Count"
						value="${store.st_Count }" type="text" data-bv-trigger="keyup" required="required" placeholder="必填项"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Managedept"><span style="color:red">* </span>管理单位</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="st_Managedept" name="st_Managedept"
						value="${store.st_Managedept }" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="st_Storedate">存放日期</label>
				<div class="col-sm-4 ">
				    <div class='input-group'>
						<input class="form-control" id="st_Storedate" name="st_Storedate"
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${store.st_Storedate }" />"
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
						value="${store.st_Manageman}" type="text" data-bv-trigger="keyup" required="required" placeholder="必填项"/>
				</div>
				<label class="col-sm-2 control-label" for="st_Managemantel"><span style="color:red">* </span>负责人电话</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="st_Managemantel"
						name="st_Managemantel" value="${store.st_Managemantel }"
						type="text" data-bv-trigger="keyup" required="required" 
						pattern="^(13|15|18)\d{9}$" data-bv-regexp-message="手机格式不正确" placeholder="请输入手机号"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Longitude">经度</label>
				<div class="col-sm-4 input-message">
					<div class="input-group">
						<span class="input-group-btn ">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="st_Longitude"
							value="${store.st_Longitude }" type="text" data-bv-trigger="keyup" required="required"
							pattern="^[0-9]+\.{0,1}[0-9]{0,6}$" placeholder="小数点保留六位"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="st_Latitude">纬度</label>
				<div class="col-sm-4 input-message">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="st_Latitude"
							value="${store.st_Latitude }" type="text" data-bv-trigger="keyup" required="required"
							pattern="^[0-9]+\.{0,1}[0-9]{0,6}$" placeholder="小数点保留六位"/>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="st_Storetel">存放地电话</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="st_Storetel" name="st_Storetel"
						value="${store.st_Storetel }" type="text" 
						pattern="(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)" 
						data-bv-regexp-message="电话号码格式不正确" placeholder="请正确输入固话号/手机号"/>
				</div>
			</div>
			<div class="form-group">
			<label class="col-sm-2 control-label" for="st_Address"><span style="color:red">* </span>地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="st_Address" name="st_Address"
						value="${store.st_Address }" type="text" data-bv-trigger="keyup" required="required" placeholder="必填项"/>
				</div>
			</div>
		</form>
	</div>
<script type="text/javascript"
		src="jsp/resource/suppliesstore/js/suppliesstore_cu.js"></script>
</body>
</html>