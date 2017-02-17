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
			<input type="hidden" name="bu_Id" value="${busstation.bu_Id }" />
			<div class="form-group ">
				<label class="col-sm-2 control-label" for="bu_Name"><span style="color:red">* </span>名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="bu_Name" name="bu_Name"
						value="${busstation.bu_Name }" type="text" placeholder="名称" data-bv-trigger="keyup" required="required" />
				</div>
				<label class="col-sm-2 control-label" for="bu_Area">占地面积</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="bu_Area" name="bu_Area" value="${busstation.bu_Area }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="bu_Longitude">经度</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="bu_Longitude"
							value="${busstation.bu_Longitude}" type="text" placeholder="经度"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="bu_Latitude">纬度</label>
				<div class="col-sm-4 ">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="bu_Latitude"
							value="${busstation.bu_Latitude}" type="text" placeholder="纬度" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="bu_Linkman"><span style="color:red">* </span>联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="bu_Linkman" name="bu_Linkman"
						value="${busstation.bu_Linkman }" type="text" placeholder="联系人" />
				</div>
				<label class="col-sm-2 control-label" for="bu_Linkmantel"><span style="color:red">* </span>联系人电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="bu_Linkmantel" name="bu_Linkmantel"
						value="${busstation.bu_Linkmantel }" type="text"
						placeholder="输入格式XXX-XXXXX" />
				</div>
			</div>
			<div class="form-group">
			    <label class="col-sm-2 control-label" for="bu_Sendnum">日发旅客量</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="bu_Sendnum" name="bu_Sendnum"
						value="${busstation.bu_Sendnum }" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="bu_Dept">所属单位</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="bu_Dept" name="bu_Dept"
						value="${busstation.bu_Dept }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="bu_Carnum">车辆数</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="bu_Carnum" name="bu_Carnum"
						value="${busstation.bu_Carnum }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="bu_Address"><span style="color:red">* </span>地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="bu_Address" name="bu_Address"
						value="${busstation.bu_Address }" type="text" placeholder="地址" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>

			<span id="msgdemo2" style="margin-left:30px;"></span>
		</form>
	</div>

	<script type="text/javascript"
		src="jsp/resource/assets/js/assets_cu.js"></script>

</body>
</html>
