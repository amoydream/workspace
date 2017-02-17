<%@ page language="java" pageEncoding="UTF-8"%>
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
	<div class="modal-body">
		<form class="form-horizontal" id="memberEditForm">
			<input type="hidden" name="me_Id" value="${member.me_Id }" /> <input
				type="hidden" name="me_Teamid" value="${member.me_Teamid }" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Name">名称</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="me_Name" name="me_Name"
						value="${member.me_Name }" type="text" placeholder="名称"
						data-bv-trigger="keyup" required="required" />
				</div>
				<label class="col-sm-2 control-label" for="me_Sex">性别</label>
				<div class="col-sm-4">
					<select class="form-control" name="me_Sex" id="me_Sex"
						value="${member.me_Sex }">
						<option value="0">男</option>
						<option value="1">女</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Deptid">所属单位</label>
				<div class="col-sm-4">
					<input class="form-control" id="me_Deptid" name="me_Deptid"
						value="${member.me_Deptid }" type="text" placeholder="所属单位" />
				</div>
				<label class="col-sm-2 control-label" for="me_Phone">手机</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="me_Phone" name="me_Phone"
						value="${member.me_Phone }" type="text" placeholder="输入数字"
						data-bv-trigger="keyup" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Tel">电话</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="me_Tel" name="me_Tel"
						value="${member.me_Tel }" type="text" placeholder="电话" />
				</div>
				<label class="col-sm-2 control-label" for="me_Borndate">出生日期</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="me_Borndate" name="me_Borndate"
						value="${member.me_Borndate }" type="text" placeholder="出生日期" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Nativeplace">籍贯</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="me_Nativeplace"
						name="me_Nativeplace" value="${member.me_Nativeplace }"
						type="text" placeholder="籍贯" />
				</div>
				<label class="col-sm-2 control-label" for="mea">民族</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="me_Nationality"
						name="me_Nationality" value="${member.me_Nationality }"
						type="text" placeholder="民族" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Idcardnum">身份证号</label>
				<div class="col-sm-4 ">
					<input class="form-control" id="me_Idcardnum" name="me_Idcardnum"
						value="${member.me_Idcardnum }" type="text" placeholder="身份证号" />
				</div>
				<label class="col-sm-2 control-label" for="me_Workyears">工作时间</label>
				<div class="col-sm-4">
					<input class="form-control" id="me_Workyears"
						name="me_Workyears" value="${member.me_Workyears }"
						type="text" placeholder="工作时间" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Job">职位</label>
				<div class="col-sm-4">
					<input class="form-control" id="me_Job" name="me_Job"
						value="${member.me_Job }" type="text" placeholder="职位" />
				</div>
				<label class="col-sm-2 control-label" for="me_Specialty">特长</label>
				<div class="col-sm-4">
					<input class="form-control" id="me_Specialty" name="me_Specialty"
						value="${member.me_Specialty }" type="text" placeholder="特长" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Jobtitle">职称</label>
				<div class="col-sm-4">
					<input class="form-control" id="me_Jobtitle" name="me_Jobtitle"
						value="${member.me_Jobtitle }" type="text" placeholder="职称" />
				</div>
				<label class="col-sm-2 control-label" for="me_Registeplace">户口所在地</label>
				<div class="col-sm-4">
					<input class="form-control" id="me_Registeplace"
						name="me_Registeplace" value="${member.me_Registeplace }"
						type="text" placeholder="户口所在地" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Familyaddress">家庭住址</label>
				<div class="col-sm-10">
					<input class="form-control" id="me_Familyaddress"
						name="me_Familyaddress" value="${member.me_Familyaddress }"
						type="text" placeholder="家庭住址" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="me_Remark">备注</label>
				<div class="col-sm-10">
					<input class="form-control" id="me_Remark" name="me_Remark"
						value="${member.me_Remark }" type="text" placeholder="备注" />
				</div>
			</div>
			<span id="msgdemo2" style="margin-left:30px;"></span>
		</form>
	</div>

	<script type="text/javascript"
		src="jsp/resource/teammember/js/teammember_cu.js"></script>

</body>
</html>
