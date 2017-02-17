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
<title>法律法规添加</title>
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
<link rel="stylesheet"
	href="lauvanUI/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet"
	href="lauvanUI/kindeditor-4.1.10/plugins/code/prettify.css" />
<script charset="utf-8"
	src="lauvanUI/kindeditor-4.1.10/kindeditor-min.js"></script>
<script charset="utf-8" src="lauvanUI/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8"
	src="lauvanUI/kindeditor-4.1.10/plugins/code/prettify.js"></script>
</head>
<body>
	<div class="modal-body">
		<form id="legalEditForm" class="form-horizontal" role="form">
			<input type="hidden" name="le_Id" value="${legal.le_Id }" />
			<input type="hidden" name="le_Filename" value="${legal.le_Filename }" />
			<div class="form-group">
				<label class="col-sm-1 control-label" for="le_Name"><span style="color:red">* </span>标题</label>
				<div class="col-sm-3 input-message">
					<input class="form-control" id="le_Name" name="le_Name"
						value="${legal.le_Name }" type="text" placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-1 control-label" for="le_Code"><span style="color:red">* </span>编号</label>
				<div class="col-sm-3 input-message">
					<input class="form-control" id="le_Code" name="le_Code"
						value="${legal.le_Code }" type="text" placeholder="必填项" data-bv-trigger="keyup" required="required"/>
				</div>
			
				<label class="col-sm-1 control-label" for="le_Subtitle">副标题</label>
				<div class="col-sm-3 ">
					<input class="form-control" id="le_Subtitle" name="le_Subtitle"
						value="${legal.le_Subtitle }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="le_State">状态</label>
				<div class="col-sm-3 ">
					<input class="form-control" id="le_State" name="le_State"
						value="${legal.le_State }" type="text" />
				</div>
				<label class="col-sm-1 control-label" for="le_Shortcontent">内容</label>
				<div class="col-sm-3 ">
					<input class="form-control" id="le_Shortcontent"
						name="le_Shortcontent" value="${legal.le_Shortcontent }"
						type="text" />
				</div>
				<label class="col-sm-1 control-label" for="le_Range">范围</label>
				<div class="col-sm-3 ">
					<input class="form-control" id="le_Range" name="le_Range"
						value="${legal.le_Range }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="le_Lowdept">部门</label>
				<div class="col-sm-3 ">
					<input class="form-control" id="le_Lowdept" name="le_Lowdept"
						value="${legal.le_Lowdept }" type="text" />
				</div>
				<label class="col-sm-1 control-label" for="le_Effectivedate">生效日期</label>
				<div class="col-sm-3 ">
					<div class='input-group'>
						<input class="form-control" id="le_Effectivedate" name="le_Effectivedate"
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${legal.le_Effectivedate }" />"
							type="text" /><span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>
				<label class="col-sm-1 control-label" for="le_Validity">有效期</label>
				<div class="col-sm-3 ">
					<div class='input-group'>
						<input class="form-control" id="le_Validity" name="le_Validity"
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${legal.le_Validity }" />"
							type="text" /><span
							class="input-group-addon"> <span
							class="glyphicon glyphicon-calendar"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="le_Savedirectory">存档路径</label>
				<div class="col-sm-3 ">
					<input class="form-control" id="le_Savedirectory"
						name="le_Savedirectory" value="${legal.le_Savedirectory }"
						type="text" />
				</div>
				<label class="col-sm-1 control-label" for="le_Formate">文档格式</label>
				<div class="col-sm-3 ">
					<input class="form-control" id="le_Formate" name="le_Formate"
						value="${legal.le_Formate }" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="le_Content">内容:</label>
				<div class="col-sm-11 ">
					<textarea class="form-control" id="le_Content" name="le_Content" rows="20">${legal.le_Content }</textarea>
				</div>
			</div>
		</form>
		<span id="msgdemo2" style="margin-left:30px;"></span>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">取消
		</button>
		<button type="button" class="btn btn-primary" id="legalEditBtn"
			onclick="legalEditSubmitForm();">编辑</button>
	</div>


	<script type="text/javascript" src="jsp/resource/legal/js/legal_cu.js"></script>
</body>
</html>