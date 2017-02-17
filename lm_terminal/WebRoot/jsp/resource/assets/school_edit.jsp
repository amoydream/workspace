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
			<input type="hidden" name="sc_Id" value="${school.sc_Id }" />
			<div class="form-group ">
				<label class="col-sm-2 control-label" for="sc_Name"><span style="color:red">* </span>名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="sc_Name" name="sc_Name"
						value="${school.sc_Name }" type="text" placeholder="名称" data-bv-trigger="keyup" required="required" />
				</div>
				<label class="col-sm-2 control-label" for="sc_Galleryful"><span style="color:red">* </span>容纳人数</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="sc_Galleryful" name="sc_Galleryful"
						value="${school.sc_Galleryful }" type="text" placeholder="必须输入数字" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="sc_Area"><span style="color:red">* </span>面积</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="sc_Area" name="sc_Area"
						value="${school.sc_Area }" type="text" placeholder="必须输入数字" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="sc_Longitude"><span style="color:red">* </span>经度</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="sc_Longitude"
							value="${school.sc_Longitude}" type="text" placeholder="经度"/>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="sc_Latitude"><span style="color:red">* </span>纬度</label>
				<div class="col-sm-4 ">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="sc_Latitude"
							value="${school.sc_Latitude}" type="text" placeholder="纬度" />
					</div>
				</div>
				<label class="col-sm-2 control-label" for="sc_Linkman">联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="sc_Linkman" name="sc_Linkman"
						value="${school.sc_Linkman }" type="text" placeholder="联系人" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="sc_Linkmantel">联系人电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="sc_Linkmantel" name="sc_Linkmantel"
						value="${school.sc_Linkmantel }" type="text"
						placeholder="输入格式XXX-XXXXX" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="sc_Address"><span style="color:red">* </span>地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="sc_Address" name="sc_Address"
						value="${school.sc_Address }" type="text" placeholder="地址" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>

			<span id="msgdemo2" style="margin-left:30px;"></span>
		</form>
	</div>

	<script type="text/javascript"
		src="jsp/resource/assets/js/assets_cu.js"></script>

</body>
</html>
