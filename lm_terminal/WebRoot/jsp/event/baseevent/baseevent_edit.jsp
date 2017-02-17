<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<form id="baseevent_editform" class="form-horizontal" role="form">
	<input type="hidden" name="be_id" value="${baseEvent.be_id }"/>
	<input type="hidden" name="be_del" value="${baseEvent.be_del }"/>
		<fieldset>
		    <div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label"><span style="color: red;">* </span>事件名称</label>
				<div class="col-sm-9 input-message">
					<input class="form-control" id="be_name"
						name="be_name" type="text" value="${baseEvent.be_name }" placeholder="输入事件名称" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
		    <div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label"><span style="color: red;">* </span>事发地点</label>
				<div class="col-sm-9 input-message">
					<input class="form-control" id="be_address"
						name="be_address" type="text" value="${baseEvent.be_address }" placeholder="输入事发地点" data-bv-trigger="keyup" required="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="be_date"><span style="color: red;">* </span>事发时间</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'>
					<input class="form-control" id="be_date" name="be_date" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${baseEvent.be_date }" />" type="text"
						placeholder="输入事发时间" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="be_reportDate"><span style="color: red;">* </span>接报时间</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="be_reportDate" name="be_reportDate" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${baseEvent.be_reportDate }" />" type="text"
						placeholder="输入接报时间" data-bv-trigger="keyup" required="required"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="eventTypeName"><span style="color: red;">* </span>事件类型</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'><input type="hidden" id="eventTypeid" name="eventTypeId" value="${baseEvent.eventType.et_id }"/>
					<input class="form-control" id="eventTypeName" name="eventTypeName" value="${baseEvent.eventType.et_name }" type="text"
						placeholder="输入事件类型" data-bv-trigger="keyup" required="required" onclick="select_eventType();"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="organid">事发单位</label>
				<div class="col-sm-4">
				    <div class='input-group'><input type="hidden" id="organId" name="organId" value="${baseEvent.organ.or_id }"/>
					<input class="form-control" id="organName" name="organName" value="${baseEvent.organ.or_name }" type="text"
						placeholder="输入事发单位" onclick="select_organ();"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="be_reportMode">接报方式</label>
				<div class="col-sm-4">
				    <div class='input-group'>
						<select class="form-control" id="be_reportMode" name="be_reportMode" value="${baseEvent.be_reportMode }" placeholder="输入事件级别">
						<option value="1" <c:if test="${baseEvent.be_reportMode=='1' }">selected="selected"</c:if>>电话</option>
						<option value="2" <c:if test="${baseEvent.be_reportMode=='2' }">selected="selected"</c:if>>传真</option>
						<option value="3" <c:if test="${baseEvent.be_reportMode=='3' }">selected="selected"</c:if>>邮件</option>
						<option value="4" <c:if test="${baseEvent.be_reportMode=='4' }">selected="selected"</c:if>>网络</option>
						<option value="5" <c:if test="${baseEvent.be_reportMode=='5' }">selected="selected"</c:if>>视频</option>
						<option value="6" <c:if test="${baseEvent.be_reportMode=='6' }">selected="selected"</c:if>>其他</option>
						</select>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="be_reportName"><span style="color: red;">* </span>报告人姓名</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="be_reportName" name="be_reportName" value="${baseEvent.be_reportName }" type="text"
					  data-bv-trigger="keyup" required="required" placeholder="输入报告人姓名"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="be_reportPhone"><span style="color: red;">* </span>报告人电话</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="be_reportPhone" name="be_reportPhone" value="${baseEvent.be_reportPhone }" type="text"
						data-bv-trigger="keyup" required="required" placeholder="输入报告人电话"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label for="disabledSelect" class="col-sm-2 control-label">事件基本情况</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="be_basicSituation" rows="3">${baseEvent.be_basicSituation }</textarea>
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
		$('#baseevent_editform').data('bootstrapValidator').updateStatus('be_date', 'NOT_VALIDATED', null);
	});
	$("#be_reportDate").datetimepicker({language:'zh-CN',format: 'yyyy-mm-dd hh:ii:ss',autoclose:true}).on('changeDate', function(ev){
		$('#baseevent_editform').data('bootstrapValidator').updateStatus('be_reportDate', 'NOT_VALIDATED', null);
	});
});
$('#baseevent_editform').bootstrapValidator();
function baseeventEdit_submitForm(index,window) {
	$('#baseevent_editform').bootstrapValidator('validate');
	if($('#baseevent_editform').data('bootstrapValidator').isValid()){
		$.post('event/baseevent/edit', $('#baseevent_editform').serialize(), function(j) {	
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

function select_eventType(){
	parent.layer.open({
	    type: 2,
	    title:'添加事件类型',
	    area:['500px','500px'],
	    scrollbar: false,
	    content: 'jsp/event/eventinfo/eventinfo_type.jsp',
	    btn:['确认','取消'],
	    yes:function(index,layero){
	    	 layero.find('iframe')[0].contentWindow.selectType(index,window,'baseevent_editform');
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