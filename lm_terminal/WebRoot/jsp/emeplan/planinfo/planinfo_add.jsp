<%@ page language="java" pageEncoding="UTF-8"%>
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
<title>预案基本信息管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet"
	href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<link rel="stylesheet"
	href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	type="text/css"></link>
</head>

<body>
	<div class="container-fluid"
		style="margin-top:15px;padding-left: 0px;margin-left: 15px;">
		<div class="row-fluid">
			<form id="planinfo_addform" class="form-horizontal" role="form">
	<input id="eventTypeId" type="hidden" name="eventTypeId" value="${param.pid }"/>
	<input type="hidden" name="pi_del" value="0"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="pi_name">预案名称</label>
				<div class="col-sm-6 input-message">
					<input class="form-control" id="pi_name" name="pi_name" type="text"
						placeholder="输入预案名称" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-1 control-label" for="pi_createDate">发布日期</label>
				<div class="col-sm-4">
					<div class='input-group'>
						<input class="form-control" id="pi_createDate" name="pi_createDate" type="text"
						placeholder="输入发布日期" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label" for="pi_subOrgan">所属机构</label>
				<div class="col-sm-3">
					<div class='input-group'>
						<input class="form-control" id="pi_subOrgan" name="pi_subOrgan" type="text"
						placeholder="输入所属机构" />
					</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_issOrgan">发布机构</label>
				<div class="col-sm-3">
					<div class='input-group'>
						<input class="form-control" id="pi_issOrgan" name="pi_issOrgan" type="text"
						placeholder="输入发布机构" />
					</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_estOrgan">编制机构</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<input class="form-control" id="pi_estOrgan" name="pi_estOrgan"
						type="text" placeholder="输入编制机构" />
						</div>
				</div>
			</div>
			<div class="form-group">
				
				<label class="col-sm-1 control-label" for="pi_appOrgan">审批机构</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<input class="form-control" id="pi_appOrgan" name="pi_appOrgan"
						type="text" placeholder="输入审批机构" />
						</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_no">版本号</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<input class="form-control" id="pi_no" name="pi_no"
						type="text" placeholder="输入版本号" />
						</div>
				</div>
				<label class="col-sm-1 control-label" for="pi_level">层级</label>
				<div class="col-sm-3">
				<div class='input-group'>
					<select class="form-control" id="pi_level" name="pi_level">
						<option value="1">省</option>
						<option value="2">地市</option>
						<option value="3">区县</option>
						<option value="4">部门</option>
						<option value="5">企业</option>
						</select>
						</div>
				</div>
			</div>

			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">说明</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_note" name="pi_note"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">描述</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_desc" name="pi_desc"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">适用范围</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_scope" name="pi_scope"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="pt_remark" class="col-sm-1 control-label">备注</label>
				<div class="col-sm-9">
				    <textarea class="form-control" rows="3" id="pi_remark" name="pi_remark"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-6 control-label"></label>
				<div class="col-sm-6">
					<button type="button" id="planinfoBtnAdd" class="btn btn-success" onclick="planinfo_addUI();">添加</button>
				</div>
			</div>
		</fieldset>
	</form>
		</div>
	</div>
	<script type="text/javascript"
		src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
	<script type="text/javascript"
		src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript"
		src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
		charset="UTF-8"></script>
	<script type="text/javascript">
		$(function() {
			$("#pi_createDate").datetimepicker({
				language : 'zh-CN',
				format : 'yyyy-mm-dd',
				minView : 'month',
				autoclose : true
			});
		});
		$('#planinfo_addform').bootstrapValidator();
		function planinfo_addUI() {
			$('#planinfo_addform').bootstrapValidator('validate');
			if ($('#planinfo_addform').data('bootstrapValidator').isValid()) {
			    $("#planinfoBtnAdd").html("正在提交中...");
			    $("#planinfoBtnAdd").attr("disabled","disabled");
				$.post('emeplan/planinfo/add', $('#planinfo_addform')
						.serialize(), function(j) {
					if (j.success) {
						var etId = $("#eventTypeId").val();
						parent.document.getElementById('tab_planinfo_iframe').contentWindow.postChild(etId);
						parent.closeTab("tab_planInfoAdd");
					}else{
						$("#planinfoBtnAdd").html("添加");
			    		$("#planinfoBtnAdd").attr("disabled",false);
					}
					parent.layer.msg(j.msg, {
						offset : 0,
						shift : 6
					});
				}, 'json');
			} else {
				$("#planinfoBtnAdd").html("添加");
	    		$("#planinfoBtnAdd").attr("disabled",false);
				parent.layer.msg('红色输入框必填', {
					offset : 0,
					shift : 6
				});
			}
		}
	</script>
</body>
</html>