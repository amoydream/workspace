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
<title>发送短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<link rel="stylesheet" href="lauvanUI/bootstrap/css/bootstrapValidator.css" type="text/css"></link>
<script type="text/javascript" src="lauvanUI/bootstrap/js/bootstrapValidator.js"></script>
<link rel="stylesheet" href="lauvanUI/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	type="text/css"></link>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src="lauvanUI/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<script type="text/javascript">
	$(function() {
	    $('#smsForm').bootstrapValidator();
    });
    
    function send(index, window) {
	    $('#smsForm').bootstrapValidator('validate');
	    if($('#smsForm').data('bootstrapValidator').isValid()) {
		    $.post('dutymanage/smsdisp/send', $('#smsForm').serialize(), function(result) {
			    if(result.success) {
				    parent.layer.close(index);
				    window.location.reload();
			    } else {
				    parent.layer.tips(result.msg, '.layui-layer-btn0', {
					    tips : 1
				    });
			    }
		    }, 'json');
	    } else {
		    parent.layer.tips('红色输入框必填', '.layui-layer-btn0', {
			    tips : 1
		    });
	    }
    }

    function selectPerson() {
	    parent.layer.open({
	        type : 2,
	        title : '选择接班人',
	        area : ['960px', '640px'],
	        scrollbar : false,
	        content : ['jsp/dutymanage/handover/handover_selectperson.jsp', 'yes'],
	        btn : ['确定', '取消'],
	        yes : function(index, layero) {
		        layero.find('iframe')[0].contentWindow.returnPersons(index, window);
	        },
	        success : function(layero, index) {
		        layero.find('iframe')[0].contentWindow.setLayer(index, window);
	        }
	    });
    }

    $(function() {
	    $('#ho_date').datetimepicker({
	        language : 'zh-CN',
	        format : 'yyyy-mm-dd',
	        minView : 'month',
	        autoclose : true
	    });
    });
</script>
</head>
<body>
	<div class="row"
		style="padding-left: 20px; padding-right: 20px; padding-top: 10px; margin-left: 0px; margin-right: 10px;">
		<div style="margin-bottom: 20px;">
			<form class="form-inline" action="dutymanage/smsdisp/read" method="post">
				<div class="form-group">
					<label for="us_Name">交班人</label>
					<input type="text" id="us_Name" name="us_Name" class="form-control" placeholder="交班人"
						value="${sessionScope.userVo.us_Name}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="pe_name">接班人</label>
					<input type="tel" id="pe_name" name="pe_name" class="form-control" placeholder="点击选择接班人"
						value="" readonly="readonly" onclick="selectPerson();">
				</div>
				<div class="form-group">
					<label for="ho_date">交班日期</label>
					<input type="tel" id="ho_date" name="ho_date" class="form-control" placeholder="交班日期" value="">
				</div>
				<p>
				<div class="form-group">
					<label for="ho_remarks">备注</label>
					<textarea rows="8" cols="100" class="form-control" name="ho_remarks" placeholder="交班备注"></textarea>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
