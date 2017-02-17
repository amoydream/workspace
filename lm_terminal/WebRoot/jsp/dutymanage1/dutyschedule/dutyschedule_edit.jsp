<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>新增值班排班</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<script type="text/javascript">
	$(function() {
	    $('#dutyScheduleForm').bootstrapValidator();
    });
    
    function dutyScheduleEdit(index, window) {
	    $('#dutyScheduleForm').bootstrapValidator('validate');
	    if($('#dutyScheduleForm').data('bootstrapValidator').isValid()) {
		    $.post('dutymanage/dutyschedule1/edit', $('#dutyScheduleForm').serialize(), function(j) {
			    if(j.success) {
				    window.$('#calendar').fullCalendar('refetchEvents');
				    window.setScheduleTemplates();
			    } else {
				    parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
			    }
			    parent.layer.close(index);
		    });
	    } else {
		    parent.layer.msg('红色输入框必填', {
			    offset: 0,
			    shift: 6
			});
	    }
    }

    function dutyScheduleDelete(index, window) {
    	parent.layer.confirm('您确定要删除么？', function(index){
    		$.post('dutymanage/dutyschedule1/delete', {id:${schedule.duty_id }}, function(j) {
    		    if(j.success) {
    			    window.$('#calendar').fullCalendar('refetchEvents');
    		    } else {
    		    	parent.layer.msg(j.msg, {
					    offset: 0,
					    shift: 6
					});
    		    }
    		    parent.layer.closeAll();
    	    });
    	});
    }

    function selectPerson() {
	    parent.layer.open({
	        type : 2,
	        title : '选择机构人员',
	        area : ['800px', '500px'],
	        scrollbar : false,
	        content : 'jsp/work/person/person_duty_select.jsp',
	        btn : ['保存', '取消'],
	        yes : function(index, layero) {
	        	layero.find('iframe')[0].contentWindow.select_DutyPerson(index, window);
	        }
	    });
    }

</script>
</head>
<body>
	<form id="dutyScheduleForm" class="form-horizontal" role="form">
	<input type="hidden" name="pe_id" id="pe_id" value="${schedule.person.pe_id }"/>
	<input type="hidden" name="duty_id" value="${schedule.duty_id }"/>
		<fieldset>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="pe_name">人员</label>
				<div class="col-sm-4 input-message">
				    <div class='input-group'>
					<input class="form-control" id="pe_name" name="pe_name" value="${schedule.person.pe_name }" type="text"
						placeholder="输入用户名" data-bv-trigger="keyup" required="required" onclick="selectPerson();"/>
						</div>
				</div>
				<label class="col-sm-2 control-label" for="duty_date">值班日期</label>
				<div class="col-sm-4 input-message">
				<div class='input-group'>
					<input class="form-control" id="duty_date" name="duty_date" value="${schedule.duty_date }" readonly="readonly" value="${param.duty_date}"/>
						</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="duty_prop">值班性质</label>
				<div class="col-sm-4">
					<div class='input-group'>
						<select class="form-control" id="duty_prop" name="duty_prop">
						<option value="1" <c:if test="${schedule.duty_prop == '1' }">selected="selected"</c:if>>带班领导</option>
						<option value="2" <c:if test="${schedule.duty_prop == '2' }">selected="selected"</c:if>>值班领导</option>
						<option value="3" <c:if test="${schedule.duty_prop == '3' }">selected="selected"</c:if>>值班干部</option>
					</select>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="duty_type">值班类型</label>
				<div class="col-sm-4 input-message">
					<div class='input-group'>
						<input type="radio" name="duty_type" value="1" <c:if test="${schedule.duty_type == '1' }">checked="checked"</c:if>/>工作日 
						<input type="radio" name="duty_type" value="2"  <c:if test="${schedule.duty_type == '2' }">checked="checked"</c:if>/>休息日
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="duty_temp">是否模板</label>
				<div class="col-sm-4">
				<div class='input-group'>
					<input type="radio" name="duty_temp" value="1" <c:if test="${schedule.duty_temp == '1' }">checked="checked"</c:if>/>是
					<input type="radio" name="duty_temp" value="" <c:if test="${schedule.duty_temp == '' }">checked="checked"</c:if>/>否
				</div></div>
				<label class="col-sm-2 control-label" for="duty_ifleader">上级领导</label>
				<div class="col-sm-4">
				<div class='input-group'>
					<input type="radio" name="duty_ifleader" value="1" <c:if test="${schedule.duty_ifleader == '1' }">checked="checked"</c:if>/>是
					<input type="radio" name="duty_ifleader" value="0" <c:if test="${schedule.duty_ifleader == '0' }">checked="checked"</c:if>/>否
				</div></div>
			</div>
		</fieldset>
	</form>
	
</body>
</html>
