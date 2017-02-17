<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>日常事件管理</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css"
	type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" type="text/css"></link>
</head>

<body>

<div class="row" style="padding-left: 10px; padding-right: 15px; padding-top: 5px;margin-left: 0px; margin-right: 10px;">
	<form id="baseevent_addform" class="form-horizontal" role="form">
	<input type="hidden" name="be_status" value="1"/>
	<input type="hidden" name="be_del" value="0"/>
	<input type="hidden" name="CallID" value="${param.CallID }"/>
		<fieldset>
		    <div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label"><span style="color: red;">* </span>事件名称</label>
				<div class="col-sm-9 input-message">
					<input class="form-control" id="be_name"
						name="be_name" type="text" placeholder="输入事件名称" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
		    <div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label"><span style="color: red;">* </span>事发地点</label>
				<div class="col-sm-9 input-message">
					<input class="form-control" id="be_address"
						name="be_address" type="text" placeholder="输入事发地点" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="be_date"><span style="color: red;">* </span>事发时间</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'>
					<input class="form-control" id="be_date" name="be_date" type="text"
						placeholder="输入事发时间" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="be_reportDate"><span style="color: red;">* </span>接报时间</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="be_reportDate" name="be_reportDate" value="${param.ev_reportDate }" type="text"
						placeholder="输入接报时间" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eventTypeName"><span style="color: red;">* </span>事件类型</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'><input type="hidden" id="eventTypeid" name="eventTypeId"/>
					<input class="form-control" id="eventTypeName" name="eventTypeName" type="text"
						data-bv-trigger="keyup" required="required" placeholder="输入事件类型" onclick="select_eventType();"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="organid">事发单位</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'><input type="hidden" id="organId" name="organId"/>
					<input class="form-control" id="organName" name="organName" type="text"
						placeholder="输入事发单位" onclick="select_organ();"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="be_reportMode">接报方式</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'>
						<select class="form-control" id="be_reportMode" name="be_reportMode" placeholder="输入事件级别">
						<option value="1">电话</option>
						<option value="2">传真</option>
						<option value="3">邮件</option>
						<option value="4">网络</option>
						<option value="5">视频</option>
						<option value="6">其他</option>
						</select>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="be_reportName"><span style="color: red;">* </span>报告人姓名</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="be_reportName" name="be_reportName" type="text"
						placeholder="输入报告人姓名" data-bv-trigger="keyup" required="required" value="${param.name }"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="be_reportPhone"><span style="color: red;">* </span>报告人电话</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="be_reportPhone" name="be_reportPhone" value="${param.ev_reportPhone }" type="text"
						placeholder="输入报告人电话" pattern="(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\(\d{3}\))|(\d{3}\-))?(1[358]\d{9})$)" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">事件基本情况</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="be_basicSituation" rows="3"></textarea>
				</div>
			</div>
		</fieldset>
		
	</form>
</div>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript">
$(function(){
	$("#be_date").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		$('#baseevent_addform').data('bootstrapValidator').updateStatus('be_date', 'NOT_VALIDATED', null);
	});
	$("#be_reportDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		$('#baseevent_addform').data('bootstrapValidator').updateStatus('be_reportDate', 'NOT_VALIDATED', null);
	});
	$('#baseevent_addform').bootstrapValidator();
	$("#be_reportPhone").val(${param.be_reportPhone});
});

function baseeventAdd_submitForm(index,window) {
	$('#baseevent_addform').bootstrapValidator('validate');
	if($('#baseevent_addform').data('bootstrapValidator').isValid()){
		$.post('event/baseevent/add', $('#baseevent_addform').serialize(), function(j) {	
			if(j.success){
				window.location.reload();
				parent.layer.close(index);
			}else{
				parent.layer.msg(j.msg, {
				    offset: 0,
				    shift: 6
				});
			}
		}, 'json');
	}else{
		parent.layer.msg('红色输入框必填', {
		    offset: 0,
		    shift: 6
		});
	}
}

function eventinfoAdd_submitForm(index,window){
	parent.tabs_open2('eventinfoAdd','事件添加','jsp/event/eventinfo/eventinfo_add.jsp?'+$('#baseevent_addform').serialize(),'');
}

function select_eventType(){
	parent.layer.open({
	    type: 2,
	    title:'添加事件类型',
	    area:['500px','500px'],
	    scrollbar: false,
	    content: 'jsp/event/eventinfo/eventinfo_type.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectType(index,window,'baseevent_addform');
	    }
	});
}
function select_organ(){
	parent.layer.open({
	    type: 2,
	    title:'添加单位',
	    area:['500px','500px'],
	    scrollbar: false,
	    content: 'jsp/event/eventinfo/eventinfo_organ.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectOrgan(index,window);
	    }
	});
}
</script>
</body>
</html>