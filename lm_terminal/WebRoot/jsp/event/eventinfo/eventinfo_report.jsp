<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>事件报告</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
</head>

<body style="background-color: #CEFFCE;">
    <div class="container-fluid" style="margin-top: 25px;">
	<div class="row-fluid">
	<form id="eventinfo_reportform" class="form-horizontal" role="form">
	<input type="hidden" name="token" value="c42bf0c8128cf7834996b11ff638442f625b09a6"/>
	<input type="hidden" name="posx" value="100"/>
	<input type="hidden" name="posy" value="110"/>
		<fieldset>
		    <div class="form-group">
				<label for="disabledSelect" class="col-sm-3 control-label">标题</label>
				<div class="col-sm-9">
					<input class="form-control" id="title"
						name="title" type="text" placeholder="输入标题" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">内容</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="content" rows="2"></textarea>
				</div>
			</div>
		</fieldset>
		
	</form>
	</div>
</div>	
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript">
$(function(){
	/* $("#ev_date").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		$('#eventinfo_reportform').data('bootstrapValidator').updateStatus('ev_date', 'NOT_VALIDATED', null);
	});
	$("#ev_reportDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		$('#eventinfo_reportform').data('bootstrapValidator').updateStatus('ev_reportDate', 'NOT_VALIDATED', null);
	});
	$("#ev_endDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}); */
	$('#eventinfo_reportform').bootstrapValidator();
	
});

function eventtypeAdd_submitForm(index,window){
	$('#eventinfo_reportform').bootstrapValidator('validate');
	if($('#eventinfo_reportform').data('bootstrapValidator').isValid()){
		$.post('http://172.12.11.169/MobileYJServer/servlet/PushTaskServlet', $('#eventinfo_reportform').serialize(), function(j) {	
		}, 'json');
	}else{
		parent.parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
	parent.parent.layer.msg("下发成功", {
	    offset: 0,
	    shift: 6
	});
}
</script>
</body>
</html>