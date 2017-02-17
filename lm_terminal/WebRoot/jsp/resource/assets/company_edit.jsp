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
			<input type="hidden" name="co_Id" value="${company.co_Id }" />
			<div class="form-group ">
				<label class="col-sm-2 control-label" for="co_Name"><span style="color:red">* </span>名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="co_Name" name="co_Name"
						value="${company.co_Name }" type="text" placeholder="名称" data-bv-trigger="keyup" required="required" />
				</div>
				<label class="col-sm-2 control-label" for="co_Type">经济类型</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="co_Type" name="co_Type"
						value="${company.co_Type }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="co_Longitude">经度</label>
				<div class="col-sm-4">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="co_Longitude"
							value="${company.co_Longitude}" type="text" placeholder="经度"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="co_Latitude">纬度</label>
				<div class="col-sm-4 ">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="co_Latitude"
							value="${company.co_Latitude}" type="text" placeholder="纬度" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="co_Linkman"><span style="color:red">* </span>联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="co_Linkman" name="co_Linkman"
						value="${company.co_Linkman }" type="text" placeholder="联系人" />
				</div>
				<label class="col-sm-2 control-label" for="co_Linkmantel"><span style="color:red">* </span>联系人电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="co_Linkmantel" name="co_Linkmantel"
						value="${company.co_Linkmantel }" type="text"
						placeholder="输入格式XXX-XXXXX" />
				</div>
			</div>
			<div class="form-group">
			    <label class="col-sm-2 control-label" for="co_Director">负责人</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="co_Director" name="co_Director"
						value="${company.co_Director }" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="co_Directortel">负责人电话</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="co_Directortel" name="co_Directortel"
						value="${company.co_Directortel }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="co_Legalman">法人</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="co_Legalman" name="co_Legalman"
						value="${company.co_Legalman }" type="text" />
				</div>
				<label class="col-sm-2 control-label" for="co_Product">主要产品</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="co_Product" name="co_Product"
						value="${company.co_Product }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="co_Workarea"><span style="color:red">* </span>经营范围</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="co_Address" name="co_Workarea"
						value="${company.co_Workarea }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="co_Address"><span style="color:red">* </span>地址</label>
				<div class="col-sm-10 input-message">
					<input class="form-control" id="co_Address" name="co_Address"
						value="${company.co_Address }" type="text" placeholder="地址" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>

			<span id="msgdemo2" style="margin-left:30px;"></span>
		</form>
	</div>

	<script type="text/javascript"
		src="jsp/resource/assets/js/assets_cu.js"></script>

</body>
</html>
