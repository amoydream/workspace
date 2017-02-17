<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.lauvan.organ.entity.C_Organ_Person"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String smsReceivers = "";
	List<C_Organ_Person> smsReceiverList = (List<C_Organ_Person>)session.getAttribute("smsReceiverList");
	if (smsReceiverList != null && smsReceiverList.size() > 0) {
		for (C_Organ_Person p : smsReceiverList) {
			smsReceivers += p.getPe_name() + "(" + p.getPe_mobilephone() + ");";
		}
	}
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
</script>
</head>
<body>
	<div class="row"
		style="padding-left: 10px; padding-right: 15px; padding-top: 5px; margin-left: 0px; margin-right: 10px;">
		<div style="margin-bottom: 15px;">
			<form id="smsForm" action="dutymanage/smsdisp/send" method="post">
				<div class="form-group">
					<span id="sp_pe_id_arr"></span>
					<label for="pe_select">接收人</label>
					<input type="text" id="pe_select" name="pe_select" class="form-control"
						value="<%=smsReceivers%>" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="send_content">短信内容</label>
					<textarea rows="10" id="send_content" name="send_content" class="form-control"
						placeholder="短信内容">${sessionScope.rp_content}</textarea>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
