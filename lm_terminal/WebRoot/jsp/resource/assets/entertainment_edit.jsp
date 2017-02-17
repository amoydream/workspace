<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<head>
<base href="<%=basePath%>">
<meta name="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrap.min.css"
	type="text/css"></link>
<link rel="stylesheet"
	href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script src="js/jquery.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>


</head>
<html>
<body>
	<div id="container"></div>
	<div class="modal-body">
		<form class="form-horizontal" id="resEditForm">
			<input type="hidden" name="en_Id" value="${entertainment.en_Id }" />
			<div class="form-group ">
				<label class="col-sm-2 control-label" for="en_Name"><span style="color:red">* </span>名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="en_Name" name="en_Name"
						value="${entertainment.en_Name }" type="text" placeholder="名称" data-bv-trigger="keyup" required="required" />
				</div>
				<label class="col-sm-2 control-label" for="en_Area">占地面积</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="en_Area" name="en_Area" value="${entertainment.en_Area }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="en_Longitude">经度</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="en_Longitude"
							value="${entertainment.en_Longitude}" type="text" placeholder="经度"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="en_Latitude">纬度</label>
				<div class="col-sm-4 ">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="en_Latitude"
							value="${entertainment.en_Latitude}" type="text" placeholder="纬度" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="en_Linkman"><span style="color:red">* </span>联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="en_Linkman" name="en_Linkman"
						value="${entertainment.en_Linkman }" type="text" placeholder="联系人" />
				</div>
				<label class="col-sm-2 control-label" for="en_Linkmantel"><span style="color:red">* </span>联系人电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="en_Linkmantel" name="en_Linkmantel"
						value="${entertainment.en_Linkmantel }" type="text"
						placeholder="输入格式XXX-XXXXX" />
				</div>
			</div>
			<div class="form-group">
			    <label class="col-sm-2 control-label" for="en_Galleryful">容纳人数</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="en_Galleryful" name="en_Galleryful"
						value="${entertainment.en_Galleryful }" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="en_Businesshours">营业时间</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="en_Businesshours" name="en_Businesshours"
						value="${entertainment.en_Businesshours }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="en_Workarea">经营范围</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="en_Workarea" name="en_Workarea"
						value="${entertainment.en_Workarea }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="en_Address"><span style="color:red">* </span>地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="en_Address" name="en_Address"
						value="${entertainment.en_Address }" type="text" placeholder="地址" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>

			<span id="msgdemo2" style="margin-left:30px;"></span>
		</form>
	</div>

	<script type="text/javascript"
		src="jsp/resource/assets/js/assets_cu.js"></script>

</body>
</html>
