<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>上报管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
</head>

<body>
<div class="modal-body">
	<form id="eventReport_addform" class="form-horizontal" role="form">
	<input type="hidden" name="ev_id" value="${param.evId }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="er_noyear"><span style="color: red;">*</span>编号-年</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="er_noyear" name="er_noyear" type="text"
						placeholder="输入编号-年" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="er_no"><span style="color: red;">*</span>编号</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="er_no" name="er_no" placeholder="输入编号" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="er_reportUnit"><span style="color: red;">*</span>上报单位</label>
				<div class="col-sm-4 input-message">
						<input class="form-control" id="er_reportUnit" name="er_reportUnit" type="text" placeholder="输入上报单位" data-bv-trigger="keyup" required="required"/>
				</div>
				<label class="col-sm-2 control-label" for="er_date">报告时间</label>
				<div class="col-sm-4 input-message">
						<input class="form-control" id="er_date" name="er_date" type="text" placeholder="输入报告时间" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="er_unit">报告单位</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="er_unit" name="er_unit" type="text" placeholder="输入报告单位" />
				</div>
				<label class="col-sm-2 control-label" for="er_issuer">签发人</label>
				<div class="col-sm-4">
					<input class="form-control" id="er_issuer" name="er_issuer" type="text" placeholder="输入签发人" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="er_issueUnit">签发单位</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="er_issueUnit" name="er_issueUnit"
						type="text" placeholder="输入签发单位" />
				</div>
				<label class="col-sm-2 control-label" for="er_issueDate">签发日期</label>
				<div class="col-sm-4 input-message">
					<input class="form-control" id="er_issueDate" name="er_issueDate"
						type="text" placeholder="输入签发日期"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="er_mainSupply">主送</label>
				<div class="col-sm-4">
					<input class="form-control" id="er_mainSupply" name="er_mainSupply"
						type="text" placeholder="输入主送"/>
				</div>
				<label class="col-sm-2 control-label" for="er_copySupply">抄送</label>
				<div class="col-sm-4">
					<input class="form-control" id="er_copySupply" name="er_copySupply"
						type="text" placeholder="输入抄送" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="er_contact">联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="er_contact" name="er_contact"
						type="text" placeholder="输入联系人"/>
				</div>
				<label class="col-sm-2 control-label" for="er_contactPhone">联系电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="er_contactPhone" name="er_contactPhone"
						type="text" placeholder="输入联系电话" />
				</div>
			</div>

		</fieldset>
	</form>
	</div>
<script type="text/javascript">
$(function(){
	$("#er_date").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		//$('#eventinfo_addform').data('bootstrapValidator').updateStatus('ev_date', 'NOT_VALIDATED', null);
	});
	$("#er_issueDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		//$('#eventinfo_addform').data('bootstrapValidator').updateStatus('ev_reportDate', 'NOT_VALIDATED', null);
	});
	//$("#ev_endDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true});
	
});
$('#eventReport_addform').bootstrapValidator();
function eventReportAdd_submitForm(index,window) {
	$('#eventReport_addform').bootstrapValidator('validate');
	if($('#eventReport_addform').data('bootstrapValidator').isValid()){
		$.post('event/eventReport/add', $('#eventReport_addform').serialize(), function(j) {	
			if(j.success){
				window.location.reload();
				parent.layer.close(index);
			}
			parent.layer.msg(j.msg, {
			    offset: 0,
			    shift: 6
			});
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}
</script>
</body>
</html>