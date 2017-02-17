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
			<input type="hidden" name="ho_Id" value="${hospital.ho_Id }" />
			<div class="form-group ">
				<label class="col-sm-2 control-label" for="ho_Name"><span style="color:red">* </span>名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ho_Name" name="ho_Name"
						value="${hospital.ho_Name }" type="text" placeholder="名称" data-bv-trigger="keyup" required="required" />
				</div>
				<label class="col-sm-2 control-label" for="ho_Type">医院类型</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ho_Type" name="ho_Type" value="${hospital.ho_Type }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ho_Longitude">经度</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="ho_Longitude"
							value="${hospital.ho_Longitude}" type="text" placeholder="经度"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="ho_Latitude">纬度</label>
				<div class="col-sm-4 ">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="ho_Latitude"
							value="${hospital.ho_Latitude}" type="text" placeholder="纬度" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ho_Linkman"><span style="color:red">* </span>联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="ho_Linkman" name="ho_Linkman"
						value="${hospital.ho_Linkman }" type="text" placeholder="联系人" />
				</div>
				<label class="col-sm-2 control-label" for="ho_Linkmantel"><span style="color:red">* </span>联系人电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="ho_Linkmantel" name="ho_Linkmantel"
						value="${hospital.ho_Linkmantel }" type="text"
						placeholder="输入格式XXX-XXXXX" />
				</div>
			</div>
			<div class="form-group">
			    <label class="col-sm-2 control-label" for="ho_Dean">院长姓名</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="ho_Dean" name="ho_Dean"
						value="${hospital.ho_Dean }" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="ho_Deantel">院长电话</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="ho_Deantel" name="ho_Deantel"
						value="${hospital.ho_Deantel }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ho_Officetel">办公室电话</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ho_Officetel" name="ho_Officetel"
						value="${hospital.ho_Officetel }" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="ho_Workernum">医务人数</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ho_Workernum" name="ho_Workernum"
						value="${hospital.ho_Workernum }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ho_Bednum">床位数</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="ho_Bednum" name="ho_Bednum"
						value="${hospital.ho_Bednum }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ho_Equipment">床位数</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="ho_Equipment" name="ho_Equipment"
						value="${hospital.ho_Equipment }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="ho_Address"><span style="color:red">* </span>地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="ho_Address" name="ho_Address"
						value="${hospital.ho_Address }" type="text" placeholder="地址" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>

			<span id="msgdemo2" style="margin-left:30px;"></span>
		</form>
	</div>

	<script type="text/javascript"
		src="jsp/resource/assets/js/assets_cu.js"></script>

</body>
</html>
