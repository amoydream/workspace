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
    
    function dutyScheduleSave(index, window) {
	    $('#dutyScheduleForm').bootstrapValidator('validate');
	    if($('#dutyScheduleForm').data('bootstrapValidator').isValid()) {
		    $.post('dutymanage/dutyschedule/save', $('#dutyScheduleForm').serialize(), function(result) {
			    if(result.success) {
				    parent.layer.close(index);
				    window.$('#calendar').fullCalendar('refetchEvents');
				    window.setScheduleTemplates();
			    } else {
				    parent.layer.tips(result.msg, '.layui-layer-btn0', {
					    tips : 1
				    });
			    }
		    });
	    } else {
		    parent.layer.tips('红色输入框必填', '.layui-layer-btn0', {
			    tips : 1
		    });
	    }
    }

    function dutyScheduleUpdate(index, window) {
	    $('#dutyScheduleForm').bootstrapValidator('validate');
	    if($('#dutyScheduleForm').data('bootstrapValidator').isValid()) {
		    $.post('dutymanage/dutyschedule/update', $('#dutyScheduleForm').serialize(), function(result) {
			    if(result.success) {
				    parent.layer.close(index);
				    window.$('#calendar').fullCalendar('refetchEvents');
				    window.setScheduleTemplates();
			    } else {
				    parent.layer.tips(result.msg, '.layui-layer-btn0', {
					    tips : 1
				    });
			    }
		    });
	    } else {
		    parent.layer.tips('红色输入框必填', '.layui-layer-btn0', {
			    tips : 1
		    });
	    }
    }

    function dutyScheduleDelete(index, window) {
	    $.post('dutymanage/dutyschedule/delete/' + $("#duty_sch_id").val(), {}, function(result) {
		    if(result.success) {
			    parent.layer.close(index);
			    window.$('#calendar').fullCalendar('refetchEvents');
		    } else {
			    parent.layer.tips(result.msg, '.layui-layer-btn0', {
				    tips : 1
			    });
		    }
	    });
    }

    function selectPerson() {
	    parent.layer.open({
	        type : 2,
	        title : '选择机构人员',
	        area : ['800px', '720px'],
	        scrollbar : false,
	        content : 'jsp/work/person/person_select.jsp',
	        btn : ['取消'],
	        yes : function(index, layero) {
		        parent.layer.close(index);
	        },
	        success : function(layero, index) {
		        layero.find('iframe')[0].contentWindow.setOpener(index, window);
	        }
	    });
    }

    function setSelectedPerson(selectedPerson) {
	    $('#pe_id').val(selectedPerson.pe_id);
	    $('#pe_name').val(selectedPerson.pe_name);
	    $('#pe_mobilephone').val(selectedPerson.pe_mobilephone);
	    $('#or_name').val(selectedPerson.organ.or_name);
    }
</script>
</head>
<body>
	<div class="row"
		style="padding-left: 10px; padding-right: 15px; padding-top: 5px; margin-left: 0px; margin-right: 10px;">
		<div style="margin-bottom: 15px;">
			<form id="dutyScheduleForm" action="dutymanage/dutyschedule/save" method="post">
				<input type="hidden" id="duty_sch_id" name="duty_sch_id" value="${dutyScheduleVo.duty_sch_id}">
				<input type="hidden" id="pe_id" name="pe_id" value="${dutyScheduleVo.pe_id}">
				<div class="form-group">
					<label for="pe_name">姓名 (点击选择人员)</label>
					<input type="text" id="pe_name" name="pe_name" class="form-control" placeholder="人员姓名"
						value="${dutyScheduleVo.pe_name}" readonly="readonly" onclick="selectPerson();">
				</div>
				<div class="form-group">
					<label for="or_name">部门</label>
					<input type="text" id="or_name" name="or_name" class="form-control" placeholder="部门名称"
						value="${dutyScheduleVo.or_name}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="pe_mobilephone">电话</label>
					<input type="text" id="pe_mobilephone" name="pe_mobilephone" class="form-control" placeholder="联系电话"
						value="${dutyScheduleVo.pe_mobilephone}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="duty_date">值班日期</label>
					<input type="text" id="duty_date" name="duty_date" class="form-control" readonly="readonly"
						value="${dutyScheduleVo.duty_date_str}">
				</div>
				<div class="form-group">
					<label for="duty_prop">值班性质</label>
					<select class="form-control" id="duty_prop" name="duty_prop" value="${dutyScheduleVo.duty_prop}">
						<option value="1">带班领导</option>
						<option value="2">值班领导</option>
						<option value="3">值班干部</option>
					</select>
				</div>
				<div class="form-group">
					<label for="duty_type">值班类型</label>
					<select class="form-control" id="duty_type" name="duty_type" value="${dutyScheduleVo.duty_type}">
						<option value="1">工作日</option>
						<option value="2">休息日</option>
					</select>
				</div>
				<div class="form-group">
					<label for="is_tmpl">保存为模板</label>
					<input type="checkbox" id="is_tmpl" name="is_tmpl" value="${dutyScheduleVo.is_tmpl}"
						onclick="this.value=this.checked?'Y':'N';">
				</div>
			</form>
		</div>
	</div>
</body>
</html>
