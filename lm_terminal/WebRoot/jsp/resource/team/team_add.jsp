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
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
</head>

<html>
<body>
	<div id="container"></div>
	<div class="modal-body">
		<form class="form-horizontal" id="teamAddForm">
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Name">名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="te_Name" name="te_Name" type="text"
						placeholder="名称" />
				</div>
				<label class="col-sm-2 control-label" for="te_Director"><span style="color:red">* </span>负责人</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="te_Director" name="te_Director"
						type="text" placeholder="负责人" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Directortel">负责人电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Directortel" name="te_Directortel"
						type="text" placeholder="负责人电话" />
				</div>
				<label class="col-sm-2 control-label" for="te_Directorphone">负责人手机</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="te_Directorphone"
						name="te_Directorphone" type="text" placeholder="负责人手机"
						  />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Deptid"><span style="color:red">* </span>所属单位</label>
				<div class="col-sm-4 input-message">
					<input type="hidden" id="organId" name="te_Deptid.or_id" /> <input
						class="form-control" id="organName" name="organName" type="text"
						onclick="select_organ();" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="te_Membernum">成员数量</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Membernum" name="te_Membernum"
						type="text" placeholder="成员数量" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Type">队伍类型</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Type" name="te_Type"
						type="text" placeholder="队伍类型" />
				</div>
				<label class="col-sm-2 control-label" for="te_Linkman">联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Linkman" name="te_Linkman"
						type="text" placeholder="联系人" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Linkmantel">联系人电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Linkmantel"
						name="te_Linkmantel" type="text" placeholder="联系人电话" />
				</div>
				<label class="col-sm-2 control-label" for="te_Fax">传真</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Fax" name="te_Fax" type="text"
						placeholder="传真" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Address">地址</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Address" name="te_Address"
						type="text" placeholder="地址" />
				</div>
				<label class="col-sm-2 control-label" for="te_Postcode">邮编</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Postcode" name="te_Postcode"
						type="text" placeholder="邮编" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Longitude">经度</label>
				<div class="col-sm-4 input-message">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="longitude" class="form-control" name="te_Longitude"
							type="text" placeholder="经度"/>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="te_Latitude">纬度</label>
				<div class="col-sm-4 input-message">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button" onclick="getMap()">
								<span class="glyphicon glyphicon-globe"></span>
							</button>
						</span> <input id="latitude" class="form-control" name="te_Latitude"
							type="text" placeholder="纬度" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Teamjob">队伍职责</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Teamjob" name="te_Teamjob"
						type="text" placeholder="队伍职责" />
				</div>
				<label class="col-sm-2 control-label" for="te_Teamscribe">队伍描述</label>
				<div class="col-sm-4">
					<input class="form-control" id="te_Teamscribe" name="te_Teamscribe"
						type="text" placeholder="队伍描述" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Equipment">装备描述</label>
				<div class="col-sm-10">
					<input class="form-control" id="te_Equipment" name="te_Equipment"
						type="text" placeholder="装备描述" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="te_Remark">备注</label>
				<div class="col-sm-10">
					<input class="form-control" id="te_Remark" name="te_Remark"
						type="text" placeholder="备注" />
				</div>
			</div>
		</form>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</div>

	<script type="text/javascript" src="jsp/resource/team/js/team_cu.js"></script>

</body>
</html>
