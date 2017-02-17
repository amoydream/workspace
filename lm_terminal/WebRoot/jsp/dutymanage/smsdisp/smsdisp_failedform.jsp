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
<title>重发短信</title>
<meta name="content-type" content="text/html; charset=UTF-8">
<jsp:include page="/include/pub.jsp"></jsp:include>
<script type="text/javascript">
	function resend(index, window) {
	    parent.parent.layer.confirm('按【确定】发送', function() {
		    $.post('dutymanage/smsdisp/resend/${smsVo.send_id}', {}, function(result) {
			    parent.parent.layer.msg(result.msg, {
			        offset : 300,
			        shift : 6
			    });
			    if(result.success) {
				    window.$result_tr.remove();
				    if(window.$('#result') != null && window.$('#result').find('tr') != null
				       && window.$('#result').find('tr').length > 0) {
					    window.searchFailed($('#page').val());
				    } else {
					    if($('#page').val() > 1) {
						    window.searchFailed($('#page').val() - 1);
					    } else {
						    window.searchFailed('1');
					    }
				    }
				    
				    parent.layer.close(index);
			    }
		    });
	    });
    }
</script>
</head>
<body>
	<div style="margin-top: 10px; margin-left: 10px; margin-right: 10px;">
		<form id="smsForm">
			<div class="form-group">
				<input type="hidden" name="us_Id" value="${userVo.us_Id}">
				<input type="hidden" name="pe_id" value="${smsVo.pe_id}">
				<input type="hidden" name="ev_id" value="${smsVo.ev_id}">
				<input type="hidden" name="tel_mobile_arr" value="${smsVo.tel_mobile}">
				<p>
					<label>联系人 : </label>
					${smsVo.pe_name}
				</p>
				<p>
					<label>部门 : </label>
					${smsVo.or_name}
				</p>
				<p>
					<label>手机号码 : </label>
					${smsVo.tel_mobile}
				</p>
				<p>
					<label>消息内容 : </label>
				</p>
				<p>${smsVo.content}</p>
			</div>
		</form>
	</div>
</body>
</html>
